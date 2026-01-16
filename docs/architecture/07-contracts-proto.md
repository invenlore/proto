# 07. Contracts: invenlore/proto

Цель: `proto` — единый источник правды для всех API (gRPC) и HTTP маппинга (gateway).

## Структура пакетов
Рекомендуемая:
- `proto/common/v1/*` — контекст, ошибки, пагинация
- `proto/identity/v1/*` — identity
- `proto/wiki/v1/*` — wiki read/write
- `proto/media/v1/*` — файлы/пресайны
- `proto/search/v1/*` — поиск

## Обязательные элементы
1. **Request context**
   - request_id, user_id, roles/permissions, tenant_id, idempotency_key
   - на wire: gRPC metadata (а не часть каждого сообщения)
2. **Единая модель ошибок**
   - `google.rpc.Status` + `details` (field violations, retry info)
3. **HTTP аннотации**
   - публичные RPC имеют `google.api.http` (grpc-gateway)
4. **OpenAPI**
   - генерируем спецификацию для документации и swagger-ui

## Версионирование
- Внутри `v1`: только добавление полей/методов, без переиспользования tag numbers.
- Ломающие изменения — `v2` или новые сущности.

## Генерация
Ожидаемые артефакты:
- Go types: `pkg/...`
- gRPC stubs: `pkg/...`
- grpc-gateway registrations: отдельный пакет или часть `pkg`
- OpenAPI: `openapi/*.json` (или аналог), используемый gateway для `/swagger/`

## Рекомендованное
- Добавить `templates/proto-guidelines.md` (см. папку templates) и ссылаться на него в README.
