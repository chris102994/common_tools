#!/bin/bash

# Tools script to get various bits of information.

# These 3 flags can be set as an ENV variable OR the git commit message to bump the correlating version
# BUMP_MAJOR
# BUMP_MINOR
# BUMP_PATCH

# Default Versioning
MAJOR_VERSION=1
MINOR_VERSION=0
PATCH_VERSION=0
GIT_VERSION=$(git describe --tags)
if [ $? -eq 0 ]; then
    GIT_VERSION=$(echo $GIT_VERSION |  egrep -o '[0-9]*\.[0-9]*\.[0-9]*' )
    MAJOR_VERSION=$(echo $GIT_VERSION | cut -d. -f1)
    MINOR_VERSION=$(echo $GIT_VERSION | cut -d. -f2)
    PATCH_VERSION=$(echo $GIT_VERSION | cut -d. -f3)
fi

GIT_MESSAGE=$(git show -s --format=%s | tr a-z A-Z)
# Check if ANY bump's are set in the ENV or MSG AND IF they ARE then Bump that version
if [ "${BUMP_MAJOR:-UNSET}" != "UNSET" ] && [ "${BUMP_MAJOR,,}" = true ] || [[ "$GIT_MESSAGE" =~ .*"BUMP_MAJOR".* ]]; then
    ((MAJOR_VERSION+=1))
    echo "Major Version Bumped to: $MAJOR_VERSION"
fi

if [ "${BUMP_MINOR:-UNSET}" != "UNSET" ] && [ "${BUMP_MINOR,,}" = true ] || [[ "$GIT_MESSAGE" =~ .*"BUMP_MINOR".* ]]; then
    ((MINOR_VERSION+=1))
    echo "Minor Version Bumped to: $MINOR_VERSION"
fi

if [ "${BUMP_PATCH:-UNSET}" != "UNSET" ] && [ "${BUMP_PATCH,,}" = true ] || [[ "$GIT_MESSAGE" =~ .*"BUMP_PATCH".* ]]; then
    ((PATCH_VERSION+=1))
    echo "Patch Bumped to: $PATCH_VERSION"
fi

# Just some handy tools we can export.
GIT_VERSION="${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}"
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GIT_COMMIT=$(git rev-parse --short HEAD)
GIT_REPO=$(git config --get remote.origin.url | grep -Po "(?<=git@github\.com:)(.*?)(?=.git)" | sed 's#.*/##')
EPOCH=$(date "+%s")
DATE=$(date)

export GIT_VERSION=$GIT_VERSION
export GIT_BRANCH=$GIT_BRANCH
export GIT_COMMIT=$GIT_COMMIT
export GIT_REPO=$GIT_REPO
export EPOCH=$EPOCH
export DATE=$DATE
export IMAGE_TAG=$IMAGE_TAG-$GIT_VERSION