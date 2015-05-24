run_analysis <- function(){
  
  #1. Merge training and test sets to create one data set
  #2. Extracts only the measurements on the mean and standard deviation for each measurement
  #3. Uses descriptive activity names to name the activities in the data set
  #4. Appropriately labels the data set with descriptive variable names.
  #5. Create a second, independent tidy data set with the average of each variable for each activity and subject
 
  library(data.table)
  library(reshape2)
  
  #Read in activity labels
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
  
  #Read in features, these are the column names
  allfeatures <- read.table("./UCI HAR Dataset/features.txt")[,2]
  #Extract only the features related to mean or standard deviation
  features <- grepl("mean|std", allfeatures)

  #Process test dataset
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  
  
  names(x_test)<-allfeatures
  
  #Only want the mean and std columns
  x_test<-x_test[,features]
  
  # Insert activity labels to match the activity ID for better readability
  y_test[,2] = activity_labels[y_test[,1]]
  names(y_test) = c("Activity_ID", "Activity_Label")
  
  names(subject_test) = "subject"
  
  #Bind test data into one table
  data_test <- cbind(as.data.table(subject_test), y_test, x_test)

  
  #Process train dataset
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  
  
  names(x_train)<-allfeatures
  
  #Only want the mean and std columns
  x_train<-x_train[,features]
  
  # Insert activity labels to match the activity ID for better readability
  y_train[,2] = activity_labels[y_train[,1]]
  names(y_train) = c("Activity_ID", "Activity_Label")
  
  names(subject_train) = "subject"
  
  # Bind train data into one table
  data_train <- cbind(as.data.table(subject_train), y_train, x_train)
  
  #Bind test and train data
  data = rbind(data_test, data_train)
  
  #Reformat data and calc mean
  id_labels   = c("subject", "Activity_ID", "Activity_Label")
  data_labels = setdiff(colnames(data), id_labels)
  molten_data      = melt(data, id = id_labels, measure.vars = data_labels)
  
  # Apply mean function to dataset using dcast function
  data_tidy   = dcast(molten_data, subject + Activity_Label ~ variable, mean)
  
  write.table(data_tidy, file = "./tidy_data.txt", row.name=FALSE)
  
}