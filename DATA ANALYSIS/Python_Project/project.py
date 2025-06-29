import opendatasets as od
import pandas as pd
import random

# We take the train data from https://www.kaggle.com/competitions/new-york-city-taxi-fare-prediction/data

# We'll train a machine learning model to predict the fare for a taxi ride in New York city given information like pickup date & time, pickup location, drop location and no. of passengers.

# Loading Training Set
# Loading the entire dataset into Pandas is going to be slow, so we can use the following optimizations:

# - Ignore the key column
# - Parse pickup datetime while loading data
# - Specify data types for other columns
# - float32 for geo coordinates
# - float32 for fare amount
# - uint8 for passenger count
# - Work with a 1% sample of the data (~500k rows)
sample_frac = 0.05

selected_cols = 'fare_amount,pickup_datetime,pickup_longitude,pickup_latitude,dropoff_longitude,dropoff_latitude,passenger_count'.split(',')
dtypes = {
    'fare_amount': 'float32',
    'pickup_longitude': 'float32',
    'pickup_latitude': 'float32',
    'dropoff_longitude': 'float32',
    'passenger_count': 'float32'
}

def skip_row(row_idx):
    if row_idx == 0:
        return False
    return random.random() > sample_frac

random.seed(42)
df = pd.read_csv("Project/train.csv", 
                 usecols=selected_cols, 
                 dtype=dtypes, 
                 parse_dates=['pickup_datetime'], 
                 skiprows=skip_row)

# Load Test Set
test_df = pd.read_csv('Project/test.csv', dtype=dtypes, parse_dates=['pickup_datetime'])

# Explore the Dataset
# Training Set
# print(df.info())
# print(df.describe())
# print(df.pickup_datetime.min(), df.pickup_datetime.max())

# Test Set
# print(test_df.info())
# print(test_df.describe())
# print(test_df.pickup_datetime.min(), test_df.pickup_datetime.max())

# Prepare Dataset for Training
# Split Training & Validation Set
# Fill/Remove Missing Values
# Extract Inputs & Outputs:
    # Training
    # Validation
    # Test

# Split Training & Validation Set
from sklearn.model_selection import train_test_split
train_df, val_df = train_test_split(df, test_size=0.2, random_state=42)

# Fill/Remove Missing Values
train_df = train_df.dropna()
val_df = val_df.dropna()

# Extract Inputs and Outputs
input_cols = ['pickup_longitude', 'pickup_latitude', 'dropoff_longitude', 'dropoff_latitude', 'passenger_count']
target_col = 'fare_amount'

# Training
train_inputs = train_df[input_cols]
train_targets = train_df[target_col]

# Validation
val_inputs = val_df[input_cols]
val_targets = val_df[target_col]

# Test
test_inputs = test_df[input_cols]

# Train & Evaluate Hardcoded Model
import numpy as np

class MeanRegressor():
    def fit(self, inputs, targets):
        self.mean = targets.mean()

    def predict(self, inputs):
        return np.full(inputs.shape[0], self.mean)

mean_model = MeanRegressor()
mean_model.fit(train_inputs, train_targets)
train_preds = mean_model.predict(train_inputs)
val_preds = mean_model.predict(val_inputs)

from sklearn.metrics import mean_squared_error

def rmse(a, b):
    return np.sqrt(mean_squared_error(a, b))

# print("Mean Model")
# train_rmse = rmse(train_targets, train_preds)
# print(f"Train RMSE: {train_rmse:.2f}")
# val_rmse = rmse(val_targets, val_preds)
# print(f"Validation RMSE: {val_rmse:.2f}")

# Make Predictions and Submit to Kaggle
# - Make predictions for test set
# - Generate submissions CSV
# Record in experiment tracking sheet
from sklearn.linear_model import LinearRegression
# linreg_model = LinearRegression()
# linreg_model.fit(train_inputs, train_targets)

# test_preds = linreg_model.predict(test_inputs)

# train_preds = linreg_model.predict(train_inputs)
# val_preds = linreg_model.predict(val_inputs)

# print("Linear Regression Model")
# train_rmse = rmse(train_targets, train_preds)
# print(f"Train RMSE: {train_rmse:.2f}")
# val_rmse = rmse(val_targets, val_preds)
# print(f"Validation RMSE: {val_rmse:.2f}")

submission_df = pd.read_csv('Project/sample_submission.csv')

def generate_submission(test_preds, fname):
    sub_df = pd.read_csv('Project/sample_submission.csv')
    sub_df['fare_amount'] = test_preds
    sub_df.to_csv(fname, index=None)

# generate_submission(test_preds, 'Project/linreg_submission.csv')

# Feature Engineering
# - Extract parts of date
# - Remove outliers & invalid data
# - Add distance between pickup & drop
# - Add distance from landmarks

