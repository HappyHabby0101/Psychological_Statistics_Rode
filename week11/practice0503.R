library("dplyr")
library("readxl")
library("reshape2")
library("rstatix")

### 2-1.[ Load diamonds ]
data(diamonds, package = 'ggplot2')
diamonds %>% head(5)

### 2-2.[ Apply functions ]
# → Function: lapply / sapply {base}
sapply(diamonds, mean)

### 2-3.[ Group by function ]
# → Function: aggregate {stats}
aggregate(price ~ cut, diamonds, mean)
# diamonds %>% group_by(cut) %>% summarize(AvgPrice=mean(price))

### 2-4.[ Relevel within variable ]
# → check the category names within a variable
levels(diamonds$color)
# → relevel Function: factor {base}

### 2-5.[ Rename categories within variable ]
# → check the category names within a variable
levels(diamonds$color)
# → Function: factor {base}
diamonds$color<-factor(diamonds$color, labels = c("Red", "White", "Blue", "Green"))
levels(diamonds$color)

### 2-8.[ Selecting data/subjects ]
# → Function: slice {dplyr}
diamonds %>% slice(1:5)
diamonds %>% slice(-1) %>% head(5)

