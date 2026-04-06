library(tidyverse)
library(ggplot2)
library(readxl)
library(tidyr)
library(car)
library(dplyr)

# Import Data
data <- read_excel("Score_FinalReport.xlsx")

data_long <- data %>%
  gather(key = "state", value = "score", F_total,C_total,E_total,M_total)

# Visualize the data
ggboxplot(data_long, x = "state", y = "score", add = "jitter") +
  stat_compare_means(paired = TRUE)

# Wilcoxon Signed Rank Test
pairwise_wilcox_test(data_long, score ~ state, paired = TRUE, p.adjust.method = "bonferroni")