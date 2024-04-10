#!/usr/bin/env bash

set -e

sudo virt-install \
   --name bootc-pytorch-iso \
   --cpu host \
   --vcpus 4 \
   --memory 8192 \
   --os-variant rhel9-unknown \
   --disk ./output/disk.img,size=110 \
   --cdrom ./output/bootiso/install.iso