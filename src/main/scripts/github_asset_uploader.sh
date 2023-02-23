#!/bin/bash
set -e

PRODUCTS=(bamboo bamboo-agent bitbucket confluence crowd jira)
RELEASE_VERSION=$1

echo "[INFO]: Helm chart version is: ${RELEASE_VERSION}"

for PRODUCT in ${PRODUCTS[@]}; do
  
  echo "[INFO]: Uploading public key to ${PRODUCT}-${RELEASE_VERSION} release assets"
  
  RELEASE_ID=$(curl -s -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${GH_TOKEN}" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/tags/${PRODUCT}-"${RELEASE_VERSION}" | jq .id)
  
  curl -s -o /dev/null \
       -w "%{http_code}" \
       -X POST \
       -H "Accept: application/vnd.github+json" \
       -H "Authorization: Bearer ${GH_TOKEN}"\
       -H "X-GitHub-Api-Version: 2022-11-28" \
       -H "Content-Type: application/octet-stream" \
       https://uploads.github.com/repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}/assets?name=helm_key.pub \
       --data-binary "@helm_key.pub"
done


