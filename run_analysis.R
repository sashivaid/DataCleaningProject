## This script is to collect the data from the wearable devices
## This script combines the training data and the test data
## Both data sets have separate files with the subject ids, the data collected 
## from the wearable devices and the activity code


## load libraries
library(dplyr)


## Read feature names and activity labels

featureNames<- read.table("./data/UCI HAR Dataset/features.txt")

activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activityLabels <- setNames(activityLabels, c("activityID", "activityName"))

## create column names vector from feature names

colNames1 <- c()

for (i in 1:length(featureNames[[2]])) {

    colNames1 <- c(colNames1, as.character(featureNames[[2]][i]))
}

## select only measurements on mean and standard deviation

meanStdNames <- grepl("(.*)mean\\(\\)|(.*)std\\(\\)", colNames1)

## make the column names more meaningful

colNames2 <- c("subjectID", colNames1[meanStdNames], "activityID")
colNames2<- gsub("^t", "time", colNames2)
colNames2<- gsub("^f", "frequency", colNames2)
colNames2 <- gsub("\\(\\)", "", colNames2)
colNames2<- gsub("std", "StandardDeviation", colNames2)
colNames2<- gsub("mean", "Mean", colNames2)
colNames2 <- gsub("-", "", colNames2)


## Read the training files 

train_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_activity <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

## Read the test files

test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_activity <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

## combine subject, measurement data & activity for 
## train & test sets

train_wearablesData <- cbind(train_subject, train_data[meanStdNames], train_activity)
test_wearablesData <- cbind(test_subject, test_data[meanStdNames], test_activity)

## now combine train & test sets into one setNames

wearablesData <- rbind(train_wearablesData, test_wearablesData)

## set the names of the variables

wearablesData <- setNames(wearablesData, colNames2)

## join with activitylabels to get the activity names

wearablesActivityData <- dplyr::inner_join(wearablesData, activityLabels, by="activityID")

## group by activity name & subject id 
## and calculate the mean of all the variables

tidyData <- aggregate(. ~ activityName+ subjectID , data = wearablesActivityData, mean)

## add "mean" to the beginning of the variables

names(tidyData) <- gsub("^time", "meanTime", names(tidyData))
names(tidyData) <- gsub("^frequency", "meanFrequency", names(tidyData))


## remove activity ID variable since we have the name
tidyData$activityID <- NULL

## write the data to a file

write.table(tidyData, "tidyData.txt", row.names=FALSE)

