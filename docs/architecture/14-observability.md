# 14. Observability (Prometheus + Grafana + FluentBit)

## Метрики (обязательный минимум)
На каждый сервис:
- `grpc_server_handling_seconds` (histogram) по method/code
- `grpc_server_requests_total` по method/code
- `process_cpu_seconds_total`, `go_memstats_*`
- saturation: goroutines, open_fds (если есть)
- Mongo driver metrics (latency, pool)

На gateway дополнительно:
- HTTP latency histogram
- rate-limit drops
- upstream errors/timeouts

На outbox workers:
- outbox_lag_seconds
- outbox_inflight
- outbox_failed_total, outbox_dead_total

## Логи
Формат: JSON (FluentBit-friendly)
Поля:
- timestamp, level
- service, version
- request_id
- user_id (если есть)
- rpc_method / http_path
- latency_ms
- status / grpc_code
- error (если есть)

## Трейсинг (позже)
Даже без полноценного tracing:
- request_id сквозной
- можно добавить `traceparent` и прокидывать как metadata

## Алерты (минимум)
- p95 latency выше порога (gateway, wiki-read)
- error rate > X%
- outbox lag растёт
- Mongo unavailable
