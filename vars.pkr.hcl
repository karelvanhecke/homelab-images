locals {
    ssh_private_key_file = "${path.root}/${var.ssh_key_directory}/id_${var.ssh_key_algorithm}"
    ssh_public_key_file = "${local.ssh_private_key_file}.pub"
    preseed_vars = {
        locale = var.locale
        timezone = var.timezone
        keyboard = var.keyboard
        suite = var.suite
        authorized_keys = chomp(file(local.ssh_public_key_file))
    }
    preseed = templatefile(
            "${path.root}/http/preseed.pkrtpl.hcl",
            local.preseed_vars
            )
    preseed_checksum = md5(local.preseed)
    boot_command = [
        "c<wait5>",
        "linux /install.amd/vmlinuz auto=true priority=critical ",
        "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
        "preseed-md5=${local.preseed_checksum}<enter><wait5>",
        "initrd /install.amd/initrd.gz<enter><wait5>",
        "boot<enter><wait5>"
    ]
}

variable "iso_url" {
    type = string
    default = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso"
}

variable "iso_checksum" {
    type = string
    default = "sha256:013f5b44670d81280b5b1bc02455842b250df2f0c6763398feb69af1a805a14f"
}

variable "format" {
    type = string
    default = "qcow2"
}

variable "version" {
    type = string
    default = "dev"
}

variable "arch" {
    type = string
    default = "amd64"
}

variable "cpus" {
    type = number
    default = 1
}

variable "memory" {
    type = number
    default = 2048
}

variable "disk_size" {
    type = string
    default = "5120M"
}

variable "output_directory" {
    type = string
    default = "images"
}

variable "boot_wait" {
    type = string
    default = "20s"
}

variable "shutdown_command" {
    type = string
    default = "systemctl start poweroff.target --job-mode=replace-irreversibly --no-block"
}

variable "ssh_timeout" {
    type = string
    default = "20m"
}

variable "headless" {
    type = bool
    default = true
}

variable "ssh_key_directory" {
    type = string
    default = ".packer-ssh"
}

variable "ssh_key_algorithm" {
    type = string
    default = "ed25519"
}

variable "timezone" {
    type = string
    default = "Europe/Brussels"
}

variable "keyboard" {
    type = string
    default = "be"
}

variable "locale" {
    type = string
    default = "en_US.UTF-8"
}

variable "suite" {
    type = string
    default = "bookworm"
}