# Extract Parts of Date
def add_dateparts(df, col):
    df[col + '_year'] = df[col].dt.year
    df[col + '_month'] = df[col].dt.month
    df[col + '_day'] = df[col].dt.day
    df[col + '_weekday'] = df[col].dt.weekday
    df[col + '_hour'] = df[col].dt.hour

add_dateparts(train_df, 'pickup_datetime')
add_dateparts(val_df, 'pickup_datetime')
add_dateparts(test_df, 'pickup_datetime')

# Add Distance Between Pickup and Drop
# haversine distance
import numpy as np

def haversine_np(lon1, lat1, lon2, lat2):
    """
    Calculate the great circle distance between two points
    on the earth (specified in decimal degrees)

    All args must be of equal length.    

    """
    lon1, lat1, lon2, lat2 = map(np.radians, [lon1, lat1, lon2, lat2])

    dlon = lon2 - lon1
    dlat = lat2 - lat1

    a = np.sin(dlat/2.0)**2 + np.cos(lat1) * np.cos(lat2) * np.sin(dlon/2.0)**2

    c = 2 * np.arcsin(np.sqrt(a))
    km = 6367 * c
    return km

def add_trip_distance(df):
    df['trip_distance'] = haversine_np(df['pickup_longitude'], df['pickup_latitude'], df['dropoff_longitude'], df['dropoff_latitude'])

add_trip_distance(train_df)
add_trip_distance(val_df)
add_trip_distance(test_df)

# Add Distance From Popular Landmarks
jfk_lonlat = -73.7781, 40.6413
lga_lonlat = -73.8740, 40.7769
ewr_lonlat = -74.1745, 40.6895
met_lonlat = -73.9632, 40.7794
wtc_lonlat = -74.0099, 40.7126

def add_landmark_dropoff_distance(df, landmark_name, landmark_lonlat):
    lon, lat = landmark_lonlat
    df[landmark_name + '_drop_distance'] = haversine_np(lon, lat, df['dropoff_longitude'], df['dropoff_latitude'])

for a_df in [train_df, val_df, test_df]:
    for name, lonlat in [('jfk', jfk_lonlat), ('lga', lga_lonlat), ('ewr', ewr_lonlat), ('met', met_lonlat), ('wtc', wtc_lonlat)]:
        add_landmark_dropoff_distance(a_df, name, lonlat)

# Remove Outliers and Invalid Data
# We'll use the following ranges
# fare_amount: $1 to $500
# longitudes: -75 to -72
# latitudes: 40 to 42
# passenger_count: 1 to 6

def remove_outliers(df):
    return df[(df['fare_amount'] >= 1.) & 
              (df['fare_amount'] <= 500.) &
              (df['pickup_longitude'] >= -75) & 
              (df['pickup_longitude'] <= -72) & 
              (df['dropoff_longitude'] >= -75) & 
              (df['dropoff_longitude'] <= -72) & 
              (df['pickup_latitude'] >= 40) & 
              (df['pickup_latitude'] <= 42) & 
              (df['dropoff_latitude'] >=40) & 
              (df['dropoff_latitude'] <= 42) & 
              (df['passenger_count'] >= 1) & 
              (df['passenger_count'] <= 6)]

train_df = remove_outliers(train_df)
val_df = remove_outliers(val_df)

# Save Intermediate DataFrames
train_df.to_parquet('train.parquet')
val_df.to_parquet('val.parquet')
test_df.to_parquet('test.parquet')

# Load the cleaned datasets
train_df = pd.read_parquet('train.parquet')
val_df = pd.read_parquet('val.parquet')
test_df = pd.read_parquet('test.parquet')

# Train & Evaluate Different Models
# We'll train each of the following & submit predictions to Kaggle:

# - Linear Regression
# - Random Forests
# - Gradient Boosting

# Split Inputs & Targets
input_cols = ['pickup_longitude', 'pickup_latitude', 'dropoff_longitude', 'dropoff_latitude', 'passenger_count', 'pickup_datetime_year', 'pickup_datetime_month', 'pickup_datetime_day', 'pickup_datetime_weekday', 'pickup_datetime_hour', 'trip_distance', 'jfk_drop_distance', 'lga_drop_distance', 'ewr_drop_distance', 'met_drop_distance', 'wtc_drop_distance']
target_col = 'fare_amount'

train_inputs = train_df[input_cols]
train_targets = train_df[target_col]

val_inputs = val_df[input_cols]
val_targets = val_df[target_col]

test_inputs = test_df[input_cols]

def evaluate(model):
    train_preds = model.predict(train_inputs)
    train_rmse = rmse(train_targets, train_preds)
    val_preds = model.predict(val_inputs)
    val_rmse = rmse(val_targets, val_preds)
    return train_rmse, val_rmse, train_preds, val_preds

def predict_and_submit(model, fname):
    test_preds = model.predict(test_inputs)
    sub_df = pd.read_csv('Project/sample_submission.csv')
    sub_df['fare_amount'] = test_preds
    sub_df.to_csv(fname, index=None)
    return sub_df


