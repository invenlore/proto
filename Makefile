PROTO_PATH := $(CURDIR)/proto
PROTO_VENDOR_PATH := $(CURDIR)/vendor.protobuf
PROTO_PKG_PATH := $(CURDIR)/pkg
PROTO_FILES = \
	common/v1/pagination.proto \
	common/v1/openapi.proto \
	common/v1/context.proto \
	common/v1/errors.proto \
	common/v1/utils.proto \
	identity/v1/messages.proto \
	identity/v1/public_service.proto \
	identity/v1/internal_service.proto \
	wiki/v1/messages.proto \
	wiki/v1/read_service.proto \
	wiki/v1/write_service.proto \
	wiki/v1/events.proto \
	media/v1/messages.proto \
	media/v1/service.proto \
	media/v1/events.proto \
	search/v1/messages.proto \
	search/v1/service.proto

.PHONY: all

all:
	make generate

generate:
	protoc \
		--proto_path $(PROTO_PATH) \
		--proto_path $(PROTO_VENDOR_PATH) \
		--go_out $(PROTO_PKG_PATH) \
		--go_opt paths=source_relative \
		--go-grpc_out $(PROTO_PKG_PATH) \
		--go-grpc_opt paths=source_relative \
		--grpc-gateway_out $(PROTO_PKG_PATH) \
		--grpc-gateway_opt paths=source_relative \
		--grpc-gateway_opt generate_unbound_methods=true \
		$(PROTO_FILES)

swagger:
	rm -f $(PROTO_PKG_PATH)/api.swagger.json
	protoc \
		--proto_path $(PROTO_PATH) \
		--proto_path $(PROTO_VENDOR_PATH) \
		--openapiv2_out $(PROTO_PKG_PATH) \
		--openapiv2_opt allow_merge=true \
		--openapiv2_opt merge_file_name=api \
		--openapiv2_opt openapi_naming_strategy=fqn \
		$(PROTO_FILES)

publish:
	GOPROXY=proxy.golang.org go list -m github.com/invenlore/proto@v$(v)
