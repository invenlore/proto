# 06. Domain model: Wiki

## Каноника (wiki-write)
Коллекции (пример):
- `pages`
  - `_id` (page_id)
  - `space_id`, `slug`, `title`
  - `head_revision_id`
  - `created_at`, `updated_at`
  - `status` (active/deleted)
  - `acl_policy` (ref или небольшой snapshot)
- `revisions`
  - `_id` (revision_id)
  - `page_id`
  - `author_id`
  - `base_revision_id` (для optimistic concurrency)
  - `content_markdown`
  - `content_hash`
  - `created_at`
- `page_slugs` (если нужен быстрый резолв slug→page_id)
- `idempotency`
  - `_id`: `${user_id}:${operation}:${idempotency_key}`
  - `result_ref` (revision_id и т.п.), `created_at`

Индексы:
- `pages`: `(space_id, slug)` unique; `(head_revision_id)`
- `revisions`: `(page_id, created_at desc)`, `(page_id, _id)`; по `content_hash` если надо дедуп
- `idempotency`: unique по `_id`, TTL по `created_at` (например 7–30 дней)

## Read-модель (wiki-read)
Коллекции (пример):
- `page_snapshots`
  - `_id`: `${page_id}:${revision_id}`
  - `page_id`, `revision_id`
  - `title`, `slug`, `space_id`
  - `html` (санитайзенный)
  - `toc`, `summary`, `word_count`
  - `links_out` (список page_id/slug)
  - `created_at`
- `page_head`
  - `_id`: `page_id`
  - `head_revision_id`
  - `title/slug/space_id` (для листингов)
  - `updated_at`
  - `permission_snapshot` (быстрый check)

Индексы:
- `page_snapshots`: `(page_id, revision_id)` unique (или `_id`), `(space_id, slug, revision_id)`
- `page_head`: `(space_id, slug)` unique, `(updated_at desc)`

## Принцип кэша
- Кэшируем snapshot по `page_id+revision_id` (immutable).
- “Latest” резолвим через `page_head` + короткий TTL.
