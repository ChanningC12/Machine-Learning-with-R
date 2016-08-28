# global.r
# Defining a dummy dataframe for the sake of demo
# The dataset/objects/variables from global.r is accessible to both the server.r and ui.r
# placed in the working directory
# creating dataframe object with 3 variables namely, Year, Month & Person name
# this dataframe might not make sense but just for example

data = data.frame(Year=c("2002","2003","2004","2003","2001","2002","2001"),
                  Month=c("Jan","Feb","Mar","Jan","Dec","Jan","Nov"),
                  Name=c("Sam","Paul","James","Ana","Rose","Juan","Tim"), 
                  row.names=NULL, stringsAsFactors = F
                  )