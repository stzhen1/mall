# Mall — Full-Stack E-Commerce Platform

A production-grade e-commerce platform with buyer/seller/admin portals, real-time WebSocket chat, JWT authentication, and a glassmorphism UI design system.

## Architecture

```
mall/
├── mall-server/           Spring Boot 3.3 + MyBatis-Plus + Redis + WebSocket
├── mall-web-buyer/        Vue 3 buyer storefront  (port 5173)
├── mall-web-seller/       Vue 3 seller dashboard  (port 5174)
└── mall-web-admin/        Vue 3 admin panel       (port 5175)
```

## Features

| Module | Description |
|--------|-------------|
| **User** | Registration, login, JWT auth (access + refresh tokens), profile management, address CRUD, password change |
| **Product** | Listing, search, categorization, image gallery, seller CRUD, admin status control |
| **Order** | Place order, seller shipment, status tracking (PAID → SHIPPED → DELIVERED), after-sales |
| **Chat** | Native WebSocket real-time messaging, JWT handshake auth, conversation list by username |
| **Admin** | Dashboard overview, user management (toggle status), product oversight, order monitoring |

## Tech Stack

### Backend
- **Java 17**, **Spring Boot 3.3**, **Spring Security**, **Spring WebSocket**
- **MyBatis-Plus 3.5.7** — ORM with logical delete
- **MySQL** — primary database
- **Redis** — JWT blacklist + refresh token storage
- **JJWT 0.12.5** — JWT token generation/validation
- **Knife4j 4.5.0** — API documentation (Swagger UI)

### Frontend (all three apps)
- **Vue 3** (Composition API + `<script setup>`)
- **Vue Router 4**, **Pinia** (state management)
- **Element Plus 2.7** — UI component library
- **Axios** — HTTP client with interceptors
- **Native WebSocket** — real-time chat (no STOMP/SockJS)
- **Vite 5** — build tool with dev proxy

## Getting Started

### Prerequisites

- Java 17+
- Maven 3.9+
- MySQL 8.0+
- Redis 6+
- Node.js 18+

### 1. Database Setup

```sql
CREATE DATABASE mall CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Then run the schema and seed scripts:

```bash
mysql -u root -p mall < mall-server/src/main/resources/db/schema.sql
mysql -u root -p mall < mall-server/src/main/resources/db/seed.sql --default-character-set=utf8mb4
```

### 2. Configure `application.yml`

Edit `mall-server/src/main/resources/application.yml`:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/mall?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai
    username: root
    password: your_password
  data:
    redis:
      host: localhost
      port: 6379
```

### 3. Start Backend

```bash
cd mall-server
mvn spring-boot:run
```

Backend starts on `http://localhost:8080`. API docs at `http://localhost:8080/doc.html`.

### 4. Start Frontends

```bash
# Buyer storefront
cd mall-web-buyer
npm install
npm run dev

# Seller dashboard
cd mall-web-seller
npm install
npm run dev

# Admin panel
cd mall-web-admin
npm install
npm run dev
```

### 5. Access

| App | URL | Test Account |
|-----|-----|--------------|
| Buyer | http://localhost:5173 | `buyer01` / `123456` |
| Seller | http://localhost:5174 | `seller01` / `123456` |
| Admin | http://localhost:5175 | `admin` / `admin123` |

## API Overview

### Auth
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/user/register` | Register (BUYER/SELLER) |
| POST | `/api/user/login` | Login, returns JWT |
| POST | `/api/user/refresh` | Refresh access token |
| POST | `/api/user/logout` | Logout, blacklist token |

### User
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/user/me` | Get profile |
| PUT | `/api/user/me` | Update profile |
| PUT | `/api/user/password` | Change password |
| GET | `/api/user/addresses` | List addresses |
| POST | `/api/user/addresses` | Add address |
| PUT | `/api/user/addresses/{id}` | Update address |
| DELETE | `/api/user/addresses/{id}` | Delete address |

### Product
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/product/list` | Paginated list (public) |
| GET | `/api/product/{id}` | Detail (public) |
| POST | `/api/product` | Create (seller) |
| PUT | `/api/product/{id}` | Update (seller) |
| PUT | `/api/product/{id}/status` | Toggle ON/OFF |
| DELETE | `/api/product/{id}` | Delete (seller) |
| GET | `/api/product/categories` | Category tree |

### Order
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/order` | Place order |
| GET | `/api/order/my` | My orders |
| GET | `/api/order/seller` | Seller's received orders |
| PUT | `/api/order/{id}/ship` | Mark shipped |

### Chat
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/chat/conversations` | Conversation list (with peer username) |
| GET | `/api/chat/messages/{convId}` | Message history |
| POST | `/api/chat/conversation` | Get or create conversation |
| POST | `/api/chat/messages` | Send message (REST fallback) |
| WS | `/ws/chat?token={jwt}` | Real-time chat (WebSocket) |

### Admin
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/admin/users` | List all users |
| PUT | `/api/admin/users/{id}/status` | Toggle user status |
| GET | `/api/admin/orders` | List all orders |

## WebSocket Chat

The chat system uses native Spring WebSocket with JWT authentication:

1. Client connects to `ws://localhost:8080/ws/chat?token={jwt}`
2. `JwtHandshakeInterceptor` validates the JWT during handshake
3. `ChatWebSocketHandler` maps sessions to userIds via `ConcurrentHashMap`
4. Messages are JSON: `{"receiverId": N, "content": "..."}`
5. Messages deliver in real-time; fallback via REST if receiver is offline

## Seed Data

The seed script populates:
- **23 users** (10 buyers, 10 sellers, 3 admins)
- **38 addresses**, **20 categories**, **60 products**
- **89 product images**, **50 orders**, **52 order items**
- **15 after-sale records**, **15 conversations**, **54 messages**

All test users share password `123456` (except admin: `admin123`).

## Project Structure

```
mall-server/src/main/java/com/mall/
├── MallApplication.java
├── common/
│   ├── BusinessException.java, Result.java, GlobalExceptionHandler.java
│   └── config/ (SecurityConfig, WebSocketConfig, MyBatisConfig, RedisConfig)
├── security/
│   ├── AuthController.java, JwtAuthFilter.java, JwtUtils.java
│   └── UserDetailsServiceImpl.java
└── module/
    ├── user/   (controller, entity, mapper, service)
    ├── product/(controller, entity, mapper, service)
    ├── order/  (controller, entity, mapper, service)
    ├── chat/   (controller, entity, mapper, service, websocket)
    └── admin/  (controller)
```

## Design System

The frontend uses a cohesive **glassmorphism** design language:

- Semi-transparent white cards with `backdrop-filter: blur()`
- Soft gradient backgrounds with subtle noise texture
- Serif display font (Cormorant Garamond) for headings, Inter for body
- Gentle animations (staggered fade-up, float, hover lift)
- CSS variable system for consistent theming across all three apps

Theme file: `src/assets/glass-theme.css` (shared identically across all apps).

## License

MIT
