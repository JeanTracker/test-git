#!/usr/bin/env bash

echo "Start..."
echo "Workflow: $GITHUB_WORKFLOW"
echo "Action: $GITHUB_ACTION"
echo "Actor: $GITHUB_ACTOR"
echo "Token: $GITHUB_TOKEN"
echo "Repository: $GITHUB_REPOSITORY"
echo "Event-name: $GITHUB_EVENT_NAME"
echo "Event-path: $GITHUB_EVENT_PATH"
echo "Workspace: $GITHUB_WORKSPACE"
echo "SHA: $GITHUB_SHA"
echo "REF: $GITHUB_REF"
echo "HEAD-REF: $GITHUB_HEAD_REF"
echo "BASE-REF: $GITHUB_BASE_REF"
pwd

docker run -t --rm -v $PWD:$PWD -w $PWD nugulinux/devenv:bionic /bin/bash -c "run_codereview.sh nugu-developers/nugu-linux externals"
