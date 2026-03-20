#!/usr/bin/env bash
set -euo pipefail

ARTIFACT_PATH="${1:?Usage: jfrog-upload.sh <artifact-path>}"
JFROG_URL="${JFROG_URL:?Set JFROG_URL}"
JFROG_REPO="${JFROG_REPO:?Set JFROG_REPO}"
JFROG_API_KEY="${JFROG_API_KEY:?Set JFROG_API_KEY}"

ARTIFACT_NAME="$(basename "${ARTIFACT_PATH}")"
TARGET_PATH="${JFROG_REPO}/${ARTIFACT_NAME}"

echo "Uploading ${ARTIFACT_PATH} to ${JFROG_URL}/artifactory/${TARGET_PATH}"

curl -f -sS \
  -H "X-JFrog-Art-Api: ${JFROG_API_KEY}" \
  -T "${ARTIFACT_PATH}" \
  "${JFROG_URL}/artifactory/${TARGET_PATH}"

echo "Upload complete: ${TARGET_PATH}"
