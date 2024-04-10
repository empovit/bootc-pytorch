#!/usr/bin/env bash

set -e

RHSM_ORG_FILE=./rhsm_org
RHSM_ACTIVATIONKEY_FILE=./rhsm_activationkey
IMAGE_NAME=quay.io/vemporop/bootc:9.4-pytorch

podman build \
    --secret id=RHSM_ORG,src=${RHSM_ORG_FILE} \
	--secret id=RHSM_ACTIVATIONKEY,src=${RHSM_ACTIVATIONKEY_FILE} \
    -t $IMAGE_NAME .