### [ Step.1 ] Import data
data <- read.table("Handlebars.dat", header = TRUE, sep = "\t") 

### [ Step.2 ] Create a contingency table
CYCLISTS <- as.table(rbind(
  c(17,120),
  c(154,578)
))
dimnames(CYCLISTS) <- list(
  Hand = c("One Handed", "Two Handed"),
  Nationality = c("English", "Dutch")
)
CYCLISTS

### [ Step.3 ] Chi-square test
chisq_test(CYCLISTS)
