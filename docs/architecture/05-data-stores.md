# 05. Data stores

## MongoDB (MVP single node)
Используем разные базы для разделения ответственности даже на одной ноде:
- `invenlore-identity-service-db` — identity
- `invenlore-wiki-write-service-db` — каноника
- `invenlore-wiki-read-service-db` — read-модель
- `invenlore-outbox-db` — события/задачи (можно по доменам)

### Требования
- Индексы обязательны (см. 06/10).
- Документы не должны разрастаться без контроля (ревизии — отдельной коллекцией).

## Redis
- Кэш горячих страниц: ключи “page_id+revision_id”
- Rate-limit в gateway: token bucket / sliding window
- Короткие locks (если нужно): аккуратно, с TTL

## S3 (Yandex Object Storage)
- Бинарники и превью
- presigned URL flow (upload/download)
- Политики доступа: private + выдача через presign

## OpenSearch/Elasticsearch
- Полнотекстовый поиск (можно включить позже)
- Индексация через outbox worker
