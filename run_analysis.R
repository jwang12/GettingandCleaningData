
library(reshape2)

## Download and unzip the dataset
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, destfile="dataset.zip", method="curl")
unzip("dataset.zip")

##Reading in the training set and the test sets with the variable names, adding the ids of activities and subjects, merging both data sets together.

## reading in files and descriptive variable names.

column.names <- read.table("UCI HAR Dataset/features.txt", colClasses="character")
column.names <- column.names[,2]

test.data <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=column.names)
train.data <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=column.names)


## adding the id numbers of activities

test.data <- cbind(test.data, read.table("UCI HAR Dataset/test/y_test.txt", col.names="Activity"))
train.data <- cbind(train.data, read.table("UCI HAR Dataset/train/y_train.txt", col.names="Activity"))


## adding the id numbers of subjects.

test.data <- cbind(test.data, read.table("UCI HAR Dataset/test/subject_test.txt", col.names="Subject"))
train.data <- cbind(train.data, read.table("UCI HAR Dataset/train/subject_train.txt", col.names="Subject"))


## merging dataset

data.set <- rbind(test.data,train.data)
# head(data.set,5)



## Using descriptive activity names to name the activities in the dataset.

activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
data.set[,"Activity"] = activity.labels[data.set[,"Activity"], 2]



## Extracting only the measurements on the mean and standard deviation for each measurement. 

## finding names of columns with mean and standard deviation.

choosen.column.numbers <- grep("-mean\\(\\)|-std\\(\\)", column.names)


## extracting data for choosen columns (mean() and std()) and also columns for activities and subject

extracted.data.set <- data.set[,c(562,563, choosen.column.numbers)]
# names(data.set2)

## Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 

datamelt <- melt(extracted.data.set, id.vars=c("Activity","Subject"))
tidydata <- dcast(datamelt, Activity + Subject ~ variable, mean)

write.table(tidydata, "tidydata.txt", row.names=FALSE)
