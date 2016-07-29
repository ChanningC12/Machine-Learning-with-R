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







