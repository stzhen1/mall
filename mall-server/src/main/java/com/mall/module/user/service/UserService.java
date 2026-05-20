package com.mall.module.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mall.module.user.entity.User;
import com.mall.module.user.entity.UserAddress;
import java.util.Collection;
import java.util.List;
import java.util.Map;

public interface UserService extends IService<User> {
    Map<String, String> register(String username, String password, String role);
    Map<String, String> login(String username, String password);
    Map<String, String> refreshToken(String refreshToken);
    void logout(Long userId);
    List<UserAddress> getAddresses(Long userId);
    UserAddress addAddress(Long userId, UserAddress address);
    void updateAddress(Long userId, Long addressId, UserAddress address);
    void deleteAddress(Long userId, Long addressId);
    void changePassword(Long userId, String oldPassword, String newPassword);
    Map<Long, User> getUserMap(Collection<Long> ids);
}
