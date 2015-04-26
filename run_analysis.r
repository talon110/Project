run_analysis <- function(path = "./UCI HAR Dataset/") {
  ## function which takes in a path and runs analysis on UCI HAR dataset in the 
  ## given path
  
  ## import necessary libraries
  library(dplyr)
  library(reshape2)
  
  # define the names of the two data sets.
  data_set <- c("test", "train")
  
  # define the paths of where the column headers, data sets, observation
  # data, data labels, and subject data will be read from
  activity_labels_path <- paste(path, "activity_labels.txt", sep = "")
  headers_path <- paste(path, "features.txt", sep = "")
  data_set_path <- paste(path, data_set, "/", sep = "")
  data_path <- paste(data_set_path, "X_", data_set, ".txt", sep = "")
  labels_path <- paste(data_set_path, "y_", data_set, ".txt", sep = "")
  subject_path <- paste(data_set_path, "subject_", data_set, ".txt", sep = "")
  
  # import the headers & redefine headers as only the second column of the 
  # dataframe (the first is only the row number)
  headers <- read.table(headers_path, stringsAsFactors = F, header = F)
  headers <- headers$V2 
  
  # set headers to be 
  headers <- gsub("()", "", headers, fixed = T) %>% 
    gsub("-", ".", ., fixed = T) %>% gsub(",", ".", ., fixed = T) %>%
    gsub("[(]", ".", .) %>% gsub("[)]", "", .) %>% 
    gsub("(\\w*)", "\\L\\1", ., perl = T)
  
  # define a vector containing the columns of means and standard deviations
  # sorted by column number
  means_stds <- sort(c(grep("mean", headers, ignore.case = T), 
                       grep("std", headers, ignore.case = T)))
  
  # create labels column
  labels <- list(NULL, NULL)
  names(labels) <- data_set
  labels$test <- read.table(labels_path[1], stringsAsFactors = F, header = F,
                            col.names = "label")
  labels$train <- read.table(labels_path[2], stringsAsFactors = F, header = F,
                             col.names = "label")
  labels <- rbind(labels$test, labels$train)
  
  # create subjects column
  subjects <- list(NULL, NULL)
  names(subjects) <- data_set
  subjects$test <- read.table(subject_path[1], stringsAsFactors = F,
                                 header = F, col.names = "subject")
  subjects$train <- read.table(subject_path[2], stringsAsFactors = F,
                                  header = F, col.names = "subject")
  subjects <- rbind(subjects$test, subjects$train)
  
  # create data columns
  data <- list(NULL, NULL)
  names(data) <- data_set
  data$test <- read.table(data_path[1], stringsAsFactors = F, header = F,
                          skipNul = T)
  data$train <- read.table(data_path[2], stringsAsFactors = F, header = F, 
                           skipNul = T)
  data <- rbind(data$test, data$train) 
  names(data) <- headers
  
  # remove following objects that are no longer used
  rm(data_set_path, headers_path, labels_path, data_path)
  
  # create activity_labels dataframe
  activity_labels <- read.table(activity_labels_path, stringsAsFactors = F, 
                                header = F, col.names = c("label", "activity"))
  
  # combine test and train data into one dataframe, add subject and activity 
  # labels, merge activity descriptions
  data <- data[, means_stds] %>% cbind(subjects, labels, .) %>% 
    merge(activity_labels, .) %>% arrange(subject, label) %>% select(-label)
  
  molten <- melt(data, id = c("subject", "activity"))
  tidy <- dcast(molten, subject + activity + variable ~ ..., mean)
  names(tidy)[4] <- "mean"
  
  write.table(tidy, "tidy_data.txt", row.names = F)

}