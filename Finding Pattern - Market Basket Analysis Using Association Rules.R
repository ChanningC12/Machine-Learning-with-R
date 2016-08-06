# The Apriori Algorithm for Association Rule Learning
# All subsets of a frequent itemset must also be frequent -- Apriori Property
# For example, the set {motor oil, lipstick} can only be frequent if both {motor oil} and {lipstick} occur frequently

# Support and Confidence
# Support measures how frequently the itemset occurs in the data
# Support can be calculated for any itemset, or even a single item. Support(X) = count(X) / N

# Confidence: Confidence(X - Y) = Support(X, Y) / Support(X)
# The confidence tells us the proportion of transactions where the presence of item or itemset X results in the presence of item or itemset Y

# Step 1: Collecting Data
# 9835 transactions, about 327 transactions per day

# Step 2: Exploring and Preparing the Data
library(arules)
# read.transactions() is similar to read.csv but returns in sparse matrix
groceries = read.transactions("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/groceries.csv", sep=",")
summary(groceries) # each cell is 1 if purchased in a certain transaction (row), 0 otherwise
# density means non-zero matrix cell

# inspect() to look at the content of the sparse matrix
inspect(groceries[1:5]) # see the first five purchases

# itemFrequency() function allows to see the proportion of transactions that contain the item
itemFrequency(groceries[,1:3])
itemFrequency(groceries[,"whole milk"])

# Visualizing item support - item frequency plot
# itemFrequencyPlot()
itemFrequencyPlot(groceries, support = 0.1) # visualize items that have at least 0.1 support
itemFrequencyPlot(groceries, topN = 20) # set TopN

# Visualizing transactional data - Plotting the sparse matrix
# image() function
image(groceries[1:5]) 
image(sample(groceries,100))


# Step 3: Training a Model
apriori(groceries) # default support = 0.1, confidence = 0.8, minlen = 1
groceryrule = apriori(groceries, parameter = list(support = 0.006, confidence = 0.25, minlen = 2))
groceryrule # 463 rules are generated


# Steo 4: Evaluating model performance
summary(groceryrule)
# Lift (X - Y) = Confidence (X - Y) / Support (Y)
# Lift is a measure of how much more likely one item is to be purchased relative to its typical purchase rate, given that you know another item has been purchased
# A large lift value is a strong indicator that a rule is important

# View the first three rules
inspect(groceryrule[1:3])
# If a customer buys pot plants, they will also buy whole milk


# Step 5: Improving Model Performance
# Sorting the set of association rules
inspect(sort(groceryrule, by = "lift")[1:5])
# Taking subsets of association rules
berryrules = subset(groceryrule, items %in% "berries")
inspect(sort(berryrules, by = "lift"))

# Save the association rules to a file or data frame
write(groceryrule, file = "Desktop/groceryrule.csv", sep = ",", quote = T, row.names = F)
# Convert to R data frame
groceryrule_df = as(groceryrule, "data.frame")
str(groceryrule_df)























