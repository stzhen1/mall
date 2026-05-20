package com.mall.module.order.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mall.common.BusinessException;
import com.mall.module.order.entity.AfterSale;
import com.mall.module.order.entity.Order;
import com.mall.module.order.entity.OrderItem;
import com.mall.module.order.mapper.AfterSaleMapper;
import com.mall.module.order.mapper.OrderItemMapper;
import com.mall.module.order.mapper.OrderMapper;
import com.mall.module.order.service.OrderService;
import com.mall.module.product.entity.Product;
import com.mall.module.product.mapper.ProductMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {
    private final OrderMapper orderMapper;
    private final OrderItemMapper itemMapper;
    private final AfterSaleMapper afterSaleMapper;
    private final ProductMapper productMapper;

    @Override
    @Transactional
    public Order placeOrder(Long buyerId, Order order) {
        BigDecimal total = BigDecimal.ZERO;
        Long sellerId = null;
        for (OrderItem item : order.getItems()) {
            Product product = productMapper.selectById(item.getProductId());
            if (product == null || !"ON".equals(product.getStatus()))
                throw new BusinessException("Product unavailable: " + item.getProductId());
            if (product.getStock() < item.getQuantity())
                throw new BusinessException("Insufficient stock: " + product.getName());
            item.setProductNameSnapshot(product.getName());
            item.setPriceSnapshot(product.getPrice());
            total = total.add(product.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            sellerId = product.getSellerId();
            product.setStock(product.getStock() - item.getQuantity());
            productMapper.updateById(product);
        }
        order.setOrderNo(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"))
                + UUID.randomUUID().toString().substring(0, 6));
        order.setBuyerId(buyerId);
        order.setSellerId(sellerId);
        order.setTotalAmount(total);
        order.setStatus("PENDING");
        orderMapper.insert(order);
        for (OrderItem item : order.getItems()) {
            item.setOrderId(order.getId());
            itemMapper.insert(item);
        }
        return order;
    }

    @Override
    public void payOrder(Long buyerId, Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null || !order.getBuyerId().equals(buyerId))
            throw new BusinessException("Order not found");
        if (!"PENDING".equals(order.getStatus()))
            throw new BusinessException("Order cannot be paid");
        order.setStatus("PAID");
        orderMapper.updateById(order);
    }

    @Override
    public List<Order> buyerOrders(Long buyerId, int page, int size) {
        Page<Order> p = orderMapper.selectPage(new Page<>(page, size),
                new LambdaQueryWrapper<Order>().eq(Order::getBuyerId, buyerId)
                        .orderByDesc(Order::getCreatedAt));
        fillItems(p.getRecords());
        return p.getRecords();
    }

    @Override
    public List<Order> sellerOrders(Long sellerId, int page, int size) {
        Page<Order> p = orderMapper.selectPage(new Page<>(page, size),
                new LambdaQueryWrapper<Order>().eq(Order::getSellerId, sellerId)
                        .orderByDesc(Order::getCreatedAt));
        fillItems(p.getRecords());
        return p.getRecords();
    }

    @Override
    public void shipOrder(Long sellerId, Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null || !order.getSellerId().equals(sellerId))
            throw new BusinessException("Order not found");
        if (!"PAID".equals(order.getStatus()))
            throw new BusinessException("Must be paid first");
        order.setStatus("SHIPPED");
        orderMapper.updateById(order);
    }

    @Override
    public void receiveOrder(Long buyerId, Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null || !order.getBuyerId().equals(buyerId))
            throw new BusinessException("Order not found");
        if (!"SHIPPED".equals(order.getStatus()))
            throw new BusinessException("Not shipped yet");
        order.setStatus("RECEIVED");
        orderMapper.updateById(order);
    }

    @Override
    public AfterSale requestAfterSale(Long buyerId, Long orderId, AfterSale afterSale) {
        Order order = orderMapper.selectById(orderId);
        if (order == null || !order.getBuyerId().equals(buyerId))
            throw new BusinessException("Order not found");
        if ("PENDING".equals(order.getStatus()) || "CANCELLED".equals(order.getStatus()))
            throw new BusinessException("Cannot request after-sales");
        afterSale.setOrderId(orderId);
        afterSale.setBuyerId(buyerId);
        afterSale.setStatus("PENDING");
        afterSale.setAmount(order.getTotalAmount());
        afterSaleMapper.insert(afterSale);
        order.setStatus("REFUNDING");
        orderMapper.updateById(order);
        return afterSale;
    }

    private void fillItems(List<Order> orders) {
        for (Order order : orders)
            order.setItems(itemMapper.selectList(
                    new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, order.getId())));
    }
}
