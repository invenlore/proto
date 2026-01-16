# 10. Outbox (без брокера) — MongoDB

Цель: обеспечить “асинхронные” задачи (рендер, индексирование, пересчёты) без Kafka/Rabbit.

## 10.1 Модель outbox документа
Коллекция: `outbox`

Поля (пример):
- `_id` (ObjectId или string uuid)
- `stream` (например `wiki`, `media`, `search`)
- `event_type` (например `PageRevisionCreated`)
- `aggregate_id` (page_id)
- `payload` (bytes/base64 или вложенный объект)
- `created_at`
- `status`: `new | processing | done | failed | dead`
- `lease_owner` (worker_id)
- `lease_until` (datetime)
- `attempts` (int)
- `last_error` (string, truncated)
- `next_retry_at` (datetime)

Индексы:
- `(status, next_retry_at, created_at)`
- `(lease_until)` (для поиска “протухших” leases)
- (опционально) `(stream, status, next_retry_at)`

## 10.2 Claim/lease алгоритм (атомарно)
Worker делает `findOneAndUpdate`:
- фильтр: `status in [new, failed] AND next_retry_at <= now` OR (`status=processing AND lease_until < now`)
- update:
  - `status=processing`
  - `lease_owner=worker_id`
  - `lease_until=now+lease_duration`
  - `attempts += 1`
- sort: `created_at asc`
- return: документ для обработки

## 10.3 Завершение
- On success: `status=done`, `lease_owner=null`, `lease_until=null`
- On retryable error:
  - `status=failed`
  - `next_retry_at = now + backoff(attempts)`
- On poison (например attempts > N):
  - `status=dead` + перенос payload в `outbox_dead` (опционально)

## 10.4 Идемпотентность обработчиков
Поскольку доставка at-least-once:
- результаты пишем через upsert по ключу (page_id, revision_id)
- избегаем “append” без уникальности

Пример:
- render пишет `page_snapshots` с `_id = page_id:revision_id`
- search индексирует документ с id = page_id:revision_id или page_id

## 10.5 Транзакционность
Mongo транзакции возможны в replica set. На MVP single node часто всё равно поднимают как replica set (1-node rs) ради транзакций.
Если транзакции недоступны:
- гарантируем “почти transactional” через порядок записи и идемпотентность:
  - write в канонику
  - запись outbox
  - при сбое возможен “пропуск outbox” → периодический reconciler (cron) сверяет head ревизии и наличие snapshot.

## 10.6 Наблюдаемость outbox
Метрики:
- outbox_new_total, outbox_done_total, outbox_failed_total
- outbox_lag_seconds (now - created_at для oldest pending)
- processing_inflight
Алерты:
- lag > threshold
- dead messages растут
