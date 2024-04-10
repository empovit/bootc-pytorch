#!/usr/bin/env bash

set -e

sudo virt-install \
   --name bootc-pytorch-qcow2 \
   --cpu host \
   --vcpus 4 \
   --memory 8192 \
   --os-variant rhel9-unknown \
   --import --disk ./output/qcow2/disk.qcow2,format=qcow2