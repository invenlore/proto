# ADR-0007: Read-model denormalization + cache by revision

## Статус
Accepted (2026-01-17)

## Контекст
Read-heavy нагрузка требует быстрых ответов и минимальной инвалидации.

## Решение
Вводим read-model и кэшируем snapshots по `(page_id, revision_id)`.

## Последствия
+ Практически нет инвалидации (immutable ключи)
- Нужны воркеры обновления read-модели
