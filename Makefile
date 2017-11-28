GOOS := linux
GOARCH := amd64

all: go hab

go:
	sh -c "cd src/ && GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=0 \
		go build -ldflags '-extldflags \"-static\"' \
		-o ../artifacts/it_works_$(GOOS)_$(GOARCH)"

hab: hab-build hab-upload hab-export
hab-build:
	hab pkg build .
hab-upload:
	hab pkg upload results/robertgzr-it_works-*-x86_64-linux.hart
hab-export:
	HAB_PKG_EXPORT_KUBERNETES_PKG_IDENT=robertgzr/hab-pkg-export-kubernetes \
		hab pkg export kubernetes robertgzr/it_works \
		-o manifest.yml

clean:
	git clean -fdx
