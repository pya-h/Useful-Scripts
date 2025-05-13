#!/bin/bash

IS_ORG=false
TAKE=100
TARGET_DIR="."
TOKEN=""
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
    -token)
      TOKEN="$2"
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
  echo "Usage: $0 [-org] [-take N] [-dir PATH] [-token TOKEN] <target>"
  exit 1
fi

TARGET="$1"

if [ "$IS_ORG" = true ]; then
  API_URL="https://api.github.com/orgs/$TARGET/repos?per_page=$TAKE"
else
  API_URL="https://api.github.com/users/$TARGET/repos?per_page=$TAKE"
fi

mkdir -p "$TARGET_DIR"

if [[ -n "$TOKEN" ]]; then
  AUTH_HEADER="Authorization: token $TOKEN"
  URL_FIELD="clone_url"
  echo "Fetching private and public repos using token..."
else
  AUTH_HEADER=""
  URL_FIELD="clone_url"
  echo "Fetching public repos only..."
fi

curl -s -H "$AUTH_HEADER" "$API_URL" | jq -r ".[] | .$URL_FIELD" | while read -r repo; do
  if [[ -n "$TOKEN" ]]; then
    # Inject token into the clone URL (only works with HTTPS)
    repo=$(echo "$repo" | sed "s|https://|https://$TOKEN@|")
  fi
  git clone "$repo" "$TARGET_DIR/$(basename "$repo" .git)"
done
