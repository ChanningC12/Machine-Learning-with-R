# Parameter tuning
library(caret)
set.seed(300)
m = train(as.factor(default)~.,data=credit,method="C5.0") # method parameter for tuning; This step is slow, R is repeatedly generating random samples of data, building decision trees, computing performance stats
m
# apply the best model to make predictions on the training data
p =predict(m,credit)
table(p,credit$default)
confusionMatrix(p,credit$default,positive="1")
# to obtain the estimated probabilities for each class
head(predict(m,credit,type="prob"))

# trainControl() function
# best chooses the candidate with the best value on the specified performance measure
# oneSE chooses the simplest candidate within one standard error of the best performance
# tolerance uses the simplest candidate within a user-specified percentage
ctrl = trainControl(method="cv",number=10, selectionFunction = "oneSE") 