# Getting and Cleaning Data Course Project
===================

Human Activity Recognition Using Smartphones Dataset

## Data citation :

The information on the original data is available at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
===================

This code book describes the detailed steps followed to create the tidy data presented in the file "tidyData.txt" from the original data. Given the original data, the goal is to 

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive activity names. 
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
===================

## Detailed steps

1. The follwing files from the original data were used

  a) UCI HAR Dataset/features.txt - List of all features
  
  b) UCI HAR Dataset/activity_labels.txt - Links the class labels with their activity name
  
  c) UCI HAR Dataset/train/subject_train.txt - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
  
  d) UCI HAR Dataset/train/X_train.txt - Training set
  
  e) UCI HAR Dataset/train/y_train.txt - Training labels
  
  f) UCI HAR Dataset/test/subject_test.txt - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30
  
  g) UCI HAR Dataset/test/X_test.txt - Test set
  
  h) UCI HAR Dataset/test/y_test.txt - Test labels
  
2. The below mentioned steps were followed to process the train/test data and create one dataframe each for train and test data
  
  a) Read the "X*.txt" file and subset only the columns containing either "mean()" or "std()" in the name. The original names from the file features.txt were retained since they are readable and the naming conventions have been described in the documentation
  
  b) Combine the columns in this file with the columns in the files "y*.txt" and "subject*.txt"
  
3. The resulting train and test files are now combined by rows to create a single data file. The activity names have been added as a new column by merging with the activity labels from the file activity_labels.txt

4. This single file is now aggregated and sorted by the subject ID and activity ID to produce a tidy data set. The mean is used for the aggregation. 



## List of variables:

All the variables are means aggregated by each subject ID and activity ID

The original variables come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
7 tGravityAcc-mean()-X
8 tGravityAcc-mean()-Y
9 tGravityAcc-mean()-Z
10 tGravityAcc-std()-X
11 tGravityAcc-std()-Y
12 tGravityAcc-std()-Z
13 tBodyAccJerk-mean()-X
14 tBodyAccJerk-mean()-Y
15 tBodyAccJerk-mean()-Z
16 tBodyAccJerk-std()-X
17 tBodyAccJerk-std()-Y
18 tBodyAccJerk-std()-Z
19 tBodyGyro-mean()-X
20 tBodyGyro-mean()-Y
21 tBodyGyro-mean()-Z
22 tBodyGyro-std()-X
23 tBodyGyro-std()-Y
24 tBodyGyro-std()-Z
25 tBodyGyroJerk-mean()-X
26 tBodyGyroJerk-mean()-Y
27 tBodyGyroJerk-mean()-Z
28 tBodyGyroJerk-std()-X
29 tBodyGyroJerk-std()-Y
30 tBodyGyroJerk-std()-Z
31 tBodyAccMag-mean()
32 tBodyAccMag-std()
33 tGravityAccMag-mean()
34 tGravityAccMag-std()
35 tBodyAccJerkMag-mean()
36 tBodyAccJerkMag-std()
37 tBodyGyroMag-mean()
38 tBodyGyroMag-std()
39 tBodyGyroJerkMag-mean()
40 tBodyGyroJerkMag-std()
41 fBodyAcc-mean()-X
42 fBodyAcc-mean()-Y
43 fBodyAcc-mean()-Z
44 fBodyAcc-std()-X
45 fBodyAcc-std()-Y
46 fBodyAcc-std()-Z
47 fBodyAccJerk-mean()-X
48 fBodyAccJerk-mean()-Y
49 fBodyAccJerk-mean()-Z
50 fBodyAccJerk-std()-X
51 fBodyAccJerk-std()-Y
52 fBodyAccJerk-std()-Z
53 fBodyGyro-mean()-X
54 fBodyGyro-mean()-Y
55 fBodyGyro-mean()-Z
56 fBodyGyro-std()-X
57 fBodyGyro-std()-Y
58 fBodyGyro-std()-Z
59 fBodyAccMag-mean()
60 fBodyAccMag-std()
61 fBodyBodyAccJerkMag-mean()
62 fBodyBodyAccJerkMag-std()
63 fBodyBodyGyroMag-mean()
64 fBodyBodyGyroMag-std()
65 fBodyBodyGyroJerkMag-mean()
66 fBodyBodyGyroJerkMag-std()
