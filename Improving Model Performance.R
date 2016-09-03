credit = read.csv("~/Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/credit.csv")
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

ctrl = trainControl(method="cv",number=10, selectionFunction = "oneSE") # create a control object named ctrl that uses 10-fold cross validation
# create a grid of parameters to optimize
grid = expand.grid(.model = "tree", .trials = c(1,5,10,15,20,25,30,35), .winnow = "FALSE")
grid # each row will be used to generate a candidate model for evaluation, built using that row's combination of model parameters

set.seed(300)
m = train(as.factor(default)~.,
          data = credit,
          method = "C5.0",
          metric = "Kappa", 
          trControl = ctrl,
          tuneGrid = grid
          )
m




# Ensemble: by combining multiple weaker learners, a stronger learner is created
# Training - Alocation Function - (M1, M2, M3) - Combination Function - Ensemble Model
# Stacking: using the predictions of several models to train a final arbiter model is known as stacking

# Bagging (bootstrap aggregating): bagging generates a number of training datasets by bootstrap sampling the original training data. These datasets are often used to generate a set of models using a single learning algorithms. The model's predictions are combined using voting (for classification) or averaging (for numeric prediction)
library(ipred)
set.seed(300)
mybag = bagging(as.factor(default)~.,data = credit, nbagg = 25) # nbagg parameter is used to control the number of decision trees voting in the ensemble
credit_pred = predict(mybag, credit)
table(credit_pred, credit$default)

# bagged trees with 10-fold CV
library(caret)
set.seed(300)
ctrl = trainControl(method = "cv", number = 10)
train(as.factor(default)~., data = credit, method = "treebag", trControl = ctrl)


# SVM
library(kernlab)
str(svmBag)
bagctrl = bagControl(fit=svmBag$fit, predict=svmBag$pred, aggregate=svmBag$aggregate) # fit (fit the model), predict (make predictions), aggregate (counting votes)
set.seed(300)
svmbag = train(as.factor(default)~.,data=credit,"bag",trControl=ctrl,bagControl=bagctrl)
svmbag

# Boosting, boosts the performance of weak learners to attain the performance of stronger learners

# Random Forest
library(randomForest)
# Building the classifier
set.seed(300)
rf = randomForest(as.factor(default)~., data = credit)
rf # out-of-bag error rate

# Evaluating random forest performance
ctrl = trainControl(method="repeatedcv", number=10, repeats=10)
grid_rf = expand.grid(.mtry=c(2,4,8,16))

set.seed(300)
m_rf = train(as.factor(default)~., data = credit, method = "rf", metric = "Kappa", trControl = ctrl, tuneGrid = grid_rf)

# compare that to a boosted tree using 10,20,30,40
grid_c50 <- expand.grid(.model = "tree",
                       .trials = c(10,20,30,40),
                       .winnow = "FALSE"
                       )
set.seed(300)
m_c50 = train(as.factor(default)~., data = credit, method = "C5.0", metric = "Kappa", trControl = ctrl, tuneGrid = grid_c50)

# compare two approaches side by side
m_rf
m_c50


















