This repository contains all the files required for the course project of the "Getting and Cleaning Data" course on Coursera.

#Description of the raw data#

The downloaded data contains two folders - *test* and *train*. There are also four other text files in the main folder. They are:

 1. A *readme.txt* file
 2. *activity_labels.txt* file which links the class labels with their activity names. There are 6 different activities in this data set.
 3. *features.txt* file which lists all the features in the data set. There are a total of 561 features for which data was collected.
 4. *features_info.txt* file which has information about the variables selected for this data set.

The *test* folder has three files. They are:

 1. *subject_test.txt*: Each row in this file identifies the subject who performed the activity. There are 2,947 rows and 1 column in this file.
 2. *Y_test.txt*: Each row in this file identifies the activity label performed by the subject. There are 2,947 rows and 1 column in this file.
 3. *X_test.txt*: This file has the actual data for each subject and activity specified in the above two files across all the 561 features specified in the *features.txt* file. There are 2,947 rows and 561 columns in this file.

The *train* folder has exactly similar files as the *test* folder. The description below is only about the dimensions of the files in this folder.

 1. *subject_train.txt*: There are 7,352 rows and 1 column in this file.
 2. *Y_train.txt*: There are 7,352 rows and 1 column in this file.
 3. *X_train.txt*: There are 7,352 rows and 561 columns in this file.

The data was collected for a total of 30 volunteers within the age bracket of 19-48 years. For the purposes of this project, the data in the *Inertial Signals* sub folder was ignored. 


#Creating the tidy data file#

The *run_analysis.R* contains the code to create the tidy data file from the raw data described in the previous section.

##Merging the training and test data sets##

The first step in creating the tidy data set was to merge the training and test data sets into one big data set. The subject and activity labels were added as new columns to the *X_train* and *X_test* data. The two files were then combined into one. The combined file has 10299 rows and 563 columns.

The columns were then named appropriately:

 1. The first column is called 'subjectID'
 2. The second column is called 'activity'
 3. The names of the remaining 561 columns are directly pulled from the *features.txt* file

One issue with the names in the *features.txt* file was that some of the names weren't unique. This creates a problem while working with data in R. It was fixed in R by using the *make.names()* function to create unique, syntactically valid names for all the columns. 

##Extracting the appropriate measurements##

The second step was to extract only those variables that corresponded to the mean and standard deviation for each measurement. The *features_info.txt* has the list of the signals that were measured in the data set. A total of 33 different signals were measured. 

Further, various variables were estimated from these 33 signals. In this project, only those variables which had *mean()* and *std()* in their names were extracted in the final tidy data set. These were chosen because only these variables represented the simplest versions of mean and standard deviation (as requested in the course project).

This resulted in a total of 66 variables being extracted for the final tidy data set.

##Labeling columns and activities with descriptive names##

To meet the requirements of a tidy data set, all activity labels were replaced with their actual descriptive names. This was done by using the *activity_labels.txt* file.

Further, the column names that were extracted from the *features.txt* file were appropriately labeled to meet the requirement of a tidy data set. The following changes were made to the names of the columns:

 1. "Acc" was replaced with "Acceleration"
 2. "Gyro" was replaced with "Gyroscopic"
 3. "Mag" was replaced with "Magnitude"
 4. "mean" was replaced with "Mean"
 5. "std" was replaced with "Std"
 6. "BodyBody" was replaced with "Body"
 7. All special characters in the variable names were removed

The variable names before and after applying the changes are described in the CODEBOOK.md file.

Finally, this resulted in a tidy data set with 10,299 rows and 68 columns. 

##Creating an independent tidy data set##

Using the data set created above, a second, independent tidy data set with the average of each variable for each activity and each subject was created. This was done using the *dplyr verbs* in R. Since there were 30 unique subject and 6 unique activities, this data set has 180 rows and 68 columns. The data is stored in a filed called *tidy_data.txt*


#Running the script and viewing the tidy data#

In order to run the script, make sure that your working directory is set to the 

 1. Set the working directory in R Studio to the 'UCI HAR Dataset' folder
 2. Download the run_analysis.R script to this folder
 3. Make sure that the *dplyr* package is installed
 4. Run the script
 5. A *tidy_data.txt* file containing the final tidy data set will be created in the folder
 6. The best way to view this file is by opening it in R studio. Use the following piece of code to view it. 
 
> *data <- read.table("./tidy_data.txt", header = TRUE);*
> *View (data)*