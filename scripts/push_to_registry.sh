#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin


if [ -f Dockerfile.debian ]; then
	docker push "$DOCKER_REPO"/"$DOCKER_NAME":"$DEBIAN_TAG"
fi

if [ -f Dockerfile.alpine ]; then
	docker push "$DOCKER_REPO"/"$DOCKER_NAME":"$ALPINE_TAG"
fi

if [ ! -f Dockerfile.debian ] || [ ! -f Dockerfile.alpine ]; then
	docker push "$DOCKER_REPO"/"$DOCKER_NAME":"$DOCKER_TAG"
fi
