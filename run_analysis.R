suppressMessages(library(dplyr))

## Read the training and test datasets

# Read all the observations 
# Read the corresponding activity labels 
# Read the corresponding subjects
# Create one table that combines the above three tables

trainx <- read.table("./train/X_train.txt")
trainy <- read.table("./train/Y_train.txt")
trainsub <- read.table("./train/subject_train.txt")
traindata <- cbind(trainsub,trainy,trainx)

testx <- read.table("./test/X_test.txt")
testy <- read.table("./test/Y_test.txt")
testsub <- read.table("./test/subject_test.txt")
testdata <- cbind(testsub,testy,testx)


# Read the activity labels text file
# Set the column names
# Convert the column containing the activity labels to a character vector

activities <- read.table("./activity_labels.txt")
colnames(activities) <- c("ID","name")
activitieschar <- as.character(activities$name)


# Read the features text file
# Set the column names
# Make all the column names (i.e. features) unique

features <- read.table("./features.txt")
colnames(features) <- c("ID","name")
newnames <- make.names(features$name, unique = TRUE)


# Merge the entire training and test datasets
# Set the column names 

alldata <- rbind(traindata,testdata)
colnames(alldata) <- c("subjectID","activity",newnames)


# Convert to a local data frame
# Extract all the measurements which represet the mean and standard deviation
# Replace the activities in the data with descriptive activity names

localalldata <- tbl_df(alldata)
filterdata <- select(localalldata, subjectID, activity, 
                     contains(".mean.."), contains(".std.."))
filterdata$activity <- activitieschar[filterdata$activity]


# Label the column names with appropriate desciptive variable names
# Done using sub() and gsub() within a function that's called by sapply 

cname <- names(filterdata)
replace <- function(x){
    x1 <- sub("Acc","Acceleration", x)
    x2 <- sub("Gyro","Gyroscopic",x1)
    x3 <- sub("Mag","Magnitude",x2)
    x4 <- sub("mean","Mean",x3)
    x5 <- sub("std","Std",x4)
    x6 <- sub("BodyBody","Body",x5)
    x7 <- gsub("\\.","",x6)
    return(x7)
}
cname = sapply(cname,replace)
names(filterdata) <- cname


# Create a "tidy" dataset. 
# It contains the average of each variable for each activity and each subject

tidydata <- filterdata %>%
          group_by(subjectID, activity) %>%
          summarise_each(funs(mean))


# Write out the final tidydata to a text file

write.table(tidydata, file = "./tidy_data.txt", row.names = FALSE)