# ADR-0008: S3 object storage for media

## Статус
Accepted (2026-01-17)

## Контекст
Вложения не должны храниться в Mongo, нужна дешёвая и масштабируемая storage.

## Решение
Используем S3 (Yandex Object Storage) + presigned URLs через media-service.

## Последствия
+ Снижение нагрузки на БД
- Нужны политики доступа и контроль размера/типа
