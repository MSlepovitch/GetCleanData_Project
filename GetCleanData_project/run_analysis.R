run_analysis.R <- function (directory){
  
  setwd (directory)  
  
  ## Combine the train and test data
  
  X_train<-read.table (paste(directory,"/train/X_train.txt", sep = ""),sep="")
  X_test<-read.table (paste(directory,"/test/X_test.txt", sep = ""),sep="")
  X_combine<-rbind(X_train,X_test, deparse.level = 0, make.row.names = FALSE)
  
  y_train<-read.table (paste(directory,"/train/y_train.txt", sep = ""),sep="")
  y_test<-read.table (paste(directory,"/test/y_test.txt", sep = ""),sep="")
  y_combine<-rbind(y_train,y_test, deparse.level = 0, make.row.names = FALSE)
  
  subject_train<-read.table (paste(directory,"/train/subject_train.txt", sep = ""),sep="")
  subject_test<-read.table (paste(directory,"/test/subject_test.txt", sep = ""),sep="")
  subject_combine<-rbind(subject_train,subject_test, deparse.level = 0, make.row.names = FALSE)
  
  ## Extract only the mean and standard deviation data
  
  ## Features 1-200 are 5 sets of 40 each, varying by XYZ, the means and stds are the first 6 features in each set
  ind<-rep(seq(0,160,by=40),6)+rep(c(1:6), each = 5)
  ## Features 201-265 are 5 sets of 13 each, the means and stds are the first 2 features in each set
  ind<-c(ind,rep(seq(200,254,by=13),2)+rep(c(1:2), each = 5))
  ## Features 266-502 are 3 sets of 79 each, varying by XYZ, the means and stds are the first 6 features in each set
  ind<-c(ind,rep(seq(265,423,by=79),6)+rep(c(1:6), each = 3))
  ## Features 503-554 are 4 sets of 13 each, the means and stds are the first 2 features in each set
  ind<-sort(c(ind,rep(seq(502,541,by=13),2)+rep(c(1:2), each = 4)), decreasing = FALSE)
  
  X_combine_mean_std<-X_combine[,ind]
  
  ## assign descriptive activity names to the activities in the data set
  
  act_names<-(read.table (paste(directory,"/activity_labels.txt", sep = ""),sep=""))[,"V2", drop = FALSE]
  activities<-act_names[as.numeric(y_combine[[1]]),]
  
  ## label the data set with descriptive variable names
  
  FeatureNames<-(read.table (paste(directory,"/features.txt", sep = ""),sep=""))[,"V2", drop = FALSE]
  FeatureNames<-FeatureNames[ind,]
  
  colnames(subject_combine)<-"subject"
  colnames(X_combine_mean_std)<-FeatureNames
  
  CleanData<-cbind(subject_combine,activities,X_combine_mean_std, deparse.level = 0, make.row.names = FALSE)
  
  ## create a second, independent tidy data set with the average of each variable for each activity and each subject
  
  headings<-c("Subject", "Activity", paste("Avg_",FeatureNames,sep=""))
  
  TidyData<-aggregate(CleanData[,c(3:68)],list(CleanData$subject, CleanData$activities), mean)
  colnames(TidyData)<-headings
  
  write.table(TidyData, file=paste(directory,"/TidyDataSet.txt", sep=""), row.name=FALSE)
  
  
}