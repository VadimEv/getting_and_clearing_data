# source of original raw data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Run this script to:
# 1. Merge training and test data into one set:

tmp1 <- read.table("UCI HAR Dataset/train/X_train.txt") 
tmp2 <- read.table("UCI HAR Dataset/test/X_test.txt") 
Xraw <- rbind(tmp1, tmp2)

tmp1 <- read.table("UCI HAR Dataset/train/subject_train.txt") 
tmp2 <- read.table("UCI HAR Dataset/test/subject_test.txt") 
S <- rbind(tmp1, tmp2)

tmp1 <- read.table("UCI HAR Dataset/train/y_train.txt") 
tmp2 <- read.table("UCI HAR Dataset/test/y_test.txt") 
Yraw <- rbind(tmp1, tmp2)

# 2.Extract measurments of mean and standart deviation for each measurment with help of ?grep

features <- read.table("UCI HAR Dataset/features.txt")
indices_of_features <- grep("-mean\\(\\)|-std\\(\\)", features[,2])
X <- Xraw[,indices_of_features]
names(X) <- features[indices_of_features,2]
#replace the names
names(X) <- gsub("\\(|\\)","", names(X))
#change uppercase to lowercase
names(X) <- tolower(names(X))

# 3. apply descriptive names from activity_labels.txt
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
activity[,2] = gsub("_","", tolower(as.character(activity[,2])))
Yraw[,1] = activity[Yraw[,1],2]
names(Yraw) <- "activity"

# 4. use proper labeling for data with descriptive names
names(S) <- "subject"
clean <- cbind(S, Yraw, X)
write.table(clean, "merged_clean_data.txt")

#5. create a second, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activity[,1])
numCols = dim(clean)[2]
#dimensions of resulting data
result = clean[1:(numSubjects*numActivities), ]

#populate the resulting tidy data
row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities){
    result[row,1] = uniqueSubjects[s]
    result[row,2] = activity[a,2]
    tmp <- clean[clean$subject==s & clean$activity == activity[a,2],]
    result[row, 3:numCols] <- colMeans(tmp[,3:numCols])
    row = row +1
  }
}

write.table(result, "averaged_data.txt")

