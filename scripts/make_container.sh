#!/bin/bash
sudo docker build --no-cache \
		  --pull \
    		  --build-arg BUILD_DATE="$(date)" \
		  --build-arg VERSION="TODO" \
		  --build-arg VCS_REF=`git rev-parse --short HEAD` \
   		  -f Dockerfile \
		  -t "$DOCKER_REPO"/"$DOCKER_NAME":"$DOCKER_TAG" \
		  .
		  
