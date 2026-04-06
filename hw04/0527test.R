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
  summary(viagraModel)

  
  
  ### [ Step.3-2 ] Post-hoc Tests 
  #--- (b) Pairwise comparisons ---#
  pairwise.t.test(viagraData$libido, viagraData$dose, p.adjust.method = "bonferroni")
  
  
  ### [ Step.4 ] Effect size
  
  omega<-function(SSm, SSr, dfm, MSr)
  {
    SSt = SSm + SSr
    omega = (SSm-(dfm*MSr))/(SSt+MSr)
    print(paste("Omega-Squared: ", omega))
  }
  omega(20.133, 23.600, 2, 1.9667)
  omega(450.66,38.09, 5, 0.334)
  omega(4180.6, 4356.6, 3, 167.56)
  
  ### [ Step.5 ] Visualization
  ggplot(viagraData, aes(x = dose, y = libido)) + geom_boxplot() +
  labs(x = "Dosage of Viagra", y = "Mean Libido")