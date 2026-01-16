# Proto guidelines (invenlore/proto)

## Версионирование
- Все публичные API: `*/v1/*`.
- Ломающие изменения — только через новую версию (`v2`) или новый метод/сообщение.
- Внутри `v1` допускается **только** добавление новых полей с новыми номерами.

## Имена и пакеты
- Пакеты: `common.v1`, `identity.v1`, `wiki.v1`, `media.v1`, `search.v1`, ...
- Go package option (`option go_package`) должен указывать на `github.com/invenlore/proto/pkg/...`.

## HTTP аннотации
- Публичные методы имеют `google.api.http` аннотации (grpc-gateway).
- GET только для read.
- POST/PUT/PATCH для write.
- Путь всегда начинается с `/v1/...`.

## Ошибки
- Используем `google.rpc.Status` с `details` (см. `common/v1/errors.proto`).
- Каждая ошибка должна включать `request_id`.

## Пагинация
- Используем `page_size` + `page_token`, возвращаем `next_page_token`.
- Стабильный порядок сортировки обязателен.

## Идемпотентность
- Для write-методов: поддерживаем `Idempotency-Key` (в HTTP) / `x-idempotency-key` (в metadata).
