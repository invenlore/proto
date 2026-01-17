# 19. Roadmap (MVP → High-load)

## MVP
- gateway + identity + wiki-write + wiki-read + media
- read-model простая: page_head + snapshots
- outbox: базовый worker (render можно упростить)

## Next
- render как отдельный воркер
- search + indexer
- permission snapshots и пространства (spaces)

## Scale
- Redis cluster
- MongoDB replica set + read preferences
- Разделение write/read по разным БД/кластерам
- CDN для публичных snapshots и S3
