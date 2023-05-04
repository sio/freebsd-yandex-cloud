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

source "qemu" "freebsd_vm" {
  iso_urls = [ // unpacking xz archive is mind bogglingly slow, and single-threaded
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

  boot_wait = "55s"
  boot_command = [
    "root<enter>",
    "chpass -p '$1$freebsd$XeVNrIF0QBHSJsEeU14jC/'<enter>",      // unsafe
    "echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config<enter>", // unsafe
    "sysrc sshd_enable=YES<enter>",
    "service sshd start<enter>",
  ]

  ssh_username     = "root"
  ssh_password     = "freebsd"
  ssh_timeout      = "25m"
  shutdown_command = "shutdown -p now"

  qemuargs = [
    ["-serial", "mon:telnet:127.0.0.1:2121,server,nowait,logfile=console.log,logappend=on"],
  ]
}

build {
  sources = ["source.qemu.freebsd_vm"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
    scripts = [
      "cloud.sh",
      "cleanup.sh",
    ]
  }
}
