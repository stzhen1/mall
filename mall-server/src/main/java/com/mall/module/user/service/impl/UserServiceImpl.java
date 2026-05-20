package com.mall.module.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mall.common.BusinessException;
import com.mall.module.user.entity.User;
import com.mall.module.user.entity.UserAddress;
import com.mall.module.user.mapper.UserAddressMapper;
import com.mall.module.user.mapper.UserMapper;
import com.mall.module.user.service.UserService;
import com.mall.security.JwtUtils;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    private final UserMapper userMapper;
    private final UserAddressMapper addressMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;

    @Override
    public Map<String, String> register(String username, String password, String role) {
        if (userMapper.selectCount(new LambdaQueryWrapper<User>().eq(User::getUsername, username)) > 0)
            throw new BusinessException("Username already exists");
        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole(role);
        user.setStatus(1);
        userMapper.insert(user);
        return buildTokens(user.getId(), role);
    }

    @Override
    public Map<String, String> login(String username, String password) {
        User user = userMapper.selectOne(new LambdaQueryWrapper<User>().eq(User::getUsername, username));
        if (user == null || !passwordEncoder.matches(password, user.getPassword()))
            throw new BusinessException("Invalid username or password");
        if (user.getStatus() == 0) throw new BusinessException("Account disabled");
        return buildTokens(user.getId(), user.getRole());
    }

    @Override
    public Map<String, String> refreshToken(String refreshToken) {
        try {
            Claims claims = jwtUtils.parseToken(refreshToken);
            Long userId = Long.valueOf(claims.getSubject());
            User user = userMapper.selectById(userId);
            if (user == null || user.getStatus() == 0) throw new BusinessException(401, "Invalid token");
            return buildTokens(userId, user.getRole());
        } catch (Exception e) { throw new BusinessException(401, "Invalid refresh token"); }
    }

    @Override
    public void logout(Long userId) { jwtUtils.removeRefreshToken(userId); }

    @Override
    public List<UserAddress> getAddresses(Long userId) {
        return addressMapper.selectList(new LambdaQueryWrapper<UserAddress>().eq(UserAddress::getUserId, userId));
    }

    @Override
    public UserAddress addAddress(Long userId, UserAddress address) {
        address.setUserId(userId);
        if (Boolean.TRUE.equals(address.getIsDefault())) {
            addressMapper.update(null, new LambdaUpdateWrapper<UserAddress>()
                    .eq(UserAddress::getUserId, userId).set(UserAddress::getIsDefault, false));
        }
        addressMapper.insert(address);
        return address;
    }

    @Override
    public void updateAddress(Long userId, Long addressId, UserAddress address) {
        UserAddress existing = addressMapper.selectById(addressId);
        if (existing == null || !existing.getUserId().equals(userId))
            throw new BusinessException("Address not found");
        if (Boolean.TRUE.equals(address.getIsDefault())) {
            addressMapper.update(null, new LambdaUpdateWrapper<UserAddress>()
                    .eq(UserAddress::getUserId, userId).set(UserAddress::getIsDefault, false));
        }
        address.setId(addressId);
        address.setUserId(userId);
        addressMapper.updateById(address);
    }

    @Override
    public void deleteAddress(Long userId, Long addressId) {
        UserAddress existing = addressMapper.selectById(addressId);
        if (existing == null || !existing.getUserId().equals(userId))
            throw new BusinessException("Address not found");
        addressMapper.deleteById(addressId);
    }

    @Override
    public void changePassword(Long userId, String oldPassword, String newPassword) {
        User user = userMapper.selectById(userId);
        if (user == null) throw new BusinessException("User not found");
        if (!passwordEncoder.matches(oldPassword, user.getPassword()))
            throw new BusinessException("Current password is incorrect");
        user.setPassword(passwordEncoder.encode(newPassword));
        userMapper.updateById(user);
    }

    @Override
    public Map<Long, User> getUserMap(Collection<Long> ids) {
        if (ids == null || ids.isEmpty()) return Collections.emptyMap();
        return userMapper.selectBatchIds(ids).stream()
                .collect(Collectors.toMap(User::getId, u -> u));
    }

    private Map<String, String> buildTokens(Long userId, String role) {
        Map<String, String> tokens = new HashMap<>();
        tokens.put("accessToken", jwtUtils.generateAccessToken(userId, role));
        tokens.put("refreshToken", jwtUtils.generateRefreshToken(userId));
        tokens.put("userId", userId.toString());
        tokens.put("role", role);
        return tokens;
    }
}
