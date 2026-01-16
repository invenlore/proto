# ADR-0005: Outbox polling + leases in Mongo

## Статус
Accepted (2026-01-17)

## Контекст
Нужно безопасно распределять обработку задач между воркерами.

## Решение
Worker забирает задачу через `findOneAndUpdate` (atomic claim) и выставляет lease.

## Последствия
+ Нет двойной обработки при конкуренции
- Нужна настройка lease/backoff
