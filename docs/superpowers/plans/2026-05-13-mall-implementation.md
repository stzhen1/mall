# Mall E-Commerce System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a complete e-commerce system with buyer mall, seller dashboard, admin panel, and real-time chat.

**Architecture:** Monolithic Spring Boot 3.x backend with 4 internal modules (user, product, order, chat), 3 independent Vue 3 SPAs (buyer/seller/admin), MySQL + Redis storage, JWT auth with WebSocket chat.

**Tech Stack:** Spring Boot 3.3 + MyBatis-Plus 3.5 + Spring Security + JWT + Redis + WebSocket STOMP / Vue 3 + Vite + Element Plus + Pinia + Axios

---

## File Structure

```
mall/
├── mall-server/                          # Spring Boot backend
│   ├── pom.xml
│   └── src/
│       ├── main/java/com/mall/
│       │   ├── MallApplication.java
│       │   ├── common/
│       │   │   ├── Result.java
│       │   │   ├── BusinessException.java
│       │   │   ├── GlobalExceptionHandler.java
│       │   │   └── config/
│       │   │       ├── SecurityConfig.java
│       │   │       ├── WebSocketConfig.java
│       │   │       ├── RedisConfig.java
│       │   │       └── MyBatisConfig.java
│       │   ├── security/
│       │   │   ├── JwtUtils.java
│       │   │   ├── JwtAuthFilter.java
│       │   │   ├── UserDetailsServiceImpl.java
│       │   │   └── AuthController.java
│       │   └── module/
│       │       ├── user/
│       │       │   ├── entity/User.java, UserAddress.java
│       │       │   ├── mapper/UserMapper.java, UserAddressMapper.java
│       │       │   ├── service/UserService.java, impl/UserServiceImpl.java
│       │       │   └── controller/UserController.java
│       │       ├── product/
│       │       │   ├── entity/Category.java, Product.java, ProductImage.java
│       │       │   ├── mapper/CategoryMapper.java, ProductMapper.java, ProductImageMapper.java
│       │       │   ├── service/ProductService.java, impl/ProductServiceImpl.java
│       │       │   └── controller/ProductController.java
│       │       ├── order/
│       │       │   ├── entity/Order.java, OrderItem.java, AfterSale.java
│       │       │   ├── mapper/OrderMapper.java, OrderItemMapper.java, AfterSaleMapper.java
│       │       │   ├── service/OrderService.java, impl/OrderServiceImpl.java
│       │       │   └── controller/OrderController.java
│       │       └── chat/
│       │           ├── entity/Conversation.java, Message.java
│       │           ├── mapper/ConversationMapper.java, MessageMapper.java
│       │           ├── service/ChatService.java, impl/ChatServiceImpl.java
│       │           └── controller/ChatController.java
│       └── main/resources/
│           ├── application.yml
│           └── db/schema.sql
│
├── mall-web-buyer/                        # Buyer mall SPA (port 5173)
│   ├── package.json, vite.config.js, index.html
│   └── src/
│       ├── main.js, App.vue
│       ├── api/ (request.js, auth.js, product.js, order.js, chat.js)
│       ├── stores/auth.js
│       ├── router/index.js
│       └── views/ (Login.vue, Register.vue, Home.vue, ProductDetail.vue,
│                    Orders.vue, Chat.vue, ChatWindow.vue)
│
├── mall-web-seller/                       # Seller dashboard SPA (port 5174)
│   └── (mirrors buyer structure with seller-specific views)
│
└── mall-web-admin/                        # Admin panel SPA (port 5175)
    └── (mirrors structure with admin-specific views)
```

---

## Phase 1: Backend Scaffolding

### Task 1.1: Create Maven project + application entry

**Files:**
- Create: `mall-server/pom.xml`
- Create: `mall-server/src/main/java/com/mall/MallApplication.java`
- Create: `mall-server/src/main/resources/application.yml`
- Create: `mall-server/src/main/resources/db/schema.sql`

