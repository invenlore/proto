# 12. Search

## MVP
- Можно отложить, оставив простой поиск по заголовкам в Mongo (ограниченно).

## Production
- OpenSearch/Elasticsearch
- Индексация через outbox: `PageRevisionCreated` → indexer обновляет документ.

## Модель документа
- id: `page_id`
- title, slug, space_id
- content_plain (из markdown, без HTML)
- updated_at, head_revision_id
- visibility/snapshot policy hash (чтобы фильтровать выдачу)

## Запросы
- search(query, filters, pagination)
- suggest(prefix)
- ranking: простая (BM25) + boosts по title.

## Консистентность
- Индекс eventually consistent.
- Wiki-read всегда источник истины по “актуальной ревизии”; search отдаёт id и мету.
