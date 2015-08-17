
---
##Instructions##

Author: *Aarthi Vemuri*	

Date: *August 16, 2015*

------

The script run_analysis.R does the following tasks:

1. Downloads and installs the required packages(reshape2)
2. Downloads and unzips the datasets if not already present in the working directory.
3. Imports the datasets( training datasets, test datasets,labels,subject IDs and features) into R.
4. Merges the training and test datasets to a complete dataset.
5. Extracts the columns related to mean and standard deviation
6. Assigns the variables names from the features dataset to the the complete dataset.
7. Add Subject IDs from the labels dataset to the corresponding measurements in the complete dataset.
8. Add the corresponding activity names from labels dataset to the complete dataset.
9. Create a new tidy dataset which has the mean of all the measurements in the complete dataset for each activity and each subject.
10. Write the tidy dataset to the working directory.


###Input

- activity_labels.txt
- features.txt
- X_test.txt
- Y_test.txt
- subject_test.txt
- X_train.txt
- Y_train.txt
- subject_train.txt

###Output

- tidy.txt
