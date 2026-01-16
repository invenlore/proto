# 02. NFR / SLO (черновик)

> Цифры — ориентиры для MVP→production. Уточняются по факту нагрузки.

## SLO (цели)
- **Availability (read path)**: 99.9%
- **p95 latency (GetPage)**: <= 150 ms (внутри кластера; с CDN может быть меньше)
- **p95 latency (Search)**: <= 400 ms
- **Write latency (UpdatePage)**: p95 <= 250 ms (без ожидания рендера/индексации)

## Нагрузка
- Read-heavy: 95–99% запросов — чтение.
- Пики: кратковременные x5–x10 от среднего.

## Ограничения
- Без брокера → at-least-once доставка задач из outbox.
- Mongo single-node на MVP → внимательно к индексам и размерам документов.

## Требования к сервисам
- Все gRPC вызовы с deadline.
- Ограничение payload размеров.
- Структурные логи: request_id обязателен.
- Метрики Prometheus: latency histogram + error counters + saturation.

## Деградация
- Если render/search отстают: чтение отдаёт последний доступный snapshot.
- Если search недоступен: API возвращает 503, остальное работает.
