## run_analysis() Readme

This script takes in a directory that contains the UCI HAR Dataset. By default, 
the script assumes this data is located in the the /UCI HAR Dataset/ path of 
the working directory). For this script to function, the contents of the working 
directory, at a minimum, should be:

* run_analysis.r
* UCI HAR Dataset/ 
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
    
Additional files are included for completeness of the project are:

* CodeBook.md
* README.md
* tidy_data.txt

All operations are performed within the run_analysis() function. The function
outputs a tidy data set containing the means of certain observations contained
in the test and train observation files. Please see [CodeBook.md](CodeBook.md) for details
concerning the transformations performed by the script and the variables used 
in the tidy data set.