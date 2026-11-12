#!/usr/bin/env bash
# Milestone 2: Check access to Purdue Dining's menu API.
# Usage: bash check_api.sh [YYYY-MM-DD]
# This script checks connectivity only; it does not implement the CLI yet.

set -euo pipefail

API_BASE="https://api.hfs.purdue.edu/menus/v2"
LOCATION="Earhart"
MENU_DATE="${1:-$(date +%Y-%m-%d)}"

if ! [[ "$MENU_DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Usage: bash check_api.sh [YYYY-MM-DD]" >&2
    exit 1
fi

for command_name in curl jq; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
        echo "Error: please install $command_name before running this script." >&2
        exit 1
    fi
done

locations_file=$(mktemp)
menu_file=$(mktemp)
trap 'rm -f "$locations_file" "$menu_file"' EXIT

echo "Checking Purdue Dining API..."

if ! curl --fail --silent --show-error --location --max-time 20 \
    --header "Accept: application/json" \
    "$API_BASE/locations" --output "$locations_file"; then
    echo "Error: could not retrieve dining locations." >&2
    exit 1
fi

if ! jq -e '.Location | type == "array"' "$locations_file" >/dev/null; then
    echo "Error: locations response was not in the expected JSON format." >&2
    exit 1
fi

echo "Locations endpoint: OK"
echo "Published locations: $(jq '.Location | length' "$locations_file")"

if ! jq -e --arg name "$LOCATION" \
    '.Location | any(.Name == $name)' "$locations_file" >/dev/null; then
    echo "Error: $LOCATION was not found in the locations response." >&2
    exit 1
fi

echo "Checking $LOCATION menu for $MENU_DATE..."
if ! curl --fail --silent --show-error --location --max-time 20 \
    --header "Accept: application/json" \
    "$API_BASE/locations/$LOCATION/$MENU_DATE" --output "$menu_file"; then
    echo "Error: could not retrieve the menu for $LOCATION on $MENU_DATE." >&2
    exit 1
fi

if ! jq -e '.Meals | type == "array"' "$menu_file" >/dev/null; then
    echo "Error: menu response was not in the expected JSON format." >&2
    exit 1
fi

echo "Menu endpoint: OK"
echo "Published: $(jq -r '.IsPublished // "unknown"' "$menu_file")"
echo "Meals returned: $(jq '.Meals | length' "$menu_file")"
jq -r '.Meals[].Name // empty' "$menu_file" | sed 's/^/ - /'

if [[ "$(jq -r '.IsPublished // "unknown"' "$menu_file")" != "true" ]]; then
    echo "Note: this menu may be unpublished; empty meal data is not necessarily an API failure."
fi

echo "Connection check complete. Nutrition item lookup is a later milestone."
