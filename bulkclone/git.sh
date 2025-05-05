#!/bin/bash

IS_ORG=false
TAKE=100
TARGET_DIR="."
POSITIONAL=()

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -org)
      IS_ORG=true
      shift
      ;;
    -take)
      TAKE="$2"
      shift
      shift
      ;;
    -dir)
      TARGET_DIR="$2"
      shift
      shift
      ;;
    *) # positional argument
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL[@]}"

if [ -z "$1" ]; then
  echo "Usage: $0 [-org] [-take N] [-dir PATH] <target>"
  exit 1
fi

TARGET="$1"
if [ "$IS_ORG" = true ]; then
  API_URL="https://api.github.com/orgs/$TARGET/repos?per_page=$TAKE"
else
  API_URL="https://api.github.com/users/$TARGET/repos?per_page=$TAKE"
fi

mkdir -p "$TARGET_DIR"

curl -s "$API_URL" | jq -r '.[].clone_url' | while read -r repo; do
  git clone "$repo" "$TARGET_DIR/$(basename "$repo" .git)"
done
