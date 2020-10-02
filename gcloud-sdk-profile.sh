#!/bin/env bash

# Forward gcloud SDK commands run on the host machine
# to the official GCloud container

# Requires: Docker

container_version=${1:-latest}

function docker_run {
  docker run \
    --rm \
    -it \
    -v $HOME/.config/gcloud:/root/.config/gcloud \
    gcr.io/google.com/cloudsdktool/cloud-sdk:"${container_version}" $@
}

gcloud() {
  docker_run gcloud $@
}

gsutils() {
  docker_run gsutils $@
}

bq() {
  docker_run bq $@
}
