# Run Analysis

Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate ability to collect, work with, and clean a data set.

## How to use this script

 - Clone this repository
 - Run R Studio
 - Set your working dir to project directory
   - > setwd('/pathToProject/RunAnalysis')
 - Include the source code into R
   - > source('run_analysis.R')
 - Run the script
   - > runAnalysis()

## Raw Data
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Script result

This script (run_analysis.R) will first download a zip file including raw data sets, then it creates a new tidy data set called averages.txt which contains averages for mean() and std() variables by subject and activity.



