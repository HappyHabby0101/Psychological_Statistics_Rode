library("dplyr")
library("rstatix")
library("ggplot2")
library("car")
library("performance")
library("QuantPsyc")
library("boot")

data <- read.table("ChildAggression.dat", header = TRUE)
attach(data)

model <- lm(Aggression ~ Parenting_Style + Television + Diet + Computer_Games + 
              Sibling_Aggression, data = data)
summary(model)

# Create scatter plot for Parenting Style
ggplot(data, aes(x = Parenting_Style, y = Aggression)) +
  geom_point() +
  labs(x = "Parenting Style", y = "Aggression") +
  ggtitle("Scatter Plot of Parenting Style vs. Aggression")

# Create scatter plot for Television
ggplot(data, aes(x = Television, y = Aggression)) +
  geom_point() +
  labs(x = "Television", y = "Aggression") +
  ggtitle("Scatter Plot of Television vs. Aggression")

# Create scatter plot for Diet
ggplot(data, aes(x = Diet, y = Aggression)) +
  geom_point() +
  labs(x = "Diet", y = "Aggression") +
  ggtitle("Scatter Plot of Diet vs. Aggression")

# Create scatter plot for Computer Games
ggplot(data, aes(x = Computer_Games, y = Aggression)) +
  geom_point() +
  labs(x = "Computer Games", y = "Aggression") +
  ggtitle("Scatter Plot of Computer Games vs. Aggression")

# Create scatter plot for Sibling Aggression
ggplot(data, aes(x = Sibling_Aggression, y = Aggression)) +
  geom_point() +
  labs(x = "Sibling Aggression", y = "Aggression") +
  ggtitle("Scatter Plot of Sibling Aggression vs. Aggression")
