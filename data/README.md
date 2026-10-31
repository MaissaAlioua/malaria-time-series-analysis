# Dataset Documentation

## Overview

This directory contains information about the dataset used in the **Malaria Incidence: Time-Series Analysis & ARIMA Forecasting** project.

The dataset contains malaria incidence observations across approximately 107 countries, covering the period from 2000 to 2018.

## Dataset Information

| Attribute | Description |
|---|---|
| Dataset name | Malaria Incidence Dataset |
| Number of observations | 2,033 |
| Time period | 2000–2018 |
| Geographic coverage | Multiple countries across WHO regions |
| Main variable | Malaria incidence |
| Format | CSV |

## Dataset Columns

| Column | Description |
|---|---|
| `Country` | Country name |
| `Year` | Observation year |
| `No. of cases` | Malaria incidence value |
| `WHO Region` | WHO region associated with the country |

## Data Source

**Original source:** []

Please refer to the original source for the official documentation, measurement units, and redistribution conditions.

## Usage

To reproduce the analysis:

1. Obtain the original dataset from the source mentioned above.
2. Download the CSV file.
3. Place it in this directory.
4. Rename it to:

```text
malaria-dataset.csv
```

5. Run the notebook located in `notebooks/malaria_time_series_arima.ipynb`.

## Data Availability

The dataset itself is not included in this repository until its redistribution permissions have been verified.

Users should download it directly from the original source if redistribution is not permitted.
