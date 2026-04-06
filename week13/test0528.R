library("dplyr")
library("rstatix")
library("ggpubr")
library("pastecs")
library("multcomp")
library("compute.es")
library("broom")

  ### [ Step.1 ] Data Loading 
  # → Loading the dataset
  gogglesData<-read.csv("goggles.csv", header = TRUE)
  gogglesData$alcohol<-factor(gogglesData$alcohol, levels = c("None", "2 Pints","4 Pints"))
  gogglesData %>% head(5)
  
  ### [ Step.2 ] Check assumptions
  #----- (a) Outliers -----#
  gogglesData %>% 
    group_by(gender, alcohol) %>% 
    identify_outliers(attractiveness)
  #----- (b) Normality -----#
  gogglesData %>% 
    group_by(gender, alcohol) %>% 
    shapiro_test(attractiveness)
  #----- (c) Homogeneity of Variance -----#
  gogglesData %>% 
    group_by(gender) %>% 
    levene_test(attractiveness ~ alcohol)
  
  ### [ Step.3-1 ] ANOVA
  
  gogglesModel<-anova_test(attractiveness ~ gender + alcohol + gender:alcohol, 
                           data = gogglesData, detailed = TRUE)
  gogglesModel