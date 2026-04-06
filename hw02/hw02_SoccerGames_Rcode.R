library("questionr")
library("dplyr")
library("rstatix")
library("effsize")
library("ggpubr")

### [ Step.1 ] Import data
data <- read.table("SageEditorsPlaySoccer.dat", header = TRUE, sep = "\t")  

### [ Step.2 ] Create a contingency table
SOCCER <- as.table(rbind(
  c(5,23),
  c(19,30)
))
dimnames(SOCCER) <- list(
  Score = c("Yes", "No"),
  Job = c("Sage Publications", "University of Sussex")
)
SOCCER

### [ Step.3 ] Chi-square test
chisq_test(SOCCER)