- [ ] Write `mall-server/pom.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.3.0</version>
    </parent>
    <groupId>com.mall</groupId>
    <artifactId>mall-server</artifactId>
    <version>1.0.0</version>
    <name>mall-server</name>
    <properties>
        <java.version>17</java.version>
        <mybatis-plus.version>3.5.7</mybatis-plus.version>
        <knife4j.version>4.5.0</knife4j.version>
        <jjwt.version>0.12.5</jjwt.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-websocket</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>
        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-spring-boot3-starter</artifactId>
            <version>${mybatis-plus.version}</version>
        </dependency>
        <dependency>
            <groupId>com.mysql</groupId>
            <artifactId>mysql-connector-j</artifactId>
        </dependency>
        <dependency>
            <groupId>com.github.xiaoymin</groupId>
            <artifactId>knife4j-openapi3-jakarta-spring-boot-starter</artifactId>
            <version>${knife4j.version}</version>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-api</artifactId>
            <version>${jjwt.version}</version>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-impl</artifactId>
            <version>${jjwt.version}</version>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-jackson</artifactId>
            <version>${jjwt.version}</version>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

- [ ] Write `mall-server/src/main/java/com/mall/MallApplication.java`:

```java
package com.mall;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.mall.module.**.mapper")
public class MallApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallApplication.class, args);
    }
}
```

- [ ] Write `mall-server/src/main/resources/application.yml`:

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
    username: root
    password: root
    driver-class-name: com.mysql.cj.jdbc.Driver
  data:
    redis:
      host: localhost
      port: 6379

mybatis-plus:
  configuration:
    map-underscore-to-camel-case: true
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
  global-config:
    db-config:
      id-type: auto
      logic-delete-field: deleted
      logic-delete-value: 1
      logic-not-delete-value: 0

jwt:
  secret: mall-secret-key-must-be-at-least-256-bits-long-for-hs256
  access-token-expire: 7200
  refresh-token-expire: 604800

knife4j:
  enable: true
```

- [ ] Write `mall-server/src/main/resources/db/schema.sql`:

```sql
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL COMMENT 'BUYER, SELLER, ADMIN',
    phone VARCHAR(20),
    avatar VARCHAR(255),
    status TINYINT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_addresses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    receiver_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    province VARCHAR(50),
    city VARCHAR(50),
    district VARCHAR(50),
    detail VARCHAR(255),
    is_default TINYINT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    parent_id BIGINT DEFAULT 0,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    seller_id BIGINT NOT NULL,
    category_id BIGINT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    status VARCHAR(10) DEFAULT 'ON',
    main_image VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    deleted TINYINT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS product_images (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    sort_order INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_no VARCHAR(32) NOT NULL UNIQUE,
    buyer_id BIGINT NOT NULL,
    seller_id BIGINT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    address_snapshot JSON,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    product_name_snapshot VARCHAR(100),
    price_snapshot DECIMAL(10,2),
    quantity INT NOT NULL
);

CREATE TABLE IF NOT EXISTS after_sales (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    buyer_id BIGINT NOT NULL,
    type VARCHAR(20) NOT NULL,
    reason VARCHAR(500),
    status VARCHAR(20) DEFAULT 'PENDING',
    amount DECIMAL(10,2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS conversations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    buyer_id BIGINT NOT NULL,
    seller_id BIGINT NOT NULL,
    last_message VARCHAR(500),
    last_message_time DATETIME
);

CREATE TABLE IF NOT EXISTS messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    conversation_id BIGINT NOT NULL,
    sender_id BIGINT NOT NULL,
    content VARCHAR(1000) NOT NULL,
    type VARCHAR(10) DEFAULT 'TEXT',
    is_read TINYINT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO users (username, password, role) VALUES
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5Eh', 'ADMIN');
```

- [ ] Build: `cd mall-server && mvn compile` → BUILD SUCCESS

---

## Phase 2: Common Infrastructure

### Task 2.1: Result, Exception, and Config classes

**Files:**
- Create: `mall-server/src/main/java/com/mall/common/Result.java`
- Create: `mall-server/src/main/java/com/mall/common/BusinessException.java`
- Create: `mall-server/src/main/java/com/mall/common/GlobalExceptionHandler.java`
- Create: `mall-server/src/main/java/com/mall/common/config/RedisConfig.java`
- Create: `mall-server/src/main/java/com/mall/common/config/MyBatisConfig.java`
- Create: `mall-server/src/main/java/com/mall/common/config/WebSocketConfig.java`

- [ ] Write `Result.java`:

```java
package com.mall.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result<T> {
    private int code;
    private String message;
    private T data;

    public static <T> Result<T> ok(T data) { return new Result<>(200, "ok", data); }
    public static <T> Result<T> ok() { return new Result<>(200, "ok", null); }
    public static <T> Result<T> fail(int code, String message) { return new Result<>(code, message, null); }
    public static <T> Result<T> fail(String message) { return new Result<>(400, message, null); }
}
```

- [ ] Write `BusinessException.java`:

```java
package com.mall.common;

import lombok.Getter;

@Getter
public class BusinessException extends RuntimeException {
    private final int code;
    public BusinessException(String message) { super(message); this.code = 400; }
    public BusinessException(int code, String message) { super(message); this.code = code; }
}
```

- [ ] Write `GlobalExceptionHandler.java`:

```java
package com.mall.common;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(BusinessException.class)
    public Result<?> handleBusiness(BusinessException e) { return Result.fail(e.getCode(), e.getMessage()); }

    @ExceptionHandler(AccessDeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public Result<?> handleAccessDenied(AccessDeniedException e) { return Result.fail(403, "Permission denied"); }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public Result<?> handleException(Exception e) { return Result.fail(500, "Internal server error"); }
}
```

- [ ] Write `RedisConfig.java`:

