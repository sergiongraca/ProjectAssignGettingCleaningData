# Load libraries

library(utils)
library(base)
library(stats)
library(plyr)

setwd("/path/to/your/Rscript")

# Read labels for activities from file

actvityLabels <- read.table("activity_labels.txt", header=FALSE,stringsAsFactors=FALSE)

# Read column names from file

colNames <- read.table("features.txt", header=FALSE,stringsAsFactors=FALSE)
colNames <- colNames[,2]

# Read Activities from Test and Training files

activities_train <- read.table("train/y_train.txt", header=FALSE,stringsAsFactors=FALSE)
activities_test <- read.table("test/y_test.txt", header=FALSE,stringsAsFactors=FALSE)

# Merge Activities names on Train and Test files

activities_train <- merge(activities_train,actvityLabels,by.x="V1",by.y="V1",all=TRUE)
activities_test <- merge(activities_test,actvityLabels,by.x="V1",by.y="V1",all=TRUE)

# Read subjects from Test and Train files

subjects_train <- scan("train/subject_train.txt", what=integer(),sep="\n")
subjects_test <- scan("test/subject_test.txt", what=integer(),sep="\n")

# Read Train data and combine with subject and activities columns

X_train <- read.table("train/X_train.txt", header=FALSE, col.names=colNames,stringsAsFactors=FALSE)
X_train <- cbind(activities=activities_train$V2,X_train,stringsAsFactors=FALSE)
X_train <- cbind(subjects=subjects_train,X_train)

# Remove/Clean temporary Train data

rm(activities_train)
rm(subjects_train)

# Read Train data and combine with subject and activities columns

X_test <- read.table("test/X_test.txt", header=FALSE, col.names=colNames)
X_test <- cbind(activities=activities_test$V2,X_test,stringsAsFactors=FALSE)
X_test <- cbind(subjects=subjects_test,X_test)

# Remove/Clean temporary Test data

rm(activities_test)
rm(subjects_test)

# Merge complete Train and Test data 

MergedData <- rbind(X_train, X_test) 

# Create Mean and Standard Deviation information for each column

MeanStdDev <- NULL
MeanStdDev <- cbind(MeanStdDev,variables=colNames)
MeanStdDev <- cbind(MeanStdDev,mean=colMeans(MergedData[,3:563], na.rm = TRUE))
MeanStdDev <- cbind(MeanStdDev,standard_deviation=apply(MergedData[,3:563],2,sd, na.rm = TRUE))
rownames(MeanStdDev) <- NULL

# Generate new Tidy Data Set

TidyData <- ddply(MergedData,c("subjects","activities"),function(df)colMeans(MergedData[,3:563], na.rm = TRUE))

# Write Tidy Data Set. Use following command to read it.
#rt <- read.table("TidyData.txt", header = TRUE, sep = ",", row.names=1)

write.table(TidyData, file="TidyData.csv", sep=",", col.names=NA)


# Remove/Clean temporary data

rm(X_train)
rm(X_test)
rm(actvityLabels)
rm(colNames)



