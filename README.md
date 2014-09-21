## Getting and Cleaning Data Course Project

The script run_analysis.R contains code sections corresponding to the five steps in the assignment. These are each explained below.

## 1. Merges the training and the test sets to create one data set.
This section first loads the training and test data sets, each consisting of subject, activity and 561 features. Columns are named the same in each dataset, so they are simply combined with cbind.

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
This section uses the package dplyr to select the columns for subject, activity, and means and standard deviations using contains.

## 3. Uses descriptive activity names to name the activities in the data set
The activities are names using the descriptions in activity_labels.txt.

## 4. Appropriately labels the data set with descriptive variable names. 
The variables subject, activity, and description were labeled in previous steps. The features were given the names in features.txt.

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
This section again uses dplyr to group the data by subject and activity (and equivalently description) then summarise each variable by the mean.