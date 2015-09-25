# How the script works

The script reads all the measurments in traingin and test sets, it reads:
1. X which contains the features ( measurements )


2 y which refers to the activiy


3. subjects which refers to the subjects (30 volunteers)

1. terer
2. sdfdsfs
3. 


The code merges the test sets and the training sets respectively

Reading Features' names and Activity Labels

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

