 # Convert text data into numerical
survey = data.frame(service = c("very unhappy", "unhappy", "neutral", "happy", "very happy"))
survey
# add a rank variable
survey = data.frame(service = c("very unhappy", "unhappy", "neutral", "happy", "very happy"), rank = c(1,2,3,4,5))

# does half way of the level makes general sense? need more precise way to transform these into numbers
library(caret)
customers = data.frame(id = c(10, 20, 30, 40, 50), gender = c("male",rep("female",2), "male", "female"),
                       mood = c(rep(c("happy","sad"),2),"happy"), outcome = c(1,1,0,0,0))
customers
str(customers)

dmy = dummyVars("~ .", data = customers) # ~ gender 
trsf = data.frame(predict(dmy, newdata = customers))
trsf
str(trsf)

# fullRank = T will only display n-1 level of category
dmy_fr = dummyVars("~ .", data = customers, fullRank = T)
trsf_fr = data.frame(predict(dmy_fr, newdata = customers))
trsf_fr

# Practice with the survey data
survey_dmy = dummyVars("~.", data = survey, fullRank = T)
survey_dmy_dt = data.frame(predict(survey_dmy, newdata = survey))
