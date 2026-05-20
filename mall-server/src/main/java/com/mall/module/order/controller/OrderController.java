package com.mall.module.order.controller;

import com.mall.common.Result;
import com.mall.module.order.entity.AfterSale;
import com.mall.module.order.entity.Order;
import com.mall.module.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/order")
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;

    @PostMapping
    @PreAuthorize("hasRole('BUYER')")
    public Result<Order> place(Authentication auth, @RequestBody Order order) {
        return Result.ok(orderService.placeOrder(Long.valueOf(auth.getName()), order));
    }

    @PutMapping("/{id}/pay")
    @PreAuthorize("hasRole('BUYER')")
    public Result<?> pay(Authentication auth, @PathVariable Long id) {
        orderService.payOrder(Long.valueOf(auth.getName()), id);
        return Result.ok();
    }

    @GetMapping("/buyer")
    @PreAuthorize("hasRole('BUYER')")
    public Result<List<Order>> buyerOrders(Authentication auth,
                                            @RequestParam(defaultValue = "1") int page,
                                            @RequestParam(defaultValue = "10") int size) {
        return Result.ok(orderService.buyerOrders(Long.valueOf(auth.getName()), page, size));
    }

    @GetMapping("/seller")
    @PreAuthorize("hasRole('SELLER')")
    public Result<List<Order>> sellerOrders(Authentication auth,
                                             @RequestParam(defaultValue = "1") int page,
                                             @RequestParam(defaultValue = "10") int size) {
        return Result.ok(orderService.sellerOrders(Long.valueOf(auth.getName()), page, size));
    }

    @PutMapping("/{id}/ship")
    @PreAuthorize("hasRole('SELLER')")
    public Result<?> ship(Authentication auth, @PathVariable Long id) {
        orderService.shipOrder(Long.valueOf(auth.getName()), id);
        return Result.ok();
    }

    @PutMapping("/{id}/receive")
    @PreAuthorize("hasRole('BUYER')")
    public Result<?> receive(Authentication auth, @PathVariable Long id) {
        orderService.receiveOrder(Long.valueOf(auth.getName()), id);
        return Result.ok();
    }

    @PostMapping("/{id}/after-sale")
    @PreAuthorize("hasRole('BUYER')")
    public Result<AfterSale> afterSale(Authentication auth, @PathVariable Long id,
                                        @RequestBody AfterSale afterSale) {
        return Result.ok(orderService.requestAfterSale(Long.valueOf(auth.getName()), id, afterSale));
    }
}
