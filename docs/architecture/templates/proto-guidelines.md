# Proto guidelines (invenlore/proto)

## Версионирование

- Все публичные API: `*/v1/*`.
- Ломающие изменения — только через новую версию (`v2`) или новый метод/сообщение.
- Внутри `v1` допускается **только** добавление новых полей с новыми номерами.

## Имена и пакеты

- Пакеты: `common.v1`, `identity.v1`, `wiki.v1`, `media.v1`, `search.v1`, ...
- Go package option (`option go_package`) должен указывать на `github.com/invenlore/proto/pkg/...`.

### Go package naming (идиоматичный стандарт)

**Стандарт для всех сервисов:**

- Каталоги: `proto/<service>/v1/*.proto`
- Proto package: `package <service>.v1;`
- Go import path: `github.com/invenlore/proto/pkg/<service>/v1`
- Go package name (после `;` в `go_package`): **без подчёркиваний**, с версией как суффикс:
    - `identityv1`, `wikiv1`, `mediav1`, `commonv1`.

**Пример:**

```proto
package identity.v1;
option go_package = "github.com/invenlore/proto/pkg/identity/v1;identityv1";
```

**Импорт в сервисах** (если нужен читаемый alias):

```go
import identity_v1 "github.com/invenlore/proto/pkg/identity/v1"
```

Alias в коде допустим и рекомендуется, если повышает читаемость.

### Swagger/OpenAPI naming

Для стабильных имён схем в OpenAPI используем:

```
--openapiv2_opt openapi_naming_strategy=fqn
```

В результате имена схем будут вида `identity.v1.User`, `wiki.v1.Page`, и т.д.

## HTTP аннотации

- Публичные методы имеют `google.api.http` аннотации (grpc-gateway).
- GET только для read.
- POST/PUT/PATCH для write.
- Путь всегда начинается с `/v1/...`.

## Ошибки

- Используем `google.rpc.Status` с `details` (см. `common/v1/errors.proto`).
- Каждая ошибка должна включать `request_id`.
- HTTP error response формат: `{ "status": { code, message, details }, "request_id" }`.
- Рекомендуемые детали:
  - `google.rpc.BadRequest` (валидация полей)
  - `google.rpc.ErrorInfo` (доменные причины)
  - `google.rpc.RetryInfo` (retryable ошибки)

## Пагинация

- Используем `page_size` + `page_token`, возвращаем `next_page_token`.
- Стабильный порядок сортировки обязателен.

## Идемпотентность

- Для write-методов: поддерживаем `Idempotency-Key` (в HTTP) / `x-idempotency-key` (в metadata).
