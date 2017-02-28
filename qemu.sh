#!/bin/bash

if [ -z "$SMP" ]; then
  SMP=1
fi

if [ -z "$MEMORY_SIZE" ]; then
  MEMORY_SIZE=1024
fi

if [ -z "$DOCKER_PORT" ]; then
  DOCKER_PORT=2375
fi

qemu-system-aarch64 -cpu cortex-a57 -smp "${SMP}" -m "${MEMORY_SIZE}" -M virt -bios QEMU_EFI.fd -nographic \
  -device virtio-blk-device,drive=image -drive if=none,id=image,file=xenial-server-cloudimg-arm64-uefi1.img \
  -device virtio-blk-device,drive=cloud -drive if=none,id=cloud,file=cloud.img \
  -netdev user,id=user0 -device virtio-net-device,netdev=user0 -redir "tcp:${DOCKER_PORT}::2375"
