# 16. Deployment & Ops

Текущее предположение: MVP развёрнут в одном окружении (single node), но сервисы должны быть готовы к горизонтальному масштабированию.

## Контейнеризация
- Каждый сервис: отдельный контейнер
- Конфиг через env

## Health/Readiness
- `/healthz`: всегда отвечает, если процесс жив
- `/readyz`: отвечает OK только после:
  - миграций
  - подключения к Mongo
  - (gateway) доступности JWKS кэша (получили ключи хотя бы один раз)

## Конфигурация
Рекомендуемые env:
- `SERVICE_NAME`, `SERVICE_VERSION`
- `GRPC_LISTEN_ADDR`, `HTTP_LISTEN_ADDR` (gateway)
- `MONGO_URI`, `MONGO_DB`
- `REDIS_ADDR` (если используем)
- `S3_ENDPOINT`, `S3_BUCKET`, `S3_ACCESS_KEY`, `S3_SECRET_KEY`
- `LOG_LEVEL`

## Rollouts
- Canary можно делать на уровне gateway маршрутов (процент трафика на новый upstream).
