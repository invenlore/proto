# ADR-0011: Error model via google.rpc.Status

## Статус
Accepted (2026-01-17)

## Контекст
Нужен единый формат ошибок для gRPC и маппинга в HTTP.

## Решение
Используем `google.rpc.Status` + details (field violations, retry info). Gateway делает единый HTTP mapping.

## Последствия
+ Однородные ошибки для клиентов
- Нужно поддерживать конвенции и тесты