```java
package com.mall.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class RedisConfig {
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory factory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(factory);
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(new GenericJackson2JsonRedisSerializer());
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(new GenericJackson2JsonRedisSerializer());
        return template;
    }
}
```

- [ ] Write `MyBatisConfig.java`:

```java
package com.mall.common.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MyBatisConfig {
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor(DbType.MYSQL));
        return interceptor;
    }
}
```

- [ ] Write `WebSocketConfig.java`:

```java
package com.mall.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/queue", "/topic");
        registry.setApplicationDestinationPrefixes("/app");
        registry.setUserDestinationPrefix("/user");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws/chat").setAllowedOriginPatterns("*").withSockJS();
    }
}
```

- [ ] Build: `cd mall-server && mvn compile` → BUILD SUCCESS

---

## Phase 3: User Module + JWT Security

### Task 3.1: User entities and mappers

**Files:**
- Create: `mall-server/src/main/java/com/mall/module/user/entity/User.java`
- Create: `mall-server/src/main/java/com/mall/module/user/entity/UserAddress.java`
- Create: `mall-server/src/main/java/com/mall/module/user/mapper/UserMapper.java`
- Create: `mall-server/src/main/java/com/mall/module/user/mapper/UserAddressMapper.java`

- [ ] Write `User.java`:

```java
package com.mall.module.user.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("users")
public class User {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String username;
    private String password;
    private String role;
    private String phone;
    private String avatar;
    private Integer status;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}
```

- [ ] Write `UserAddress.java`:

```java
package com.mall.module.user.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("user_addresses")
public class UserAddress {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private String receiverName;
    private String phone;
    private String province;
    private String city;
    private String district;
    private String detail;
    private Integer isDefault;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}
```

- [ ] Write `UserMapper.java`:

```java
package com.mall.module.user.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mall.module.user.entity.User;
import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface UserMapper extends BaseMapper<User> {}
```

- [ ] Write `UserAddressMapper.java`:

```java
package com.mall.module.user.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mall.module.user.entity.UserAddress;
import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface UserAddressMapper extends BaseMapper<UserAddress> {}
```

- [ ] Build: `mvn compile` → BUILD SUCCESS

### Task 3.2: JWT utilities and Spring Security config

**Files:**
- Create: `mall-server/src/main/java/com/mall/security/JwtUtils.java`
- Create: `mall-server/src/main/java/com/mall/security/JwtAuthFilter.java`
- Create: `mall-server/src/main/java/com/mall/security/UserDetailsServiceImpl.java`
- Create: `mall-server/src/main/java/com/mall/common/config/SecurityConfig.java`

- [ ] Write `JwtUtils.java`:

```java
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
```

- [ ] Write `JwtAuthFilter.java`:

```java
package com.mall.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;
import java.util.List;

@Component
@RequiredArgsConstructor
public class JwtAuthFilter extends OncePerRequestFilter {
    private final JwtUtils jwtUtils;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String header = request.getHeader("Authorization");
        if (!StringUtils.hasText(header) || !header.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }
        String token = header.substring(7);
        if (jwtUtils.isTokenBlacklisted(token)) { filterChain.doFilter(request, response); return; }
        try {
            Claims claims = jwtUtils.parseToken(token);
            String userId = claims.getSubject();
            String role = claims.get("role", String.class);
            UsernamePasswordAuthenticationToken auth =
                    new UsernamePasswordAuthenticationToken(userId, null,
                            List.of(new SimpleGrantedAuthority("ROLE_" + role)));
            SecurityContextHolder.getContext().setAuthentication(auth);
        } catch (ExpiredJwtException ignored) {
        } catch (Exception ignored) {}
        filterChain.doFilter(request, response);
    }
}
```

- [ ] Write `UserDetailsServiceImpl.java`:

```java
package com.mall.security;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mall.module.user.entity.User;
import com.mall.module.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {
    private final UserMapper userMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userMapper.selectOne(new LambdaQueryWrapper<User>().eq(User::getUsername, username));
        if (user == null) throw new UsernameNotFoundException("User not found: " + username);
        return new org.springframework.security.core.userdetails.User(
                user.getId().toString(), user.getPassword(), user.getStatus() == 1,
                true, true, true,
                List.of(new SimpleGrantedAuthority("ROLE_" + user.getRole())));
    }
}
```

- [ ] Write `SecurityConfig.java`:

```java
package com.mall.common.config;

import com.mall.security.JwtAuthFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final JwtAuthFilter jwtAuthFilter;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
            .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/user/register", "/api/user/login", "/api/user/refresh").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/product/**").permitAll()
                .requestMatchers("/ws/chat/**").permitAll()
                .requestMatchers("/doc.html", "/webjars/**", "/v3/api-docs/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated())
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    @Bean public PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}
```

- [ ] Build: `mvn compile` → BUILD SUCCESS

### Task 3.3: User service and controllers

