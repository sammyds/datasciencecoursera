# Getting and Cleaning Data Course Project
===================

Human Activity Recognition Using Smartphones Dataset

===================

This tidy data set has been created from original data collected from sensor signals from experiments carried out with a group of 30 volunteers by Smartlab - Non Linear Complex Systems Laboratory. 

The information on the original data is available at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data should be downloaded from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The files includes the actual data as well as descriptions of variables etc

The following steps describe how the tidy data set provided in the file "tidyData.txt" has been created.

===================

1. Download the zipped file from the url
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Unzip the file in the working directory of R. This should create the directory "UCI HAR Dataset" and all the required files should be under this directory

3. Download the file run_analysis.R from the github url provided, into the working directory

4. run_analysis.R requires the package reshape2. Please make sure it is installed prior
to running the script run_analysis.R

5. Run the script run_analysis.R
    a) It loads the test and train data sets using the function loadFiles
    b) It keeps only the mean() and std() columns from the original data 
    c) It aggreagates the data for each column by taking the average for each subject ID and activity ID
    d) It prepares the tidy data into a dataframe and writes it to the file tidyData.txt and places it in the directory "UCI HAR Dataset"


