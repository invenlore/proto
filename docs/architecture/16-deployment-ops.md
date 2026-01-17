# 16. Deployment & Ops

Текущее предположение: MVP развёрнут в одном окружении (single node), но сервисы должны быть готовы к горизонтальному масштабированию.

## Контейнеризация
- Каждый сервис: отдельный контейнер
- Конфиг через env (все доступные переменные описаны в пакете invenlore/core в файле `.env.template`)

## Health/Readiness
- HTTP `/health`: всегда отвечает, если процесс жив
- gRPC `/<serviceName><ServiceName>Service./HealthCheck` (напр.: `/identity.IdentityService/HealthCheck`): отвечает OK только после:
  - миграций
  - подключения к MongoDB
  - (gateway) доступности JWKS кэша (получили ключи хотя бы один раз)

## Конфигурация
Рекомендуемые env для сервисов:
- `APP_ENV`, `APP_LOG_LEVEL`
- `GRPC_PORT`, `HEALTH_PORT`
- `MONGO_URI`, `MONGO_DATABASE_NAME`
- `REDIS_ADDRESS` (если используем)
- `S3_ENDPOINT`, `S3_BUCKET`, `S3_ACCESS_KEY_ID`, `S3_ACCESS_SECRET_KEY`

Рекомендуемые env для gateway:
- `APP_ENV`, `APP_LOG_LEVEL`
- `HTTP_PORT`, `HEALTH_PORT`
- `<SERVICE_NAME>_SERVICE_ENDPOINT` (напр.: `IDENTITY_SERVICE_ENDPOINT=identityservice:8080`)

## Rollouts
- Canary можно делать на уровне gateway маршрутов (процент трафика на новый upstream).
