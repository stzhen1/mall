package com.mall.security;

import com.mall.common.Result;
import com.mall.module.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class AuthController {
    private final UserService userService;
    private final JwtUtils jwtUtils;

    @PostMapping("/register")
    public Result<Map<String, String>> register(@RequestBody Map<String, String> body) {
        return Result.ok(userService.register(body.get("username"), body.get("password"), body.get("role")));
    }

    @PostMapping("/login")
    public Result<Map<String, String>> login(@RequestBody Map<String, String> body) {
        return Result.ok(userService.login(body.get("username"), body.get("password")));
    }

    @PostMapping("/refresh")
    public Result<Map<String, String>> refresh(@RequestBody Map<String, String> body) {
        return Result.ok(userService.refreshToken(body.get("refreshToken")));
    }

    @PostMapping("/logout")
    public Result<?> logout(Authentication auth, HttpServletRequest request) {
        if (auth != null) {
            String token = request.getHeader("Authorization");
            if (token != null && token.startsWith("Bearer ")) {
                token = token.substring(7);
                jwtUtils.blacklistToken(token, 7200);
            }
            userService.logout(Long.valueOf(auth.getName()));
        }
        return Result.ok();
    }
}
