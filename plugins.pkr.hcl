packer {
    required_plugins {
        qemu = {
            source  = "github.com/hashicorp/qemu"
            version = "1.0.10"
        }
        ansible = {
            source  = "github.com/hashicorp/ansible"
            version = "1.1.1"
        }
    }
}
