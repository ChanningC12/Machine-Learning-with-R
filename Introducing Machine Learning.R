# Machine Learning: The field of study interested in the development of computer algorithms for transforming data into intelligent action
# Data Mining: A closely related sibling of machine learning, data mining is concerned with the generation of novel insight from large databases. Search hidden nuggets of information

# Steps to apply Machine Learning:
# 1. Collect Data
# 2. Exploring and preparing Data
# 3. Training a model on the data
# 4. Evaluate model performance
# 5. Improving model performance

# Chapter 2
# Exploring and Understanding Data
setwd("../")
getwd()
setwd("Desktop/")

usedcars = read.csv("Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/usedcars.csv",stringsAsFactors = F)
str(usedcars)
summary(usedcars$year)
summary(usedcars[c("price","mileage")])
range(usedcars$price)
diff(range(usedcars$price))
# Q3 - Q1
IQR(usedcars$price)
quantile(usedcars$price)
quantile(usedcars$price,seq(from=0,to=1,by=0.1))

# boxplot
par(mfrow=c(1,2))
boxplot(usedcars$price, main="Boxplot of Used Car Prices",ylab="Price($)")
boxplot(usedcars$mileage,main="Boxplot of Used Car Mileage",ylab="Odometer (mi.)")

# histogram
hist(usedcars$price,main="Histogram of Used Car Mileage",xlab="Odometer (mi.)")
hist(usedcars$mileage,main="Histogram of Used Car Mileage",xlab="Odometer (mi.)")

# var and sd
var(usedcars$price)
sd(usedcars$price)
var(usedcars$mileage)
sd(usedcars$mileage)


# exploring categorical variables
table(usedcars$year)
table(usedcars$model)
table(usedcars$color)
prop.table(table(usedcars$model))
round(prop.table(table(usedcars$color))*100,1)

# scatter plot
par(mfrow=c(1,1))
plot(x=usedcars$mileage,y=usedcars$price,main="Scatterplot of Price vs. Mileage",xlab="Used Car Odometer (mi.)",ylab="Used Car Price ($)")

library(gmodels)
usedcars$conservative = usedcars$color %in% c("Black","Gray","Silver","White") # %in% return to T or F
table(usedcars$conservative)
CrossTable(x=usedcars$model,y=usedcars$conservative)
