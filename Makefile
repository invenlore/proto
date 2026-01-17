PROTO_PATH := $(CURDIR)/proto
PROTO_VENDOR_PATH := $(CURDIR)/vendor.protobuf
PROTO_PKG_PATH := $(CURDIR)/pkg

.PHONY: all

all: 
	make generate/identity

generate:
	make generate/identity

generate/identity:
	rm -rf $(PROTO_PKG_PATH)/identity/*
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
    	identity/messages.proto identity/service.proto

swagger:
	rm -f $(PROTO_PKG_PATH)/api.swagger.json
	protoc \
		--proto_path $(PROTO_PATH) \
		--proto_path $(PROTO_VENDOR_PATH) \
		--openapiv2_out $(PROTO_PKG_PATH) \
		--openapiv2_opt allow_merge=true \
		--openapiv2_opt merge_file_name=api \
    	identity/messages.proto identity/service.proto

publish:
	GOPROXY=proxy.golang.org go list -m github.com/invenlore/proto@v$(v)
