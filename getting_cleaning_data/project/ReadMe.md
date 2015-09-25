# How the Script Works

The script reads all the measurements in training and test sets, it reads:

1. X which contains the features ( measurements )
2. y which refers to the activiy
3. subjects which refers to the subjects (30 volunteers)

The code merges the test sets and the training sets respectively, it also reads activity names and features' names.


The next setp will be finding features with Mean or STD only
```R
meanCols = grep("-mean()", as.vector(features$V2), ignore.case = FALSE, fixed = TRUE );
stdCols = grep("-std()", as.vector(features$V2), ignore.case = FALSE, fixed = TRUE );
```
Merging the vectors and sorting them:
```R
Cols = c(stdCols, meanCols);
Cols = sort.int( Cols)
```
Extracting Mean & STD features fom the original dataset
```R
MeanSTDOnly = X[, Cols];
```

Assigning activities names, and adding it to the dataset:

```R
library(plyr);
activity_names = mapvalues( as.vector(y$V1), as.vector(activities$V1), as.vector(activities$V2));
MeanSTDOnly["activities"] <- activity_names;
```
Adding subjects column
```R
MeanSTDOnly["subjects"] <- subjects$V1;
```

Aggregate using the function mean:
```R
tidy <- aggregate(MeanSTDOnly[1:66], by=list(MeanSTDOnly$activities, MeanSTDOnly$subjects), FUN=mean);
colnames(tidy)[1] <- "activity";
colnames(tidy)[2] <- "subjects";
```

And finally writing the data
```R
write.table(tidy, file= "tidyset.txt",  row.names = FALSE);
```

# Original dataset

* You can find the original dataset [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Make sure to extract the dataset and have in the same working directory of the script.

