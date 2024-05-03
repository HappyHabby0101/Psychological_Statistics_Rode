### [ Step.1 ] Load data 
drugData <- read.delim("Drug.dat", header = TRUE)
drugData$BDIchange <- drugData$wedsBDI-drugData$sundayBDI
drugData %>% head(5)

### [ Step.2 ] Assumption check
by(drugData$BDIchange, drugData$drug, stat.desc, basic = FALSE, norm = TRUE)
leveneTest(drugData$BDIchange, drugData$drug)
alcoholData<-subset(drugData, drug == "Alcohol")
ecstasyData<-subset(drugData, drug == "Ecstasy")


