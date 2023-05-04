variable "freebsd_version" {
  type    = string
  default = "13.2-STABLE"
}

variable "output_qcow2" {
  type    = string
  default = "freebsd.qcow2"
}

local "freebsd_baseimg_url" {
  expression = "https://download.freebsd.org/ftp/snapshots/VM-IMAGES/${var.freebsd_version}/amd64/Latest/FreeBSD-${var.freebsd_version}-amd64.qcow2.xz"
}

data "http" "freebsd_baseimg_checksum_file" {
  url = "https://download.freebsd.org/ftp/snapshots/VM-IMAGES/${var.freebsd_version}/amd64/Latest/CHECKSUM.SHA512"
}

local "yandex_image_name" {
  expression = "freebsd-${split(".", var.freebsd_version)[0]}"
}

build {
  sources = ["source.qemu.freebsd_cloud"]
}

source "qemu" "freebsd_cloud" {
  iso_urls      = [
    "./FreeBSD-${var.freebsd_version}-amd64.qcow2.xz",
    local.freebsd_baseimg_url
  ]
  iso_checksum = "${split(" ", split("\n", data.http.freebsd_baseimg_checksum_file.body)[0])[3]}"
  disk_image   = true
  format       = "qcow2"

  output_directory = "images"
  vm_name          = var.output_qcow2

  accelerator = "kvm"
  memory      = 1024
  cpus        = 1
  headless    = true

  disk_compression   = true
  skip_compaction    = false
  disk_discard       = "unmap"
  disk_detect_zeroes = "unmap"

  ssh_username = "root"
  ssh_timeout = "5m"
}