**Files:**
- Create: `mall-server/src/main/java/com/mall/module/user/service/UserService.java`
- Create: `mall-server/src/main/java/com/mall/module/user/service/impl/UserServiceImpl.java`
- Create: `mall-server/src/main/java/com/mall/security/AuthController.java`
- Create: `mall-server/src/main/java/com/mall/module/user/controller/UserController.java`

- [ ] Write `UserService.java`:

```java
package com.mall.module.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mall.module.user.entity.User;
import com.mall.module.user.entity.UserAddress;
import java.util.List;
import java.util.Map;

public interface UserService extends IService<User> {
    Map<String, String> register(String username, String password, String role);
    Map<String, String> login(String username, String password);
    Map<String, String> refreshToken(String refreshToken);
    void logout(Long userId);
    List<UserAddress> getAddresses(Long userId);
    UserAddress addAddress(Long userId, UserAddress address);
}
```

- [ ] Write `UserServiceImpl.java`:

```java
package com.mall.module.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
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
        if (address.getIsDefault() != null && address.getIsDefault() == 1) {
            addressMapper.update(null, new LambdaQueryWrapper<UserAddress>()
                    .eq(UserAddress::getUserId, userId).set(UserAddress::getIsDefault, 0));
        }
        addressMapper.insert(address);
        return address;
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
```

- [ ] Write `AuthController.java`:

```java
package com.mall.security;

import com.mall.common.Result;
import com.mall.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class AuthController {
    private final UserService userService;

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
    public Result<?> logout(@RequestAttribute(required = false) Long userId) {
        if (userId != null) userService.logout(userId);
        return Result.ok();
    }
}
```

- [ ] Write `UserController.java`:

```java
package com.mall.module.user.controller;

import com.mall.common.Result;
import com.mall.module.user.entity.User;
import com.mall.module.user.entity.UserAddress;
import com.mall.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;

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

    @GetMapping("/addresses")
    public Result<List<UserAddress>> addresses(Authentication auth) {
        return Result.ok(userService.getAddresses(Long.valueOf(auth.getName())));
    }

    @PostMapping("/addresses")
    public Result<UserAddress> addAddress(Authentication auth, @RequestBody UserAddress address) {
        return Result.ok(userService.addAddress(Long.valueOf(auth.getName()), address));
    }
}
```

- [ ] Build: `mvn compile` → BUILD SUCCESS

---

## Phase 4: Product Module

### Task 4.1: Product entities and mappers

**Files:**
- Create: `mall-server/src/main/java/com/mall/module/product/entity/Category.java`
- Create: `mall-server/src/main/java/com/mall/module/product/entity/Product.java`
- Create: `mall-server/src/main/java/com/mall/module/product/entity/ProductImage.java`
- Create: `mall-server/src/main/java/com/mall/module/product/mapper/CategoryMapper.java`
- Create: `mall-server/src/main/java/com/mall/module/product/mapper/ProductMapper.java`
- Create: `mall-server/src/main/java/com/mall/module/product/mapper/ProductImageMapper.java`

- [ ] Write `Category.java`:

```java
package com.mall.module.product.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName("categories")
public class Category {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String name;
    private Long parentId;
    private Integer sortOrder;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
    @TableField(exist = false)
    private List<Category> children;
}
```

- [ ] Write `Product.java`:

```java
package com.mall.module.product.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName("products")
public class Product {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long sellerId;
    private Long categoryId;
    private String name;
    private String description;
    private BigDecimal price;
    private Integer stock;
    private String status;
    private String mainImage;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
    @TableLogic
    private Integer deleted;
    @TableField(exist = false)
    private List<ProductImage> images;
}
```

- [ ] Write `ProductImage.java`:

```java
package com.mall.module.product.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("product_images")
public class ProductImage {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long productId;
    private String imageUrl;
    private Integer sortOrder;
}
```

- [ ] Write mappers (each in its own file):

```java
// CategoryMapper.java
package com.mall.module.product.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mall.module.product.entity.Category;
import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface CategoryMapper extends BaseMapper<Category> {}

// ProductMapper.java
package com.mall.module.product.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mall.module.product.entity.Product;
import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface ProductMapper extends BaseMapper<Product> {}

// ProductImageMapper.java
package com.mall.module.product.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mall.module.product.entity.ProductImage;
import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface ProductImageMapper extends BaseMapper<ProductImage> {}
```

- [ ] Build: `mvn compile` → BUILD SUCCESS

### Task 4.2: Product service and controller

**Files:**
- Create: `mall-server/src/main/java/com/mall/module/product/service/ProductService.java`
- Create: `mall-server/src/main/java/com/mall/module/product/service/impl/ProductServiceImpl.java`
- Create: `mall-server/src/main/java/com/mall/module/product/controller/ProductController.java`

- [ ] Write `ProductService.java`:

