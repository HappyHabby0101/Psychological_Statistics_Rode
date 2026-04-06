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

### 3-1.[ Change data from wide to long format ]
(spider <- read.delim("SpiderWide.dat"))
# → Now we change it into long format
spider.long <- spider %>%
  gather(key = "View", value = "Anxiety", picture, real)
#　spider.long %>% head(5)

### 3-2.[ Changing between the long form and the wide form ]
# → Function: melt/dcast {reshape2} & str_sub {stringr}
library("stringr")
library("reshape2")
Aid_00s <- read.csv("US_Foreign_Aid_00s.csv")
melt00 <- melt(Aid_00s, id.vars=c("Country.Name", "Program.Name"), 
               variable.name="Year", value.name="Dollars")
melt00$Year <- as.numeric(str_sub(melt00$Year, start=3, 6))
cast00 <- dcast(melt00, Country.Name + Program.Name ~ Year, value.var = "Dollar
head(Aid_00s)
head(cast00)



