#!/usr/bin/env bash

set -e

mkdir -p output

TYPE=${TYPE:-qcow2}
LOCAL_ARGS=''
BOOTC_IMAGE=${BOOTC_IMAGE:-"quay.io/vemporop/bootc:9.4-pytorch"}

if [[ "$LOCAL_IMAGE" != "" ]]; then
    LOCAL_ARGS="-v /var/lib/containers/storage:/var/lib/containers/storage --local"
fi

sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v $(pwd)/config.json:/config.json \
    -v $(pwd)/output:/output \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type ${TYPE} \
    --config /config.json \
    ${LOCAL_ARGS} \
    ${BOOTC_IMAGE}