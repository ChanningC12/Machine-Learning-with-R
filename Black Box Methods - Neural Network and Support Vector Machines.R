# ANN: Artificial Neural Network, models the relationship between a set of input signals and an output signal
# Topology, determines complexity. 1. Number of layers. 2. Whether allowed to travel backward. 3. The number of nodes within each layer
# Backpropagation method

# Modeling the strength of concrete with ANNs

# Step 1: Collecting data
# 1030 examples of concrete, with 8 features describing the components used in the mixture

# Step 2: Exploring and preaparing the data
concrete = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/concrete.csv")
View(concrete)
dim(concrete)
str(concrete)

# Neural networks work best when the input data are scaled to a narrow range around 0
# Standardization, scale(). When the data follow a bell-shaped curve (a normal distribution)
# Normalization, when the data follow a uniform distribution or are severely non-normal

# define the normalize function
normalize = function(x) {
    return((x-min(x))/(max(x)-min(x)))
}

# normalize the concrete data
concrete_normal = as.data.frame(lapply(concrete,normalize))
summary(concrete_normal)

# train the data (the csv was already sorted in random order)
concrete_rand = concrete_normal[order(runif(nrow(concrete_normal))),]
concrete_train = concrete_rand[1:floor(0.75*nrow(concrete_rand)),]
concrete_test = concrete_rand[ceiling(0.75*nrow(concrete_rand)):nrow(concrete_rand),]

# examine the train and test set
summary(concrete_train)
summary(concrete_test)


# Step 3: Training a model on the data
# use multilayer feedforward neural network in neuralnet package (other packages: nnet, RSNNS)
library(grid)
library(neuralnet)

# train the simplest multilayer feedforward network with only a single hidden node
concrete_model = neuralnet(strength ~ cement + slag + ash + water + superplastic + coarseagg + fineagg + age, data = concrete_train)
str(concrete_model)
# visualize the network topology
plot(concrete_model)

# Step 4: Evaluating model performance
# compute() function to generate predictions on the testing dataset
model_results = compute(concrete_model, concrete_test[1:8])
# returns a list with two components: $neurons, stores the neurons for each layer in the network. $net.results, stores the predicted values
predicted_strength = model_results$net.result

# for numeric prediction problems, no confusion matrix, but needs to measure the correlation between the predicted value and the true value
cor(predicted_strength, concrete_test$strength) 

# Step 5: Improving model performance
# increase the number of hidden nodes
concrete_model2 = neuralnet(strength ~ cement + slag + ash + water + superplastic + coarseagg + fineagg + age, data = concrete_train, hidden = 5)
plot(concrete_model2)
model_results2 = compute(concrete_model2, concrete_test[1:8])
predicted_strength2 = model_results2$net.result
cor(predicted_strength2,concrete_test[,"strength"]) # cor(predicted_strength2,concrete_test[,9])





# Support Vector Machine
# A surface that defines a boundary between various points of data which represents exmaple plotted in to create flat boundary - hyperplane
# SVM cn be used in any type of learning task but is most easily understood when used for binary classification

# Maximum Margin Hyperplane: the line that leads to the greatest separation will generalize the best of future data
# Support Vectors: are points from each class that are closet to the MMH

# Kernel: adding new features that express mathematical relationshops between measured characteristics
# switch the dimension and transform non-linear to linearly separable - new perspective of data


# Performing OCR (Optical Character Recognition) with SVMs, Image Processing
# Step 1: Collecting Data
# contains 20000 examples of 26 English alphabet capital letters as printed using 20 different randomly reshaped and distorted black and white fonts

# Step 2: Exploring and preparing the data
letters = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/letterdata.csv")
View(letters)
dim(letters)
str(letters)
# SVM learners require all features to be numeric
# Rescale(automatically performed when fitting SVM model)

# Divide into train dataset and test dataset
prop.table(table(letters$letter))
letters_train = letters[1:16000,]
letters_test = letters[16001:20000,]
prop.table(table(letters_train$letter))
prop.table(table(letters_test$letter))

# Step 3: Training a model on the data, e1071 package (klaR, kernlab)
library(kernlab)
letter_classifier = ksvm(letter ~ ., data = letters_train, kernal = "vanilladot") # linear kernel function
letter_classifier


# Step 4: Evaluating model performance
letter_predictions = predict(letter_classifier, letters_test) # return a predicted letter for each row of values in the testing data
head(letter_predictions)
head(letters_test$letter)
table(letter_predictions,letters_test$letter)
# library(gmodels)
# CrossTable(letters_test$letter, letter_predictions, prop.chisq = F, prop.c = F, prop.r = F, dnn = c("actual","predicted") )

agreement = letter_predictions == letters_test$letter # return a vector of T or F values indicating whether the model's predicted letter agrees with the actual letter in the test dataset
table(agreement)
prop.table(table(agreement))


# Step 5: Improving model performance
# Gaussian RBF kernel
letter_classifier_rbf = ksvm(letter ~ ., data = letters_train, kernel = "rbfdot")
letter_predictions_rbf = predict(letter_classifier_rbf, letters_test)
agreement_rbf = letter_predictions_rbf == letters_test$letter
table(agreement_rbf)
prop.table(table(agreement_rbf))
































