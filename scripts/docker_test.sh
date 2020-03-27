#!/bin/bash

set -u # Unset Variables are an error
set -e # Exit on error


TAGS=''
for ENV in versions/*; do
	TAG="$(cat "${ENV}" | grep "IMAGE_TAG=" | sed 's#.*=##')"
	if [ -n "${TAG}" ]; then
		TAG="${TAG}-${GIT_VERSION}"
		TAGS="${TAGS} ${TAG}"
	fi
done

docker run \
	--name=docker-test-framework \
	-e DOCKER_NAME="${DOCKER_NAME}" \
	-e DOCKER_REPO="${DOCKER_USERNAME}" \
	-e DOCKER_SLEEP="${DOCKER_SLEEP:-60}" \
	-e GIT_EMAIL="${GIT_EMAIL}" \
	-e GIT_TOKEN="${GIT_TOKEN}" \
	-e GIT_VERSION="${GIT_VERSION}" \
	-e GUI="${GUI:-true}" \
	-e SSL="${SSL:-false}" \
	-e PORT="${PORT:-5700}" \
	-e TAGS="${TAGS}" \
	-e WEB_PATH="${WEB_PATH:-?autoconnect=true&resize=scale}" \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v "$(pwd)":/workspace \
christopher102994/docker-test-framework:latest
