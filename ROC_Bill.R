ROC_Curve = data.frame(tag = c("A","B","A","A","B","B","A","B","A","A","A","B","B","A","B","B","A","A","B","B"),score = c(4,3,6,4,6,2,3,3,5,6,6,2,3,5,3,4,3,2,1,5))
ROC_Curve$C6 = ifelse(ROC_Curve$score>=6,"A","B")
ROC_Curve$C5 = ifelse(ROC_Curve$score>=5,"A","B")
ROC_Curve$C4 = ifelse(ROC_Curve$score>=4,"A","B")
ROC_Curve$C3 = ifelse(ROC_Curve$score>=3,"A","B")
library(caret)
table(ROC_Curve$C6,ROC_Curve$tag)
confusionMatrix(ROC_Curve$C6,ROC_Curve$tag,positive="A")
confusionMatrix(ROC_Curve$C5,ROC_Curve$tag,positive="A")
confusionMatrix(ROC_Curve$C4,ROC_Curve$tag,positive="A")
confusionMatrix(ROC_Curve$C3,ROC_Curve$tag,positive="A")


ROC_Curve = data.frame(tag = c("A","B","A","A","B","B","A","B","A","A","A","B","B","A","B","B","A","A","B","B"),
                       score = c(4,3,6,4,6,2,3,4,5,6,6,2,3,5,2,3,3,2,1,5))

# Aug 3rd
library(xlsx)
ROC_Curve = read.xlsx("Desktop/ListTag.xlsx",sheetIndex = 1, header = T)
names(ROC_Curve)
ROC_Curve$C6 = ifelse(ROC_Curve$Scores>=6,"T","F")
ROC_Curve$C5 = ifelse(ROC_Curve$Scores>=5,"T","F")
ROC_Curve$C4 = ifelse(ROC_Curve$Scores>=4,"T","F")
ROC_Curve$C3 = ifelse(ROC_Curve$Scores>=3,"T","F")
ROC_Curve
library(caret)
table(ROC_Curve$C6,ROC_Curve$Tags)
confusionMatrix(ROC_Curve$C6,ROC_Curve$Tags,positive="T")
confusionMatrix(ROC_Curve$C5,ROC_Curve$Tags,positive="T")
confusionMatrix(ROC_Curve$C4,ROC_Curve$Tags,positive="T")
confusionMatrix(ROC_Curve$C3,ROC_Curve$Tags,positive="T")




