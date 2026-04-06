library(tidyverse)
library(ggplot2)
library(readxl)
library(tidyr)
library(car)
library(dplyr)
library(ggpubr)
library(rstatix)

# Import Data
data <- read_excel("Score_FinalReport.xlsx")

data_long <- data %>%
  gather(key = "state", value = "score", F_total,C_total,E_total,M_total)

# Visualization
ggplot(data_long, aes(x = state, y = score, fill = state)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = 0.5) +
  labs(title = "Distribution of Test Scores by State",
       x = "State",
       y = "Test Score") +
  theme_minimal()

# Perform Wilcoxon signed-rank test
classic_p_value <- wilcox.test(data$F_total, data$C_total, paired = TRUE, alternative = "less")$p.value
electronic_p_value <- wilcox.test(data$F_total, data$E_total, paired = TRUE, alternative = "less")$p.value
metal_p_value <- wilcox.test(data$F_total, data$M_total, paired = TRUE, alternative = "less")$p.value

# Filter Relax State
data_long_music <- data_long %>%
  filter(state != "F_total")

# Check Normality and Homogeneity of Variance
# Normality
data_long_music %>%
  group_by(state) %>% 
  shapiro_test(score)

# Homogeneity of Variance
data_long_music <- data_long_music %>%
  mutate(state = as.factor(state))
data_long_music %>% 
  levene_test(score ~ state)

#  K-W test
res.kruskal <- data_long_music %>% kruskal_test(score ~ state)
res.kruskal

# Post-hoc test
pairwise_t_test(data_long_music, score ~ state, paired = TRUE, p.adjust.method = "bonferroni")

# Effect Size
data_long_music %>% kruskal_effsize(score ~ state)

library(pwr)
effect_size <- 0.5
alpha <- 0.05
power <- 0.8

sample_size <- pwr.t.test(d = effect_size, sig.level = alpha, power = power, type = "paired", alternative = "two.sided")
sample_size

# Visualization
ggline(data_long_music, x = "state", y = "score", add = c("mean_se", "jitter")) +
  stat_compare_means(aes(label = ..p.adj..), method = "t.test", paired = TRUE)