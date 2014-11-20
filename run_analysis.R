# 1. MERGE TRAINING AND TEST DATASETS TO CREATE ONE DATASET

# the script assumes that the required files are located in your working directory
# first thing is to load each file from the working directory

trainingData <- read.table("X_train.txt", sep = "") # load the training dataset 
trainingLabels <-  read.table("y_train.txt", sep = "") # load the labels for the training dataset
testData <- read.table("x_test.txt", sep = "") # load test dataset
testLabels <-  read.table("y_test.txt", sep = "") # load labels for test dataset
testSubjects <-  read.table("subject_test.txt", sep = "") # load subjects for test dataset
trainingSubjects <-  read.table("subject_train.txt", sep = "") # load subjects for training dataset
features <- read.table("features.txt", sep = "") # load features

# next, we join test and training datasets, labels and subjects

joinedData <- rbind(trainingData, testData) # merge test and training data
joinedLabels <- rbind(trainingLabels, testLabels) # join test and training labels
joinedSubjects <- rbind(trainingSubjects, testSubjects) # join test and training subjects

# finally, join all the data together to form one dataframe
combinedData <- cbind(joinedSubjects, joinedLabels, joinedData)

# 2. EXTRACT ONLY THE MEAN AND STD FOR EACH MEASUREMENT

RowsWithMeanAndStd <- grep("mean\\()|std\\()", features[, 2]) # grep is used to find rows in the feature list that contain either "mean()" or "std()" keywords 
# (\\ is escape character)


# extract only the rows from the big combined dataset that contain either mean or std values
joinedData <- joinedData[,RowsWithMeanAndStd] # here we select all rows and those columns that contain mean or std
combinedData <- cbind(joinedSubjects, joinedLabels, joinedData) # here we combine all our cleaned data

# 3. USE DESCRIPTIVE ACTIVITY NAMES

activityNames <- read.table("activity_labels.txt") # read the labels
activitiesLabeled <- activityNames[joinedLabels[, 1], 2] # assign labels to the rows instead of integers
joinedLabels[,1] <- activitiesLabeled # assign labels to the first columns, that is, to activities
names(joinedLabels) <- "Activity" # assign name to the column

# 4. Add labels 

names(joinedSubjects) <- "subject"  # assign name to the column
combinedData <- cbind(joinedSubjects, joinedLabels, joinedData) # again gather all our data with the new names
write.table(combinedData, "combinedData.txt") # print to file the first dataset

# 5. CREATE A SECOND, INDEPENDENT DATASET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

# the aggregate function comes handy! we calculate the mean by subject and by activity for each variable here
cleanedData <- aggregate(combinedData, by=list(SUBJECT =combinedData$subject, ACTIVITY = combinedData$Activity), mean)

# remove unnecessary columns
cleanedData[,3] = NULL 
cleanedData[,3] = NULL 

# write to file
write.table(cleanedData, "cleanedData.txt", row.name=FALSE) # print to file the second, cleaned dataset


