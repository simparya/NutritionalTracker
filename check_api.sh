
#!/bin/bash

# Check if Purdue's menu API is working

url="https://api.hfs.purdue.edu/menus/v2"
today=$(date +%Y-%m-%d)

echo "Checking Purdue Dining API..."

curl -s -f "$url/locations/Earhart/$today" -o menu_test.json #Get today menu from Earhart

if [ $? -eq 0 ]; then
    echo "Menu downloaded successfully!"
    if jq empty menu_test.json 2>/dev/null; then #Check if menu is downloaded successfully
        echo "JSON data looks good."
        echo "Saved menu data to menu_test.json"
    else
        echo "Error: The response is not valid JSON."
    fi
else
    echo "Error: Could not connect to Purdue's menu API."
fi
