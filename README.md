# BoilerNutrition CLI

A Bash command-line tool designed to help Purdue students check dining court menus and nutritional information without opening the Purdue Menu app.

## The Problem

Finding nutritional information for Purdue dining court meals requires students to navigate the Purdue Menu app or website, which can be complicated. This project aims to make that information easier to access directly from a terminal, especially for students tracking calories or protein.

## How It Works

The planned Version 1.0 will allow users to:

- View an available dining court menu (Earhart) for a selected meal (breakfast, lunch, or dinner).
- Search for food items by name.
- View published calories, protein, carbohydrates, and fat, when available.
- Receive clear messages for invalid input, unavailable menus, or missing nutrition values.

The application will use `curl` to request menu information and `jq` to extract fields from the returned JSON. Access to the proposed Purdue menu API still needs to be tested.

![System diagram](C:\Users\huynguyen\Downloads\BoilerNutrition_starter\System Diagram.png)

## Tech Stack

- **Language:** Bash
- **Commands/tools:** `curl` for HTTP requests and `jq` for JSON processing
- **Data source:** Purdue dining menu data (API access to be verified)
- **Development:** Visual Studio Code, Git, and GitHub

## Setup

1. Install Bash, `curl`, and `jq`.
2. Clone this repository with its GitHub URL.
3. Enter the project directory.
4. Once the script is implemented, run it using Bash.

```bash
# Replace with your actual GitHub repository URL
# git clone https://github.com/YOUR_USERNAME/BoilerNutrition.git
# cd BoilerNutrition
# bash boilernutrition.sh
```

## Usage

Run `bash boilernutrition.sh`, select a meal, choose or search for a food item, and read its available nutritional information in the terminal. Actual commands and example output will be added after implementation and testing.

## Roadmap

### Version 1.0 — MVP

- [ ] Verify access to the menu data source
- [ ] Fetch and display daily menus
- [ ] Add meal selection and interactive terminal navigation
- [ ] Display available nutritional information
- [ ] Implement food search and error handling

### Future Updates — Schedule Quadrant

- [ ] Support additional dining courts
- [ ] Compare nutritional values between food items
- [ ] Calculate total nutrition for selected meals
- [ ] Save favorite foods
- [ ] Export nutrition data to CSV

## Author

CS193 final project — [GitHub profile](https://github.com/simparya)
