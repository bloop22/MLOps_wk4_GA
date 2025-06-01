# Week 2 - MLOps Assignment: Data & Model Versioning with DVC

This project demonstrates how to use **Git** and **DVC (Data Version Control)** to manage dataset and model versions in a machine learning workflow using the Iris dataset and a Decision Tree classifier.

---

## 📁 Files and Their Utility

### `iris.csv`
- The base dataset used for training.

---

### `main.py`
- Trains a Decision Tree classifier on `iris.csv`.
- Saves the trained model as `model.joblib`.

---

### `modifyData.py`
- Performs **random sampling with replacement** to select 15 rows from `iris.csv`.
- Appends these to the dataset, increasing its size from 150 to 165 rows.

---

### `requirements.txt`
- Lists required Python packages.

---

### `wk2Screencast.sh`
- Bash script that automates the entire experiment pipeline.
- Includes:
  - Git and DVC initialization
  - Environment setup
  - Dataset tracking
  - Model training
  - Versioning using Git tags (`v1.0`, `v2.0`)
  - DVC diff to compare changes between versions

---

### `wk_2_script.sh`
- A rougher initial version retained for reference.

---

