# wearable_computing
## Assignment, Getting &amp; Cleaning Data
The data collected from the Samsung wearable computing experiment is tidied by the run_analysis.R script available in this repo.
First all data relevant to the scope of this assignment are exctracted from the UCI_HAR file. These are:
1. X_train and X_test : recorded signals from accelerometer & gyrometer of phone, training & testing samples respectively [,561]num
2. y_train and y_test : number labels associated with physical activity performed at the time of sampling [1:6] int 
3. subject_train and subject_test : Numeric ID associated with volunteer whose activities are being studied. [1:30] int
4. activity_labels : Descriptive label associated with numeric physical activity recorded in y_train/test [1:6] char
5. features : Descriptive variable name for recorded variables [561] char

Once all relevant data are read into individual tables, appropriate column names are added.
1. Subject -> to numeric volunteer ID (subject_train/test)
2. Activity -> to numeric physical activity identifier (y_train/test)
3. Features -> is added to X_train/test as olumn names to identify measured signals & components

Train and Test datasets are separately constructed
1. Using cbind, Subject_train, y_train, X_train are binded together to create train dataset.
2. Similarly the test dataset is also created.

Merged dataset is created by using rbind on Tain and Test datasets, the column names must be same to merge successfully.
The merged dataset, called train_test, is ordered by Subect and Activity respectively.

                    [train_test] dimensions- [10299, 563]
 ________________________________________________________________
|Subject(int) | Activity(int ) |              Features(num)       |
|____________ | ______________ | ________________________________ |
|             |                |                                  |
|             |                |                                  |
|             |                |                                  |
|             |                |                                  |
|             |                |                                  |
| _______________________________________________________________ |
        
A substrin search for "mean | std" is carried out through features to find columns that contain data on mean and standard deviation only.
Using 'select', only Subject, Activity and column indexes obtained above are retained, rest of the columns are discarded.

The data set is then grouped by Subject first then Activity, using 'group_by'. The grouped data is summarized across all columns using 'summarise_all' to calculate means. 

This results in a tidied, summarised dataframe train_test that has dimensions - [180, 81].
The rows (records) are obtained by summarising 6 activities of 30 volunteers each, [30 x 6 = 180] giving 180 records.
The table givies grouped, summarized means of 79 variables (selected from 561) giving a total of [Subject + Activity +79 =81] columns.

To make the dataset descriptive, the numbers in Activity column were replaced by descriptive, character activity labels such as Walking, Sitting, Laying etc. Column names are descriptive enough and any change would lead to loss of information, hence column names are retained from the supplied features document.

              [train_test] dimensions- [180, 81]
_________________________________________________________________
|Subject(int) | Activity(char) |              Features(num)       |
|____________ | ______________ | ________________________________ |
|             |                |                                  |
|             |                |                                  |
|             |                |                                  |
|             |                |                                  |
|             |                |                                  |
| _______________________________________________________________ |

Therefore, all objectives of the assignment have been met. 
        
       
