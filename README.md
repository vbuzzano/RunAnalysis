# Run Analysis

Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate ability to collect, work with, and clean a data set.

## How to use this script step by step

 1. Clone this repository
 2. Run R Studio
 3. Once in the R console, set your working dir to project directory
   - > setwd('/pathToProject/RunAnalysis')
 4. This script use 'dplyr' package, so you have to install this package before running.
   - > install.packages('dplyr')
 5. Include the source code into R
   - > source('run_analysis.R')
 6. Run the script
   - > runAnalysis()

## What does the function runAnalysis()

Download raw data from an experiements done by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto (Smartlab - Non Linear Complex Systems Laboratory) DITEN - University degli Studi di Genova, Genoa I-16145, Italy.

Merge test and train data sets to get one big data.frame

Extract variables from the "data.frame" using regex mean\(|std\( to keep only variables for measurements on the mean and standard deviation, but not take gravityMean features tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, tBodyGyroJerkMean because these features are used on the angle() variable.

Tidy the result data set with the average of each variable for each activity and each subject.

Save tidy data containing average of each variable for each activity and each subject into 'averages.txt' file.

## Raw Data description
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Script result file [averages.txt](https://s3.amazonaws.com/coursera-uploads/user-051fa137730c3eb33da98f95/972585/asst-3/c33837803e7311e4936bedd6353e4722.txt)

This script (run_analysis.R) will first download a zip file including raw data sets, then it creates a new tidy data set named [averages.txt](https://s3.amazonaws.com/coursera-uploads/user-051fa137730c3eb33da98f95/972585/asst-3/c33837803e7311e4936bedd6353e4722.txt) which contains averages for mean() and std() variables by subject and activity.

for more informations about variables/features included into 'average.txt', please look at the [codebook](https://github.com/vbuzzano/RunAnalysis/blob/master/codebook.md)



