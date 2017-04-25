## Project1  
# Coursera_Getting and Cleaning Data Project  

The repertory "UCI HAR Dataset" is the working directory.  
The script run_analysis.R gets the datas from the seven text files :  
features  
/train/subject_train  
/train/X_train  
/train/y_train  
/test/subject_test  
/test/X_test  
/test/y_test  
First it determines the 66 features for which the measures are required for the analysis and gets the names.  
Then it creates two data frames frome the train set and the test test with 68 variables : subject, activities and the 66 features.
The merged dataframe data contains 10299 observations.  
Finally, using the dplyr library, it performs a tidy data set with the average of each variable for each activity and each subject.