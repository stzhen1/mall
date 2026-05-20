package com.mall.module.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mall.module.order.entity.AfterSale;
import com.mall.module.order.entity.Order;
import java.util.List;

public interface OrderService extends IService<Order> {
    Order placeOrder(Long buyerId, Order order);
    void payOrder(Long buyerId, Long orderId);
    List<Order> buyerOrders(Long buyerId, int page, int size);
    List<Order> sellerOrders(Long sellerId, int page, int size);
    void shipOrder(Long sellerId, Long orderId);
    void receiveOrder(Long buyerId, Long orderId);
    AfterSale requestAfterSale(Long buyerId, Long orderId, AfterSale afterSale);
}
