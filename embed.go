package third_party

import (
	"embed"
	"fmt"
	"io/fs"
)

//go:embed pkg/api.swagger.json
var SwaggerJSON []byte

//go:embed third_party/swagger_ui/*
var SwaggerUI embed.FS

func GetSwaggerJSON() []byte {
	return SwaggerJSON
}

func GetSwaggerUIEmbedFS() embed.FS {
	return SwaggerUI
}

func GetSwaggerUISubFS() (fs.FS, error) {
	subFS, err := fs.Sub(SwaggerUI, "third_party/swagger_ui")
	if err != nil {
		return nil, fmt.Errorf("could not get sub filesystem for swagger_ui: %w", err)
	}

	return subFS, nil
}
