publish:
	GOPROXY=proxy.golang.org go list -m github.com/invenlore/proto@v$(v)

generate/user:
	protoc -I . \
    	--go_out ./user/gen/go/ --go_opt paths=source_relative \
    	--go-grpc_out ./user/gen/go/ --go-grpc_opt paths=source_relative \
    	user/user.proto

generate: generate/user

.PHONY: generate
