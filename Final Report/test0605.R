library(tidyverse)
library(car)
library(reshape2)
library(readxl)
library(tidyr)

# Load Data
data <- read_excel("Alpha_psd.xlsx")

# Fill in Missing Values
data_filled <- data %>%
  mutate(
    relax_alpha = ifelse(is.na(relax_alpha), mean(relax_alpha, na.rm = TRUE), relax_alpha),
    classic_alpha = ifelse(is.na(classic_alpha), mean(classic_alpha, na.rm = TRUE), classic_alpha),
    ele_alpha = ifelse(is.na(ele_alpha), mean(ele_alpha, na.rm = TRUE), ele_alpha),
    metal_alpha = ifelse(is.na(metal_alpha), mean(metal_alpha, na.rm = TRUE), metal_alpha)
  )

data_long <- data_filled %>%
  gather(key = "Condition", value = "AlphaPower", relax_alpha:metal_alpha)
data_long$Condition <- as.factor(data_long$Condition)
data_long$Subject <- as.factor(data_long$Subject)
data_long$Channel <- as.factor(data_long$Channel)

# Normality
shapiro_results <- data_long %>%
  group_by(Condition) %>%
  summarise(p_value = shapiro.test(AlphaPower)$p.value)

# Homogeneity of Variance
levene_test <- levene_test(AlphaPower ~ Condition, data = data_long)

ggplot(data_long, aes(sample = AlphaPower)) +
  stat_qq() +
  stat_qq_line() +
  facet_wrap(~ Condition, scales = "free") +
  labs(title = "Q-Q Plots for Alpha Power by Condition") +
  theme_minimal()

res.kruskal_music <- data_long %>% kruskal_test(AlphaPower ~ Condition)
res.kruskal_music

effectsize_music <- data_long %>% kruskal_effsize(AlphaPower ~ Condition)
effectsize_music

res.kruskal_channel <- data_long %>% kruskal_test(AlphaPower ~ Channel)
res.kruskal_channel

effectsize_channel <- data_long %>% kruskal_effsize(AlphaPower ~ Channel)
effectsize_channel

posthoc_results <- pairwise.wilcox.test(data_long$AlphaPower, data_long$Channel, p.adjust.method = "bonferroni")

print(posthoc_results$p.value)




