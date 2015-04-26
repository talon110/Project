## run_analysis() Readme

This script takes in a directory that contains the UCI HAR Dataset. By default, 
the script assumes this data is located in the the /UCI HAR Dataset/ path of 
the working directory). This directory should contain:

* activity_labels.txt
* features.txt
* features_info.txt
* test/
  * subject_test.txt
  * X_test.txt
  * y_test.txt
* train/
  * subject_train.txt
  * X_train.txt
  * y_train.txt

All operations are performed within the run_analysis() function. The function
outputs a tidy data set containing the means of certain observations contained
in the test and train observation files. Please see [CodeBook.md](codebook.md) for details
concerning the transformations performed by the script and the variables used 
in the tidy data set.