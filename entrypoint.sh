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

# 0: success, otherwise: failure
RESULT=0

PR=${GITHUB_REF#"refs/pull/"}
PRNUM=${PR%"/merge"}
URL=https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PRNUM}/commits
echo " - API endpoint: $URL"

list=$(curl $URL -X GET -s | jq '.[].sha' -r)
len=$(echo "$list" | wc -l)
echo " - Commits $len: $list"

# Run review.sh on each commit in the PR
echo
echo -e "\e[0;34mStart review for each commits.\e[0m"

# Get PR number
PR=${GITHUB_REF#"refs/pull/"}
PRNUM=${PR%"/merge"}

# Github REST API endpoints
BODY_URL=https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${PRNUM}/comments
CODE_URL=https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${PRNUM}/comments

# Write message to specific file and line
function post_code_message()
{
    echo "POST to ${CODE_URL} with ${MESSAGE}"
    curl ${CODE_URL} -s \
        -H "Authorization: token ${GITHUB_TOKEN}" \
        -H "Content-Type: application/json" \
        -X POST --data "$(cat <<EOF
{
    "commit_id": "$COMMIT",
    "path": "Dockerfile",
    "position": "1",
    "body": "Wrong Docker images"
}
EOF
)"
}

i=1
COMMIT=""
for sha1 in $list; do
    echo "-------------------------------------------------------------"
    echo -e "[$i/$len] Check commit - \e[1;34m$sha1\e[0m"
    echo "-------------------------------------------------------------"
    COMMIT=$sha1
done

post_code_message()

echo -e "\e[1;34mDone\e[0m"


exit $RESULT