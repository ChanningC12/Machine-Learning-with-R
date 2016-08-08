# Ensembles
library(caret)
names(getModelInfo())

# Read in the data
library(RCurl)
urlData = getURL('https://raw.githubusercontent.com/hadley/fueleconomy/master/data-raw/vehicles.csv')
vehicles = read.csv(text = urlData)
dim(vehicles)
View(vehicles)
str(vehicles)

# clean up the data and only use the first 24 columns
vehicles = vehicles[names(vehicles)[1:24]]
vehicles = data.frame(lapply(vehicles,as.character),stringsAsFactors = F)
vehicles = data.frame(lapply(vehicles,as.numeric))
vehicles[is.na(vehicles)] = 0
vehicles$cylinders = ifelse(vehicles$cylinders == 6, 1, 0)

prop.table(table(vehicles$cylinders))
names(vehicles) # use all the variables to predict cylinders

# divide into ensemble/blender/testing
set.seed(1234)
vehicles = vehicles[sample(nrow(vehicles)),] # reorder the rows
split = floor(nrow(vehicles)/3)
ensembleData = vehicles[0:split,]
blenderData = vehicles[(split+1):(split*2),]
testingData = vehicles[(split*2+1):nrow(vehicles),]

labelName = "cylinders"
predictors = names(ensembleData)[names(ensembleData) != labelName]
predictors

# caret
# crossvalidate 3 times
myControl = trainControl(method = "cv", number = 3, repeats = 1, returnResamp = "none") # trainControl defines the best parameters for the model 
# train the ensemble model
model_gbm = train(x = ensembleData[,predictors],y = ensembleData[,labelName], method = "gbm", trControl = myControl)
model_rpart = train(x = ensembleData[,predictors],y = ensembleData[,labelName], method = "rpart", trControl = myControl)
model_treebag = train(x = ensembleData[,predictors],y = ensembleData[,labelName], method = "treebag", trControl = myControl)

# use these three models to predict belender dataset and testing dataset, added probablities predicted by the model as columns
blenderData$gbm_PROB = predict(object = model_gbm, blenderData[,predictors])
blenderData$rf_PROB = predict(object = model_rpart, blenderData[,predictors])
blenderData$treebag_PROB = predict(object = model_treebag, blenderData[,predictors])

testingData$gbm_PROB = predict(object = model_gbm, testingData[,predictors])
testingData$rf_PROB = predict(object = model_rpart, testingData[,predictors])
testingData$treebag_PROB = predict(object = model_treebag, testingData[,predictors])

predictors = names(blenderData)[names(blenderData) != labelName]
final_blender_model = train(blenderData[,predictors],blenderData[,labelName],method = 'gbm',trControl = myControl)

preds = predict(object = final_blender_model, testingData[,predictors])
library(pROC)
auc = roc(testingData[,labelName],preds)
auc # 0.9949














