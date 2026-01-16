# Runbook: Outbox workers

## Симптомы
- outbox_lag_seconds растёт
- много failed/dead сообщений

## Диагностика
- Сколько воркеров запущено
- Есть ли lock contention (lease_until постоянно продлевается)
- Ошибки в last_error

## Что делать
- Увеличить число воркеров
- Уменьшить batch size/увеличить lease duration
- Исправить идемпотентность обработчика
