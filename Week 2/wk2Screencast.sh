#!/bin/bash

# Set up some formatting
divider="------------------------------------------------------------"
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)

print_step() {
    echo -e "\n${blue}${divider}${reset}"
    echo -e "${bold}${green}▶ $1${reset}"
    echo -e "${blue}${divider}${reset}\n"
}

# Uncomment if you want to clone fresh
# print_step "Cloning the repository..."
# git clone https://github.com/MLOps.git
# cd MLOps/Week\ 2

print_step "Initializing Git..."
git init

print_step "Configuring Git user..."
git config --global user.email "presthahooda@gmail.com"
git config --global user.name "pre"

print_step "Setting up Python virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

print_step "Installing required Python packages..."
pip install -r requirements.txt > /dev/null
pip install dvc > /dev/null

print_step "Initializing DVC in the project..."
dvc init > /dev/null

print_step "Adding iris.csv to DVC tracking..."
dvc add iris.csv > /dev/null
git add iris.csv.dvc .gitignore

print_step "Running the model training script (first version)..."
python main.py  # Model saved as model.joblib

print_step "Adding model.joblib to DVC tracking..."
dvc add model.joblib > /dev/null
git add model.joblib.dvc .gitignore

print_step "Committing first model version to Git..."
git commit -m "first iteration"
git tag -a "v1.0" -m "model trained on 150 records"

print_step "Modifying the dataset and retraining model..."
python modifyData.py 
python main.py

print_step "Re-adding updated iris.csv and model.joblib to DVC..."
dvc add model.joblib iris.csv > /dev/null
git add model.joblib.dvc iris.csv.dvc .gitignore

print_step "Committing second model version to Git..."
git commit -m "second iteration"
git tag -a "v2.0" -m "model trained on 165 records"

print_step "Checking out version v1.0..."
git checkout v1.0
dvc checkout

print_step "Row count in iris.csv at v1.0:"
wc -l iris.csv

print_step "Checking out version v2.0..."
git checkout v2.0
dvc checkout

print_step "Row count in iris.csv at v2.0:"
wc -l iris.csv

print_step "Resetting to working state (after checkout)..."
git reset

print_step "Showing DVC differences between v1.0 and v2.0 (JSON output)..."
dvc diff v1.0 v2.0 --json

print_step "Showing detailed DVC diff with explanations..."
dvc diff v1.0 v2.0 --json --show-hash

echo -e "\n${bold}${green}✅ Script complete.${reset}\n"
