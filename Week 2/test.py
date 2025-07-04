import unittest
import pandas as pd
import joblib
import os

class TestIrisModel(unittest.TestCase):
    model_path = "Week 2/model.joblib"
    sample_path = "Week 2/samples/sample1.csv"
    model = None

    def setUp(self):
        self.assertTrue(os.path.exists(self.model_path), f"Model file not found at {self.model_path}")
        self.model = joblib.load(self.model_path)

    def test_data_validation(self):
        df = pd.read_csv(self.sample_path)

        # Check for missing values
        self.assertFalse(df.isnull().values.any(), "Sample contains missing values")

        # Check for expected columns
        expected_cols = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width']
        for col in expected_cols:
            self.assertIn(col, df.columns, f"Missing expected column: {col}")

        # Check for correct data types
        for col in expected_cols:
            self.assertTrue(
                pd.api.types.is_float_dtype(df[col]) or pd.api.types.is_numeric_dtype(df[col]),
                f"Column {col} is not numeric"
            )

    def test_sample_prediction(self):
        self.assertTrue(os.path.exists(self.sample_path), f"Sample file not found at {self.sample_path}")
        df = pd.read_csv(self.sample_path)

        # Drop label if it exists
        if 'species' in df.columns:
            df = df.drop(columns=['species'])

        prediction = self.model.predict(df)

        expected = "setosa"
        self.assertEqual(prediction[0], expected, f"Expected '{expected}', but got '{prediction[0]}'")

if __name__ == '__main__':
    unittest.main()
