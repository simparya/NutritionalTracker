
#!/bin/bash

# Get today's menu from Earhart Dining Court

url="https://api.hfs.purdue.edu/menus/v2"
today=$(date +%Y-%m-%d)

echo "Purdue Dining Menu - Earhart"
echo "Date: $today"
echo ""

# Download the menu
curl -s -f "$url/locations/Earhart/$today" -o menu.json

# Check if the download worked
if [ $? -ne 0 ]; then
    echo "Could not download the menu."
    exit 1
fi

# Check if the response contains menu data
if ! jq -e '.Meals | type == "array"' menu.json > /dev/null 2>&1; then
    echo "Menu data is unavailable."
    exit 1
fi

# Display the available meals
echo "Available meals:"
jq -r '.Meals[].Name' menu.json

echo ""
read -p "Enter a meal (Breakfast, Lunch, Dinner): " meal

# Find the selected meal and display its food items
echo ""
echo "Food items for $meal:"

jq -r --arg meal "$meal" '
    .Meals[] |
    select(.Name == $meal) |
    .Stations[].Items[].Name
' menu.json
