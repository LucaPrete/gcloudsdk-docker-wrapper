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

# gcloud command shortcuts - credits to ludoo (https://github.com/ludoo)

function fw() {
  net=$1
  shift
  gcloud compute firewall-rules list --filter network:$net --format="table(
    name, network, direction, priority,
    sourceRanges.list():label=SRC_RANGES,
    allowed[].map().firewall_rule().list():label=ALLOW,
    denied[].map().firewall_rule().list():label=DENY,
    targetTags.list():label=TARGET_TAGS, disabled
  )" $*;
}

function rt() {
  net=$1
  shift
  gcloud compute routes list --filter network:$net $*
}

function gssh() {
  host=$1
  shift
  gcloud compute ssh $host $*
}

function i() {
  gcloud compute instances list $*
}

function d() {
  gcloud compute instances describe $*
}

function h() {
  backend=$1
  shift
  gcloud compute backend-services get-health $backend \
    --flatten status.healthStatus \
    --format "value(status.healthStatus.ipAddress, status.healthStatus.healthState)" $*;
}
