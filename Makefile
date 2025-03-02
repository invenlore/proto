publish:
	GOPROXY=proxy.golang.org go list -m github.com/invenlore/proto@v$(v)

generate/user/grpc:
	protoc -I . \
    	--go_out . --go_opt paths=source_relative \
    	--go-grpc_out . --go-grpc_opt paths=source_relative \
    	proto/user/user.proto

generate/user/grpc-gateway:
	protoc -I . --grpc-gateway_out . \
    	--grpc-gateway_opt paths=source_relative \
    	--grpc-gateway_opt generate_unbound_methods=true \
    	proto/user/user.proto

generate/user:
	generate/user/grpc
	generate/user/grpc-gateway

generate:
	generate/user

.PHONY: generate
