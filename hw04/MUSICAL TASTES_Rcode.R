library("dplyr")
library("rstatix")
library("ggpubr")
library("pastecs")
library("compute.es")
library("emmeans")
library("multcomp")
library("agricolae")

# 1.Import and Restructure Data 
data_music <- read.table("fugazi.dat", header = TRUE, sep = "\t")
data_music <- data_music %>%
  mutate(age = recode(age, `1` = "young", `2` = "old")) %>%
  mutate(music = recode(music, `1` = "Fugazi", `2` = "ABBA", '3' = "Barf Grooks"))
 
# 2.Check Normality and Homogeneity of Variance
# 2-1.Normality
data_music %>% 
  group_by(music, age) %>% 
  shapiro_test(liking)

# 2-2.Homogeneity of Variance
data_music <- data_music %>%
  mutate(music = as.factor(music))

data_music %>% 
  group_by(age) %>% 
  levene_test(liking ~ music)

# 3-1. Two-way ANOVA
musicModel<-anova_test(liking ~ age + music + age:music, 
                         data = data_music, detailed = TRUE)
musicModel

# 3-2. post-hoc test
data_music %>% 
  group_by(age) %>% 
  anova_test(liking ~ music, detailed = TRUE)

pwc_young <- data_music %>% 
  filter(age=='young') %>% 
  pairwise_t_test(liking~music, p.adjust.method = "bonferroni")
pwc_young

pwc_old <- data_music %>% 
  filter(age=='old') %>% 
  pairwise_t_test(liking~music, p.adjust.method = "bonferroni")
pwc_old

# 4. Effect Size
omega_factorial<-function(n,a,b, SSa, SSb, SSab, SSr)
{
  MSa<-SSa/(a-1)
  MSb<-SSb/(b-1)
  MSab<-SSab/((a-1)*(b-1))
  MSr<-SSr/(a*b*(n-1))
  varA<-((a-1)*(MSa-MSr))/(n*a*b)
  varB<-((b-1)*(MSb-MSr))/(n*a*b)
  varAB<-((a-1)*(b-1)*(MSab-MSr))/(n*a*b)
  varTotal<-varA + varB + varAB + MSr
  print(paste("Omega-Squared A: ", varA/varTotal),digits=3)
  print(paste("Omega-Squared B: ", varB/varTotal),digits=3)
  print(paste("Omega-Squared AB: ", varAB/varTotal),digits=3)
}
omega_factorial(45,2,3,0.711,81864.067,310790.156,32553.47)
