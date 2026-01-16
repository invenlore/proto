# Invenlore Wiki Architecture (MVP → High-load)

Эта папка фиксирует архитектуру вики-системы invenlore и адаптацию под существующие проекты:

- **api.gateway** — входная точка HTTP → gRPC
- **identity.service** — identity/authn/authz (JWT/JWKS, RBAC)
- **proto** — единый контракт (protobuf + gRPC + HTTP аннотации + OpenAPI)

Ограничения и вводные:
- **Без брокеров сообщений** (Kafka/Rabbit/SQS и т.п.)
- Межсервисное взаимодействие: **gRPC**, сущности: **protobuf**
- Язык: **Go 1.24.11** (все сервисы)
- Хранилище данных: **MongoDB (MVP: single node)**
- Наблюдаемость: **Prometheus + Grafana**, логи через **FluentBit**
- Объектное хранилище: **Yandex Object Storage (S3), 100 GB**

## Навигация
- `00-overview.md` — цели, принципы, high-level
- `01-glossary.md` — термины
- `02-nfr-slo.md` — требования к нагрузке/латентности/надёжности
- `04-services.md` — список сервисов и границы ответственности
- `07-contracts-proto.md` — как устроен `proto` и правила
- `08-api-gateway.md` — требования к gateway (auth, error mapping, limits)
- `09-identity-service.md` — требования к `identity`
- `10-outbox-no-broker.md` — transactional outbox в Mongo, leases, идемпотентность
- `11-read-model-caching.md` — read-модель, кэширование, инвалидация “через версию”
- `13-media-s3.md` — вложения/пресайны/превью
- `14-observability.md` — метрики/логи/алерты
- `15-security.md` — безопасность и доверие
- `16-deployment-ops.md` — деплой, конфиги, readiness/health
- `adr/` — зафиксированные архитектурные решения
- `diagrams/` — Mermaid диаграммы (контекст, последовательности, данные)

## Как обновлять
- Любое существенное решение оформлять ADR в `adr/`.
- Любые изменения внешнего API — только через PR в `proto` + обновление `07-contracts-proto.md`.
