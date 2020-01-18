#!/bin/bash
DATE=$(date)
VCS_REF=$(git rev-parse --short HEAD)

if [ -f Dockerfile.debian ]; then
	sudo docker build \
	  --no-cache \
	  --pull \
	  --build-arg BUILD_DATE="$DATE" \
	  --build-arg VERSION="TODO" \
	  --build-arg VCS_REF="$VCS_REF" \
		  -f Dockerfile.debian \
	  -t "$DOCKER_REPO"/"$DOCKER_NAME":"$DEBIAN_TAG" \
	  .
fi

if [ -f Dockerfile.alpine ]; then
	sudo docker build \
	  --no-cache \
	  --pull \
	  --build-arg BUILD_DATE="$DATE" \
	  --build-arg VERSION="TODO" \
	  --build-arg VCS_REF="$VCS_REF" \
	  -f Dockerfile.alpine \
	  -t "$DOCKER_REPO"/"$DOCKER_NAME":"$ALPINE_TAG" \
	  .
fi

if [ ! -f Dockerfile.debian ] || [ ! -f Dockerfile.alpine ]; then
	sudo docker build \
	  --no-cache \
	  --pull \
	  --build-arg BUILD_DATE="$DATE" \
	  --build-arg VERSION="TODO" \
	  --build-arg VCS_REF="$VCS_REF" \
		  -f Dockerfile \
	  -t "$DOCKER_REPO"/"$DOCKER_NAME":"$DOCKER_TAG" \
	  .
fi
