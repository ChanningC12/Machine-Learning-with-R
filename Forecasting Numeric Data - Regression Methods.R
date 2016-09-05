launch = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/challenger.csv")
View(launch)
dim(launch)
str(launch)

b = cov(launch$temperature, launch$distress_ct) / var(launch$temperature)
b
a = mean(launch$distress_ct) - b*mean(launch$temperature)
a
r = cov(launch$temperature, launch$distress_ct) / (sd(launch$temperature)*sd(launch$distress_ct))
r
cor(launch$temperature, launch$distress_ct)

# correlation does not imply causation
reg = function(y,x){
    x = as.matrix(x)
    x = cbind(Intercept = 1, x)
    solve(t(x) %*% x) %*% t(x) %*% y
}

reg(y = launch$distress_ct, x = launch$temperature)
reg(y = launch$distress_ct, x = launch[3:5])

# Example - predicting medical expenses using linear regression
# Step 1: collecting data
# insurance.csv includes 1338 examples of beneficiaries currently enrolled in the insurance plan with features indicating characteristics of the patient as well as medical expenses

# Step 2: Exploring and preparing the data
insurance = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/insurance.csv", stringsAsFactors = T)
dim(insurance)
str(insurance)
summary(insurance$charges)
hist(insurance$charges)
table(insurance$region)

# correlation matrix
round(cor(insurance[c("age","bmi","children","charges")],use = "pairwise.complete.obs"),3)

# Visaulizing relationships among features - scatter plot
pairs(insurance[c("age","bmi","children","charges")])

library(psych)
# produces a slightly more informative scatterplot matrix
pairs.panels(insurance[c("age","bmi","children","charges")])

library(corrplot)
corrplot(cor(insurance[c("age","bmi","children","charges")],use = "pairwise.complete.obs"), order = "hclust", method = "shade", tl.cex = .7)

# Step 3: Training a model on the data
ins_model = lm(charges ~ age + children + bmi + sex + smoker + region, data = insurance)
ins_model
summary(ins_model)
# lm() function automatically applieda technique known as dummy coding
# relevel() can be used to specify the reference group manually

# divide into train/test set
library(caret)
inTrain = createDataPartition(y = insurance$charges, p = 0.75, list = F)
ins_train = insurance[inTrain,]
ins_test = insurance[-inTrain,]
summary(insurance)
summary(ins_train)
summary(ins_test)

ins_model_train = lm(charges ~ ., data = ins_train)
ins_model_pred = predict(ins_model_train, ins_test)
summary(ins_model_pred)

# use caret to evaluate model
trControl = trainControl(method = "none")
ins_model_caret = train(x = insurance[,-7], y = insurance[,7], method = "lm", metric = "RMSE", trControl = trControl)
ins_model_caret$results
RMSE(pred = ins_model_caret$finalModel$fitted.values, obs = insurance[,7])
R2(pred = ins_model_caret$finalModel$fitted.values, obs = insurance[,7])
# http://machinelearningmastery.com/evaluate-machine-learning-algorithms-with-r/

# Step 5: Improving model performance
insurance$age2 = insurance$age^2 # adding non-linear relationship
insurance$bmi30 = ifelse(insurance$bmi >= 30, 1, 0) # concerting a numeric variable to a binaty indicator
# create interaction, bmi30*smoker

ins_model2 = lm(charges ~ age + age2 + children + bmi + sex + bmi30*smoker + region, data = insurance)
summary(ins_model2)


# Understanding regression trees and model trees
# Example - estimating the quality of wines with regression trees and model trees

# Step 1: Collecting Data
# 11 chemical properties of 4898 wine samples

# Step 2: Exploring and preparing the data
wine = read.csv("~/Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/whitewines.csv") # do not need to normalize/standardize data
View(wine)
dim(wine)
str(wine)
hist(wine$quality)

# parition into two sets
wine_train = wine[1:3750,]
wine_test = wine[3751:4898,]


# Step 3: Training a model on the data
# rpart(recursive partitioning) package
m.rpart = rpart(quality ~ ., data = wine_train)
m.rpart # alcohol was used first in the tree, it is the single most important predictor of wine quality
library(rpart.plot)
rpart.plot(m.rpart, digits = 3) # digits parameter controls the number of numeric digits to include in the diagram
rpart.plot(m.rpart, digits = 4, fallen.leaves = T, type = 3, extra = 101) # fallen.leaves forces the leaf nodes to be aligned at the bottom of the plot, extra parameters affect the way the decisions and nodes are labeled

# Step 4: Evaluating model performance
p.rpart = predict(m.rpart, wine_test)
summary(p.rpart)
summary(wine_test$quality)
cor(p.rpart, wine_test$quality)

# Measuring performance with mean absolute error
MAE = function(actual, predicted) {
    mean(abs(actual - predicted))
}

MAE(p.rpart, wine_test$quality)
mean(wine_train$quality)
mean_abserror(5.87,wine_test$quality)

# Step 5: Improving model performance
library(RWeka)
m.m5p = M5P(quality ~ ., data = wine_train)
m.m5p
summary(m.m5p)
p.m5p = predict(m.m5p, wine_test)
summary(p.m5p)
cor(p.m5p, wine_test$quality)




















