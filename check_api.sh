#!/bin/bash

# Check if we can get menu data from Purdue's API

url="https://api.hfs.purdue.edu/menus/v2"
date_today=$(date +%Y-%m-%d)

# Make sure curl and jq are installed
if ! command -v curl > /dev/null || ! command -v jq > /dev/null; then
    echo "Please install curl and jq first."
    exit 1
fi

echo "Checking Purdue menu API..."

# Download Earhart's menu for today
if ! curl -fsSL --max-time 20 "$url/locations/Earhart/$date_today" -o menu_test.json; then
    echo "Couldn't download today's menu."
    exit 1
fi

# Check if the file is valid JSON
if ! jq empty menu_test.json 2>/dev/null; then
    echo "The response was not valid JSON."
    exit 1
fi

echo "Got a JSON response from the API."
echo "Saved it to menu_test.json"
echo "Open the file to see how the menu data is organized."
