# 04. Services

## Обязательные сервисы (MVP)
1. **api.gateway**
   - HTTP → gRPC
   - authn (JWT verify), limits, error mapping, swagger
2. **identity**
   - регистрация/логин/refresh
   - JWKS, RBAC
3. **wiki-write**
   - запись ревизий и метаданных
   - outbox события
4. **wiki-read**
   - быстрые чтения read-модели
   - кэширование
5. **media**
   - пресайны, метаданные файлов, политики доступа

## Рекомендуемые после MVP
6. **render**
7. **search**

## Сервисные зависимости (high-level)
- gateway → identity/wiki*/media/search
- wiki-write → identity (опционально для ABAC), media (валидация ссылок), outbox
- wiki-read → redis + read-model mongo
- render/search/media workers → outbox (polling)

## Антипаттерны
- Не делать обязательный hop в identity на каждом read (используем JWT claims и/или permission snapshots).
- Не отдавать канонику напрямую на чтение (read-model обязателен при росте).
