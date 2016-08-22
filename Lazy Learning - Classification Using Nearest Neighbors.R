# Classifying unlabeled examples by assigning them the class of the most similar labeled examples

# Nearest neighbors requires a distance function
# Euclidean distance - shortest direct route; Manhattan distance - pedestrian path

# Choose an appropriate k, the model always predicts the majority class

# Rescale features for kNN
# 1. min-max normalization (Xnew = (X-min(X))/(max(X)-min(X)))
# 2. z-score standardization

# Explore and preparing the data
wbcd = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/wisc_bc_data.csv", stringsAsFactors = F)
head(wbcd)
View(wbcd)
str(wbcd)
dim(wbcd)

# exclude the ID
wbcd = wbcd[-1]
table(wbcd$diagnosis)
round(prop.table(table(wbcd$diagnosis))*100,1)

# convert the diagnosis into factor
wbcd$diagnosis = factor(wbcd$diagnosis, levels = c("B","M"), labels = c("Benign","Malignant"))

summary(wbcd[c("radius_mean","area_mean","smoothness_mean")])
# need to rescale, apply normalization

# Transformation - normalizing numeric data
normalize = function(x) {
    return ((x-min(x))/(max(x)-min(x)))
}
normalize(c(1,2,3,4,5))

# lapply() function of R takes a list and applies a function to each element of the list
wbcd_n = as.data.frame(lapply(wbcd[2:31],normalize))
summary(wbcd_n$area_mean)



# Data preparation - creating training and test datasets
wbcd_train = wbcd_n[1:469,]
wbcd_test = wbcd_n[470:569,]

# when constructing the training and testing data, we exclude the target variable
wbcd_train_labels = wbcd[1:469,1]
wbcd_test_labels = wbcd[470:569,1]
# we will use these in the next steps of training and evaluating our classifier


# Training a model on the data
library(class)
wbcd_test_pred = knn(wbcd_train, wbcd_test, wbcd_train_labels, k=21)


# Evaluating model performance
library(gmodels)
CrossTable(x = wbcd_test_labels, y = wbcd_pred, prop.chisq = F)


# Improving the performance - use standardization; try different k
wbcd_z = as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)
# divide into train and test
wbcd_train = wbcd_z[1:469,]
wbcd_test = wbcd_z[470:569,]
wbcd_train_labels = wbcd[1:469,1]
wbcd_test_labels = wbcd[470:569,1]
wbcd_test_pred = knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=21)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq = F)

# Testing alternative values of k





















