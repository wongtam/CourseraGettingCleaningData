## Getting and Cleaning Data Project

The project involves cleaning the UCI-HAR Dataset downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R contains the function run_analysis(). The function carries out the following:
1. Read X_test.txt, y_test.txt, subject_test.txt from the test dataset
2. Discard unwanted columns from X_test, only keeping the ones with mean or standard deviation data
3. Merge the data from the 3 files to create one data_test table.
4. Repeat the above from X_train.txt, y_train.txt and subject_train.txt to create a data_train table
5. Merge the data_test and data_train tables to create one data set.
6. Melt the data and calculate the mean for each subject and activity, writing the results into tidy_data.txt.



