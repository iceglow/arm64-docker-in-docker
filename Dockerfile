FROM ubuntu:17.04

MAINTAINER Joakim Lundin <joakim.lundin@gmail.com>

USER root
WORKDIR /qemu

COPY cloud.yml /qemu/
COPY qemu.sh /qemu/

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y qemu qemu-utils cloud-utils && \
    wget https://releases.linaro.org/components/kernel/uefi-linaro/15.12/release/qemu64/QEMU_EFI.fd && \
    wget https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-arm64-uefi1.img && \
    cloud-localds cloud.img /qemu/cloud.yml

CMD [ "/qemu/qemu.sh" ]
