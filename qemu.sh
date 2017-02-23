#!/bin/bash

qemu-system-aarch64 -cpu cortex-a57 -smp 4 -m 2048 -M virt -bios QEMU_EFI.fd -nographic \
  -device virtio-blk-device,drive=image -drive if=none,id=image,file=xenial-server-cloudimg-arm64-uefi1.img \
  -device virtio-blk-device,drive=cloud -drive if=none,id=cloud,file=cloud.img \
  -netdev user,id=user0 -device virtio-net-device,netdev=user0 -redir tcp:2375::2375
