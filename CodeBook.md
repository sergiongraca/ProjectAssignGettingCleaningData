The run_analisys.R script was executed using the following files from the project:

    1. activity_labels.txt. This file has all the Labels of the activities. 
    2. features.txt. This file has the labels of all the measurements.
    3. train/y_train.txt and test/y_test.txt. These files have all the activity codes realized by each subject.
    4. train/subject_train.txt and test/subject_test.txt. These files have the subjects that realized each activity.
    5. train/X_train.txt and test/X_test.txt. These files have the measuremt related to a subject and activity.
    
The script reads the activities and activities labels and merge them into one temporary data.table. 

Then subjects, activity names and measurements are all merged in one single file for Train and other for Test.

The colnames are created for each file (Train and Test) using the features.txt file.

Then the two files (Train and Test) are merged, creating an output data.table called MergedData.

MergedData is used to obtain all mean and standard deviation information for each measurement on another data.table called MeanStdDev.

MergedData is also used to obtain the Tidy Data Set called TidyData. This data.table is writen in the project root directory as TidyData.txt.

All temporary files created by the process are deleted.

MergedData columns

1. subjects - the code associated to each subject that participate of the measurements.
2. activities - the description of the activity realized by one subject
3. columns 3 to 561 - measurements used by the original project listed on the features.txt file

TidyData columns

1. subjects - the code associated to each subject that participate of the measurements.
2. activities - the description of the activity realized by one subject
3. columns 3 to 561 - measurements used by the original project listed on the features.txt file

MeanStdDev columns

1. variables - measurements listed on the features.txt file
2. mean - mean of all occurrences of each measurement
3. standard_deviation - standard deviation of all occurrences of each measurement



