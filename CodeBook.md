# 📘 Codebook - Human Activity Recognition Dataset

## 📂 Feature Selection

The selected features are derived from **tri-axial accelerometer** and **gyroscope sensors**, which recorded raw signals along the **X, Y, and Z axes** at a constant frequency of **50 Hz**. These signals were processed through several filtering and transformation steps:

-   **Median filter**
-   **3rd-order low-pass Butterworth filter** with a cutoff frequency of **20 Hz** for noise reduction
-   Separation of **body** and **gravity acceleration** using a **low-pass filter at 0.3 Hz**

### ⏱ Time Domain Signals (`t`)

Raw or derived signals in the time domain:

-   `tBodyAcc-XYZ`: Body acceleration
-   `tGravityAcc-XYZ`: Gravity acceleration
-   `tBodyAccJerk-XYZ`: Jerk signal (derivative of acceleration)
-   `tBodyGyro-XYZ`: Angular velocity
-   `tBodyGyroJerk-XYZ`: Jerk signal from gyroscope (angular acceleration)

**Magnitude signals (Euclidean norm):**

-   `tBodyAccMag`
-   `tGravityAccMag`
-   `tBodyAccJerkMag`
-   `tBodyGyroMag`
-   `tBodyGyroJerkMag`

------------------------------------------------------------------------

### 🌐 Frequency Domain Signals (`f`)

Obtained by applying the **Fast Fourier Transform (FFT)** on sliding time windows:

-   `fBodyAcc-XYZ`
-   `fBodyAccJerk-XYZ`
-   `fBodyGyro-XYZ`
-   `fBodyAccMag`
-   `fBodyAccJerkMag`
-   `fBodyGyroMag`
-   `fBodyGyroJerkMag`

------------------------------------------------------------------------

## 📊 Extracted Variables (Feature Vector)

Each signal was used to compute a series of statistical and shape-based descriptors as listed below:

| Function | Description |
|----|----|
| `mean()` | Mean value |
| `std()` | Standard deviation |
| `mad()` | Median absolute deviation |
| `max()` | Maximum value |
| `min()` | Minimum value |
| `sma()` | Signal Magnitude Area (sum of absolute values, normalized) |
| `energy()` | Energy: sum of squared values divided by the number of values |
| `iqr()` | Interquartile range (Q3 - Q1) |
| `entropy()` | Signal entropy |
| `arCoeff()` | Autoregression coefficients (Burg method, order 4) |
| `correlation()` | Correlation between two signals |
| `maxInds()` | Index of the frequency component with the highest magnitude |
| `meanFreq()` | Weighted average frequency (mean frequency) |
| `skewness()` | Skewness of the signal distribution |
| `kurtosis()` | Kurtosis of the signal distribution |
| `bandsEnergy()` | Energy within frequency sub-bands (64 FFT bins) |
| `angle()` | Angle between two averaged signal vectors |

------------------------------------------------------------------------

## 🔄 Mean Vectors Used in `angle()`

These are average values of signals within a window, used in the computation of angle-based features:

-   `gravityMean`
-   `tBodyAccMean`
-   `tBodyAccJerkMean`
-   `tBodyGyroMean`
-   `tBodyGyroJerkMean`

------------------------------------------------------------------------

## 📐 Variable Naming Conventions

-   **Prefixes:**
    -   `t` = time domain
    -   `f` = frequency domain
-   **Suffixes:**
    -   `-XYZ` = tri-axial signal (components in X, Y, Z)
    -   `Mag` = magnitude of the vector
-   **Examples:**
    -   `tBodyAcc-mean()-X`
    -   `fBodyGyro-entropy()-Z`
    -   `tBodyAccJerkMag-energy()`

------------------------------------------------------------------------

## 📁 Reference File

The full list of feature vector variables is available in the `features.txt` file.

------------------------------------------------------------------------
