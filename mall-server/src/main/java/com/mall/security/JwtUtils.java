package com.mall.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.concurrent.TimeUnit;

@Component
public class JwtUtils {
    private final SecretKey key;
    private final long accessExpire;
    private final long refreshExpire;
    private final RedisTemplate<String, Object> redisTemplate;

    public JwtUtils(@Value("${jwt.secret}") String secret,
                    @Value("${jwt.access-token-expire}") long accessExpire,
                    @Value("${jwt.refresh-token-expire}") long refreshExpire,
                    RedisTemplate<String, Object> redisTemplate) {
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.accessExpire = accessExpire;
        this.refreshExpire = refreshExpire;
        this.redisTemplate = redisTemplate;
    }

    public String generateAccessToken(Long userId, String role) {
        return Jwts.builder()
                .subject(userId.toString()).claim("role", role)
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + accessExpire * 1000))
                .signWith(key).compact();
    }

    public String generateRefreshToken(Long userId) {
        String token = Jwts.builder()
                .subject(userId.toString()).issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + refreshExpire * 1000))
                .signWith(key).compact();
        redisTemplate.opsForValue().set("refresh:" + userId, token, refreshExpire, TimeUnit.SECONDS);
        return token;
    }

    public Claims parseToken(String token) {
        return Jwts.parser().verifyWith(key).build().parseSignedClaims(token).getPayload();
    }

    public boolean isTokenBlacklisted(String token) {
        return Boolean.TRUE.equals(redisTemplate.hasKey("blacklist:" + token));
    }

    public void blacklistToken(String token, long expireSeconds) {
        redisTemplate.opsForValue().set("blacklist:" + token, "1", expireSeconds, TimeUnit.SECONDS);
    }

    public void removeRefreshToken(Long userId) {
        redisTemplate.delete("refresh:" + userId);
    }
}
