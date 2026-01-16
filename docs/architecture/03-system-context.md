# 03. System context

## Внешние акторы
- Web/mobile клиенты
- Admin/оператор
- (Опционально) интеграции через API

## Основные потоки
- Чтение страниц: клиент → gateway → wiki-read → (Redis/Mongo)
- Редактирование: клиент → gateway → wiki-write → Mongo (каноника + outbox)
- Рендер: render-worker → outbox → HTML snapshots
- Поиск: search-indexer → outbox → OpenSearch, клиент → gateway → search
- Вложения: клиент → media (presign) → S3 → media (finalize)

См. диаграммы в `diagrams/`.
