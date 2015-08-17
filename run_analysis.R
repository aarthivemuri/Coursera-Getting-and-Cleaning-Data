
# Clear the environment

rm(list = ls())

# Load the required packages
                  
library(reshape2)

# Download and unzip the dataset

filename <- "getdata-projectfiles-UCI HAR Dataset.zip"
file.exists(filename)

if (!file.exists(filename)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
      download.file(fileURL, filename, mode = 'wb')
}  

if (!file.exists("UCI HAR Dataset")) { 
      unzip(filename) 
}

rm(filename)

# Import all the required files into datasets in R

labels = read.table("UCI HAR Dataset/activity_labels.txt")
labels = data.frame(as.character(labels$V2))
names(labels)[1] = paste("activity_labels")

features = read.table("UCI HAR Dataset/features.txt")
features = data.frame(as.character(features$V2))
names(features)[1] = paste("features")

testdata = read.table("UCI HAR Dataset/test/X_test.txt")
testlabels = read.table("UCI HAR Dataset/test/Y_test.txt")
subjecttestlabels = read.table("UCI HAR Dataset/test/subject_test.txt")

traindata = read.table("UCI HAR Dataset/train/X_train.txt")
trainlabels = read.table("UCI HAR Dataset/train/Y_train.txt")
subjecttrainlabels = read.table("UCI HAR Dataset/train/subject_train.txt")

# Merge the training and test data & add labels

testdata$subjectID = subjecttestlabels
traindata$subjectID = subjecttrainlabels

testdata$label = testlabels
traindata$label = trainlabels

testdata$label = as.numeric(unlist(testdata$label))
testdata$subjectID = as.numeric(unlist(testdata$subjectID))

traindata$label = as.numeric(unlist(traindata$label))
traindata$subjectID = as.numeric(unlist(traindata$subjectID))

row.names(traindata) = make.names(2948:10299, unique=TRUE)
row.names(testdata) = make.names(1:2947, unique=TRUE)

total = rbind(testdata,traindata)
rm(testdata,traindata,testlabels,trainlabels,subjecttrainlabels,subjecttestlabels)

# Extract only the measurements on the mean and standard deviation for each measurement

names(total) = paste(features$features)
names(total)[563] = paste("activity_labels")
names(total)[562] = paste("subject_id")
total = total[,c(562,563,1:561)]
total1 = total[,grep(".*mean.*|.*std.*", names(total), value=TRUE)]
rm(features)

# Add descriptive activity names to name the activities in the data set

total2 = cbind(total$subject_id,total$activity_labels,total1)
names(total2)[1] = paste("Subject_id")
names(total2)[2] = paste("activity_labels")
labels = cbind(rownames(labels),labels)
names(labels)[2] = paste("Activity")
names(labels)[1] = paste("activity_labels")
total3 = merge(total2,labels, by = "activity_labels")
total3 = total3[,c(2,82,3:81)]
rm(total,total1,total2)
final = total3
rm(total3,labels)
      
# create a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

final$Subject_id = as.factor(final$Subject_id)
final$Activity = as.factor(final$Activity)
      
tidy1 = melt(final, id.vars = c("Subject_id","Activity"))
tidy = dcast(tidy1, Subject_id + Activity ~ variable, mean)

rm(tidy1)
      
write.table(tidy, "tidy.txt", row.names = F)
