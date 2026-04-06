# INFIDELITY
# Import Data
data <- read.csv("Infidelity.csv")

# Combine "Partner" and "Self" into "Target"
library(tidyr)
data_long <- tidyr::gather(data, Target, Score, -Gender,-X)

# Calculate Mean and Std. of "Gender" and "Target"
library(dplyr)
summary_data <- data_long %>% #input "data_long"
  group_by(Gender, Target) %>% #grouping
  summarise(mean = mean(Score), sd = sd(Score))

# Plot
# dodge:The bars representing different types will be displayed side by side.

library(ggplot2)
p <- ggplot(summary_data, aes(x = Gender, y = mean, fill = Target)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), 
                position = position_dodge(width = 0.9), 
                width = 0.25, 
                size = 0.7) + #outlook of error bar  
  labs(x = "Gender", y = "Mean score", fill = "Target") +
  theme_minimal() #make pic clear

print(p)