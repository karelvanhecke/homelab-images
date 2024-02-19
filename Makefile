VERSION := $(shell git rev-parse --short HEAD)
SSH_KEY_DIRECTORY = .packer-ssh
SSH_KEY_ALGORITHM = ed25519
SSH_OUTPUT_KEYFILE = $(SSH_KEY_DIRECTORY)/id_$(SSH_KEY_ALGORITHM)
OUTPUT_DIRECTORY = images
BUILDER = qemu
PACKER_OPTS = -var "version=$(VERSION)" -var "ssh_key_directory=$(SSH_KEY_DIRECTORY)" -var "ssh_key_algorithm=$(SSH_KEY_ALGORITHM)" -var "output_directory=$(OUTPUT_DIRECTORY)"
PACKER_VALIDATE = packer validate $(PACKER_OPTS)
PACKER_BUILD = packer build $(PACKER_OPTS)

.PHONY: all init gen-ssh-key validate-all build-all validate build clean
all: init gen-ssh-key validate-all build-all

init:
	@packer init .

gen-ssh-key:
	@mkdir -p .packer-ssh; test -f $(SSH_OUTPUT_KEYFILE) || ssh-keygen -q -t $(SSH_KEY_ALGORITHM) -f $(SSH_OUTPUT_KEYFILE) -N ""

validate-all:
	@$(PACKER_VALIDATE) .

build-all:
	@$(PACKER_BUILD) .

validate:
	@$(PACKER_VALIDATE) -only "$(BUILDER).$(VARIANT)" .

build:
	@$(PACKER_BUILD) -only "$(BUILDER).$(VARIANT)" .

clean:
	@rm -rfv $(SSH_KEY_DIRECTORY) $(OUTPUT_DIRECTORY)