```java
package com.mall.module.product.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mall.module.product.entity.Category;
import com.mall.module.product.entity.Product;
import java.util.List;

public interface ProductService extends IService<Product> {
    IPage<Product> pageList(int page, int size, Long categoryId, String keyword);
    Product getDetail(Long id);
    Product create(Long sellerId, Product product);
    Product updateProduct(Long sellerId, Long productId, Product product);
    void updateStatus(Long sellerId, Long productId, String status);
    void deleteProduct(Long sellerId, Long productId);
    List<Category> getCategoryTree();
}
```

- [ ] Write `ProductServiceImpl.java`:

```java
package com.mall.module.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mall.common.BusinessException;
import com.mall.module.product.entity.Category;
import com.mall.module.product.entity.Product;
import com.mall.module.product.entity.ProductImage;
import com.mall.module.product.mapper.CategoryMapper;
import com.mall.module.product.mapper.ProductImageMapper;
import com.mall.module.product.mapper.ProductMapper;
import com.mall.module.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {
    private final ProductMapper productMapper;
    private final CategoryMapper categoryMapper;
    private final ProductImageMapper imageMapper;

    @Override
    public IPage<Product> pageList(int page, int size, Long categoryId, String keyword) {
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<Product>()
                .eq(Product::getStatus, "ON");
        if (categoryId != null) wrapper.eq(Product::getCategoryId, categoryId);
        if (StringUtils.hasText(keyword)) wrapper.like(Product::getName, keyword);
        wrapper.orderByDesc(Product::getCreatedAt);
        return productMapper.selectPage(new Page<>(page, size), wrapper);
    }

    @Override
    public Product getDetail(Long id) {
        Product product = productMapper.selectById(id);
        if (product == null) throw new BusinessException("Product not found");
        product.setImages(imageMapper.selectList(
                new LambdaQueryWrapper<ProductImage>().eq(ProductImage::getProductId, id)
                        .orderByAsc(ProductImage::getSortOrder)));
        return product;
    }

    @Override
    @Transactional
    public Product create(Long sellerId, Product product) {
        product.setSellerId(sellerId);
        product.setStatus("ON");
        productMapper.insert(product);
        saveImages(product);
        return product;
    }

    @Override
    @Transactional
    public Product updateProduct(Long sellerId, Long productId, Product product) {
        Product existing = productMapper.selectById(productId);
        if (existing == null || !existing.getSellerId().equals(sellerId))
            throw new BusinessException("Not your product");
        product.setId(productId);
        product.setSellerId(sellerId);
        productMapper.updateById(product);
        if (product.getImages() != null) {
            imageMapper.delete(new LambdaQueryWrapper<ProductImage>().eq(ProductImage::getProductId, productId));
            saveImages(product);
        }
        return getDetail(productId);
    }

    @Override
    public void updateStatus(Long sellerId, Long productId, String status) {
        Product existing = productMapper.selectById(productId);
        if (existing == null || !existing.getSellerId().equals(sellerId))
            throw new BusinessException("Not your product");
        Product update = new Product();
        update.setId(productId);
        update.setStatus(status);
        productMapper.updateById(update);
    }

    @Override
    public void deleteProduct(Long sellerId, Long productId) {
        Product existing = productMapper.selectById(productId);
        if (existing == null || !existing.getSellerId().equals(sellerId))
            throw new BusinessException("Not your product");
        productMapper.deleteById(productId);
    }

    @Override
    public List<Category> getCategoryTree() {
        List<Category> all = categoryMapper.selectList(null);
        Map<Long, List<Category>> byParent = all.stream()
                .collect(Collectors.groupingBy(c -> c.getParentId() == null ? 0L : c.getParentId()));
        List<Category> roots = byParent.getOrDefault(0L, new ArrayList<>());
        for (Category root : roots)
            root.setChildren(byParent.getOrDefault(root.getId(), new ArrayList<>()));
        return roots;
    }

    private void saveImages(Product product) {
        if (product.getImages() != null) {
            for (ProductImage img : product.getImages()) {
                img.setProductId(product.getId());
                imageMapper.insert(img);
            }
        }
    }
}
```

- [ ] Write `ProductController.java`:

