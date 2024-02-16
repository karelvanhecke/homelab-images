variable "iso_url" {
    type = string
    default = "https://cdimage.debian.org/debian-cd/12.5.0/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso"
}

variable "iso_checksum" {
    type = string
    default = "file:https://cdimage.debian.org/debian-cd/12.5.0/amd64/iso-cd/SHA256SUMS"
}

variable "boot_command" {
    type = list(string)
    default = [
        "c<wait5>",
        "linux /install.amd/vmlinuz auto=true priority=critical ",
        "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian-12.cfg<enter><wait5>",
        "initrd /install.amd/initrd.gz<enter><wait5>",
        "boot<enter><wait5>"
    ]
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
    default = "shutdown -P now"
}

variable "ssh_timeout" {
    type = string
    default = "20m"
}

variable "headless" {
    type = bool
    default = true
}
