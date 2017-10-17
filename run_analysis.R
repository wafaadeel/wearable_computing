#Step 1: First all relevant data is read, 3 files for train and test each 
#(X: measured features, y: associated physical activity, sub: volunteer ID number)
#2 files are common, (activity_labels: number & physical activity association, features: list of features measured)
#Step 2: Column names are added.
#Train and Test datasets are created separately by combining Subject ID, Activity No. and measured features.
#Step 3: Training and testing datasets are merged.
#Step 4: Merged dataset is trimmed to select only mean and standard deviation variables
#Step 5: Activity numbers are replaced by associated activity label to make dataset descriptive.
#Step 6: Merged dataset is ordered by Subject ID first and Activity next
#Step 7: Merged dataset is grouped by Subject ID and Activity to enable grouped summary
#All columns are summarised to obtain mean across 180 records and 79 variables.
#Note 1: Feature names are self descriptory and in my opinion any relabelling would cause loss of information and/or
#unnecessary shifting between codebook and dataset.
#Note 2: Dataset is in the long(narrow) tidy format. Only one variable in each column, only one observation in each record.
#Phew, that was long!


#Reading in relevant tables
activity_labels<- read.table("./UCI_HAR/activity_labels.txt")
features<-read.table("./UCI_HAR/features.txt")
X_train<- read.table("./UCI_HAR/train/X_train.txt")
X_test<- read.table("./UCI_HAR/test/X_test.txt")
y_train<- read.table("./UCI_HAR/train/y_train.txt")
y_test<- read.table("./UCI_HAR/test/y_test.txt")
sub_train<- read.table("./UCI_HAR/train/subject_train.txt")
sub_test<- read.table("./UCI_HAR/test/subject_test.txt")

#Extracting feature labels from feature list
feat_char<-features[2]
feat_char<-sapply(feat_char, as.character)

#Attaching features to training and testing data as column names
names(X_train)<-feat_char
names(X_test)<-feat_char

#Attaching column names to Subject ID and activities measured
names(sub_train)<-"Subject"
names(sub_test)<-"Subject"
names(y_train)<-"Activity"
names(y_test)<-"Activity"
 
#Creating train and test dataframes by compiling subject, activity and measured features
train<- cbind(sub_train, y_train, X_train)
test<- cbind(sub_test, y_test, X_test)

#Combining training and testing data to create single dataset
train_test<-rbind(train, test)

#Selecting only mean and standard deviation columns from the dataset
sub="mean|std"
string=names(train_test)
retain<-grepl(sub, string)
retain<-which(retain)
train_test<- train_test[ , c(1,2,retain)]

#Replacing Activity numbers by associated activity labels
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

#Ordering merged, labelled dataset by Subject and then Activity
train_test<-train_test[order(train_test$Subject,train_test$Activity), ]

#Grouping dataset by Subject and then Activity to summarise features
train_test <- train_test %>% group_by(Subject, Activity)

#Summarising mean and std data across columns, as grouped by Subject then Activity
train_test <- summarise_all(train_test, mean)
  
