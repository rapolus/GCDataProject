# GCDataProject
Course Project of the Getting and Cleaning Data Course

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
 2. *Y_test.txt*: There are 7,352 rows and 1 column in this file.
 3. *X_test.txt*: There are 7,352 rows and 561 columns in this file.

The data was collected for a total of 30 volunteers within the age bracket of 19-48 years. For the purposes of this project, the data in the *Inertial Signals* sub folder was ignored. 

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