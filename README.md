##Read me for runanaysis.R##

Purpose

The purpose of this script is to clean and tidy data from this dataset that Samsung has provided according to the specifications given by the Coursera course

The script downloads the data from the URL (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)and reads data sets from the UCI HAR Dataset folder that was extracted from the downloaded file. The data sets are combined and labelled with descriptive variable names. All mean and standard deviation measurements, i.e. all measurements that contain "mean" or "std" in lower or upper case in their name, are extracted from the data. The activity labels (1-6) are mapped to the respective activity names. The extracted measurements are grouped by subject and activity and aggregated with the mean function. The aggregated data is written to a file named tidydata.txt.