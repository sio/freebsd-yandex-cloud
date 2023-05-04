#!/bin/sh
set -euo pipefail
set -v

# Install cloud-init
pkg install -y net/cloud-init
sysrc cloudinit_enable=YES
