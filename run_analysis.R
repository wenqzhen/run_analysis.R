##This code is for cleaning the Human Activity Recognition Using Smartphones Dataset
##Data is from the link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##This code requires data being loaded on your machine

##------set the working directory on your machine. I used the folder UCI HAR Dataset
setwd("~/Learning Info/Data Scientist/Getting and Cleaning Data/data/UCI HAR Dataset")

##------read activity table and features table, to be used as showing activity and column headers
features <- read.table('features.txt', col.names=c('id','name'))
actLabels <- read.table('activity_labels.txt', col.names=c('id','activity'))                      

##------read test data
volunteerId <- read.table('./test/subject_test.txt', col.names='volunteerId')
measure <- read.table('./test/X_test.txt',col.name=features$name)
activity <- read.table('./test/y_test.txt', col.names='activityId')
n<-nrow(activity)
group <-sample('test',n,replace=TRUE) #------indicating if it's test or train data
test <- cbind(volunteerId,activity,group,measure)

##------read train data
volunteerId <- read.table('./train/subject_train.txt', col.names='volunteerId')
measure <- read.table('./train/X_train.txt',col.name=features$name)
activity <- read.table('./train/y_train.txt', col.names='activityId')
n<-nrow(activity)
group <-sample('train',n,replace=TRUE) #------indicating if it's test or train data
train <- cbind(volunteerId,activity,group,measure)

##------combine test data and train data
data <- rbind(test,train)

##------merge activity and activity id
data2<-merge(data,actLabels, by.x='activityId',by.y='id',all.x)

##------subset the mean and std measurements
mcol <-grep("mean", names(data2), ignore.case=TRUE, value=TRUE)
stdcol <- grep("std", names(data2), ignore.case=TRUE, value=TRUE)
col <- c( 'volunteerId', 'activity',mcol, stdcol)
cleandata <- data2[,col]

##------take mean of each variable by volunteer and activity
library(dplyr)
grouped <- group_by(cleandata, volunteerId, activity)
summary <- summarise_each(grouped, funs(mean))

##------Alternative of aggregation: use aggregate function instead of dplyr package
#summary<-aggregate(cleandata[,3:88], by=list(cleandata$volunteerId,cleandata$activity),FUN=mean)

write.table(summary, file='summary.txt', row.names=FALSE)




