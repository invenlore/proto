# Runbook: MongoDB

## Симптомы
- Выросла latency запросов
- Connection pool exhausted

## Диагностика
- Проверить индексы (slow queries)
- Проверить размер документов (snapshots)
- Проверить ресурсы CPU/RAM/Disk

## Что делать
- Добавить индексы, поправить запросы
- Вынести read-model в отдельную БД/коллекцию
