#!/bin/bash

set -u # Unset Variables are an error
set -e # Exit on error

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push "$DOCKER_REPO"/"$DOCKER_NAME":"$IMAGE_TAG"
docker push "$DOCKER_REPO"/"$DOCKER_NAME":"$LATEST_TAG"