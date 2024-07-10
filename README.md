# Stock Price Prediction Model

This MATLAB script trains a neural network to predict stock price ranges based on historical data.

## Overview

The script performs the following main tasks:
1. Loads and preprocesses stock market data
2. Prepares input and output data for training
3. Splits data into training and validation sets
4. Defines and trains a neural network
5. Evaluates the model's performance

## Prerequisites

- MATLAB 2022b
- Deep Learning Toolbox

## Usage

1. Ensure you have a `Data` variable in your workspace or a `LoadData` script available.
2. Run the script in MATLAB.

## Key Components

### Data Preparation
- Uses historical stock data (price, high, low)
- Creates input sequences of length `delay` (200 by default)
- Generates output predictions for `horizon` future time steps (100 by default)

### Model Architecture
- The neural network architecture is defined in a separate script called `LG[1-8]`

### Training
- Uses Adam optimizer
- Trains for a maximum of 100 epochs
- Implements early stopping based on validation loss

### Evaluation
- Predicts on validation data
- Plots predicted vs. actual values

## Customization

You can modify the following parameters:
- `delay`: Input sequence length
- `horizon`: Prediction horizon
- `feature`: Select which features to use (1:4 by default)
- Training options (epochs, learning rate, etc.)

## Notes

- The code assumes the existence of a `Data` variable or a `LoadData` script.
- The neural network architecture (`LG[1-8]`) is not provided in this snippet.
- The script uses a custom `plotSeries` function.

## Disclaimer

This code is for educational purposes only. Stock market prediction is inherently risky, and this model should not be used for actual trading decisions without thorough validation and risk assessment.
