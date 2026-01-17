# 09. Identity (проект invenlore/identity.service)

identity — центр доверия: выдаёт токены, ключи (JWKS) и хранит модель ролей/прав.
Ранее сервис назывался user.service.

## Что нужно добавить

### 1) Разделение API на Public и Internal
- Public:
  - register/login/refresh/logout
  - get/update profile
- Internal:
  - JWKS (публичные ключи)
  - (опционально) ValidateToken
  - Authorize(user, action, resource) для ABAC случаев
  - GetUserBrief (без PII)

### 2) JWT + refresh tokens
- Access token: короткий TTL (например 10–20 минут).
- Refresh token: хранится в Mongo, можно отзывать.
- Сессии: коллекция `sessions` с индексами по user_id и expiry.

### 3) JWKS и ротация ключей
- Храним текущий активный keypair и набор публичных предыдущих ключей.
- JWKS endpoint отдаёт набор публичных ключей + kid.
- Gateway кэширует JWKS и регулярно обновляет.

### 4) RBAC
- Коллекции:
  - `users`, `roles`, `permissions`, `user_roles`
- JWT содержит roles/scopes (компактно).
- Для сложных политик — internal Authorize.

### 5) Идемпотентность
- На чувствительных методах (register, change email, etc.) — idem key при необходимости.
- На wiki-write idem key обязательно (в wiki-write), но identity должна поддерживать общий механизм (common patterns).

### 6) Interceptors / endpoints
- gRPC interceptors: request_id, logging, metrics, recovery, authz для internal методов.
- `/metrics`, `/healthz`, `/readyz` (ready только после миграций и подключения к Mongo).
