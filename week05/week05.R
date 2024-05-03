library("pastecs")
library("car")
library("tidyverse")
library("rstatix")
library("effsize")
library("ggpubr")
library("PASWR")


### [ Example 6.8 ]  
E608<-data.frame(length=c(24.1, 22.9, 23.0, 26.1, 25.0, 30.8, 27.1, 23.2, 
                          22.8, 23.7, 24.6, 30.3, 23.9, 21.8, 28.1, 25.4, 31.2, 30.9))
# Question: Are the 18 samples clicking froglets (median length of 30 mm)
E608 %>% sign_test(length ~ 1, mu = 30)

PASWR::SIGN.test(E608$length, md=30)

