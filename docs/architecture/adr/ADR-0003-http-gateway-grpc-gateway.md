# ADR-0003: HTTP edge via api.gateway (grpc-gateway)

## Статус
Accepted (2026-01-17)

## Контекст
Клиентам нужен HTTP API, внутри система должна работать на gRPC.

## Решение
Используем api.gateway: HTTP → gRPC, а маппинг фиксируем в proto через `google.api.http`.

## Последствия
+ Один “edge” слой политик (auth, limits, error mapping)
+ Документация OpenAPI из proto
- Gateway становится критическим компонентом (Tier-0)
