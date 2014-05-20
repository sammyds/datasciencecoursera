# Function to load the test or train data files. dataType must be "test" or "train"
loadFiles = function (dataType) {

  # Create file name variables
  # dataDir set in the calling script
  sFileName = paste0 (dataDir, "/", dataType, "/subject_", dataType, ".txt")
  xFileName = paste0 (dataDir, "/", dataType, "/X_", dataType, ".txt")
  yFileName = paste0 (dataDir, "/", dataType, "/Y_", dataType, ".txt")
  
  # Read all the data files into dataframes
  sFile = read.table (sFileName, sep = "",  header = FALSE)
  xFile = read.table (xFileName, sep = "",  header = FALSE)
  yFile = read.table (yFileName, sep = "",  header = FALSE)
  
  # Assign the column names collected from the features file to the xFile
  # features file should already have been loaded in the calling script
  colnames(xFile) = as.vector(features [,2])
  
  # Assign meaningful column names to sFile and yFile
  colnames(sFile) = c("subjectID")
  colnames(yFile) = c("activityID")
  
  # From the dataframe xFile, subset only the columnn with names containing
  #  mean() or std(). The vector cols in set the calling script
  xFile = xFile [,cols]
  
  # Combine all the columns from all the data files
  dataFile = cbind (sFile, yFile, xFile)
  
  # Remove all the temporary files
  rm (sFile, xFile, yFile)
  
  # Return the final dataframe to the calling script
  return (dataFile)
}

# Main script
# Load the package reshape2. The data processing uses the fucntion "melt" 
# which is part of this package
require(reshape2)

# The zipped file containing the data sets has to be unzipped in the working directory
# All the data would then be available under the following parent directory
dataDir = "UCI HAR Dataset"

# Read the file features.txt into a dataframe
features = read.table (paste0 (dataDir, "/features.txt"), sep = "",  header = FALSE)

# Gather column names containing mean() or std() into a vector
cols = as.vector(features[grep("*(mean\\(\\))|*(std\\(\\))", features$V2, 
                               ignore.case = TRUE),2])

# Read the file activity_labels.txt into a dataframe and assign meaningful column names
activityLabels = read.table (paste0 (dataDir, "/activity_labels.txt"), sep = "",  
                             header = FALSE)
colnames(activityLabels) = c("activityID", "activityName")

# Read all the test data files into a dataframe
test = loadFiles ("test")

# Read all the train data files into a dataframe
train = loadFiles ("train")

# Combine the rows from the test and train dataframes
allData = rbind (test, train)

# Noramlize the data by the columns subjectID and activityID
allDataMelt <- melt(allData, id = c("subjectID", "activityID"))

# Create tidy data set by aggregating the normalized data
tidyData = dcast(allDataMelt, subjectID + activityID ~ variable, mean)

# Add the activity name to each row of tidyData 
tidyData = merge (x = activityLabels, y = tidyData, by.x = "activityID", 
                  by.y = "activityID")

# Sort the data by subjectID and activityID
tidyData = tidyData [order (tidyData$subjectID, tidyData$activityID),]

# Write the tidy data to a text file
write.table (tidyData, paste0 (dataDir, "/tidyData.txt"))

# Cleanup all the dataframes
rm (features, activityLabels, allData, allDataMelt, test, train)
