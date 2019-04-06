#!/bin/bash

REPO_TAG="$(git describe --tags $(git rev-list --tags --max-count=1 2>/dev/null) 2>/dev/null)"

# tagged version is the TAG
if [ ! -z "$CIRCLE_TAG" ]; then
    echo $CIRCLE_TAG
# master build without tag is a BETA
elif [ ! -z ${CIRCLE_BRANCH} ] && [ -z "$CIRCLE_PR_NUMBER" ]; then
    echo $REPO_TAG-beta
# must be a PR build
else
    echo $REPO_TAG-pr
fi