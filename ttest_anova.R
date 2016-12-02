### t-test, prop.test, anova
a = data.frame(
    Sabor =
        c(5, 7, 3,
          4, 2, 6,
          5, 3, 6,
          5, 6, 0,
          7, 4, 0,
          7, 7, 0,
          6, 6, 0,
          4, 6, 1,
          6, 4, 0,
          7, 7, 0,
          2, 4, 0,
          5, 7, 4,
          7, 5, 0,
          4, 5, 0,
          6, 6, 3
        ),
    Tipo = factor(rep(c("A", "B", "C"), 15)),
    Provador = factor(rep(1:15, rep(3, 15))),
    TT = c(rep(c("M","N"),22),"M"))

# t-test
tapply(a$Sabor,a$TT,mean)
t.test(Sabor~TT,data=a)

# anova: It is a generalized version of a t-test that checks whether the means between groups (page variants) are equal or not
# The Null Hypothesis in ANOVA is that all means between groups are equal
# Groups are independent – each customer is presented with only one variant of the page.
# Residuals are normal – the metric is normally distributed in each group. This is because ANOVA utilizes linear regression under-the-hood.
# Variance of the metric is equal between groups – this property is also called Homoscedasticity and is one of the most troublesome requirements of ANOVA.

tapply(a$Sabor,a$Tipo,mean)
a1 = aov(a$Sabor~a$Tipo)
summary(a1)
TukeyHSD(x=a1,'a$Tipo',conf.level = 0.95)
plot(a1)

# A more concrete example
library(pwr)
pwr.anova.test(k=4,f=0.1,sig.level=0.05,power=0.9) # n=355

# Homoscedasticity
boxplot(a$Sabor~a$Tipo)
# null hypotheses is the variance are equal between groups
bartlett.test(a$Sabor~a$Tipo) # p-value is 0.2

# aov: one-way anova, using a single grouping variable
dataAOV = aov(a$Sabor~a$Tipo)
summary(dataAOV) # p-value is small, reject the null hypothesis that all means are equal
TukeyHSD(dataAOV)

# dealing with heteroscedastic data
oneway.test(a$Sabor~a$Tipo)

# for non-normality distributed data
kruskal.test(a$Sabor~a$Tipo)

# prop.test
prop.test(c(50,100),c(200,800))










