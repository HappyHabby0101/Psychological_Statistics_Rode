library("pastecs")
library("car")
library("tidyverse")
library("rstatix")
library("effsize")
library("ggpubr")


### [ Step.1 ] Load data 
drugData <- read.delim("Drug.dat", header = TRUE)
drugData$BDIchange <- drugData$wedsBDI-drugData$sundayBDI

### [ Step.2 ] Assumption check
by(drugData$BDIchange, drugData$drug, stat.desc, basic = FALSE, norm = TRUE)
leveneTest(drugData$BDIchange, drugData$drug)

alcoholData<-subset(drugData, drug == "Alcohol")
ecstasyData<-subset(drugData, drug == "Ecstasy")

### [ Step.3 ] Repeated-measure Wilcoxon test
(ecstasyModel<-wilcox.test(ecstasyData$wedsBDI, ecstasyData$sundayBDI, paired = TRUE))

### [ Step.4 ] Effect size
rFromWilcox<-function(wilcoxModel, N){
  z<- qnorm(wilcoxModel$p.value/2)
  r<- z/ sqrt(N)
  cat(wilcoxModel$data.name, "Effect Size, r = ", r)
  
}
rFromWilcox(ecstasyModel, 20)      

### [ Step.5 ] Visualization & Report
ecstasy.long <- ecstasyData %>%
  gather(key = "day", value = "BDI", sundayBDI, wedsBDI)
#ecstasy.long %>% head(5)
ggplot(ecstasy.long, aes(day, BDI)) + 
  geom_boxplot()