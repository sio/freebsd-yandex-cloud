#!/bin/bash
set -euo pipefail
set -v

qemu-system-x86_64 \
    -drive file=images/freebsd.qcow2,if=virtio,cache=writeback,discard=unmap,format=qcow2,detect-zeroes=unmap \
    -m 1024M \
    -smp cpus=1,sockets=1 \
    -machine type=pc,accel=kvm \
    -cpu qemu64 \
    -device virtio-net,netdev=user.0 \
    -vnc 127.0.0.1:99 \
    -netdev user,id=user.0,hostfwd=tcp::4040-:5985,hostfwd=tcp::4041-:3389

