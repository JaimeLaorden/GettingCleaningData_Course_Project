GettingCleaningData_Course_Project
==================================

Coursera Repository - Needed for Project Course first Course - Getting and Cleaning Data Project Course

## You should include a README.md in the repo describing how the script works

### As per Course Project Requirments an R script called run_analysis.R has been created 
### R script address the following tasks:

    1.	Merges the training and the test sets to create one data set. 
    2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
    3.	Uses descriptive activity names to name the activities in the data set
    4.	Appropriately labels the data set with descriptive variable names. 
    5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### R script called run_analysis.R has been divided in different sections/modules to implement the described tasks above.

1.	Module 1: Run_analysis.R


    - Module 1.1: Checking Files availability 
    - Module 1.2: Loading & merging Train and Test Data sets in one unique dataset: x_global
    - Module 1.3: Adequate naming of all attributes/columns based on “features.txt” file
    - Module  1.4 Extracts only the measurements on the mean and standard deviation for each measurement. 
    - Module 1.5 Uses descriptive activity names to name the activities in the data set
    - Module 1.6: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. New dataset will be: x_global_avg

###Final outcome of R_script is file "x_global_avg.txt".
### Dimensions of the table file will be:

- 180 rows : 6 Activity X 30 Experimenters pairs
- 563 attributes, including Activity, Experimenter, and additional 561 columns to store average of measurements of each variable corresponding to the Activity/Experimenter pair
 
Each row of this file would be one activity-one experimenter pair, and 561 columns with average of each measurement variable for that pair

***Please check on specific comments within “Run_analysis.R” at github for further details on each step within each module***

2.	Module 2. To be defined in further analysis to be done


