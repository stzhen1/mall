# Mall E-Commerce System Design Spec

**Date:** 2026-05-13  
**Status:** Approved

## 1. Overview

A full-stack e-commerce management system supporting three roles: buyer, seller, and admin. Features include registration/login, product listing/delisting, purchasing with after-sales, and real-time chat.

## 2. Architecture

**Pattern:** Monolithic Spring Boot backend with 3 independent Vue SPAs.

```
Buyer Mall (Vue SPA) ──┐
Seller Dashboard (Vue SPA) ──┼── REST + WebSocket ── Spring Boot ── MySQL + Redis
Admin Panel (Vue SPA) ──┘
```

Spring Boot internal modules: `mall-user`, `mall-product`, `mall-order`, `mall-chat`.

## 3. Technology Stack

| Layer | Choice |
|-------|--------|
| Backend | Spring Boot 3.x + MyBatis-Plus |
| Security | Spring Security + JWT + Redis Blacklist |
| API Docs | Knife4j (Swagger) |
| Real-time | Spring WebSocket + STOMP |
| Frontend | Vue 3 + Vite + Element Plus + Pinia |
| HTTP Client | Axios with JWT refresh interceptors |
| Database | MySQL 8.x |
| Cache | Redis (JWT blacklist, session, hot data) |
| Build | Maven (backend) + Vite (frontend) |

## 4. Database Design

### Users Module (mall_user)
- **users** — id, username, password(bcrypt), role(BUYER/SELLER/ADMIN), phone, avatar, status, created_at
- **user_addresses** — id, user_id, receiver_name, phone, province, city, district, detail, is_default

### Product Module (mall_product)
- **categories** — id, name, parent_id, sort_order (tree structure)
- **products** — id, seller_id, category_id, name, description, price, stock, status(ON/OFF), main_image, created_at
- **product_images** — id, product_id, image_url, sort_order

### Order Module (mall_order)
- **orders** — id, order_no, buyer_id, seller_id, total_amount, status(PENDING→PAID→SHIPPED→RECEIVED; REFUNDING→REFUNDED; CANCELLED), address_snapshot(JSON), created_at
- **order_items** — id, order_id, product_id, product_name_snapshot, price_snapshot, quantity
- **after_sales** — id, order_id, buyer_id, type(REFUND/RETURN), reason, status, amount, created_at

### Chat Module (mall_chat)
- **conversations** — id, buyer_id, seller_id, last_message, last_message_time
- **messages** — id, conversation_id, sender_id, content, type(TEXT/IMAGE), is_read, created_at

## 5. API Endpoints

### User `/api/user`
- POST `/register` (public) — Register buyer or seller
- POST `/login` (public) — Login, returns JWT pair
- POST `/refresh` (public) — Refresh access token
- GET `/me` — Current user profile
- PUT `/me` — Update profile
- GET/POST `/addresses` — Manage shipping addresses

### Product `/api/product`
- GET `/list` (public) — Paginated product list with search/category filter
- GET `/{id}` (public) — Product detail
- POST `/` (seller) — Create product
- PUT `/{id}` (seller) — Update own product
- PUT `/{id}/status` (seller) — Toggle listing status (on/off shelf)
- DELETE `/{id}` (seller) — Delete product
- GET `/categories` (public) — Category tree

### Order `/api/order`
- POST `/` (buyer) — Place order
- PUT `/{id}/pay` (buyer) — Simulate payment
- GET `/buyer` (buyer) — Buyer's orders
- GET `/seller` (seller) — Seller's orders
- PUT `/{id}/ship` (seller) — Mark shipped
- PUT `/{id}/receive` (buyer) — Confirm receipt
- POST `/{id}/after-sale` (buyer) — Request after-sales

### Chat `/api/chat`
- GET `/conversations` — My conversation list
- GET `/messages/{convId}` — Paginated message history
- WS `/ws/chat` — Real-time WebSocket via STOMP

## 6. Frontend Routes

**Buyer Mall:** `/` home → `/product/:id` detail → `/orders` my orders → `/chat` conversations → `/chat/:id` chat

**Seller Dashboard:** `/` dashboard → `/products` manage → `/products/add` create → `/orders` manage → `/chat` conversations

**Admin Panel:** `/` dashboard → `/users` manage → `/products` review → `/orders` platform orders

## 7. Unified Response Format

```json
{ "code": 200, "message": "ok", "data": {...} }
{ "code": 400, "message": "business error message", "data": null }
{ "code": 401, "message": "Token expired", "data": null }
{ "code": 403, "message": "Permission denied", "data": null }
```

Backend: `@RestControllerAdvice` global exception handler.  
Frontend: Axios interceptor auto-refreshes on 401.

## 8. Security

- Passwords: BCrypt hashing
- JWT: Access Token 2h + Refresh Token 7d, Redis blacklist on logout
- Authorization: `@PreAuthorize` method-level, buyer/seller/admin role isolation
- Ownership: Sellers can only operate their own products (backend owner check)
- Orders: Dual buyer/seller verification
- Uploads: Whitelist extension check, 5MB max
- Injection: MyBatis-Plus parameterized queries; input sanitization

## 9. Testing

| Level | Tool | Scope |
|-------|------|-------|
| Unit | JUnit 5 + Mockito | Service layer core logic |
| API | Spring MockMvc | Controller correctness |
| Integration | H2 in-memory | Full business flow (register→list→order→pay→receive) |

No frontend tests for MVP speed.

## 10. Scope Boundaries

**In scope:** Buyer registration/shopping, seller product management, order lifecycle, simulated payment, STOMP-based real-time chat, admin oversight, after-sales requests.

**Out of scope (MVP):** Real payment integration (interface reserved), SMS/email verification, recommendation engine, inventory auto-deduction race condition handling, file upload (can hardcode image URLs), mobile app.
