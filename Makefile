VERSION := $(shell git rev-parse --short HEAD)
TEMPLATE = base
PACKER_LOG = 1
PACKER_VALIDATE_COMMAND = PACKER_LOG=$(PACKER_LOG) packer validate -var "version=$(VERSION)"
PACKER_BUILD_COMMAND = PACKER_LOG=$(PACKER_LOG) packer build -var "version=$(VERSION)"

.PHONY: all init validate build
all: init validate build

init:
	packer init .

validate:
	@if [ "$(TEMPLATE)" = "base" ]; then \
		$(PACKER_VALIDATE_COMMAND) .; \
	else \
		$(PACKER_VALIDATE_COMMAND) -var-file=$(TEMPLATE).pkrvars.hcl .; \
	fi

build:
	@if [ "$(TEMPLATE)" = "base" ]; then \
		$(PACKER_BUILD_COMMAND) .; \
	else \
		$(PACKER_BUILD_COMMAND) -var-file=$(TEMPLATE).pkrvars.hcl .; \
	fi
