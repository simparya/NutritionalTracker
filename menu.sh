
#!/bin/bash

url="https://api.hfs.purdue.edu/menus/v2"
today=$(date +%Y-%m-%d)

echo "===== Purdue Dining Menu ====="
echo "Date: $today"
echo ""

# Display dining courts
echo "1. Earhart"
echo "2. Ford"
echo "3. Wiley"
echo "4. Windsor"
echo "5. Hillenbrand"

read -p "Choose a dining court: " choice

# Set the dining court based on user input
case $choice in
    1) court="Earhart" ;;
    2) court="Ford" ;;
    3) court="Wiley" ;;
    4) court="Windsor" ;;
    5) court="Hillenbrand" ;;
    *)
        echo "Invalid dining court."
        exit 1
        ;;
esac

# Download the selected dining court's menu
curl -fsSL "$url/locations/$court/$today" -o menu.json

if [ $? -ne 0 ]; then
    echo "Could not download the menu."
    exit 1
fi

# Check menu data
if ! jq -e '.Meals | type == "array"' menu.json > /dev/null 2>&1; then
    echo "Menu data is unavailable."
    exit 1
fi

# Display available meals
echo ""
echo "Available meals at $court:"
jq -r '.Meals[].Name' menu.json

read -p "Enter a meal name: " meal

# Display food items
echo ""
echo "Food items at $court for $meal:"

jq -r --arg meal "$meal" '
    .Meals[] |
    select(.Name == $meal) |
    .Stations[].Items[].Name
' menu.json
