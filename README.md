
# 📊 Human Activity Recognition – Tidy Dataset Project

This project is based on the [UCI Human Activity Recognition Using
Smartphones
Dataset](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones).
The goal is to **clean and transform raw sensor data** into a tidy
dataset, summarizing the mean of each measurement variable for each
activity and each subject.

## 🧠 Project Objective

-   Merge training and test datasets.
-   Extract only measurements on the **mean and standard deviation**.
-   Assign descriptive activity names.
-   Label dataset with descriptive variable names.
-   Create a second, independent tidy dataset with the **average of each
    variable for each activity and each subject**.

------------------------------------------------------------------------

## 📦 Requirements

This project uses the following R packages:

``` r
install.packages(c("dplyr", "tidyr", "here"))
```

🚀 Steps Performed 1. Data Import The raw data is read from the UCI HAR
Dataset folder using read.table() and paths are handled using the here
package to maintain portability.

``` r
x_train, y_train, subject_train   # Training data
x_test, y_test, subject_test      # Test data
features                          # Feature (variable) names
activity_labels                   # Activity code-to-label mapping
```

2.  Merge Datasets Training and test sets are merged using rbind() to
    create unified data:

``` r
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
```

3.  Label and Filter Measurements Variable names are applied using
    features.txt.

Only columns related to mean() and std() are extracted using a regex and
grep().

``` r
mean_and_std <- grep("mean\\(\\)|std\\(\\)", features[, 2])
x_data_filtered <- x_data[, mean_and_std]
```

4.  Assign Descriptive Activity Names Activity IDs are replaced with
    descriptive labels using case_when()

``` r
y_data$V1 <- dplyr::case_when(
  y_data$V1 == 1 ~ "WALKING",
  y_data$V1 == 2 ~ "WALKING_UPSTAIRS",
  y_data$V1 == 3 ~ "WALKING_DOWNSTAIRS",
  y_data$V1 == 4 ~ "SITTING",
  y_data$V1 == 5 ~ "STANDING",
  y_data$V1 == 6 ~ "LAYING"
)
```

5.  Create Tidy Dataset A clean, tidy dataset is created by binding
    subject, activity, and filtered measurement data:

``` r
tidy_data_filtered <- cbind(subject_data, y_data, x_data_filtered)
names(tidy_data_filtered)[2] <- "Activity"
names(tidy_data_filtered)[1] <- "Subject"
```

6.  Export Tidy Data The final tidy dataset is saved as a .txt file

``` r
write.table(tidy_data_filtered, file = "tidy_data_filtered.txt", row.names = FALSE)
```

💾 Output The file tidy_data_filtered.txt contains:

One row for each subject/activity combination.

Columns with the mean and standard deviation of each selected feature.

This dataset is suitable for further statistical analysis, machine
learning, or building interactive dashboards (e.g., with Shiny).

💡 Possible Extensions Create a second tidy dataset grouped by subject
and activity using group_by() and summarise_all(mean).

Build a Shiny dashboard for visual exploration.

Apply clustering algorithms to identify activity patterns.

Extend the analysis for clinical purposes (e.g., ICU patient motion
monitoring).

📌 Data Source Original dataset available at the UCI Machine Learning
Repository

📬 Author GitHub: Kernel236
