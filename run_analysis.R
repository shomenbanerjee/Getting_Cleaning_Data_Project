run_analysis <- function() {
     
  #Check if dataset exists, otherwise exit the program
     myWD <- getwd()
          
     if (!file.exists(paste(myWD, "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset", sep="/"))) {
          print("You don't seem to have required DataSet for this program to run. Please download the DataSet and re-try.")
          return()
     }
       
     
     #install.packages("reshape", "dplyr", "reshape2")
     library(dplyr)
     library(reshape)
     library(reshape2)
     
  #Load the activityLabel df  
  
  activityLabels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", 
                               col.names=c("ActivityId", "Activity"))[,2]
  
  
  #Load the features df  
    
  features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")[,2]
  
  #Load the subset of features of mean & std deviation. This will be useful later
  subset_features <- grepl("mean|std", features)
    
  #-----------------------T E S T  D A T A----------------------------#
  #load subject_test in a df
  subject_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
  names(subject_test) = "SubjectId"
    
  
  #load Y_test in a df
  Y_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
  names(Y_test) = "Activity"
  
  #Replace lables with activity ID in Y_Test  
  Y_test <- mutate(Y_test, Activity=activityLabels[Activity])
  
  
  #Load X-test in a df
  X_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
    
  #Replace lables with features in X_test 
  names(X_test) = features

  #Subset load only mean and standard deviation
  X_test = X_test[,subset_features]
  
  #Bind Subject_test, Y_test and X_test to a common test df
  test <- cbind(subject_test, Y_test, X_test)
  
  #Do some cleanup
  rm(subject_test, Y_test, X_test)
  
  #-----------------------T R A I N  D A T A----------------------------#
  #load subject_train in a df
  subject_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
  names(subject_train) = "SubjectId"
  
  
  #load Y_train in a df
  Y_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
  names(Y_train) = "Activity"
  
  #Replace lables with activity ID in Y_train  
  Y_train <- mutate(Y_train, Activity=activityLabels[Activity])
  
  
  #Load X-train in a df
  X_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
   
  
  #Replace lables with features in X_train
  names(X_train) = features
  
  #Subset load only mean and standard deviation
  X_train = X_train[,subset_features]
  
  #Bind Subject_train, Y_train and X_train to a common train df
  train <- cbind(subject_train, Y_train, X_train)
  
  #Do some cleanup
  rm(subject_train, Y_train, X_train)
  
  #Create a mergerd df as per Question 1 of the Project
  common <- rbind(train, test)
  
  
  #Do some cleanup
  rm(test, train, features, activityLabels, subset_features)
  
 
  #Re-shaping data to have average of each variable for each activity
  #and each subject
  idVars <- names(common[,1:2])
  measureVars <- setdiff(names(common), idVars)
  
  #Need to do a melt and dcast to reshape data so we can derive the tidy df
  commonMelt <- melt(common, id=idVars, measure.vars=measureVars)  
  
  tidyData <- dcast(commonMelt, SubjectId+Activity ~ variable,mean)
  
  print(tidyData[1:3, 1:3])
  
  #Wtite the dataset to a new .txt file
  write.table(tidyData, "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/TidyData.txt")
  
 
  
}
