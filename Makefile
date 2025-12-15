PROTO_PATH := $(CURDIR)/proto
PROTO_VENDOR_PATH := $(CURDIR)/vendor.protobuf
PROTO_PKG_PATH := $(CURDIR)/pkg

.PHONY: all

all: 
	make generate/user

generate:
	make generate/user

generate/user:
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
    	user/messages.proto user/service.proto

publish:
	GOPROXY=proxy.golang.org go list -m github.com/invenlore/proto@v$(v)
