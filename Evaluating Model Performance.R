# Measuring performance for classification
# Three main types of data that are used to evaluate a classifier
# 1. Actual class value; 2. Predicted class value; 3. Estimated probablity of the prediction
head(sms_result)
head(subset(sms_result,actual_type!=predict_type))

# confusion matrix
table(sms_results$actual_type,sms_results$predict_type)

# caret package (Classification and Regression Training)
library(caret)
confusionMatrix(sms_results$predict_type,sms_results$actual_type,positive="spam")

# kappa statistic, range to maximum value of 1, which indicates perfect agreement between the model's predictions and true value
# Kappa() in R to calculate kappa in vcd package (Visualization Categorical Data)
Kappa(table(sms_results$actual_type, sms_results$predict_type))

# kappa2() function in the Inter-Rater Reliability (irr) package can be used to calculate kappa from vectors of predicted and actual values stored in a data frame
library(irr)
kappa2(sms_results[1:2])

# Sensitivity: measures the proportion of positive examples that are correctly classified
# Specificity: measures the proportion of negative examples that are correctly classified
# caret package
sensitivity(sms_results$predict_type,sms_results$actual_type,positive="spam")
specificity(sms_results$predict_type,sms_results$actual_type,negative="ham")

# Precision: measures the proportion of positive examples that are truly positive


# The F-measure (F1 score): 2*TP/(2*TP+FP+FN)


# ROC Curve in ROCR package
library(ROCR)
pred = prediction(prediction = sms_results$prob_spam,labels = sms_results$actual_type)
# The best practice is to use AUC in combination with qualitative examination of the ROC curve
# plot ROC
perf = performance(pred, measure="tpr", x.measure="fpr")
plot(perf,main="ROC curve for SMS spam filter", col="blue", lwd=3)
# use abline to add reference line
abline(a=0,b=1,lwd=2,lty=3)
perf.auc = performance(pred,measure="auc") # calculate AUC
str(perf.auc)

# Estimating future performance
# resubmission error: occurs when the training data is incorrectly predicted in spite of the model being built directly from this data
# caret package
# holdout method: partitioning data into training and test datasets
# training dataset is to generate model
# test dataset is to generate predictions for evaluation
# validation dataset would be used for iterating and refining the model or models choosen, leaving the test dataset to be used only once as a final step to report an estimated error rate
library(caret)
# read in credit dataset
credit = read.csv("~/Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/credit.csv")
# examine the data
dim(credit)
head(credit)
str(credit)
# divide into three partitions
random_ids = order(runif(1000)) # runif(), return to n random numbers between 0 and 1
credit_train = credit[random_ids[1:500],]
credit_validate = credit[random_ids[501:750],]
credit_test = credit[random_ids[751:1000],]

# Holdout method has two problems:
# 1. each partition may have a larger or smaller proportion of some classes -- Stratified random sampling
# 2. substantial portions of data must be reserved for testing and validating the model -- Repeateed holdout (k-fold cross-validation)

# stratified random sampling: ensures that the generated random partitions have approximately the same proportion of each class as the full dataset
# caret package provides a createDataPartition() function that will create partitions based on stratified holdout sampling
in_train = createDataPartition(credit$default,p=0.75, list = F) # parameter p specifies the proportion of instances to be included in the partition; list = F prevents the result from being stored in list format
in_train
credit_train = credit[in_train,]
credit_test = credit[-in_train,]

# Cross-validation
# k-fold cross-validation: k-fold CV randomly divides the data into k completely separate random partitions called folds
# 10-fold cross validation, a machine learning model is built on the remaining 90 percent of data, the fold's matching percent sample is then used for model evaluation. 
# After the process of training and evaluating the model has occurred for 10 times, the average performance across all folds is reported
# leave-one-out method
folds = createFolds(credit$default, k=10) # The result of the createFolds() function is a list of vectors storing the row numbers for each of the k=10 requested folds
str(folds)
credit01_train = credit[folds$Fold01,]
credit01_test = credit[-folds$Fold01,]

# example: caret(for creating the folds), C50 (for the decision tree), irr(for calculating kappa)
library(caret)
library(C50)
library(irr)
set.seed(123) # set.seed() function is used here to ensure that the results are consistent if you run the same code again
folds = createFolds(credit$default, k=10)

# lapply() to perform CV
cv_results = lapply(folds, function(x){
    credit_train = credit[x,]
    credit_test = credit[-x,]
    credit_model = C5.0(as.factor(default)~.,data=credit_train)
    credit_pred = predict(credit_model,credit_test)
    credit_actual = credit_test$default
    kappa = kappa2(data.frame(credit_actual,credit_pred))$value
    return(kappa)
})

str(cv_results)

# calculate the average of these 10 kappa values
mean(unlist(cv_results))

# Boostrap sampling (alternative to K-fold CV)
# bootstrap: refers to statistical methods of using random samples of data to estimate properties of a larger set
# create several randomly-selected training and test datasets, allows examples to be selected multiple times through a process of sampling with replacement
# the bootstrap is less representative of the full dataset: 63.2%
# error = 0.632*error_test + 0.368*error_train












