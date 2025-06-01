#!/bin/bash

#echo "Cloning the repository..."
# git clone https://github.com/bloop22/MLOps.git

# echo "Navigating to Week 2 directory..."
# cd MLOps
# cd "Week 2"

echo "Initializing Git..."
git init

#Configure git user
git config --global user.email "presthahooda@gmail.com"
git config --global user.name "pre"


echo "Setting up Python virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

echo "Installing required Python packages..."
pip install -r requirements.txt
pip install dvc

echo "Initializing DVC in the project..."
dvc init 

echo "Adding iris.csv to DVC tracking..."
dvc add iris.csv
git add iris.csv.dvc .gitignore

echo "Running the model training script (first version)..."
python main.py  # Model is saved in model.joblib

echo "Adding model.joblib to DVC tracking..."
dvc add model.joblib
git add model.joblib.dvc .gitignore

echo "Committing first model version to Git..."
git commit -m "first iteration"
git tag -a "v1.0" -m "model trained on 150 records"

echo "Modifying the dataset and retraining model..."
python modifyData.py 
python main.py

echo "Re-adding updated iris.csv and model.joblib to DVC..."
dvc add model.joblib iris.csv
git add model.joblib.dvc iris.csv.dvc .gitignore

echo "Committing second model version to Git..."
git commit -m "second iteration"
git tag -a "v2.0" -m "model trained on 165 records"

echo "Checking out version v1.0..."
git checkout v1.0
dvc checkout

echo "Row count in iris.csv at v1.0:"
wc -l iris.csv


echo "Checking out version v2.0..."
git checkout v2.0

echo "Row count in iris.csv at v2.0:"
wc -l iris.csv

echo "Resetting to working state (after checkout)..."
git reset

echo "Showing DVC differences between v1.0 and v2.0 (JSON output)..."
dvc diff v1.0 v2.0 --json

echo "Showing detailed DVC diff with explanations..."
dvc diff v1.0 v2.0 --json --show-hash

echo "✅ Script complete."
