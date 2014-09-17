library(dplyr)

## 
## Getting and Cleaning Data - Project
## 
## by Vincent Buzzano
##

## Funciton Run Analyse to execute the following step on the data containing in

##
## Merges the training and the test sets to create one data set.
## 
## - Extracts only the measurements on the mean and standard deviation for each measurement. 
## - Uses descriptive activity names to name the activities in the data set
## - Appropriately labels the data set with descriptive variable names. 
## - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
runAnalyse <- function() {
    
    # 0. Download and extract Raw Data
    print("0. Download and extract Raw Data")
    prepareData()
    
    # 1. Merges the test and training sets to create one data set
    print("1. Merges the test and training sets to create one data set")
    dTest  <- readDataSet('test')
    dTrain <- readDataSet('train')
    d <- rbind(dTest, dTrain)
       
    # 2. Extracts only the measurements on the mean and standard deviation for 
    #    each measurement. 
    print("2. Extracts only the measurements on the mean and standard deviation for each measurement.")
    features <- read.csv(fileFeatures, header=FALSE, sep=" ", col.names = c('id', 'feature'))
    featuresToKeep <- grep('mean\\(|std\\(', features[,2])
    featuresToKeep <- grep('mean\\(\\)$|std\\(\\)$', features[,2])
    d <- d[, c(1, 2, featuresToKeep + 2)]
    
    # 3. Uses descriptive activity names to name the activities in the data set
    print("3. Uses descriptive activity names to name the activities in the data set")
    activityLabels <- read.csv(fileActivityLabels, header=FALSE, sep=" ", col.names = c('id', 'label'))
    d[,2] <- activityLabels[d[,2], 2]

    # 4. Appropriately labels the data set with descriptive variable names. 
    print("4. Appropriately labels the data set with descriptive variable names.")
    colnames(d) <- c('subject','activity', as.vector(features[featuresToKeep,2]))
    
    # 5. creates a second, independent tidy data set with the average of 
    #    each variable for each activity and each subject.    
    print("5.  creates a second, independent tidy data set with the average of each variable for each activity and each subject.")
    tidyDF <- tbl_df(d) %>%
        group_by(subject, activity) %>%
        summarise_each(funs(mean))

    tidyDF
    write.table(x = tidyDF, file = 'averages.txt', row.name = FALSE)
}

# This function read data sets files for 'test' or 'train' and create a 
# data.frame, set the column names and keep only mean() and std() column
readDataSet <- function(mode = 'test') {
    dir <- paste(dataDir, dataZipDir, mode, sep="/")
    
    # Read subject 
    filename <- paste(dir, paste('subject_', mode, '.txt', sep=''), sep='/')
    ds <- read.table(filename, colClasses = 'numeric')
    
    # Read data, tidy columns and transform to numeric
    filename <- paste(dir, paste('X_', mode, '.txt', sep=''), sep='/')
    dx <- read.table(filename, colClasses = 'numeric')
        
    # Read activity
    filename <- paste(dir, paste('y_', mode, '.txt', sep=''), sep='/')
    dy <- read.table(filename, colClasses = 'numeric')

    # Crete data frame
    data.frame(ds, dy, dx)
}

## Simple function to download and extract zip file into the Data folder
## 1st: If the "Data" dir does not alerady exists, create it.
## 2nd: If the "Zip File" does not exists, download it
## 3rd: if the "Zip File" has not been extracted, extract it
prepareData <- function() {
    
    # 1. Create data directory if it does not already exists
    if (!file.exists(dataDir))
        dir.create(dataDir)
    
    # 2. Download data zip file if not exists in the data directory
    if (!file.exists(dataZipFile))
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile = dataZipFile, 
                      method   = "curl")

    # 3. extract dataset to data directory
    if (!file.exists(fileActivityLabels))
            unzip(zipfile = dataZipFile, exdir = dataRootDir)
}

## static variables
dataDir            <- "data"
dataZipFile        <- "dataset.zip"
dataZipDir         <- 'UCI HAR Dataset'
fileActivityLabels <- paste(dataDir, dataZipDir,"activity_labels.txt", sep = "/")
fileFeatures       <- paste(dataDir, dataZipDir,"features.txt", sep = "/")
