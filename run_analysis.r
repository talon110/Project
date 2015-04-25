run_analysis <- function(path = "./UCI HAR Dataset/") {
  ## function which takes in a path and runs analysis on UCI HAR dataset in the 
  ## given path
  
  ## import necessary libraries
  library(tidyr)
  library(dplyr)
  
  # define the names of the two data sets.
  data_set <- c("test", "train")
  #print(data_set)
  #print(summary(data_set))
  
  # define the paths of where the column headers, the data sets, the
  # observation data, and the data labels will be read from
  activity_labels_path <- paste(path, "activity_labels.txt", sep = "")
  headers_path <- paste(path, "features.txt", sep = "")
  data_set_path <- paste(path, data_set, "/", sep = "")
  data_path <- paste(data_set_path, "X_", data_set, ".txt", sep = "")
  labels_path <- paste(data_set_path, "y_", data_set, ".txt", sep = "")
  
  # import the headers, labels, and observation data
  headers <- read.table(headers_path, stringsAsFactors = F, header = F)
  # redefine headers as only the second column of the dataframe (the first is
  # only the row number)
  headers <- headers$V2
  #View(headers)
  
  # create labels list, set list element names, and assign data frames to each
  # element
  labels <- list(NULL, NULL)
  names(labels) <- data_set
  labels$test <- read.table(labels_path[1], stringsAsFactors = F, header = F,
                            col.names = "label")
  labels$train <- read.table(labels_path[2], stringsAsFactors = F, header = F,
                             col.names = "label")
  
  # create data list, set list element names, and assign data frames to each
  # element
  data_list <- list(NULL, NULL)
  names(data_list) <- data_set
  data_list$test <- read.table(data_path[1], stringsAsFactors = F, header = F, 
                          col.names = headers, skipNul = T)
  data_list$train <- read.table(data_path[2], stringsAsFactors = F, header = F, 
                           col.names = headers, skipNul = T)
  
  # remove following objects that are no longer used
  rm(headers, headers_path, data_set_path, data_path, labels_path)
  
  # overwrite data_list with result of cbinding labels with the respective data
  data_list$test <- cbind(labels$test, data_list$test)
  data_list$train <- cbind(labels$train, data_list$train)
  
  # remove labels object since it's no longer used
  rm(labels)
  
  data <- rbind(data_list$test, data_list$train)
  View(data)
  
  # remove the data_list object since it's no longer used
  rm(data_list)
}