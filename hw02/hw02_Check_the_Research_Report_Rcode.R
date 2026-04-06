

### [ Step.1 ] Import data
data <- read.csv("Ratio_Sub_by_Region.csv")
data$Expect <- rep(2, nrow(data))

### [ Step.2 ] Repeated-measure Wilcoxon test
Supra_Marginal_B <-wilcox.test(data$Supra_Marginal_B, data$Expect, alternative = "less")
Basal_Ganglia_B <-wilcox.test(data$Basal_Ganglia_B, data$Expect, alternative = "less")
Middle_Frontal_L <-wilcox.test(data$Middle_Frontal_L, data$Expect, alternative = "less")
Thalamus_B <-wilcox.test(data$Thalamus_B, data$Expect, alternative = "less")
Superior_Temporal_B <-wilcox.test(data$Superior_Temporal_B, data$Expect, alternative = "less")
Precentral_B <-wilcox.test(data$Precentral_B, data$Expect, alternative = "less")