# Ridge Regression
from sklearn.linear_model import Ridge

ridge_model = Ridge(random_state=42, alpha=0.9)
ridge_model.fit(train_inputs, train_targets)

print(f"Ridge Model")
train_rmse, val_rmse, train_preds, val_preds = evaluate(ridge_model)
print(f"Train RMSE: {train_rmse:.2f}")
print(f"Validation RMSE: {val_rmse:.2f}")

predict_and_submit(ridge_model, 'Project/ridge_submission.csv')

# Random Forests
from sklearn.ensemble import RandomForestRegressor

rf_model = RandomForestRegressor(max_depth=10, n_jobs=-1, random_state=42, n_estimators=50)
rf_model.fit(train_inputs, train_targets)

print(f"Random Forests Model")
train_rmse, val_rmse, train_preds, val_preds = evaluate(rf_model)
print(f"Train RMSE: {train_rmse:.2f}")
print(f"Validation RMSE: {val_rmse:.2f}")

predict_and_submit(rf_model, 'Project/rf_submission.csv')

# Gradient Boosting
from xgboost import XGBRegressor

xgb_model = XGBRegressor(random_state=42, n_jobs=-1, objective='reg:squarederror')
xgb_model.fit(train_inputs, train_targets)  

print(f"Gradient Boosting Model")
train_rmse, val_rmse, train_preds, val_preds = evaluate(xgb_model)
print(f"Train RMSE: {train_rmse:.2f}")
print(f"Validation RMSE: {val_rmse:.2f}")   

predict_and_submit(xgb_model, 'Project/xgb_submission.csv')

# Tune Hyperparmeters
# We'll train parameters for the XGBoost model. Here’s a strategy for tuning hyperparameters:

# Tune the most important/impactful hyperparameter first e.g. n_estimators

# With the best value of the first hyperparameter, tune the next most impactful hyperparameter

# And so on, keep training the next most impactful parameters with the best values for previous parameters...

# Then, go back to the top and further tune each parameter again for further marginal gains

# Hyperparameter tuning is more art than science, unfortunately. Try to get a feel for how the parameters interact with each other based on your understanding of the parameter…

import matplotlib.pyplot as plt

def test_params(ModelClass, **params):
    """Trains a model with the given parameters and returns training & validation RMSE"""
    model = ModelClass(**params).fit(train_inputs, train_targets)
    train_rmse = mean_squared_error(model.predict(train_inputs), train_targets, squared=False)
    val_rmse = mean_squared_error(model.predict(val_inputs), val_targets, squared=False)
    return train_rmse, val_rmse

def test_param_and_plot(ModelClass, param_name, param_values, **other_params):
    """Trains multiple models by varying the value of param_name according to param_values"""
    train_errors, val_errors = [], [] 
    for value in param_values:
        params = dict(other_params)
        params[param_name] = value
        train_rmse, val_rmse = test_params(ModelClass, **params)
        train_errors.append(train_rmse)
        val_errors.append(val_rmse)
    
    plt.figure(figsize=(10,6))
    plt.title('Overfitting curve: ' + param_name)
    plt.plot(param_values, train_errors, 'b-o')
    plt.plot(param_values, val_errors, 'r-o')
    plt.xlabel(param_name)
    plt.ylabel('RMSE')
    plt.legend(['Training', 'Validation'])

best_params = {
    'random_state': 42,
    'n_jobs': -1,
    'objective': 'reg:squarederror'
}

# No. of Trees
# test_param_and_plot(XGBRegressor, 'n_estimators', [100, 250, 500], **best_params)

best_params['n_estimators'] = 250

# Max Depth
# test_param_and_plot(XGBRegressor, 'max_depth', [3, 4, 5], **best_params)

best_params['max_depth'] = 5

# Learning Rate
# test_param_and_plot(XGBRegressor, 'learning_rate', [0.05, 0.1, 0.25], **best_params)

best_params['learning_rate'] = 0.25

# Subsample
# test_param_and_plot(XGBRegressor, 'subsample', [0.5, 0.8, 1.0], **best_params)

best_params['subsample'] = 0.8

# Other Parameters
xgb_model_final = XGBRegressor(objective='reg:squarederror', n_jobs=-1, random_state=42,
                               n_estimators=500, max_depth=5, learning_rate=0.1, 
                               subsample=0.8, colsample_bytree=0.8)

xgb_model_final.fit(train_inputs, train_targets)

print("Gradient Boosting Model with Tuned Hyperparameters")
train_rmse, val_rmse, train_preds, val_preds = evaluate(xgb_model_final)
print(f"Train RMSE: {train_rmse:.2f}")
print(f"Validation RMSE: {val_rmse:.2f}")

predict_and_submit(xgb_model_final, 'Project/xgb_tuned_submission.csv')

