library("pastecs")
library("car")
library("tidyverse")
library("rstatix")
library("effsize")
library("ggpubr")

### [ Step.1 ] Import data
data <- read.table("DarkLord.dat", header = TRUE, sep = "\t")
data$change <- data$nomessag - data$message

### [ Step.2 ] Repeated-measure Wilcoxon test
(Model<-wilcox.test(data$nomessag, data$message, paired = TRUE))

### [ Step.3 ] Effect size
rFromWilcox<-function(wilcoxModel, N){
  z<- qnorm(wilcoxModel$p.value/2)
  r<- z/ sqrt(N)
  cat(Model$data.name, "Effect Size, r = ", r)
}
rFromWilcox(Model, 32)

### [ Step.5 ] Compare with t-test
result <- t.test(data$nomessag, data$message, paired = TRUE)
result


