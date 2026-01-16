# Runbook: api.gateway

## Симптомы
- Резкий рост 5xx / 429
- p95 latency вырос

## Быстрая диагностика
- Проверить `/metrics` на error rate и timeouts
- Посмотреть логи по request_id

## Типовые причины
- Upstream недоступен / выросли таймауты
- Слишком жёсткий rate limit
- Утечка соединений / saturation

## Что делать
- Снизить нагрузку (rate limit), включить деградацию
- Проверить upstream readiness
