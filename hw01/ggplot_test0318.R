library(ggplot2)
library(tidyr)

# 假設我們已經有一個名為 data_test 的資料框，其中包含了學校、班級、數學成績和英文成績欄位
data_test <- data.frame(
  School = c("A", "A", "A", "A", "B", "B", "B", "B"), #gender
  Class = c(1, 1, 2, 2, 1, 1, 2, 2), # self, partner
  Math_Score = c(80, 85, 75, 78, 90, 85, 88, 82), #self
  English_Score = c(70, 75, 68, 72, 78, 80, 85, 79) #partner
)

# 將資料從寬格式轉換為長格式
data_test_long <- tidyr::gather(data_test, Subject, Score, -School,-Class)

# 繪製圖表
p <- ggplot(data_test_long, aes(x = School, y = Score, fill = Subject)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(stat = "identity", position = position_dodge(width = 0.9), 
                aes(ymin = Score - 1, ymax = Score + 1), # 假設錯誤範圍為 1
                width = 0.25) +
  facet_wrap(~ Class) +
  labs(x = "School", y = "Mean score", fill = "Subject") +
  theme_minimal()

# 顯示圖表
print(p)

