library("dplyr")
library("rstatix")
library("ggplot2")
library("car")
library("performance")
library("QuantPsyc")
library("boot")

data <- read.csv("CAQ_orig_flu.csv")
attach(data)
data %>% get_summary_stats(type = "mean_sd")

# Calculate the correlation coefficient between CAQ scores and AUT fluency.
model <- lm(CAQ.scores ~Fluency)
summary(model)

# Calculate the correlation coefficient between CAQ scores and AUT originality.
model <- lm(CAQ.scores ~Fluency)
summary(model)

high_data <- data[data$CAQ_scores > 4.2, ]