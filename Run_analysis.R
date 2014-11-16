#
# Course: Getting and Cleaning Data 
# Course Project
# Jaime Laorden Ferrero - October 2014
#
# The code should have a file run_analysis.R in the main directory
# that can be run as long as the Samsung data is in your working directory. 
# 
# We assume "UCI HAR Dataset" directory in working directory with Samsung data on it.
setwd("UCI HAR Dataset")
#
# 1.1 Check if all required files are available - This includes:
#
# "X_test.txt", "y_test.txt", "subject_test.txt", "X_train.txt", "y_train.txt", "subject_train.txt"
#
      list_of_files <- c("test\\X_test.txt", "test\\y_test.txt", "test\\subject_test.txt", 
                         "train\\X_train.txt", "train\\y_train.txt", "train\\subject_train.txt")
      
      for (file in list_of_files){
            
            if (file.exists(file)) {
                    print(paste("file: ", file, ": OK, is present", sep=""))
            } else {
                    stop(paste("file: ", file, ": NO OK!!! - not present"))
            }
      }
#
# 1.2 Load all data sets and merge in a unique dataset
#?
      activity_labels <- read.table("activity_labels.txt", header = FALSE, sep = " ")
      
      x_train = read.table("train\\X_train.txt", header = FALSE)
      y_train = read.table("train\\y_train.txt", header = FALSE)
      subject_train = read.table("train\\subject_train.txt", header = FALSE)
      
      x_test = read.table("test\\X_test.txt", header = FALSE)
      y_test = read.table("test\\y_test.txt", header = FALSE)
      subject_test = read.table("test\\subject_test.txt", header = FALSE)
      #
      # data sets will be merge in a unique "x_global" dataset
          x_train_all <- cbind(subject_train, y_train, x_train)
          x_test_all <- cbind( subject_test, y_test, x_test)
          x_global <- rbind(x_train_all, x_test_all)
      
      # remove all temporary dataset variables
      # rm(x_train_all); rm(x_test_all); rm(x_test); rm(y_test); rm(subject_test); rm(x_train); rm(y_train); rm(subject_train)
      # rm(file); rm(list_of_files)
#
# 1.3 Uses descriptive activity names to name the activities in the data set
#  Adequate Naming of all atributes-features-columns will be, 
# "Experimenter", "Activity", variables names from file "features.txt" file
#
      list_attrib_names <- c("Experimenter", "Activity")
      
      features_names <- read.table("features.txt")
      features_names <- as.character(features_names[,2])

      # Clean Columns datanames with "make.names" and removing extra "."

        features_names <- make.names(features_names)
        # Removing 3 .s in names
        ystr <- "\\.\\.\\."
        features_names <- sub(mystr,".",features_names)
        # Removing 2 .s in names
        mystr <- "\\.\\."
        features_names <- sub(mystr,".",features_names)
        # Removing last ending . in manes
        mystr <- "\\.$"
        features_names <- sub(mystr,"",features_names)

    
      list_attrib_names <- c(list_attrib_names,features_names)

      # naming atributes in table "x_global" - There are 561 atributes + experimenter + activity
      for (i in 1:563){
            colnames(x_global)[i] <- list_attrib_names[i]
      }
   

#
# 1.4 Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
#
x_global_mean <- apply(x_global,2, mean )
x_global_sd <- apply(x_global,2, sd )
x_global_var_names <- names(x_global_sd)

measurements_mean_sd <- cbind(x_global_var_names,x_global_mean, x_global_sd)
measurements_mean_sd <- as.data.frame(measurements_mean_sd)

# 1.5 Use descriptive activity names to name the activities in the data set 
#
x_global$Activity <- activity_labels[x_global$Activity,2]

# 1.5 From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

for (columna in 3:563) {

        # we will use tapply for each of the 563 columns of the file to calculate mean 
        # by two variables INDEX=list(x_global$Activity, x_global$Experimenter)
    
        temp <- tapply(x_global[,columna], 
                         INDEX=list(x_global$Activity, x_global$Experimenter), 
                         mean)
        temp <-   as.data.frame(as.table(temp))
        names(temp) <- c("Activity", "Experimenter", names(x_global)[columna])
        
        if (columna == 3) {x_global_avg <- temp[,1:2]}
        
        x_global_avg <- cbind(x_global_avg, temp[,3])
        names(x_global_avg)[columna] <- names(x_global)[columna]
}

# Once built the new data set x_global_avg, we write it to a txt file
# x_global_avg will be a 180 rows (6 activities x 30 experimenters) by
#                        563 columns with average of each variable for each pair 
#                        of Activity and Experimenter
write.table(x_global_avg, file = "x_global_avg.txt", row.name=FALSE)




