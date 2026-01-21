# 08. API Gateway (проект invenlore/api.gateway)

Gateway — edge сервис: принимает HTTP, выполняет общие политики и вызывает внутренние gRPC.

## Что нужно добавить

### 1) Регистрация маршрутов из proto

- Подключить grpc-gateway registrations, сгенерированные из `invenlore/proto`.
- Принцип: новый RPC с HTTP аннотацией появляется в gateway без ручного роутинга.

### 2) Auth middleware (JWT verify)

- Валидация access token локально, без вызова identity на каждый запрос.
- Ключи проверки получаем через JWKS от identity (кэшируем, поддерживаем ротацию).
- Прокидываем в gRPC metadata:
    - `x-request-id`
    - `x-user-id`
    - `x-roles` (или `x-scopes`)
    - `x-idempotency-key` (из заголовка `Idempotency-Key`)

### 3) Единое преобразование ошибок

- Маппинг gRPC codes → HTTP status.
- Структура тела ответа (JSON):
    - `code`, `message`, `details`, `request_id`
- Все ответы содержат `request_id`.

### 4) Limits/Resilience

- Таймауты per-route, выше уровнем, чем у сервисов.
- Ограничение размера body/headers.
- Rate limiting (IP/user/route) через Redis.
- Upstream connection pool, keepalive, ограничение параллелизма.

### 5) Observability

- `/metrics` (Prometheus)
- `/health` (liveness + readiness)
- `/swagger/` (swagger UI + OpenAPI из proto)
- Логи в JSON: request_id, method, path, status, latency_ms, user_id.

## Политики безопасности

- Доверять `X-Forwarded-For` только от вашего LB/ingress.
- CORS политика фиксируется конфигом.
