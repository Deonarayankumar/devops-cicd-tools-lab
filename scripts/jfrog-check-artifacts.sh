#!/usr/bin/env bash
set -euo pipefail

ARTIFACT_NAME="${1:?Usage: jfrog-check-artifacts.sh <artifact-name>}"
JFROG_URL="${JFROG_URL:?Set JFROG_URL}"
JFROG_REPO="${JFROG_REPO:?Set JFROG_REPO}"
JFROG_API_KEY="${JFROG_API_KEY:?Set JFROG_API_KEY}"

TARGET_URL="${JFROG_URL}/artifactory/api/storage/${JFROG_REPO}/${ARTIFACT_NAME}"

echo "Checking artifact: ${TARGET_URL}"

HTTP_CODE=$(curl -sS -o /dev/null -w "%{http_code}" \
  -H "X-JFrog-Art-Api: ${JFROG_API_KEY}" \
  "${TARGET_URL}")

if [[ "${HTTP_CODE}" == "200" ]]; then
  echo "Artifact found: ${ARTIFACT_NAME}"
  exit 0
else
  echo "Artifact not found (HTTP ${HTTP_CODE}): ${ARTIFACT_NAME}" >&2
  exit 1
fi
