library("dplyr")
library("rstatix")
library("ggplot2")
library("car")
library("performance")
library("QuantPsyc")
library("boot")

data <- read.table("Supermodel.dat", header = TRUE)
attach(data)
model <- lm(SALARY ~ AGE + YEARS + BEAUTY, data = data)
summary(model)

ggplot(data, aes(x = AGE, y = SALARY)) +
  geom_point() +
  labs(x = "Age", y = "Salary") +
  ggtitle("Scatter plot of Age vs. Salary")

ggplot(data, aes(x = YEARS, y = SALARY)) +
  geom_point() +
  labs(x = "Years in Modeling", y = "Salary") +
  ggtitle("Scatter plot of Years in Modeling vs. Salary")