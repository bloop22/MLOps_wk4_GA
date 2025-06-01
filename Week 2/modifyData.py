# modifyData.py

import pandas as pd

# Define data file
data_file = "iris.csv"

# Load original data
data = pd.read_csv(data_file)

# Sample 15 rows with replacement from original data
sampled = data.sample(n=15, replace=True, random_state=42)

# Append sampled rows to original data
modified_data = pd.concat([data, sampled], ignore_index=True)

# Overwrite the original file
modified_data.to_csv(data_file, index=False)

print(f"Overwritten {data_file} with {len(modified_data)} rows (added 15 sampled rows).")
