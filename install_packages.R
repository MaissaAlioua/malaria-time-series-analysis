# ==========================================
# Malaria Time-Series Analysis & ARIMA
# R Package Installation Script
# ==========================================

# Required packages
packages <- c(
  "forecast",
  "tseries",
  "TSA",
  "MASS",
  "lmtest",
  "zoo",
  "tidyverse",
  "IRkernel"
)

# Identify packages that are not already installed
installed <- rownames(installed.packages())
missing_packages <- packages[!packages %in% installed]

# Install missing packages
if (length(missing_packages) > 0) {
  install.packages(missing_packages, dependencies = TRUE)
}

# Load and verify packages
invisible(lapply(packages, function(pkg) {
  library(pkg, character.only = TRUE)
}))

cat("All required packages are installed and loaded successfully!\n")
