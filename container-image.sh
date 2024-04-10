#!/usr/bin/env bash

set -e

RHSM_ORG_FILE=${RHSM_ORG_FILE:-'.rhsm_org'}
RHSM_ACTIVATIONKEY_FILE=${RHSM_ACTIVATIONKEY_FILE:-'.rhsm_activationkey'}

BASE_IMAGE=${BASE_IMAGE:-'quay.io/fabiendupont/rhel9-nvidia:9.4-550.54.15'}
IMAGE_NAME=${IMAGE_NAME:-'quay.io/vemporop/bootc:9.4-pytorch'}

sudo podman build \
    --secret id=RHSM_ORG,src=${RHSM_ORG_FILE} \
	--secret id=RHSM_ACTIVATIONKEY,src=${RHSM_ACTIVATIONKEY_FILE} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    -t ${IMAGE_NAME} .