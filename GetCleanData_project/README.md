# GetCleanData_Project 

This is the course project for Getting and Cleaning Data course from coursera.org

run.analysis_R script creates a tidy data set as per instructions for the course project

the syntax is run.analysis_R(<directory>) where <directory> is the path to all the folders and files in UCI HAR Dataset.

The script run_analysis.R goes through the following steps:

1.  Merges the training and the test sets to create one data set.  Files 'train/X_train.txt' and 'test/X_test.txt'  are combined, files 'train/y_train.txt' and 'test/y_test.txt'  are combined and files 'train/subject_train.txt' and 'test/subject_test.txt' are combined.   The resulting variable names are "X_combine", 
"y_combine" and "subject_combine".

2.  Extracts only the measurements on the mean and standard deviation for each measurement.  All the variables in the data set are listed in file 'features.txt'.  The contents of the file 'features.txt' are searched for strings containing either "mean" or "std".  Based on this information, appropriate columns are extracted from the "X_combine" variable into "X_combine_mean_std" variable.

3.  Adds descriptive activity names to name the activities in the data set.   The activities for each set are listed in 'train/y_train.txt' and 'test/y_test.txt' ; they are coded as numbers 1-6.  File 'activity_labels.txt' has the activity description for each of the numeric codes.  Variable "activities" is createdbased on "y_combine" variable and file 'activity_labels.txt'  and stores the descriptive activity names for the combined set

4.  Labels the data set with descriptive variable names.    All the variables in the data set are listed in file 'features.txt'; the 
same approach described above in step #2 is used to extract the appropriate variable names from the list and assign the names to the columns of "X_combine_mean_std".

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  The column names for the features in this data set are changed from XXX to Avg_XXX by adding "Avg_" in front of each column name.  The result is written out in a "TidyDataSet.txt" file.





