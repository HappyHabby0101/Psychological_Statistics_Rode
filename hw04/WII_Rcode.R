library("dplyr")
library("rstatix")
library("ggpubr")
library("pastecs")
library("compute.es")
library("emmeans")
library("multcomp")
library("agricolae")

# 1.Import Data
data <- read.table("Wii.dat", header= TRUE, sep = '\t')

# 2.Check Normality and Homogeneity of Variance
# 2-1.Normality
data %>% 
  group_by(athlete, stretch) %>% 
  shapiro_test(injury)
# 2-2.Homogeneity of Variance
leveneTest(data$injury, 
           interaction(data$athlete, data$stretch), center = median)

# 3. Kruskal-Wallis test and  Post-hoc Tests
# 3.1 Athlete / Non-Athlete Group
kruskal.test(injury ~ athlete, data = data)
wilcox_test(data, injury ~ athlete, p.adjust.method = "bonferroni")
# 3.2 Stretch / No Stretch Group
kruskal.test(injury ~ stretch, data = data)
wilcox_test(data, injury ~ stretch, p.adjust.method = "bonferroni")

# 4. Effect Size
data %>% kruskal_effsize(injury ~ athlete)
data %>% kruskal_effsize(injury ~ stretch)