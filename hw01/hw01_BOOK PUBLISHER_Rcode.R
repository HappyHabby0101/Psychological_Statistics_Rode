#  BOOK PUBLISHER
# Import Data
data_03 <- read.table("FieldBook.dat", header = TRUE, sep = "\t")

# Presentation of Data Organization
library(tidyr)
data_03_long <- tidyr::gather(data_03, Book, Score)

library(dplyr)
summary_data_03 <- data_03_long %>%
  group_by(Book) %>%
  summarise(mean = mean(Score), sd = sd(Score))

# Plot the happiness level 
library(ggplot2)
p <- ggplot(summary_data_03, aes(x = Book, y = mean)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), 
                position = position_dodge(width = 0.9), 
                width = 0.25, 
                size = 0.7) + #outlook of error bar
  labs(x = "Book", y = "Mean Score") +
  theme_minimal() #make pic clear

print(p)









