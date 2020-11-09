source "arm" "raspberryos" {
  file_urls = [
    "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2020-08-24/2020-08-20-raspios-buster-armhf-lite.zip"
  ]
  file_checksum_type = "sha256"
  file_checksum_url = "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2020-08-24/2020-08-20-raspios-buster-armhf-lite.zip.sha256"
  file_target_extension = "zip"
  image_build_method = "resize"
  image_chroot_env = [
    "PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
  ]

  image_partitions {
    filesystem = "vfat"
    mountpoint = "/boot"
    name = "boot"
    size = "256M"
    start_sector = "8192"
    type = "c"
  }

  image_partitions {
    filesystem = "ext4"
    mountpoint = "/"
    name = "root"
    size = "0"
    start_sector = "532480"
    type = "83"
  }

  image_path = "raspberry-pi.img"
  image_size = "6G"
  image_type = "dos"
  qemu_binary_destination_path = "/usr/bin/qemu-arm-static"
  qemu_binary_source_path = "/usr/bin/qemu-arm-static"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/from-1.5/blocks/build
build {
  sources = [
    "source.arm.raspberryos"
  ]

  provisioner "file" {
    destination = "/etc/pihole/"
    source = "filesystem/etc/pihole/setupVars.conf"
  }

  provisioner "shell" {
    inline = [
      "touch /boot/ssh",
      "curl -L https://install.pi-hole.net | bash /dev/stdin --unattended"
    ]
  }
}
