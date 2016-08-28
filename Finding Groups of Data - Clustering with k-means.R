# Finding teen market segments using k-means clustering
# Step 1: Collecting Data
# unnamed 30000 high school students profile on SNS
# dataset: how many times each word appear in the person's SNS profile

# Step 2: Exploring and preparing the data
teens = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/snsdata.csv")
str(teens)
table(teens$gradyear) # distribute evenly among grades
table(teens$gender, useNA = "ifany") # Include the number of NAs
summary(teens$age) # min age =3, max age = 106. Need to clean the data before moving on
teens$age = ifelse(teens$age >= 13 & teens$age < 20, teens$age, NA)
summary(teens$age)

# Data Preparation - dummy coding missing values
teens$female = ifelse(teens$gender == "F" & !is.na(teens$gender), 1, 0)
teens$no_gender = ifelse(is.na(teens$gender), 1, 0)
table(teens$gender, useNA = "ifany")
table(teens$female, useNA = "ifany")
table(teens$no_gender, useNA = "ifany")

# Data Preparation - Imputing missing values
# To fill the age, use the guess of graduation year
mean(teens$age,na.rm = T)
aggregate(data = teens, age ~ gradyear, mean, na.rm = T)
ave_age = ave(teens$age, teens$gradyear, FUN = function(x) mean(x, na.rm = T))
teens$age = ifelse(is.na(teens$age), ave_age, teens$age)
summary(teens$age)


# Step 3: Training a model on the data
library(stats)
interests = teens[,5:40]
# standardize the data before building the model
interests_z = as.data.frame(lapply(interests,scale))

# k = 5
teen_cluster = kmeans(interests_z, 5)


# Step 4: Evaluating model performance
# Check the size in each cluster
teen_cluster$size
# examine the centers
teen_cluster$centers

# Step 5: Improving model performance
# Add cluster to the original dataset
teens$cluster = teen_cluster$cluster
teens[1:5,c("cluster", "gender", "age", "friends")]
aggregate(data = teens, age ~ cluster, mean)
aggregate(data = teens, female ~ cluster, mean)
aggregate(data = teens, friends ~ cluster, mean)













