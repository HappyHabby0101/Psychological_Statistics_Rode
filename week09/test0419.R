library("dplyr")
library("rstatix")
library("ggplot2")
library("car")
library("performance")
library("QuantPsyc")
library("boot")
library("magrittr")

### [ Step.1 ] Load data
reg <- read.csv("tannin.csv", header = TRUE)
attach(reg)
reg %>% get_summary_stats(type = "mean_sd")

### [ Step.3 (1)] Regression analysis: lm in Regression table
model <- lm(growth ~ tannin)
summary(model)

### [ Step.3 (2) ] Regression analysis: lm in ANOVA table
summary.aov(model)

### [ Step.5 (1) ] Visualization
par(mfrow=c(1,1))
plot(tannin,growth,pch=21,bg="gray")
abline(model,col="red")
lines(range, prdt[,2], col="gray80", lty=2)
lines(range, prdt[,3], col="gray80", lty=2)
polygon(c(rev(range), range), c(rev(prdt[ ,3]), prdt[ ,2]), col=rgb(1,0,0,0.1)