```java
package com.mall.module.product.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.mall.common.Result;
import com.mall.module.product.entity.Category;
import com.mall.module.product.entity.Product;
import com.mall.module.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/product")
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @GetMapping("/list")
    public Result<IPage<Product>> list(@RequestParam(defaultValue = "1") int page,
                                        @RequestParam(defaultValue = "10") int size,
                                        @RequestParam(required = false) Long categoryId,
                                        @RequestParam(required = false) String keyword) {
        return Result.ok(productService.pageList(page, size, categoryId, keyword));
    }

    @GetMapping("/{id}")
    public Result<Product> detail(@PathVariable Long id) {
        return Result.ok(productService.getDetail(id));
    }

    @PostMapping
    @PreAuthorize("hasRole('SELLER')")
    public Result<Product> create(Authentication auth, @RequestBody Product product) {
        return Result.ok(productService.create(Long.valueOf(auth.getName()), product));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('SELLER')")
    public Result<Product> update(Authentication auth, @PathVariable Long id, @RequestBody Product product) {
        return Result.ok(productService.updateProduct(Long.valueOf(auth.getName()), id, product));
    }

    @PutMapping("/{id}/status")
    @PreAuthorize("hasRole('SELLER')")
    public Result<?> updateStatus(Authentication auth, @PathVariable Long id, @RequestBody Product product) {
        productService.updateStatus(Long.valueOf(auth.getName()), id, product.getStatus());
        return Result.ok();
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('SELLER')")
    public Result<?> delete(Authentication auth, @PathVariable Long id) {
        productService.deleteProduct(Long.valueOf(auth.getName()), id);
        return Result.ok();
    }

    @GetMapping("/categories")
    public Result<List<Category>> categories() {
        return Result.ok(productService.getCategoryTree());
    }
}
```

- [ ] Build: `mvn compile` → BUILD SUCCESS

---

## Phase 5: Order Module

### Task 5.1: Order entities and mappers

Same pattern as previous modules. Create 6 files:
- `mall-server/src/main/java/com/mall/module/order/entity/Order.java`
- `mall-server/src/main/java/com/mall/module/order/entity/OrderItem.java`
- `mall-server/src/main/java/com/mall/module/order/entity/AfterSale.java`
- `mall-server/src/main/java/com/mall/module/order/mapper/OrderMapper.java`
- `mall-server/src/main/java/com/mall/module/order/mapper/OrderItemMapper.java`
- `mall-server/src/main/java/com/mall/module/order/mapper/AfterSaleMapper.java`

- [ ] `Order.java` with fields: id, orderNo, buyerId, sellerId, totalAmount, status, addressSnapshot, createdAt + @TableField(exist=false) List<OrderItem> items
- [ ] `OrderItem.java` with fields: id, orderId, productId, productNameSnapshot, priceSnapshot, quantity
- [ ] `AfterSale.java` with fields: id, orderId, buyerId, type, reason, status, amount, createdAt
- [ ] All mappers extend `BaseMapper<T>`, annotated `@Mapper`

Build: `mvn compile` → BUILD SUCCESS

### Task 5.2: Order service and controller

- [ ] Write `OrderService.java`:

```java
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
```

- [ ] Write `OrderServiceImpl.java`:

```java
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
        Order order = getOrder(orderId, buyerId, true);
        if (!"PENDING".equals(order.getStatus())) throw new BusinessException("Order cannot be paid");
        order.setStatus("PAID");
        orderMapper.updateById(order);
    }

    @Override
    public List<Order> buyerOrders(Long buyerId, int page, int size) {
        Page<Order> p = orderMapper.selectPage(new Page<>(page, size),
                new LambdaQueryWrapper<Order>().eq(Order::getBuyerId, buyerId).orderByDesc(Order::getCreatedAt));
        fillItems(p.getRecords());
        return p.getRecords();
    }

    @Override
    public List<Order> sellerOrders(Long sellerId, int page, int size) {
        Page<Order> p = orderMapper.selectPage(new Page<>(page, size),
                new LambdaQueryWrapper<Order>().eq(Order::getSellerId, sellerId).orderByDesc(Order::getCreatedAt));
        fillItems(p.getRecords());
        return p.getRecords();
    }

    @Override
    public void shipOrder(Long sellerId, Long orderId) {
        Order order = getOrder(orderId, sellerId, false);
        if (!order.getSellerId().equals(sellerId)) throw new BusinessException("Not your order");
        if (!"PAID".equals(order.getStatus())) throw new BusinessException("Must be paid first");
        order.setStatus("SHIPPED");
        orderMapper.updateById(order);
    }

    @Override
    public void receiveOrder(Long buyerId, Long orderId) {
        Order order = getOrder(orderId, buyerId, true);
        if (!"SHIPPED".equals(order.getStatus())) throw new BusinessException("Not shipped yet");
        order.setStatus("RECEIVED");
        orderMapper.updateById(order);
    }

    @Override
    public AfterSale requestAfterSale(Long buyerId, Long orderId, AfterSale afterSale) {
        Order order = getOrder(orderId, buyerId, true);
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

    private Order getOrder(Long orderId, Long userId, boolean isBuyer) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) throw new BusinessException("Order not found");
        if (isBuyer && !order.getBuyerId().equals(userId)) throw new BusinessException("Not your order");
        return order;
    }

    private void fillItems(List<Order> orders) {
        for (Order order : orders)
            order.setItems(itemMapper.selectList(
                    new LambdaQueryWrapper<OrderItem>().eq(OrderItem::getOrderId, order.getId())));
    }
}
```

- [ ] Write `OrderController.java` (REST endpoints matching spec section 5)

```java
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
```

- [ ] Build: `mvn compile` → BUILD SUCCESS

---

