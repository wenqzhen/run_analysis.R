run_analysis.R
==============

This is the course project for Getting and Cleaning Data class.

You can find information about the data in CodeBook.md.

The R code is for creating a new tidy data set with the average of each variable for each activity and each subject(volunteerId) from the raw data.

Data can be obtained at the following address:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Extract the files, and set the folder as your R working directory before you run the R code.

The R code run_analysis.R will combine the training set and test set data into one, and aggregate the data by VolunteerId(subject) and activity.
