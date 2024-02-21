#_preseed_V1

# Locale
d-i debian-installer/locale string ${locale}

# Keyboard
d-i keyboard-configuration/xkb-keymap select ${keyboard}

# Mirror configuration
d-i mirror/protocol string http
d-i mirror/country string manual
d-i mirror/http/hostname string deb.debian.org
d-i mirror/http/directory string /debian
d-i mirror/http/proxy string
d-i mirror/suite string ${suite}

# Skip creation of a normal user account
d-i passwd/make-user boolean false

# Required during install: root will be locked, password will be removed
d-i passwd/root-password password r00tme
d-i passwd/root-password-again password r00tme

# UTC clock
d-i clock-setup/utc boolean true

# Timezone
d-i time/zone string ${timezone}

# NTP
d-i clock-setup/ntp boolean true

# Disable firmware lookup
d-i hw-detect/firmware-lookup string never

# Disable loading non-free firmware
d-i hw-detect/load_firmware boolean false

# Partitioning
d-i partman-auto/method string regular
d-i partman-auto/choose_recipe select cloud
# Recipe
d-i partman-auto/expert_recipe string                        \
     cloud ::                                                \
             1 1 1 free                                      \
                     $bios_boot{ }                           \
                     method{ biosgrub }                      \
             .                                               \
             100 100 100 free                                \
                     method{ efi }                           \
                     format{ }                               \
             .                                               \
             500 500 500 ext4                                \
                     $bootable{ }                            \
                     method{ format } format{ }              \
                     use_filesystem{ } filesystem{ ext4 }    \
                     mountpoint{ /boot }                     \
             .                                               \
             3000 5000 -1 xfs                                \
                     method{ format } format{ }              \
                     use_filesystem{ } filesystem{ xfs }     \
                     mountpoint{ / }                         \
             .

# Skip partman confirmation
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman-basicfilesystems/no_swap boolean false

# Ensure the partition table is GPT - this is required for EFI
d-i partman-partitioning/choose_label select gpt
d-i partman-partitioning/default_label string gpt

# Do not install recommends
d-i base-installer/install-recommends boolean false

# Disable cdrom entries
d-i apt-setup/disable-cdrom-entries boolean true
d-i apt-setup/cdrom/set-first boolean false

# Make sure non-free firmware is disabled
d-i apt-setup/non-free-firmware boolean false

# Match http mirror for security_host
d-i apt-setup/security_host string deb.debian.org

# Disable source repositories
d-i apt-setup/enable-source-repositories boolean false

# Keep minimal install
d-i pkgsel/run_tasksel boolean false

# Keep base system packages up to date
d-i pkgsel/upgrade select full-upgrade

# Install openssh-server
d-i pkgsel/include string openssh-server

# Bootloader setup
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true
d-i grub-installer/bootdev string /dev/sda

# Eject cdrom after installation
d-i cdrom-detect/eject boolean true

# Avoid install complete message
d-i finish-install/reboot_in_progress note

# Set authorized_keys, lock root and remove its password
d-i preseed/late_command string in-target passwd -dl root; \
in-target mkdir /root/.ssh; \
in-target chmod 700 /root/.ssh; \
echo "${authorized_keys}" > /target/root/.ssh/authorized_keys; \
in-target chown root:root /root/.ssh/authorized_keys; \
in-target chmod 600 /root/.ssh/authorized_keys
