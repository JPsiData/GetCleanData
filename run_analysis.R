## 1. Merges the training and the test sets to create one data set.
setwd("~/Git/GetCleanData")

# Load training data
X_train <- read.table("train/X_train.txt",stringsAsFactors=FALSE)
features <- read.table("features.txt",stringsAsFactors=FALSE) 
features <- features[,2]
colnames(X_train) <- features

Y_train <- read.table("train/y_train.txt",stringsAsFactors=FALSE)
colnames(Y_train) <- "Activity"

subject_train <- read.table("train/subject_train.txt",stringsAsFactors=FALSE)
colnames(subject_train) <- "Subject"

data_train <- cbind(subject_train, Y_train, X_train)

# Load test data with same columns
X_test <- read.table("test/X_test.txt",stringsAsFactors=FALSE)
colnames(X_test) <- features

Y_test <- read.table("test/y_test.txt",stringsAsFactors=FALSE)
colnames(Y_test) <- "Activity"

subject_test <- read.table("test/subject_test.txt",stringsAsFactors=FALSE)
colnames(subject_test) <- "Subject"

data_test <- cbind(subject_test, Y_test, X_test)

# Merge training and test data
mydata <- rbind(data_train,data_test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)
names(mydata)
mydata.select <- select(mydata,Subject, Activity, contains("mean()",ignore.case=FALSE),
                 contains("std()",ignore.case=FALSE),
                 -contains("meanFreq()",ignore.case=FALSE) )
names(mydata.select)

## 3. Uses descriptive activity names to name the activities in the data set
labels <- read.table("activity_labels.txt",stringsAsFactors=FALSE)
colnames(labels) <- c("ActivityCode","Description")
mydata.select <- merge(mydata.select,labels,by.x="Activity",by.y="ActivityCode",all=FALSE)

## 4. Appropriately labels the data set with descriptive variable names. 
# Labels applied as above: Subject, Activity, Description, Features

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
mydata.select %>% 
  group_by(Subject, Activity, Description) %>% 
  summarise_each(funs(mean)) %>%
  format(digits = 2) %>%
  write.table(file="output.txt",sep='\t',row.name=FALSE)
