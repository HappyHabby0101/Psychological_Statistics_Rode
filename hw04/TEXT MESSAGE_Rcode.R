library("dplyr")
library("rstatix")
library("ggpubr")
library("pastecs")
library("compute.es")
library("emmeans")
library("multcomp")
library("agricolae")

# 1. Import and Restructure Data
data <- read.table("TextMessages.dat", header = TRUE, sep = "\t")
# Convert the data to long format
data_long <- data %>%
  pivot_longer(cols = c(Baseline, Six_months), 
               names_to = "Time", 
               values_to = "Score") %>%
  mutate(Subject = rep(paste0("S", 1:50), each = 2))

# 2. Check Normality
data_long %>% 
  group_by(Group,Time) %>% 
  shapiro_test(Score)

# 3. Two-way Repeated ANOVA
# Perform repeated-measures ANOVA
repeated_anova_result <- aov(Score ~ Group * Time + Error(Subject/Time), data = data_long)
summary(repeated_anova_result)

# 4.  Post-hoc tests
pwc <- data_long %>%
    group_by(Group) %>%
    pairwise_t_test(Score ~ Time, paired = TRUE, p.adjust.method='bonferroni')
pwc
