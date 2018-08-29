#!/bin/bash -x

#####DOCKERVERSION="18.03.1-ce"

DOCKERVERSION=$(sudo curl --silent --unix-socket /var/run/docker.sock http:/localhost/info | jq -r ".ServerVersion")

echo "get docker cli for $DOCKERVERSION"

curl -o /tmp/docker-${DOCKERVERSION}.tgz -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz
sudo tar xzvf /tmp/docker-${DOCKERVERSION}.tgz --strip 1  -C /usr/local/bin docker/docker
rm /tmp/docker-${DOCKERVERSION}.tgz
