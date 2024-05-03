library("dplyr")
library("rstatix")
library("ggplot2")
library("psych")
library("ggcorrplot")

# Anxiety level is linearly related with the exam score

### [ Step.1 ] Data Loading 
# → Loading the dataset
examData = read.delim("ExamAnxiety.dat",  header = TRUE)
examData %>% head(4)

### [ Step.2 ] Check assumptions

#----- (a) Outliers -----#
examData %>% identify_outliers(Anxiety)
#examData %>% identify_outliers(Exam)

#----- (b) Normality -----#
examData %>% shapiro_test(Anxiety)
#examData %>% shapiro_test(Exam)
#examData %>% shapiro_test(Revise)
# → subgroup by Gender

examData %>% group_by(Gender) %>% shapiro_test(Anxiety)

