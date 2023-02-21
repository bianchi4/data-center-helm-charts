#!/bin/bash

products=(bamboo bamboo-agent bitbucket common confluence crowd jira)
export REPO_PATH="${1}"
export CHARTS_LOCATION="src/main/charts"
for product in "${products[@]}"; do
  echo "[INFO]: Generating ${REPO_PATH}/${CHARTS_LOCATION}/${product}/RELEASE_NOTES.md"
  python3 -W ignore -c \
    "import prepare_release; print (prepare_release.gen_changelog(\"${product}\", \"${REPO_PATH}\"))" \
      | sed 's/\[//g' \
      | sed 's/\]//g' \
      | sed 's/,//g' \
      | sed "s/'/\"/g" \
      | sed 's/\" \"/\n/g' \
      | sed 's/"//g' > "${REPO_PATH}"/"${CHARTS_LOCATION}"/"${product}"/RELEASE_NOTES.md
done