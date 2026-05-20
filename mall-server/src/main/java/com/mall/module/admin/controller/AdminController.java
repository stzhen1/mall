package com.mall.module.admin.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mall.common.Result;
import com.mall.module.order.entity.Order;
import com.mall.module.order.mapper.OrderMapper;
import com.mall.module.user.entity.User;
import com.mall.module.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin")
@PreAuthorize("hasRole('ADMIN')")
@RequiredArgsConstructor
public class AdminController {
    private final UserMapper userMapper;
    private final OrderMapper orderMapper;

    @GetMapping("/users")
    public Result<Page<User>> users(@RequestParam(defaultValue = "1") int page,
                                     @RequestParam(defaultValue = "10") int size) {
        Page<User> result = userMapper.selectPage(new Page<>(page, size),
                new LambdaQueryWrapper<User>().orderByDesc(User::getCreatedAt));
        result.getRecords().forEach(u -> u.setPassword(null));
        return Result.ok(result);
    }

    @PutMapping("/users/{id}/status")
    public Result<?> toggleUserStatus(@PathVariable Long id) {
        User user = userMapper.selectById(id);
        if (user != null) {
            user.setStatus(user.getStatus() == 1 ? 0 : 1);
            userMapper.updateById(user);
        }
        return Result.ok();
    }

    @GetMapping("/orders")
    public Result<Page<Order>> orders(@RequestParam(defaultValue = "1") int page,
                                       @RequestParam(defaultValue = "10") int size) {
        return Result.ok(orderMapper.selectPage(new Page<>(page, size),
                new LambdaQueryWrapper<Order>().orderByDesc(Order::getCreatedAt)));
    }
}
