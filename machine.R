#set seed
set.seed(12321)

#read csv
ds <- read.csv("c:\\users\\hofb\\downloads\\pml-training.csv", stringsAsFactors=F, na.strings=c("","NA"))

#strip out columns with aggregates
ds <- ds[,!grepl("^max_|skewness_|max_|min_|avg_|stddev_|amplitude_|var_|kurtosis_|raw_time|cvtd_|X|user_name|new_window|num_window",colnames(ds))]
ds$classe <- as.factor(ds$classe)

#split out test and train
inTrain <- createDataPartition(y=ds$classe, p=.7, list=F)
train <- ds[inTrain,]
test <- ds[-inTrain,]

fit <- randomForest(classe~., data=train)
summary(fit)

fit$confusion

testpreds <- predict(fit, test)
confusionMatrix(testpreds, test$classe)

dsf <- read.csv("c:\\users\\hofb\\downloads\\pml-testing.csv", stringsAsFactors=F, na.strings=c("","NA"))

#strip out columns with aggregates
dsf <- dsf[,!grepl("^max_|skewness_|max_|min_|avg_|stddev_|amplitude_|var_|kurtosis_|raw_time|cvtd_|X|user_name|new_window|num_window",colnames(dsf))]
preds <- predict(fit, dsf)

preds