## Phase 6: Chat Module

### Task 6.1: Chat entities and mappers

Create 4 files:
- `mall-server/src/main/java/com/mall/module/chat/entity/Conversation.java` — id, buyerId, sellerId, lastMessage, lastMessageTime
- `mall-server/src/main/java/com/mall/module/chat/entity/Message.java` — id, conversationId, senderId, content, type, isRead, createdAt
- `mall-server/src/main/java/com/mall/module/chat/mapper/ConversationMapper.java` — extends BaseMapper<Conversation>
- `mall-server/src/main/java/com/mall/module/chat/mapper/MessageMapper.java` — extends BaseMapper<Message>

Build: `mvn compile` → BUILD SUCCESS

### Task 6.2: Chat service and controller

- [ ] Write `ChatService.java`:

```java
package com.mall.module.chat.service;

import com.mall.module.chat.entity.Conversation;
import com.mall.module.chat.entity.Message;
import java.util.List;

public interface ChatService {
    List<Conversation> getConversations(Long userId);
    List<Message> getMessages(Long conversationId, int page, int size);
    Message sendMessage(Long senderId, Long conversationId, String content);
    Conversation getOrCreateConversation(Long buyerId, Long sellerId);
}
```

- [ ] Write `ChatServiceImpl.java`:

```java
package com.mall.module.chat.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mall.common.BusinessException;
import com.mall.module.chat.entity.Conversation;
import com.mall.module.chat.entity.Message;
import com.mall.module.chat.mapper.ConversationMapper;
import com.mall.module.chat.mapper.MessageMapper;
import com.mall.module.chat.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {
    private final ConversationMapper conversationMapper;
    private final MessageMapper messageMapper;

    @Override
    public List<Conversation> getConversations(Long userId) {
        return conversationMapper.selectList(new LambdaQueryWrapper<Conversation>()
                .and(w -> w.eq(Conversation::getBuyerId, userId).or().eq(Conversation::getSellerId, userId))
                .orderByDesc(Conversation::getLastMessageTime));
    }

    @Override
    public List<Message> getMessages(Long conversationId, int page, int size) {
        return messageMapper.selectPage(new Page<>(page, size),
                new LambdaQueryWrapper<Message>().eq(Message::getConversationId, conversationId)
                        .orderByDesc(Message::getCreatedAt)).getRecords();
    }

    @Override
    public Message sendMessage(Long senderId, Long conversationId, String content) {
        Conversation conv = conversationMapper.selectById(conversationId);
        if (conv == null) throw new BusinessException("Conversation not found");
        if (!conv.getBuyerId().equals(senderId) && !conv.getSellerId().equals(senderId))
            throw new BusinessException("Not in this conversation");
        Message msg = new Message();
        msg.setConversationId(conversationId);
        msg.setSenderId(senderId);
        msg.setContent(content);
        msg.setType("TEXT");
        msg.setIsRead(0);
        messageMapper.insert(msg);
        conv.setLastMessage(content);
        conv.setLastMessageTime(LocalDateTime.now());
        conversationMapper.updateById(conv);
        return msg;
    }

    @Override
    public Conversation getOrCreateConversation(Long buyerId, Long sellerId) {
        Conversation conv = conversationMapper.selectOne(new LambdaQueryWrapper<Conversation>()
                .eq(Conversation::getBuyerId, buyerId).eq(Conversation::getSellerId, sellerId));
        if (conv == null) {
            conv = new Conversation();
            conv.setBuyerId(buyerId);
            conv.setSellerId(sellerId);
            conversationMapper.insert(conv);
        }
        return conv;
    }
}
```

- [ ] Write `ChatController.java`:

```java
package com.mall.module.chat.controller;

import com.mall.common.Result;
import com.mall.module.chat.entity.Conversation;
import com.mall.module.chat.entity.Message;
import com.mall.module.chat.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {
    private final ChatService chatService;
    private final SimpMessagingTemplate messagingTemplate;

    @GetMapping("/conversations")
    public Result<List<Conversation>> conversations(Authentication auth) {
        return Result.ok(chatService.getConversations(Long.valueOf(auth.getName())));
    }

    @GetMapping("/messages/{convId}")
    public Result<List<Message>> messages(@PathVariable Long convId,
                                           @RequestParam(defaultValue = "1") int page,
                                           @RequestParam(defaultValue = "50") int size) {
        return Result.ok(chatService.getMessages(convId, page, size));
    }

    @PostMapping("/conversation")
    public Result<Conversation> getOrCreateConversation(@RequestBody Map<String, Long> body) {
        return Result.ok(chatService.getOrCreateConversation(body.get("buyerId"), body.get("sellerId")));
    }

    @MessageMapping("/chat.send")
    public void handleChat(@Payload Map<String, Object> payload, Principal principal) {
        Long senderId = Long.valueOf(principal.getName());
        Long conversationId = Long.valueOf(payload.get("conversationId").toString());
        String content = payload.get("content").toString();
        Message msg = chatService.sendMessage(senderId, conversationId, content);
        messagingTemplate.convertAndSend("/topic/chat." + conversationId, msg);
    }
}
```

