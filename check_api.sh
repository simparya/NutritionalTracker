
#!/bin/bash

# Purdue Dining Menu API connection test

url="https://api.hfs.purdue.edu/menus/v2"
today=$(date +%Y-%m-%d)

echo "Checking Purdue Dining API..."

# Check if jq is installed
if ! command -v jq > /dev/null 2>&1; then
    echo "Error: jq is not installed."
    exit 1
fi

# Download today's Earhart menu
curl -s -f "$url/locations/Earhart/$today" -o menu_test.json

# Check if the download worked
if [ $? -ne 0 ]; then
    echo "Error: Could not download the menu."
    exit 1
fi

# Check if the downloaded data is valid JSON
if jq empty menu_test.json 2>/dev/null; then
    echo "Successfully connected to Purdue Dining API!"
    echo "Menu saved to menu_test.json"
else
    echo "Error: Invalid JSON response."
    exit 1
fi

# Display available meals
echo ""
echo "Available meals at Earhart:"
jq -r '.Meals[].Name' menu_test.json
