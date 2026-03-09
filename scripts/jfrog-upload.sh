#!/usr/bin/env bash
set -euo pipefail

ARTIFACT_PATH="${1:?Usage: jfrog-upload.sh <artifact-path>}"
echo "Would upload: ${ARTIFACT_PATH}"
