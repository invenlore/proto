# 19. Roadmap (MVP → High-load)

## MVP
- gateway + identity + wiki-write + wiki-read + media
- read-model простая: page_head + snapshots
- outbox: базовый worker (render можно упростить)

## Next
- render-service как отдельный воркер
- search-service + indexer
- permission snapshots и пространства (spaces)

## Scale
- Redis cluster
- Mongo replica set + read preferences
- Разделение write/read по разным БД/кластерам
- CDN для публичных snapshots и S3
