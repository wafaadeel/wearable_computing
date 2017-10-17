#Reading in relevant tables
activity_labels<- read.table("./UCI_HAR/activity_labels.txt")
features<-read.table("./UCI_HAR/features.txt")
X_train<- read.table("./UCI_HAR/train/X_train.txt")
X_test<- read.table("./UCI_HAR/test/X_test.txt")
y_train<- read.table("./UCI_HAR/train/y_train.txt")
y_test<- read.table("./UCI_HAR/test/y_test.txt")
sub_train<- read.table("./UCI_HAR/train/subject_train.txt")
sub_test<- read.table("./UCI_HAR/test/subject_test.txt")

feat_char<-features[2]
feat_char<-sapply(feat_char, as.character)
names(X_train)<-feat_char
names(X_test)<-feat_char
#names(X_train)<-feat_char
names(sub_train)<-"Subject"
names(sub_test)<-"Subject"
names(y_train)<-"Activity"
names(y_test)<-"Activity"
 
train<- cbind(sub_train, y_train, X_train)
test<- cbind(sub_test, y_test, X_test)
train_test<-rbind(train, test)

sub="mean|std"
string=names(train_test)
retain<-grepl(sub, string)
retain<-which(retain)
train_test<- train_test[ , c(1,2,retain)]


act1<-grepl("1", train_test$Activity)
train_test$Activity[act1]<-"Walking"
act2<-grepl("2", train_test$Activity)
train_test$Activity[act2]<-"Walking Up"
act3<-grepl("3", train_test$Activity)
train_test$Activity[act3]<-"Walking Down"
act4<-grepl("4", train_test$Activity)
train_test$Activity[act4]<-"Sitting"
act5<-grepl("5", train_test$Activity)
train_test$Activity[act5]<-"Standing"
act6<-grepl("6", train_test$Activity)
train_test$Activity[act6]<-"Laying"

train_test<-train_test[order(train_test$Subject,train_test$Activity), ]

train_test <- train_test %>% group_by(Subject, Activity)

train_test <- summarise_all(train_test, mean)
  