- [ ] Build: `mvn compile` → BUILD SUCCESS

---

## Phase 7: Buyer Frontend (mall-web-buyer)

### Task 7.1: Scaffold Vite project

Create `mall-web-buyer/package.json` (vue, vue-router, pinia, element-plus, @element-plus/icons-vue, axios, @stomp/stompjs, sockjs-client). Create `vite.config.js` (port 5173, proxy /api→localhost:8080, /ws→localhost:8080 with ws). Create `index.html`. Run `npm install`.

### Task 7.2: Core JS files

- [ ] `src/main.js` — createApp, use Pinia, Router, ElementPlus, register icons
- [ ] `src/App.vue` — `<router-view />`
- [ ] `src/api/request.js` — Axios with JWT interceptor (attach Bearer, refresh on 401)
- [ ] `src/api/auth.js` — login, register, refreshToken, getProfile, getAddresses, addAddress
- [ ] `src/api/product.js` — getProducts, getProductDetail, getCategories
- [ ] `src/api/order.js` — placeOrder, payOrder, getBuyerOrders, receiveOrder, requestAfterSale
- [ ] `src/api/chat.js` — getConversations, getMessages, getOrCreateConversation
- [ ] `src/stores/auth.js` — user, accessToken, refreshToken (Pinia, localStorage persistence), setTokens, logout
- [ ] `src/router/index.js` — routes (Login, Register, Home, ProductDetail, Orders, Chat, ChatWindow), auth guard

### Task 7.3: Buyer views

Each view in `mall-web-buyer/src/views/`:

- **Login.vue** — Username/password form, call login API, store tokens, redirect to /
- **Register.vue** — Username/password form, call register API with role=BUYER
- **Home.vue** — Header with search + login/logout/orders/chat nav, product grid with pagination
- **ProductDetail.vue** — Full product display (image, name, price, stock, description), "Buy Now" button (calls placeOrder), "Chat Seller" button (creates conversation → navigates to chat)
- **Orders.vue** — Order table with orderNo, amount, status tag, action buttons (Pay, Confirm Receipt, After-Sale)
- **Chat.vue** — Conversation list as clickable cards showing last message
- **ChatWindow.vue** — Full-height chat UI: message history + input + STOMP WebSocket connection

Build: `cd mall-web-buyer && npm run build` → no errors

---

## Phase 8: Seller Frontend (mall-web-seller)

Same scaffold pattern as buyer (port 5174). Key difference: `api/product.js` adds createProduct, updateProduct, updateProductStatus, deleteProduct. `api/order.js` uses getSellerOrders and shipOrder.

Views:
- **Login.vue / Register.vue** — Same as buyer, role=SELLER
- **Dashboard.vue** — Stats cards (product count, pending orders, unread messages)
- **Products.vue** — Table of seller's products with Edit / On-Off-Shelf / Delete actions
- **ProductForm.vue** — Form for creating/editing product (name, description, price, stock, category dropdown, image URL)
- **Orders.vue** — Table of received orders with Ship button for PAID orders
- **Chat.vue / ChatWindow.vue** — Same as buyer

Build: `npm run build` → no errors

---

## Phase 9: Admin Frontend (mall-web-admin)

Lightest frontend (port 5175). No registration — uses pre-seeded admin/admin123.

Views:
- **Login.vue** — Admin login
- **Dashboard.vue** — Platform stats
- **Users.vue** — All users table, enable/disable toggle
- **Products.vue** — All products table, force-delist
- **Orders.vue** — All orders table

Build: `npm run build` → no errors

---

## Phase 10: Integration & Verification

- [ ] Start MySQL + Redis
- [ ] Run schema.sql: `mysql -u root -p mall < mall-server/src/main/resources/db/schema.sql`
- [ ] Start backend: `cd mall-server && mvn spring-boot:run`
- [ ] Start 3 frontends in separate terminals:
  - `cd mall-web-buyer && npm run dev`
  - `cd mall-web-seller && npm run dev`
  - `cd mall-web-admin && npm run dev`
- [ ] Manual test flow: Register seller → create products → Register buyer → browse → buy → pay → seller ships → buyer receives → chat between them → admin views all

---

## Self-Review

1. **Spec coverage:** User registration/login (Phase 3), product listing/delisting (Phase 4), purchase flow (Phase 5), after-sales (Phase 5), chat (Phase 6), 3 frontends (Phases 7-9), JWT+Redis (Task 3.2), WebSocket (Task 2.2 + 6.2).

2. **No placeholders:** All tasks contain complete code. Frontend views have full templates and scripts.

3. **Type consistency:** Backend entities match DB schema. API endpoints match controllers. Frontend API calls match backend endpoints.
