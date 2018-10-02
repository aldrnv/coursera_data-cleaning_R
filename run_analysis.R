# Aldreen Venzon
# Oct 1, 2018
# Course 3: Getting and Cleaning Data

##########
##0) Download and Unzip file
##########
SamsungData <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(SamsungData, 'UCI-HAR-dataset.zip') # Unzip fil
unzip('./UCI-HAR-dataset.zip', exdir = getwd()) # save files in working directory

##########
##1) Merges the training and the test sets to create one data set.
##########
# All Tests
x_Test <- read.table('UCI HAR Dataset/test/X_test.txt')
y_Test <- read.table('UCI HAR Dataset/test/Y_test.txt')
subject_Test <- read.table('UCI HAR Dataset/test/subject_test.txt')
# All Train
x_Train <- read.table('UCI HAR Dataset/train/X_train.txt')
y_Train <- read.table('UCI HAR Dataset/train/Y_train.txt')
subject_Train <- read.table('UCI HAR Dataset/train/subject_train.txt')
# Merge all data
X <- rbind(x_Test, x_Train)
Y <- rbind(y_Test, y_Train)
Subject <- rbind(subject_Test, subject_Train)
        # View(X)
        # View(Y)
        # View(Subject)

##########
##2) Extracts only the measurements on the mean and standard deviation for each measurement.
##########
# X Features
features <- read.table('UCI HAR Dataset/features.txt')
        View(features)
# X Mean and Standard deviations only
mean_std <- grep('mean\\(\\)|std\\(\\)', features[ ,2])
        # View(mean_std)
X_mean_std <- X[ ,mean_std]
        # View(X_mean_std)
X_names <- features[mean_std,2]
        # View(X_names)

##########
##3) Uses descriptive activity names to name the activities in the data set
# Y Activities
##########
activity <- read.table('UCI HAR Dataset/activity_labels.txt')
        View(activity)
# Replace Y with Activity Names
Y[ ,1] <- activity[Y[ ,1], 2]

##########
##4) Appropriately labels the data set with descriptive variable names.
##########
names(Subject) <- 'Subjects'
        # View(Subject)
names(X_mean_std) <- X_names
        # View(X_mean_std)
names(Y) <- 'Activities'
        # View(Y)
# Column bind all data
allData <- cbind(Subject, Y, X_mean_std)
        # View(allData)

##########
##5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##########
library(data.table)
dt_allData <- data.table(allData)
tidy_allData <- dt_allData[ ,lapply(.SD, mean), by = 'Activities,Subjects']
        # View(tidy_allData)
write.table(tidy_allData, file = 'AllTidyNow.txt', row.names = FALSE)        
