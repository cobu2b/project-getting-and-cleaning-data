Read Me
=================================

This file explains how run_analysis script (run\_analysis.R) works and how to reproduce the tidy data set.

1. There should be a folder called "UCI HAR Dataset" at the same level as the run_analysis script. The UCI HAR Dataset must contain the following files.
    - features.txt
    - activity_labels.txt
    - train/subject_train.txt
    - train/X_train.txt
    - train/y_train.txt
    - train/subject_test.txt
    - train/X_test.txt
    - train/y_test.txt
    
2. Load all data listed on the step 1 in order to merge the training and the test sets to create one data set and assign column names of the data set (Step 1 in run\_analysis.R). In this step, dataTrain and dataTest's column names are labeled with descriptive feature names mentioned in features.txt with modifications. The result is stored in mergedData with features, subject, and activity identification.

3. Extract only mean and standard deviation measurements (Step 2 in run\_analysis.R). As explained in features\_info.txt, only mean and std are matched give requirements, so the measures with meanFreq will not be included. The result is stored in data with selected features, subject, and activity identification.

4. Map activity identification with descriptive activity names defined in activity_labels.txt (Step 3 in run\_analysis.R). This step is done by adding new column called activityName and assigning the value with mapping activity identification and name defined in activity_labels.txt. This solution will allow to preserve current order of data  resulted from step 3.

5. Label all data's column names with descriptive names (Step 4 in run\_analysis.R). This step is done on step 1 and 3. The data results from all previous steps is a tidy data because each variable is stored in one column and each different observation of the variable is stored in a different row.

6. Create the independent tidy data set with the average of each variable for each activity and each subject and write the tidy data set into the file called tidyData.txt without row.names column (Step 5 in run\_analysis.R). The tidy data is calculated by using aggregate function grouping by subject  and activity identification to calculate average of selected measurements.The result is stored in tidyData variable and written into tidyData.txt. Again, the result of this step is a tidy data because each variable is stored in one column and each different observation of the variable is stored in a different row. 