ARG BASE_IMAGE
FROM ${BASE_IMAGE}

USER root

WORKDIR ${HOME}
COPY --chmod=744 ./rhsm-register /usr/local/bin/rhsm-register

RUN --mount=type=secret,id=RHSM_ORG,target=/run/secrets/RHSM_ORG \
    --mount=type=secret,id=RHSM_ACTIVATIONKEY,target=/run/secrets/RHSM_ACTIVATIONKEY \
    /usr/local/bin/rhsm-register \
    && dnf install -y git make python3-pip \
    && subscription-manager unregister \
    && dnf clean all \
    && rm /usr/local/bin/rhsm-register

RUN pip install torch torchvision torchaudio
