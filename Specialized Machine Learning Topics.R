# Getting data from the Web with the RCurl package
library(RCurl)
# download a page
webpage = getURI("http://www.packtpub.com/") # save the full text of the Packt Publishing's homepage
str(webpage)

# Reading and Writing XML with the XML package

# Reading and writing JSON with the rjson package

# Reading and writing Microsoft Excel spreadsheets using xlsx

# Working with social network data and graph data: network package; sna package


# Improving the performance of R
# 1. make data frames faster with data.table
# 2. create disk-based data frames with ff. ffdf strucure.
# 3. use massive matrices with bigmemory. bigalgebra, biganalytics and bigtabulate

# Measure execution time
system.time(rnorm(10000))
