library("tidyverse")
library("rstatix")
library("effsize")
library("ggplot2")
library("ggpubr")
# 1. Data preparation
Publisher <- read.delim("FieldBook.dat")
Publisher <- Publisher %>% mutate(diff=women-statbook)

# 2. Explore the data: check distributional assumptions
pastecs::stat.desc(Publisher$diff, basic = FALSE, desc = FALSE, norm = TRUE)

# 3.Compute the paired test
(Paired.test <- t.test(Publisher$women, Publisher$statbook, paired = TRUE))

# 4. Calculate the effect size.
effsize::cohen.d(Publisher$women, Publisher$statbook, paired=TRUE)

