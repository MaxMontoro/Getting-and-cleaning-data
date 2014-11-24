Variables in the script

trainingData - training dataset

trainingLabels  - labels for training dataset

testData - test dataset

testLabels - labels for test dataset

testSubjects - subjects for test dataset

trainingSubjects - subjects for training dataset

features - list of features

joinedData - merged test and training data

joinedLabels - merged test and training labels

joinedSubjects - merged test and training subjects

combinedData - all the three data components in one dataframe

RowsWithMeanAndStd - integer vector, corresponing to the rows in features that contain mean or std values

activityNames - names of the activities

cleanedData - tidy data containing the means of each variable for each subject and activity

Data

X_train.txt

Y_train.txt

x_test.txt

y_test.txt

subject_test.txt

subject_train.txt

features.txt

Transformations

- Merged test data with training data (data, labels and subject) using rbind
- 
- Combined all the data into one dataframe with cbind

Functions used:

read.table - for reading from file

write.table - for writing to file

rbind - for appending rows

cbind - for appending columns

grep - for searching for strings 

aggregate - for calculating means for each subject and each activity; I found this to be a very helpful function
