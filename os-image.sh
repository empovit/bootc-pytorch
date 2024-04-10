#!/usr/bin/env bash

set -e

mkdir -p output

TYPE=${TYPE:-qcow2}
BOOTC_IMAGE=${BOOTC_IMAGE:-"quay.io/vemporop/bootc:9.4-pytorch"}

LOCAL_ARG=''
LOCAL_MOUNT=''

if [[ "$LOCAL_IMG" != "" ]]; then
    LOCAL_MOUNT="-v /var/lib/containers/storage:/var/lib/containers/storage"
    LOCAL_ARG="--local"
fi

sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v $(pwd)/config.json:/config.json \
    -v $(pwd)/output:/output \
    ${LOCAL_MOUNT} \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type ${TYPE} \
    --config /config.json \
    ${LOCAL_ARG} \
    ${BOOTC_IMAGE}