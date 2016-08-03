# Naive Bayes
# uses data about prior events to estimate the probablity of future events

# Bayes' theorem 
# P(A|B) = (P(B|A)*P(A)) / P(B)
# P(A|B)*P(B) = P(B|A)*P(A)

# Naive Bayes algorithm describes a simple application using Bayes' theorem for classification

# Laplace estimator: adds a small number to each of the counts in the frequency table, which ensures that each feature has a nonzero probablity of occurring with each class
# Typically set to 1

# Example - Filtering mobile phone spam with the naive Bayes algorithm
# Step 1: Collecting Data
# Step 2: Exploring and preparing the data
sms_raw = read.csv("Desktop/Github/Machine-Learning-with-R/Machine-Learning-with-R-datasets/sms_spam.csv", stringsAsFactors = FALSE)
View(sms_raw)
str(sms_raw)
# convert the type into factor
sms_raw$type = as.factor(sms_raw$type)
str(sms_raw)

# text mining package: tm
library(tm)
# create a corpus
sms_corpus = Corpus(VectorSource(sms_raw$text)) # Corpus() creates an R object to store text documents
# print(vignette("tm"))
print(sms_corpus)
# inspect() to view specific SMS messages
inspect(sms_corpus[1:3])

# perform some common cleaning steps in order to remove punctuation and other characters that may clutter the result
# convert all of the SMS messages to lowercase and remove any numbers
corpus_clean = tm_map(sms_corpus,tolower)
corpus_clean = tm_map(sms_corpus,removeNumbers)
# stop words: to, and, but, or
corpus_clean = tm_map(corpus_clean,removeWords,stopwords())
corpus_clean = tm_map(corpus_clean,removePunctuation)
# remove additional whitespace, leaving only a single space between words
corpus_clean = tm_map(corpus_clean, stripWhitespace)

# Tokenization: split the messages into individual components
# DocumentTermMatrix() will take a corpus and create a data structure called sparse matrix (rows of matrix indicate document, columns indicate terms)
# create a sparse matrix
sms_dtm = DocumentTermMatrix(corpus_clean)


# Data preparation - Creating training and test datasets (75%/25%)
sms_raw_train = sms_raw[1:4169,]
sms_raw_test = sms_raw[4170:5574,]

sms_dtm_train = sms_dtm[1:4169,]
sms_dtm_test = sms_dtm[4170:5574,]

sms_corpus_train = sms_corpus[1:4169]
sms_corpus_test = sms_corpus[4170:5574]

# compare the spam in the training and test data frames
prop.table(table(sms_raw_train$type))
prop.table(table(sms_raw_test$type))


# Visualizing text data - word clouds
# wordcloud package
library(RColorBrewer)
library(wordcloud)
wordcloud(sms_corpus_train, min.freq = 40, random.order = F)

spam = subset(sms_raw_train, type == "spam")
ham = subset(sms_raw_train, type == "ham")

par(mfrow=c(1,2))
wordcloud(spam$text,max.word=40,scale=c(3,0.5))
wordcloud(ham$text,max.word=40,scale=c(3,0.5))


# Data Preparation - creating indicator features for frequent workds
# Transform the sparse matrix into a data structure that can be used to train a naive Bayes classifier
# We will eliminate any words that appear in less than five SMS messages, or less than about 0.1 percent of records in the training data
# findFreqTerms()
findFreqTerms(sms_dtm_train,5) # display a character vector of the words appearing at least 5 times in the sms_dtm_train matrix
sms_train = DocumentTermMatrix(sms_corpus_train,list(dictionary=findFreqTerms(sms_dtm_train,5)))
sms_test = DocumentTermMatrix(sms_corpus_test,list(dictionary=findFreqTerms(sms_dtm_test,5)))

# Naive Bayes classifier is typically trained on data with categorical features
convert_counts = function(x) {
    x = ifelse(x>0,1,0)
    x = factor(x,levels=c(0,1),labels=c("No","Yes"))
    return(x)
}

# two matrix, each with factor type column indicating Yes or No for whether each column's word appears in the messages comprising the rows
sms_train = apply(sms_train, MARGIN = 2, convert_counts)
sms_test = apply(sms_test, MARGIN = 2, convert_counts)


# Training a model on the data
# e1071 package for Naive Bayes implementation
library(e1071)
sms_classifier = naiveBayes(sms_train,sms_raw_train$type) # the sms_classifier variable now contains a naiveBayes classifier object that can be used to make predictions


# Evaluating model performance
sms_test_pred = predict(sms_classifier,sms_test)

# comprare predicted value to the actual value
library(gmodels)
CrossTable(sms_test_pred,sms_raw_test$type,prop.chisq=F, prop.t=F, dnn=c("predicted","actual"))


# Improving model performance
sms_classifier2 = naiveBayes(sms_train, sms_raw_train$type, laplace = 1)
sms_test_pred2 = predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_raw_test$type, prop.chisq = F, prop.t = F, dnn = c("predicted","actual"))



















