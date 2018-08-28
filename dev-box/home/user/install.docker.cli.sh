#!/bin/bash

DOCKERVERSION=${1:-18.03.1-ce}
curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz -O /tmp/docker-${DOCKERVERSION}.tgz
sudo tar xzvf /tmp/docker-${DOCKERVERSION}.tgz --strip 1  -C /usr/local/bin docker/docker
rm /tmp/docker-${DOCKERVERSION}.tgz
