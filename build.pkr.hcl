source "qemu" "debian" {
    accelerator          = "kvm"
    boot_command         = var.boot_command
    boot_wait            = var.boot_wait
    communicator         = "ssh"
    cpus                 = var.cpus
    disk_interface       = "virtio-scsi"
    disk_size            = var.disk_size
    efi_boot             = true
    efi_drop_efivars     = true
    format               = var.format
    headless             = var.headless
    http_directory       = "${path.root}/http"
    iso_checksum         = var.iso_checksum
    iso_url              = var.iso_url
    memory               = var.memory
    net_device           = "virtio-net"
    output_directory     = var.output_directory
    shutdown_command     = var.shutdown_command
    ssh_private_key_file = "${path.root}/ssh/builder"
    ssh_timeout          = var.ssh_timeout
    ssh_username         = "root"
    disk_discard         = "unmap"
    disk_detect_zeroes   = "unmap"
    vm_name              = "${source.name}-${var.version}-${var.arch}.${var.format}"
}

build {
    source "qemu.debian" {
        name = "generic"
    }

    source "qemu.debian" {
        name = "router"
    }

    source "qemu.debian" {
        name = "nameserver"
    }

    provisioner "ansible" {
        playbook_file   = "${path.root}/ansible/${source.name}.yml"
        host_alias      = source.name
        roles_path      = "${path.root}/ansible/roles"
        extra_arguments = [
            "--scp-extra-args='-O'",
            "--extra-vars",
            "ansible_remote_tmp=/tmp"
        ]
    }
}
