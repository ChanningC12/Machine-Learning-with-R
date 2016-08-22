# Recursive partitioning: divide and conquer, uses the feature values to split the data into smaller and smaller subsets of similar classes
# pure: only have a single class
# C5.0 uses entropy for measuring purity. The entropy of a sample of data indicates how mixed the class values are
par(mfrow=c(1,1))
curve(-x * log2(x) - (1 - x) * log2(1 - x), col="red", xlab = "x", ylab = "Entropy", lwd=4)
# InfoGain(F) = Entropy(S1) - Entropy(S2)

# pruning: reducing the size that the decision tree generalizes better to unseen data

# Example - Identifying risky bank loans using C5.0 decision tree

# 2. Exploring and preparing the data
credit = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/credit.csv")
View(credit)
str(credit)
table(credit$checking_balance)
table(credit$savings_balance)
summary(credit$months_loan_duration)
summary(credit$amount)
table(credit$default)

# data preparation - creating random training and test datasets
set.seed(12345)
# random sorted to avoid problematic issues
credit_rand = credit[order(runif(1000)),]
# now split into training and test
credit_train = credit_rand[1:900,]
credit_test = credit_rand[901:1000,]
# This should be close to 70/30
prop.table(table(credit_train$default))
prop.table(table(credit_test$default))

# Step 3 - training a model on the data
library(C50) # tree package is working as well
credit_model = C5.0(credit_train[-21],as.factor(credit_train$default))
credit_model
summary(credit_model)

# Step 4 - Evaluating model performance
credit_pred = predict(credit_model, credit_test)
library(gmodels)
CrossTable(credit_test$default, credit_pred, prop.chisq = F, prop.c = F, prop.r = F, dnn = c("actual default","predicted default"))

# Step 5 - Improve model performance
# Boosting the accurancy of decision trees
credit_boost10 = C5.0(credit_train[-21], as.factor(credit_train$default), trials = 10)
credit_boost10
summary(credit_boost10)
credit_boost_pred10 = predict(credit_boost10, credit_test)
CrossTable(credit_test$default, credit_boost_pred10, prop.chisq = F, prop.c = F, prop.r = F, dnn = c("actual default", "predicted default"))


# Making some mistakes more costly than others
# The C5.0 algorithm allows us to assign a penalty to different types of errors in order to discourage a tree from making more costly mistakes
# cost matrix
error_cost = matrix(c(0,1,4,0), nrow = 2) # FN cost is four times aws much as a FP
error_cost

credit_cost = C5.0(credit_train[-21], as.factor(credit_train$default), costs = error_cost)
credit_cost_pred = predict(credit_cost, credit_test)
CrossTable(credit_test$default, credit_cost_pred, prop.chisq = F, prop.c = F, prop.r = F, dnn = c("actual default", "predicted default"))


# Understanding classification rules
# One Rule Algorithm: select one rule only
# RIPPER algorithm
# rule-learning algorithm is slow and inaccurate on noisy data

# Example: identifying poisonous mushrooms with rule learners
# Step 1: Collecting Data: 8124 mushroom samples from 23 species with 22 features of the mushroom samples
# Step 2: Exploring and preparing the data
mushrooms = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/mushrooms.csv",stringsAsFactors=T)
dim(mushrooms)
View(mushrooms)
str(mushrooms) # veil_type only has one level so we can remove it
mushrooms$veil_type = NULL

# take a look at the mushroom type
table(mushrooms$type)
round(prop.table(table(mushrooms$type))*100,2) # 51.8% edible, 48.2% poisonous


# Step 3: Training a model on the data
# 1R implementation in the RWeka package, OneR()
library(RWeka)
# train/test split method 1
mushrooms_rand = mushrooms[order(runif(nrow(mushrooms))),]
mushrooms_train = mushrooms[1:floor(0.75*nrow(mushrooms)),]
mushrooms_test = mushrooms[ceiling(0.75*nrow(mushrooms)):nrow(mushrooms),]

# train/test split method 2
inTrain = createDataPartition(y=mushrooms$type,p=0.75,list=F)
mushrooms_train_caret = mushrooms[inTrain,]
mushrooms_test_caret = mushrooms[-inTrain,]
dim(mushrooms_train_caret)
dim(mushrooms_test_caret)

# Examine the proportion of type in the training/test datasets to make sure it is distribute randomly
round(prop.table(table(mushrooms_train$type))*100,2)
round(prop.table(table(mushrooms_test$type))*100,2)

round(prop.table(table(mushrooms_train_caret$type))*100,2)
round(prop.table(table(mushrooms_test_caret$type))*100,2)

# Train the model with OneR
mushroom_1R = OneR(type~.,data = mushrooms_train)
mushroom_1R # odor feature was selected for rule generation
table(mushrooms$type,mushrooms$odor)

mushroom_1R_caret = OneR(type~.,data = mushrooms_train_caret)
mushroom_1R_caret


# Step 4: Evaluating model performance 
mushrooms_pred = predict(mushroom_1R,mushrooms_test)
CrossTable(mushrooms_test$type, mushrooms_pred, prop.chisq = F, prop.c = F, prop.r = F, dnn = c("actual type","predicted type"))
summary(mushroom_1R)

mushrooms_pred_caret = predict(mushroom_1R_caret,mushrooms_test_caret)
CrossTable(mushrooms_test_caret$type, mushrooms_pred_caret, prop.chisq = F, prop.c = F, prop.r = F, dnn = c("actual type","predicted type"))
summary(mushroom_1R_caret)



# Step 5: Improving model performance: JRip(), a Java-based implementation of the RIPPER rule learning algorithm
mushroom_JRip = JRip(type~., data = mushrooms_train)
mushroom_JRip

mushroom_JRip_caret = JRip(type~., data = mushrooms_train_caret)
mushroom_JRip_caret

mushroom_JRip_pred = predict(mushroom_JRip, mushrooms_test)
mushroom_JRip_pred_caret = predict(mushroom_JRip_caret, mushrooms_test_caret)

CrossTable(mushrooms_test$type, mushroom_JRip_pred, prop.chisq = F, prop.c = F, prop.r = F, dnn = c("actual type","predicted type"))
CrossTable(mushrooms_test_caret$type, mushroom_JRip_pred_caret, prop.chisq = F, prop.c = F, prop.r = F, dnn = c("actual type","predicted type"))








