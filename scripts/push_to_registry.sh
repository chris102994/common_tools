#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push "$DOCKER_REPO"/"$DOCKER_NAME":"$DOCKER_TAG"
docker push "$DOCKER_REPO"/"$DOCKER_NAME":"$TRAVIS_JOB_ID"
