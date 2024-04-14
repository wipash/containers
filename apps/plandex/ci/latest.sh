#!/usr/bin/env bash
version="$(curl -sX GET "https://api.github.com/repos/plandex-ai/plandex/releases" | jq --raw-output '.[] | select(.tag_name | startswith("server/")) | .tag_name' | sort -rV | head -n 1 2>/dev/null)"
version="${version#*/v}"
printf "%s" "${version}"
