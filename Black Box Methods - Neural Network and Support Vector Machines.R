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






































