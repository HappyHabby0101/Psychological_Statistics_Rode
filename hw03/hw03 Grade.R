library("dplyr")
library("rstatix")
library("ggplot2")
library("car")
library("performance")
library("QuantPsyc")
library("boot")

data <- read.table("EssayMarks.dat", header = TRUE, sep = "\t")
attach(data)
data %>% get_summary_stats(type = "mean_sd")

model <- lm(essay ~ hours )
summary(model)

