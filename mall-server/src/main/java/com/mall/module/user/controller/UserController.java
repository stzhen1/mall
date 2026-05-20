package com.mall.module.user.controller;

import com.mall.common.Result;
import com.mall.module.user.entity.User;
import com.mall.module.user.entity.UserAddress;
import com.mall.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/me")
    public Result<User> me(Authentication auth) {
        return Result.ok(userService.getById(Long.valueOf(auth.getName())));
    }

    @PutMapping("/me")
    public Result<?> updateMe(Authentication auth, @RequestBody User user) {
        user.setId(Long.valueOf(auth.getName()));
        user.setPassword(null); user.setRole(null);
        userService.updateById(user);
        return Result.ok();
    }

    @PutMapping("/password")
    public Result<?> changePassword(Authentication auth, @RequestBody Map<String, String> body) {
        userService.changePassword(Long.valueOf(auth.getName()),
                body.get("oldPassword"), body.get("newPassword"));
        return Result.ok();
    }

    @GetMapping("/addresses")
    public Result<List<UserAddress>> addresses(Authentication auth) {
        return Result.ok(userService.getAddresses(Long.valueOf(auth.getName())));
    }

    @PostMapping("/addresses")
    public Result<UserAddress> addAddress(Authentication auth, @RequestBody UserAddress address) {
        return Result.ok(userService.addAddress(Long.valueOf(auth.getName()), address));
    }

    @PutMapping("/addresses/{id}")
    public Result<?> updateAddress(Authentication auth, @PathVariable Long id, @RequestBody UserAddress address) {
        userService.updateAddress(Long.valueOf(auth.getName()), id, address);
        return Result.ok();
    }

    @DeleteMapping("/addresses/{id}")
    public Result<?> deleteAddress(Authentication auth, @PathVariable Long id) {
        userService.deleteAddress(Long.valueOf(auth.getName()), id);
        return Result.ok();
    }
}
