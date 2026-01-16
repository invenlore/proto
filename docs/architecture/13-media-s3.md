# 13. Media + S3 (Yandex Object Storage)

## Поток загрузки (presign)
1) Клиент запрашивает у media-service `CreateUpload`
2) media-service возвращает presigned PUT URL + `media_id`
3) Клиент грузит файл напрямую в S3
4) Клиент вызывает `FinalizeUpload(media_id)`
5) media-service проверяет объект (size, checksum) и фиксирует метаданные

## Поток скачивания
1) Клиент запрашивает `GetDownload(media_id)`
2) media-service проверяет права и выдаёт presigned GET URL с коротким TTL

## Превью/thumbnail
- media-service создаёт outbox задачу `MediaUploaded`
- worker генерирует превью и кладёт в S3
- metadata обновляются

## Политики безопасности
- бакет private
- доступ только через presigned URLs
- ограничения по content-type/size на CreateUpload
