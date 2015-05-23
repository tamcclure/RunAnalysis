run_analysis.R<-#Read features and activity labels data
  features<-read.table("C:/Users/Dana/Documents/Cousera/UCI HAR Dataset/features.txt",header=F)
activityType<-read.table("C:/Users/Dana/Documents/Cousera/UCI HAR Dataset/activity_labels.txt",header=F)

#Create columns labels for activityType
colnames(activityType)<-c("activityId","activityType")

#Read Test data files, create column labels and column bind all files
subtest<-read.table("C:/Users/Dana/Documents/Cousera/UCI HAR Dataset/test/subject_test.txt",header=F)
ytest<-read.table("C:/Users/Dana/Documents/Cousera/UCI HAR Dataset/test/Y_test.txt",header=F)
xtest<-read.table("C:/Users/Dana/Documents/Cousera/UCI HAR Dataset/test/X_test.txt",header=F)
colnames(subtest)<-"subjectId"
colnames(xtest)<-features[,2]
colnames(ytest)<-"activityId"
finaltest<-cbind(ytest,subtest,xtest)

#Read Train data files, create column labels and column bind all files
subtrain<-read.table("C:/Users/Dana/Documents/Cousera/UCI HAR Dataset/train/subject_train.txt",header=F)
ytrain<-read.table("C:/Users/Dana/Documents/Cousera/UCI HAR Dataset/train/Y_train.txt",header=F)
xtrain<-read.table("C:/Users/Dana/Documents/Cousera/UCI HAR Dataset/train/X_train.txt",header=F)
colnames(subtrain)<-"subjectId"
colnames(xtrain)<-features[,2]
colnames(ytrain)<-"activityId"
finaltrain<-cbind(ytrain,subtrain,xtrain)

#Row bind final train and test data files
fdata<-rbind(finaltrain,finaltest)

colNames<-colnames(fdata)
#print(colNames)
stdmeanlogical<-(grepl("activity..",colNames)|grepl("subject..",colNames)|grepl("-mean..",colNames)&grepl("-meanFreq..",colNames)&grepl("mean..",colNames)|grepl("-std..",colNames)&grepl("std..",colNames))
finaldata<-fdata[stdmeanlogical==T]
finaldata<-merge(finaldata,activityType,by="activityId",all.x=T)
colNames<-colnames(finaldata)
#print(colNames)
L<-length(colNames)
for (i in 1:L){
  colNames[i]<-gsub("\\()","",colNames[i])
  colNames[i]<-gsub("-std$","StdDev",colNames[i])
  colNames[i]<-gsub("-mean","Mean",colNames[i])
  colNames[i]<-gsub("^(t)","time",colNames[i])
  colNames[i]<-gsub("^(f)","freq",colNames[i])
  colNames[i]<-gsub("[Gg]ravity","Gravity",colNames[i])
  colNames[i]<-gsub("[Bb]ody[Bb]ody|[Bb]ody","Body",colNames[i])
  colNames[i]<-gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i]<-gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i]<-gsub("[Bb]odyaccjerkmag","BodyAccJerkMagnitude",colNames[i])
  colNames[i]<-gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i]<-gsub("GyroMag","GyroMagnitude",colNames[i])
}
colnames(finaldata)<-colNames
print(finaldata)

NoActData<-finaldata[,names(finaldata)!="activityType"]
groupData<-group_by(NoActData,activityId,subjectId)
arrangeData<-arrange(groupData,subjectId,activityId)
aggData<-aggregate(arrangeData,list(activityId=arrangeData$activityId,subjectId=arrangeData$subjectId),mean)
rm_duplicate_cols<-aggData[,-c(1,2)]
TData<-merge(activityType,rm_duplicate_cols,by="activityId",all.x=T)
TidyData<-arrange(TData,subjectId,activityId)
#View(TidyData)
write.table(TidyData,"./Cousera/UCI HAR Dataset/TidyData.txt",row.names=FALSE,sep="\t")
