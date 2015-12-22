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
  
    substring="mean(?!Freq)|std"
    FeatureNames<-(read.table (paste(directory,"/features.txt", sep = ""),sep=""))[,"V2", drop = FALSE]
  
    X_combine_mean_std<-X_combine[,grep(substring,FeatureNames[,1], perl = TRUE)]
  
    
  ## assign descriptive activity names to the activities in the data set
  
    act_names<-(read.table (paste(directory,"/activity_labels.txt", sep = ""),sep=""))[,"V2", drop = FALSE]
    activities<-act_names[as.numeric(y_combine[[1]]),]
  
  ## label the data set with descriptive variable names
  
    colnames(subject_combine)<-"subject"
    colnames(X_combine_mean_std)<-grep(substring,FeatureNames[,1], value=TRUE, perl = TRUE)
  
    CleanData<-cbind(subject_combine,activities,X_combine_mean_std, deparse.level = 0)
  
  ## create a second, independent tidy data set with the average of each variable for each activity and each subject
  
    headings<-c("Subject", "Activity", paste("Avg_",grep(substring,FeatureNames[,1], value=TRUE, perl = TRUE),sep=""))
  
    TidyData<-aggregate(CleanData[,c(3:dim(CleanData)[2])],list(CleanData$subject, CleanData$activities), mean)
    colnames(TidyData)<-headings
  
  write.table(TidyData, file=paste(directory,"/TidyDataSet.txt", sep=""), row.name=FALSE)
  
  
}
