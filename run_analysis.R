suppressMessages(library(dplyr))
trainx <- read.table("./train/X_train.txt")
trainy <- read.table("./train/Y_train.txt")
trainsub <- read.table("./train/subject_train.txt")
traindata <- cbind(trainsub,trainy,trainx)

testx <- read.table("./test/X_test.txt")
testy <- read.table("./test/Y_test.txt")
testsub <- read.table("./test/subject_test.txt")
testdata <- cbind(testsub,testy,testx)

activities <- read.table("./activity_labels.txt")
colnames(activities) <- c("ID","name")
activitieschar <- as.character(activities$name)

features <- read.table("./features.txt")
colnames(features) <- c("ID","name")
newnames <- make.names(features$name, unique = TRUE)

alldata <- rbind(traindata,testdata)
colnames(alldata) <- c("subjectID","activity",newnames)


localalldata <- tbl_df(alldata)
filterdata <- select(localalldata, subjectID, activity, 
                     contains(".mean.."), contains(".std.."))
filterdata$activity <- activitieschar[filterdata$activity]

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

tidydata <- filterdata %>%
          group_by(subjectID, activity) %>%
          summarise_each(funs(mean))

write.table(tidydata, file = "./tidy_data.txt", row.names = FALSE)