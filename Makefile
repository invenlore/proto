gen/user:
	protoc -I . \
    --go_out ./user/gen/go/ --go_opt paths=source_relative \
    --go-grpc_out ./user/gen/go/ --go-grpc_opt paths=source_relative \
    user/user.proto

gen: gen/user

.PHONY: gen
