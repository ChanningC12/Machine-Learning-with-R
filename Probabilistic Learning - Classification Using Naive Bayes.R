# Naive Bayes
# uses data about prior events to estimate the probablity of future events

# Bayes' theorem 
# P(A|B) = (P(B|A)*P(A)) / P(B)
# P(A|B)*P(B) = P(B|A)*P(A)

# Naive Bayes algorithm describes a simple application using Bayes' theorem for classification

# Laplace estimator: adds a small number to each of the counts in the frequency table, which ensures that each feature has a nonzero probablity of occurring with each class
# Typically set to 1.