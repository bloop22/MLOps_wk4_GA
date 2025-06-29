# MLOps Wk 4
## Files Overview

- **train.py**: Trains a Decision Tree classifier on the Iris dataset and saves the model to `model.joblib`.
- **test.py**: Contains unittests to:
  - Validate the format and data integrity of `sample1.csv`
  - Predict the class of the sample using the trained model
- **requirements.txt**: Lists required libraries like `scikit-learn`, `pandas`, and `joblib`.
- **./github/workflows/python-app.yml**: GitHub Actions workflow to:
  - Install dependencies
  - Run unittests
  - Generate a CML report with test outputs

---
 
