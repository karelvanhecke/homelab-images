VERSION := $(shell git rev-parse --short HEAD)
BUILDER = qemu
PACKER_VALIDATE = packer validate -var "version=$(VERSION)"
PACKER_BUILD = packer build -var "version=$(VERSION)"

.PHONY: all init validate-all build-all validate build
all: init validate-all build-all

init:
	@packer init .

validate-all:
	@$(PACKER_VALIDATE) .

build-all:
	@$(PACKER_BUILD) .

validate:
	@$(PACKER_VALIDATE) -only "$(BUILDER).$(VARIANT)" .

build:
	@$(PACKER_BUILD) -only "$(BUILDER).$(VARIANT)" .
