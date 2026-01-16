# Runbook: OpenSearch

## Симптомы
- Поиск медленный/503
- Индексация отстаёт

## Диагностика
- Cluster health
- Queue/lag у indexer (outbox)

## Что делать
- Масштабировать indexer
- Проверить mapping и размер документов
