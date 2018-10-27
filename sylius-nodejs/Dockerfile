# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/compose/compose-file/#target

FROM node:${NODE_VERSION}-alpine

ARG NODE_VERSION=10

WORKDIR /srv/sylius

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		g++ \
		gcc \
		git \
		make \
		python \
	;

