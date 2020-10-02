# Google Cloud SDK - Docker wrapper

A simple bash script to forward local Google Cloud SDK CLI commands to the Google Cloud SDK Docker image, allowing to run commands locally without any need to install CLI tools on the host machine.

## Requirements

* Docker

## Getting started

Source the bash file. Optionally, add the source command to your *~/.bash_profile* to source it automatically when the shell starts.

```shell
source gcloud-sdk-profile.sh [container-version]
```

>Note: optionally, specify a container version as the first param

Now, run a Google Cloud SDK command. It will be automatically executed in a dedicated Docker container.
The container will be terminated as soon as the command finishes.

## Supported Commands

* gcloud

* gsutils

* bq

## Commands shortcuts

Some commands may be long and difficult to remember. [ludoo](https://github.com/ludoo) provided a list of nice shortcuts as well!
The full list can be checked out directly [here](gcloud-sdk-profile.sh).

## Persistency and volumes

Your local *~/.config/gcloud* folder is automatically mounted in the container under */root/.config/gcloud*. This way your settings are saved on the host machine, although the applications are executed in the containers.
