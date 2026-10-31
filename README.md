# Malaria Incidence: Time-Series Analysis & ARIMA Forecasting (R)

A statistical time-series analysis of WHO malaria incidence data (2000–2018) using the **Box-Jenkins methodology and ARIMA models in R**. This project covers the complete forecasting workflow, from exploratory data analysis and stationarity testing to model selection, residual diagnostics, and out-of-sample evaluation.

The project also critically examines the limitations of applying traditional ARIMA models to epidemiological data and documents the reasons behind the model's limited forecasting performance.

---

## Project Overview

| | Description |
|---|---|
| **Objective** | Analyze and forecast malaria incidence using ARIMA models and evaluate their predictive performance. |
| **Programming Language** | R |
| **Environment** | Google Colab (R kernel) |
| **Main Libraries** | `forecast`, `tseries`, `TSA`, `MASS`, `lmtest`, `zoo`, `tidyverse` |
| **Dataset** | 2,033 country-year observations covering 2000–2018 |
| **Notebook** | `notebooks/malaria_time_series_arima.ipynb` |

## Dataset

The project uses malaria incidence data covering 2000–2018, containing 2,033 observations across approximately 107 countries.

### Dataset Description

| Column | Description |
|---|---|
| `Country` | Name of the country |
| `Year` | Observation year (2000–2018) |
| `No. of cases` | Reported malaria incidence value |
| `WHO Region` | WHO geographical region associated with the country |

### Dataset Statistics

| Statistic | Value |
|---|---:|
| Number of observations | 2,033 |
| Time period | 2000–2018 |
| Minimum | 0 |
| Maximum | 743.51 |
| Mean | 109.19 |
| Median | 11.15 |

