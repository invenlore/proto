# 15. Security

## Транспорт
- Внутри кластера: gRPC по mTLS (план внедрения, можно поэтапно)
- Снаружи: HTTPS только через gateway

## Аутентификация
- JWT access token
- Refresh tokens в Mongo, отзыв

## Авторизация
- RBAC roles/scopes в JWT
- Для ABAC: internal Authorize(user, action, resource)

## Секреты
- Не хранить секреты в репо
- Использовать secret storage оркестратора/CI

## Защита от злоупотреблений
- Rate limiting на gateway
- Ограничение размеров body/headers
- Ограничение частоты логинов

## PII
- identity хранит PII
- остальные сервисы получают только user_id и минимальные поля через GetUserBrief.
