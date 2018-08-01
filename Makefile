# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make. 

.PHONY: gxone android ios gxone-cross swarm evm all test clean
.PHONY: gxone-linux gxone-linux-386 gxone-linux-amd64 gxone-linux-mips64 gxone-linux-mips64le
.PHONY: gxone-linux-arm gxone-linux-arm-5 gxone-linux-arm-6 gxone-linux-arm-7 gxone-linux-arm64
.PHONY: gxone-darwin gxone-darwin-386 gxone-darwin-amd64
.PHONY: gxone-windows gxone-windows-386 gxone-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest
 
gxone:
	build/env.sh go run build/ci.go install ./cmd/gxone
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gxone\" to launch gxone."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gxone.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Gxone.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

lint: ## Run linters.
	build/env.sh go run build/ci.go lint

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gxone-cross: gxone-linux gxone-darwin gxone-windows gxone-android gxone-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gxone-*

gxone-linux: gxone-linux-386 gxone-linux-amd64 gxone-linux-arm gxone-linux-mips64 gxone-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-*

gxone-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gxone
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep 386

gxone-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gxone
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep amd64

gxone-linux-arm: gxone-linux-arm-5 gxone-linux-arm-6 gxone-linux-arm-7 gxone-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep arm

gxone-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gxone
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep arm-5

gxone-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gxone
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep arm-6

gxone-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gxone
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep arm-7

gxone-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gxone
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep arm64

gxone-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gxone
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep mips

gxone-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gxone
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep mipsle

gxone-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gxone
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep mips64

gxone-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gxone
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gxone-linux-* | grep mips64le

gxone-darwin: gxone-darwin-386 gxone-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gxone-darwin-*

gxone-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gxone
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-darwin-* | grep 386

gxone-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gxone
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-darwin-* | grep amd64

gxone-windows: gxone-windows-386 gxone-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gxone-windows-*

gxone-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gxone
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-windows-* | grep 386

gxone-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gxone
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gxone-windows-* | grep amd64

xonemaster-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/xonemaster
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/xonemaster-linux-* | grep amd64

xoneboot-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/xoneboot
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/xoneboot-linux-* | grep amd64
