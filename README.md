### Introduction

This assignment is to write a R script that will merge the 
human activity recognition  using smart phones datasets
and extract only the features corresponding to mean & standard deviation
and further compute the average of these variables by certain factors

The experiment was conducted by:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.

### Original Data
The data comes in training and test set directories with individual files that contain
the subject (who performed the experiment), 561 feature vector with time and frequency
domain variables and the activity label.
The original data also contains the feature names and the code table for linking
activity id to activity name.


### Process for merging data and performing required analyses

Following steps describe the process for merging and performing the required analysis:

*Load the feature names and activity names.
*create a logical vector with feature names that represent only mean or standard deviation
*Combine the subject, measurement data for only features that represent the mean and 
*standard deviation and activity data sets for training and test individually.
*Now, combine both training and test data set.
*Join with the activity labels data to get th e descriptive names for the activity id
*Calculate the mean of the variables after grouping by activity name and subject

### Result Data Set
The resultant data set is a tidy data set with each row representing the 
activity name, subject id and the mean of the mean & standard deviation 
measurements from the original data set for each activity name & subject



