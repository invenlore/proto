# ADR-0012: Permission snapshots for read path

## Статус
Accepted (2026-01-17)

## Контекст
Вызов identity/acl на каждом чтении увеличивает latency и нагрузку.

## Решение
Храним permission snapshot в read-модели (page_head). Проверяем права локально по JWT claims.

## Последствия
+ Быстрый read path
- Политика прав становится eventually consistent (через outbox)