**Data source:** [(https://www.who.int/data/gho/data/indicators/indicator-details/GHO/malaria-incidence-%28per-1-000-population-at-risk%29?utm_source=chatgpt.com)]


> **Note on measurement units:** The values appear to represent malaria incidence per 1,000 population at risk rather than raw case counts. This interpretation should be verified against the original data source before treating the variable as a measure of incidence. The terminology and units used throughout the analysis should remain consistent with the source documentation.

---

## Methodology

The analysis follows the classical **Box-Jenkins methodology**, implementing the following stages:

### 1. Data Preparation

- Imported the dataset and converted variables to their appropriate data types.
- Renamed columns for easier manipulation and analysis.
- Examined missing values and checked data consistency.
- Applied interpolation using `zoo::na.approx()` to handle missing observations after the transformation stage.

### 2. Exploratory Data Analysis (EDA)

- Examined the dataset structure using `glimpse()` and `summary()`.
- Analyzed malaria incidence trends over time.
- Visualized the evolution of the series.
- Calculated and plotted rolling means and rolling standard deviations using a five-observation window to investigate trend and variance behavior.

### 3. Variance Stabilization

Applied the Box-Cox transformation to stabilize the variance of the time series.

- Estimated the optimal transformation parameter using profile likelihood (`MASS::boxcox`).
- Obtained an estimated value of approximately **λ = -0.06**, which is close to a logarithmic transformation.

### 4. Stationarity Analysis

Investigated the stationarity of the transformed series using the Augmented Dickey-Fuller (ADF) test.

- Performed the ADF test on the Box-Cox-transformed series.
- Applied first-order differencing and repeated the stationarity test.
- Examined the resulting series to determine its suitability for ARIMA modeling.

### 5. ARIMA Order Identification

Used complementary statistical techniques to identify suitable ARIMA model configurations:

- Autocorrelation Function (ACF) plots.
- Partial Autocorrelation Function (PACF) plots.
- Automated subset selection using `TSA::armasubsets()`.

### 6. Model Fitting and Selection

Fitted four candidate ARIMA models using `stats::arima()`.

Models were compared using:

- Akaike Information Criterion (AIC).
- Bayesian Information Criterion (BIC).
- Training Root Mean Squared Error (RMSE).
- Training Mean Absolute Error (MAE).

### 7. Residual Diagnostics

Evaluated the adequacy of the selected model through graphical analysis and statistical hypothesis testing:

- Residual time-series plots.
- Residual ACF and PACF.
- Residual histogram and Q-Q plot.
- Shapiro-Wilk test for normality.
- Runs test for randomness.
- Breusch-Pagan test for heteroscedasticity.

### 8. Forecasting and Evaluation

- Generated a 10-step-ahead forecast.
- Used the final 10 observations as a hold-out test set.
- Calculated MAE, RMSE, and R² to evaluate predictive performance.
- Examined the 95% prediction intervals and compared forecasts against actual observations.

---

## Results and Findings

### 1. Candidate ARIMA Models

Four candidate models were evaluated and compared using information criteria and training errors.

| Model | ARIMA Order | AIC | BIC | Train RMSE | Train MAE |
|---|---|---:|---:|---:|---:|
| Model 1 | (2,0,0) | 9411.28 | 9433.73 | 2.472 | 2.018 |
| Model 2 | (4,0,1) | **9409.17** | 9448.46 | 2.467 | 2.015 |
| Model 3 | (1,1,1) | 9415.35 | **9432.19** | 2.475 | 2.034 |
| Model 4 | (2,1,0) | 10001.88 | 10018.71 | 2.865 | 2.285 |

**Selected model: ARIMA(4,0,1)**

Model 2 was selected for further diagnostics and forecasting because it achieved the lowest AIC and slightly lower training errors.

However, its AIC advantage over Model 1 is approximately 2 points, indicating that the two models have relatively similar statistical support. Therefore, the selection should not be interpreted as evidence of a substantial improvement.

### 2. Residual Diagnostics

The selected ARIMA(4,0,1) model was subjected to several diagnostic tests.

| Diagnostic Test | Result | Interpretation |
|---|---|---|
| ADF (Box-Cox series) | -15.94, p < 0.01 | Evidence of stationarity |
| ADF (Differenced series) | -20.75, p < 0.01 | Evidence of stationarity |
| Breusch-Pagan | p = 0.068 | No statistically significant heteroscedasticity at the 5% level |
| Runs Test | p = 0.959 | No evidence against randomness in residual signs |
| Shapiro-Wilk | W = 0.978, p < 2.2e-16 | Residuals significantly deviate from normality |

**Key observations:**

- The stationarity tests provide evidence that the transformed series is stationary.
- The Breusch-Pagan test does not indicate statistically significant heteroscedasticity at the 5% significance level.
- The Runs test suggests that the residual signs behave randomly.
- The Shapiro-Wilk test rejects the normality assumption, with the residual distribution exhibiting left-skewness.

Overall, although some diagnostic properties are satisfactory, the residual distribution indicates that the model does not fully satisfy all assumptions.

### 3. Forecasting Performance

The selected model was evaluated on a hold-out set consisting of the final 10 observations.

| Evaluation Metric | Result |
|---|---:|
| MAE | 2.22 |
| RMSE | 2.45 |
| R² | 0.02 |

The model achieves an R² of approximately 0.02, suggesting that it explains very little of the variation in the hold-out observations.

The forecast results indicate that the model captures almost no useful predictive structure in the evaluated series.

Furthermore, the estimated autoregressive coefficients are relatively small (approximately 0.05–0.26), suggesting weak temporal dependence.

### 4. Main Finding: Limited Predictive Performance

An important outcome of this project is that **a statistically fitted ARIMA model does not necessarily provide meaningful forecasting performance**.

Despite applying variance stabilization, stationarity testing, model identification, and residual diagnostics, the selected model achieved limited predictive accuracy.

Rather than presenting this as a successful forecasting solution, the project treats it as a negative experimental result and highlights the importance of critically evaluating model adequacy.

---

## Limitations and Future Improvements

Several methodological limitations were identified during the analysis. These observations provide a roadmap for improving the project.

### 1. Panel Data Structure

The dataset contains approximately 107 countries observed over 19 years. However, the current implementation treats all 2,033 observations as a single sequential time series.

This approach ignores the panel structure of the dataset and may introduce artificial temporal relationships because observations from different countries are treated as consecutive time steps.

**Proposed improvements:**
- Construct a yearly global malaria incidence aggregate.
- Perform separate time-series analyses for each WHO region.
- Develop individual forecasting models for selected high-burden countries.

### 2. Baseline Comparisons

The current evaluation focuses primarily on ARIMA models.

**Proposed improvements:**
- Introduce Naive and Random Walk with Drift forecasting baselines.
- Compare ARIMA against Exponential Smoothing (ETS).
- Report Mean Absolute Scaled Error (MASE) to provide a more meaningful comparison with baseline methods.

### 3. Forecast Evaluation

The current evaluation relies on a single 10-observation hold-out set.

**Proposed improvements:**
- Implement rolling-origin time-series cross-validation.
- Evaluate forecasting performance across multiple forecast horizons.
- Report errors on the original data scale by applying the inverse Box-Cox transformation.

### 4. Machine Learning Approaches

Explore alternative models capable of capturing nonlinear relationships and incorporating additional information.

Potential approaches include:
- Random Forest and Gradient Boosting.
- Lag-based feature engineering.
- Incorporating WHO region and country-level information.
- GroupKFold cross-validation by country to reduce data leakage between training and evaluation sets.

### 5. Reproducibility

Introduce `renv` to manage and lock R package dependencies, ensuring a reproducible execution environment.

---

## How to Run

### Google Colab

1. Open Google Colab.
2. Change the runtime type to **R**.
3. Upload the notebook and the dataset (`malaria-dataset.csv`).
4. Execute all notebook cells.

### Local Installation

Clone the repository:

```bash
git clone https://github.com/MaissaAlioua/malaria-time-series-analysis.git
cd malaria-time-series-analysis
```

Install the required R packages:

```bash
Rscript install_packages.R
```

Place the dataset in the `data/` directory, following the instructions in `data/README.md`.

Open the notebook using an environment that supports Jupyter notebooks with an R kernel.

---

## Repository Structure

```text
.
├── README.md
├── install_packages.R
├── notebooks/
│   └── malaria_time_series.ipynb
├── data/
│   └── README.md
└── figures/
    └── (visualizations used in the README)
```

**Directory description:**

- `README.md`: Project documentation, methodology, results, and instructions.
- `install_packages.R`: Script for installing the required R dependencies.
- `notebooks/`: Jupyter notebook containing the complete analysis.
- `data/`: Dataset documentation, source information, and licensing details.
- `figures/`: Visualizations generated during the analysis and used in the documentation.

---

## Technologies and Skills Demonstrated

**Programming Language:** R

**Libraries:** `forecast` · `tseries` · `TSA` · `MASS` · `lmtest` · `zoo` · `tidyverse`

**Technical Skills:**
- Time-Series Analysis and Forecasting
- Box-Cox Transformation and Variance Stabilization
- Stationarity Testing and Differencing
- ACF/PACF Analysis and ARIMA Identification
- Statistical Model Selection (AIC/BIC)
- Residual Diagnostics and Hypothesis Testing
- Forecast Evaluation (MAE, RMSE, R²)
- Critical Interpretation of Statistical Results
- Reproducible Statistical Computing

---

## Project Takeaway

This project demonstrates the complete application of the Box-Jenkins methodology to real-world epidemiological data, while emphasizing that statistical modeling is not only about fitting models but also about understanding their limitations.

The limited forecasting performance of the selected ARIMA model motivated further investigation into panel time-series methods, machine learning approaches, and models incorporating external epidemiological factors.
