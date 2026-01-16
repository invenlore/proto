# Runbook: Incident - latency spike

## Шаги
1) Определить компонент: gateway vs wiki-read vs Mongo
2) Проверить saturation (CPU/RAM) и connection pools
3) Проверить cache hit rate
4) Проверить error codes (timeouts/unavailable)
5) Принять меры:
   - включить деградацию (если есть)
   - временно ужесточить rate limit
   - масштабировать read replicas / воркеры
