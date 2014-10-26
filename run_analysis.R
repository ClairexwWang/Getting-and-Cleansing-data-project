#### Part1 ####
#Merges the training and the test sets to create one data set.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#1. setwd 
setwd("/usr/local/Cleansing Data Project/")
#2. read test set
testDataset <- read.csv ("/usr/local/Cleansing Data Project/UCI HAR Dataset/test/X_test.txt", sep = "", colClasses = "numeric", header = FALSE)
#3. read train set
trainDataset <- read.csv ("/usr/local/Cleansing Data Project/UCI HAR Dataset/train/X_train.txt", sep = "", colClasses = "numeric", header = FALSE)
#4. read feaures vector
featuresData <- read.csv("./UCI HAR Dataset/features.txt", sep = "", header = FALSE)
featuresVector <- featuresData[, 2]
#5. add header to test & train set
colnames(testDataset) <- featuresVector
colnames(trainDataset) <- featuresVector
#6. read label file
testY <- read.csv("./UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
trainY <- read.csv("./UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
#7. add header
colnames(testY) <- "activityLabel"
colnames(trainY) <- "activityLabel"
#8. read Activity lable data
activityLabels <- read.csv("./UCI HAR Dataset//activity_labels.txt", sep = "", 
                           header = FALSE)
colnames(activityLabels) <- c("activityLabel", "activity")
#9. merge activity with labels
activityTest <- merge(testY, activityLabels)
activityTrain <- merge(trainY, activityLabels)
#10. add activity data to test adn train set
testDataset <- cbind(testDataset, activityTest)
trainDataset <- cbind(trainDataset, activityTrain)
#11. merge test and train set
completeDataset <- rbind(testDataset, trainDataset)

##### Part 2 ####
#Extracts only the measurements on the mean and standard deviation for each measurement
completeDataset <- subset(completeDataset, select = grepl("mean|std", featuresVector))
write.table(completeDataset, file = "tidyDataset.txt", sep = "\t", row.names = FALSE)
#### Part 3 ####
# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subjectTest <- read.csv("./UCI HAR Dataset/test/subject_test.txt", sep = "", 
                        header = FALSE)
subjectTrain <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep = "", 
                         header = FALSE)
colnames(subjectTrain) <- "subject"
colnames(subjectTest) <- "subject"
testDataset <- cbind(testDataset, subjectTest)
trainDataset <- cbind(trainDataset, subjectTrain)
completeDataset1 <- rbind(testDataset, trainDataset)
tidyDataset2 <- aggregate(completeDataset1[, 1:562], completeDataset1[, 563:564], 
                          FUN = mean)
write.table(tidyDataset2, file = "tidyDatasetfinal.txt", sep = "\t", row.names = FALSE)

