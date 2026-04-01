import pandas as pd
from sklearn.preprocessing import MinMaxScaler

# Load the dataset
df = pd.read_csv('Realestate.csv')

# ─────────────────────────────────────────────────────────────
# 1. Normalize the houseAge column using Min-Max normalization.
#    This scales all values to a range of 0 to 1.
# ─────────────────────────────────────────────────────────────
scaler = MinMaxScaler()
df['houseAge'] = scaler.fit_transform(df[['houseAge']])

# ─────────────────────────────────────────────────────────────
# 2. Create a new column 'houseAgeStandardized' that holds
#    the normalized houseAge values copied from step 1.
# ─────────────────────────────────────────────────────────────
df['houseAgeStandardized'] = df['houseAge']

# ─────────────────────────────────────────────────────────────
# 3. Drop the 'numberOfConvenienceStores' column from the
#    dataset permanently using inplace=True.
# ─────────────────────────────────────────────────────────────
df.drop(columns=['numberOfConvenienceStores'], inplace=True)

# ─────────────────────────────────────────────────────────────
# 4. Rename the 'transaction' column to 'transactionDate'
#    for clearer, more descriptive naming.
# ─────────────────────────────────────────────────────────────
df.rename(columns={'transaction': 'transactionDate'}, inplace=True)

# ─────────────────────────────────────────────────────────────
# 5. Use .loc[] to display all rows with index labels 0 to 10.
#    .loc[] is label-based, so it includes both endpoints (0 and 10).
# ─────────────────────────────────────────────────────────────
print("=== .loc[] — rows 0 through 10 (label-based, inclusive) ===")
print(df.loc[0:10])
print()

# ─────────────────────────────────────────────────────────────
# 6. Use .iloc[] to display the first 10 rows by position.
#    .iloc[] is position-based, so [0:10] returns rows 0–9.
# ─────────────────────────────────────────────────────────────
print("=== .iloc[] — first 10 rows (position-based, rows 0–9) ===")
print(df.iloc[0:10])
print()

# ─────────────────────────────────────────────────────────────
# 7. Find and remove any duplicate rows from the dataset.
#    keep='first' retains the first occurrence; all copies after
#    that are dropped. Results are printed before and after.
# ─────────────────────────────────────────────────────────────
duplicates_found = df.duplicated().sum()
print(f"Duplicate rows found: {duplicates_found}")
df.drop_duplicates(keep='first', inplace=True)
print(f"Rows after removing duplicates: {len(df)}")
print()

# ─────────────────────────────────────────────────────────────
# 8. Find any missing (NaN) values and fill them with the
#    column mean. This preserves the distribution of each
#    column while handling gaps in the data.
# ─────────────────────────────────────────────────────────────
missing_before = df.isnull().sum()
print("Missing values per column (before fill):")
print(missing_before[missing_before > 0])

df.fillna(df.mean(numeric_only=True), inplace=True)

missing_after = df.isnull().sum().sum()
print(f"\nTotal missing values after fill: {missing_after}")
print()

# Final dataset overview
print("=== Final Dataset Info ===")
print(df.info())
print("\nFirst 5 rows of cleaned dataset:")
print(df.head())
