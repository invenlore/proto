# 11. Read-model и кэширование

## Проблема
Если читать канонику (revisions) на каждый запрос, latency и нагрузка растут.

## Решение
Делаем read-model:
- `page_head` — “указатель” на head_revision_id + мета
- `page_snapshots` — immutable snapshots (HTML/TOC/summary) по (page_id, revision_id)

Обновление read-model:
- через outbox события из wiki-write

## Кэширование (ключевая стратегия)
Кэш “immutable”:
- key: `page:{page_id}:{revision_id}:{variant}`
- TTL: большой (часы/дни) или вообще без TTL при LRU eviction

Кэш “latest pointer”:
- key: `page_head:{page_id}`
- TTL: короткий (5–30 секунд)

Плюсы:
- инвалидация почти не нужна: новая ревизия → новый ключ
- “latest” меняется, но указатель кэшируется коротко

## ACL на read-пути
Не делаем обязательный вызов identity/acl:
- в `page_head` держим permission snapshot
- JWT содержит roles/scopes → проверка локально в wiki-read

Если политика меняется:
- outbox событие `PageAclChanged` → обновление snapshot.

## ETag/Cache-Control
Gateway может прокидывать/выставлять ETag по `revision_id`.
Для публичного контента: CDN кеширует HTML snapshots.
