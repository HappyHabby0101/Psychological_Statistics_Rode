# PROBABILITY (a)
probability_a <- 1 - pnorm(3)
print(probability_a)

# PROBABILITY (b)
# pnorm(x, mean, sd)
probability_b <- 1 - pnorm(42,35,6)
print(probability_b)

# PROBABILITY (c)
# dbinom(x, size, prob)
probability_c <- dbinom(10,10,0.8)
print(probability_c)



