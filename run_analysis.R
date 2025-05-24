#########################################################
###### IMPORT AND MERGE OF TRAINN and TEST DATA #########
#########################################################
# Load necessary libraries
library(tidyr)
library(dplyr)

#Import Data [INPUT]
x_train <- read.table(
  # data path is generalised using "here" package
  # below call returns a filepath relative to project root
  here::here("UCI HAR Dataset", "train", "X_train.txt") # reading the training data
)
y_train <- read.table(
  here::here("UCI HAR Dataset", "train", "y_train.txt") # reading the activity labels
)
x_test <- read.table(
  here::here("UCI HAR Dataset", "test", "X_test.txt")  # reading the test data
)
y_test <- read.table(
  here::here("UCI HAR Dataset", "test", "y_test.txt") # reading the test activity labels
)
#Read the subject data
subject_train <- read.table(
  here::here("UCI HAR Dataset", "train", "subject_train.txt") # reading the subject data
)
subject_test <- read.table(
  here::here("UCI HAR Dataset", "test", "subject_test.txt") # reading the subject data
)
features <- read.table(
  here::here("UCI HAR Dataset", "features.txt") # reading the features
)

#Merging the training and test data
x_data <- rbind(x_train, x_test) # merging the training and test data
y_data <- rbind(y_train, y_test) # merging the training and test activity labels

#Clear env and free some memory
rm(x_train, y_train, x_test, y_test) # removing the training and test data

#Extract only the mean and the sd for each measurement from x_data
names(x_data) <- features[, 2] # renaming the columns of x_data with V2 of features

#grep + REGEX to extract the mean and sd
mean_and_std <- grep("mean\\(\\)|std\\(\\)", features[, 2]) # extracting the mean and sd return the index of the columns

#Extracting the mean and sd from x_data
x_data_filtered <- x_data[, mean_and_std] 

#Extracting the activity labels
activity_labels <- read.table(
  here::here("UCI HAR Dataset", "activity_labels.txt") # reading the activity labels
)
#Change the value of the y_data with more intuitive labelling
y_data$V1 <- case_when(y_data$V1 == 1 ~ "WALKING",
                        y_data$V1 == 2 ~ "WALKING_UPSTAIRS",
                        y_data$V1 == 3 ~ "WALKING_DOWNSTAIRS",
                        y_data$V1 == 4 ~ "SITTING",
                        y_data$V1 == 5 ~ "STANDING",
                        y_data$V1 == 6 ~ "LAYING")

#Create the nnew 2 tidy data set with the average of each variable for each activity and each subject
#Merging the subject data
subject_data <- rbind(subject_train, subject_test) # merging the subject data
names(subject_data) <- "Subject" # renaming the columns of subject_data
rm(subject_train, subject_test) # removing the training and test subject data

###########################################
####### CREATING THE TIDY DATASET #########
###########################################

tidy_data_filtered <- cbind(subject_data, y_data, x_data_filtered) # merging the subject data with the activity data
names(tidy_data_filtered)[2] <- "Activity" # renaming the columns of tidy_data_filtered


#Caluclate the mean of each variable for each activity and each subject
tidy_data_filtered_mean <- tidy_data_filtered %>%
  group_by(Subject, Activity) %>% 
  summarise(across(where(is.numeric), mean, na.rm = TRUE), .groups = "drop")


######OUTPUT######
#Saving database in txt file
write.table(tidy_data_filtered_mean, file = "tidy_data_filtered.txt", row.names = FALSE) # saving the tidy data set in a text file
