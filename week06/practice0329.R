library("questionr")
library("dplyr")
library("rstatix")
library("effsize")
library("ggpubr")

### [ Distribution plot ] Binomial distribution
n = 20
p = 0.25
binom_dist <- tibble(n_success = 1:n) %>%
  mutate(probability = dbinom(n_success, size=n, prob=p))
#binom_dist
binom_dist %>%
  ggplot(aes(x=n_success, y=probability))+
  geom_line()+
  geom_point(size=2)+
  scale_x_continuous(breaks=1:n)+
  scale_y_continuous(breaks = scales::pretty_breaks(n = 5))+
  labs


### [ Example 3.9 ] Mice muscle destrophy
# → (a) Fewer than 5 will have muscular dystrophy: P(X<5)
pbinom(4,20,0.25) %>% round(3)
# → (b) 5 will have muscular dystrophy: P(X=5)
dbinom(4,20,0.25) %>% round(2)