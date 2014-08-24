##########################################################
## Step 1: Merges the training and the test sets 
##         to create one data set.
##########################################################
## Read data
feature <- read.table(file = "./UCI HAR Dataset/features.txt", 
                      col.names = c("featureId", "featureName"))
activity <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", 
                       col.names = c("activityId", "activityName"))
subjectTrain <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", 
                           col.names = c("subject"))
dataTrain <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
activityTrain <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", 
                            col.names = c("activityId"))
subjectTest <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt",
                          col.names = c("subject"))
dataTest <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
activityTest <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", 
                           col.names = c("activityId"))

## Update dataTrain and dataTest's names 
## by using descriptive feature names
featureNames <- gsub("-", "_", feature$featureName)
featureNames <- gsub("\\(\\)", "", featureNames)

names(dataTrain) <- featureNames
names(dataTest) <- featureNames

## Merge training and test data
mergedData <- rbind(cbind(dataTrain, subjectTrain, activityTrain), 
                    cbind(dataTest, subjectTest, activityTest))

##########################################################
## Step 2: Extracts only the measurements on 
##         the mean and standard deviation 
##         for each measurement. 
##########################################################
## Extract only meansurements contained mean or std
## However, meanFreq is not considered because
## it does not refer to the mean value of measurements
data_indexes <- grep("mean|std", names(mergedData))
meanFreq_indexes <- grep("meanFreq", names(mergedData))
data_indexes <- setdiff(data_indexes, meanFreq_indexes)

## Constract new data set with selected features, subject, and activity
data <- mergedData[, c(data_indexes, length(mergedData) -1, length(mergedData))]

##########################################################
## Step 3: Uses descriptive activity names to name 
##         the activities in the data set.
##########################################################
data$activityName <- "unset"
data$activityName[data$activityId == 1]  <- tolower(as.character(activity$activityName[1]))
data$activityName[data$activityId == 2]  <- tolower(as.character(activity$activityName[2]))
data$activityName[data$activityId == 3]  <- tolower(as.character(activity$activityName[3]))
data$activityName[data$activityId == 4]  <- tolower(as.character(activity$activityName[4]))
data$activityName[data$activityId == 5]  <- tolower(as.character(activity$activityName[5]))
data$activityName[data$activityId == 6]  <- tolower(as.character(activity$activityName[6]))

##########################################################
## Step 4: Appropriately labels the data set with 
##         descriptive variable names.
##########################################################
## This step is already done in step 1 and 3

##########################################################
## Step 5: Creates a second, independent tidy data set with 
##         the average of each variable for each activity 
##         and each subject.
##########################################################
## Calculate means of each subject and each activity
tidyData <- aggregate(x = data, by = list(data$subject, data$activityId), FUN = mean)
tidyData <- tidyData[order(tidyData[ , "subject"], tidyData[ , "activityId"]), ]

## Subset the tidy data
tidyData <- tidyData[, seq(3, length(names(tidyData)) -1)]

## Write the tidy data into a file
write.table(x = tidyData, file = "tidyData.txt", row.names = FALSE)
