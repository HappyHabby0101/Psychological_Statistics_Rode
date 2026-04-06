library("dplyr")
library("rstatix")
library("ggpubr")
library("pastecs")
library("compute.es")
library("emmeans")
library("multcomp")
library("agricolae")

### [ Step.1 ] Load data
libido <- c(3,2,1,1,4,5,2,4,2,3,7,4,5,3,6)
dose <- gl(3,5, labels = c("Placebo", "Low Dose", "High Dose"))
viagraData <- data.frame(dose, libido)

### [ Step.2 ] Check assumptions

#----- (a) Outliers -----#
viagraData %>% 
  group_by(dose) %>% 
  identify_outliers(libido)

#----- (b) Normality -----#
viagraData %>% 
  group_by(dose) %>% 
  shapiro_test(libido)

#----- (c) Homogeneity of Variance -----#
viagraData %>% 
  levene_test(libido ~ dose)

### [ Step.3-1 ] ANOVA 
viagraModel <- aov(libido~dose, data = viagraData)
#viagraModel_lm<-lm(libido~dose, data = viagraData)
summary(viagraModel)
summary.lm(viagraModel)
par(mfrow=c(2,2))
plot(viagraModel)