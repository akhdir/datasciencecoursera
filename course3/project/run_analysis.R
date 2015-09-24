XTest = read.table("./UCI HAR Dataset/test/X_test.txt");
yTest = read.table("./UCI HAR Dataset/test/y_test.txt");
subjectsTest = read.table("./UCI HAR Dataset/test/subject_test.txt");

XTrain = read.table("./UCI HAR Dataset/train/X_train.txt");
yTrain = read.table("./UCI HAR Dataset/train/y_train.txt");
subjectsTrain = read.table("./UCI HAR Dataset/train/subject_train.txt");

# Merging datasets
X = rbind(XTrain,XTest);
y = rbind(yTrain, yTest);
subjects = rbind(subjectsTrain, subjectsTest);

# reading Features file
features = read.table("./UCI HAR Dataset/features.txt");
activities = read.table("./UCI HAR Dataset/activity_labels.txt");
# finding features with Mean or STD only
meanCols = grep("-mean()", as.vector(features$V2), ignore.case = FALSE, fixed = TRUE );
stdCols = grep("-std()", as.vector(features$V2), ignore.case = FALSE, fixed = TRUE );
Cols = c(stdCols, meanCols);
Cols = sort.int( Cols)
# extracting Mean & STD Cols only
MeanSTDOnly = X[, Cols];

# tmp = replace(as.vector(y$V1), as.vector(activities$V2), as.vector(activities$V1) );
colnames(MeanSTDOnly) <- as.vector(features[sort.int(Cols),]$V2);

# assigning activities names
library(plyr);
activity_names = mapvalues( as.vector(y$V1), as.vector(activities$V1), as.vector(activities$V2));
MeanSTDOnly["activities"] <- activity_names;

MeanSTDOnly["subjects"] <- subjects$V1;

tidy <- aggregate(MeanSTDOnly[1:66], by=list(MeanSTDOnly$activities, MeanSTDOnly$subjects), FUN=mean);
colnames(tidy)[1] <- "activity";
colnames(tidy)[2] <- "subjects";
write.table(tidy, file= "tidyset.txt",  row.names = FALSE);
#X["activities"] = y;
#X["subjects"] = subjects;

# converting data frame to vector
# as.vector(t(s))

# repeating vector 
# rep(1:4, each=561)
# head(X);



