# Runbook: Redis

## Симптомы
- Cache miss rate высокий
- Latency выросла на чтении

## Диагностика
- Проверить memory usage/evictions
- Проверить ключи и TTL

## Что делать
- Подстроить TTL для page_head
- Убедиться, что immutable snapshots кэшируются по revision_id
