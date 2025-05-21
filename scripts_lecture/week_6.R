
log(4.3)
exp(4.3)

# Exercise 1
dat <- read.csv("data/woodp_Occ.csv")
head(dat)

m1 <- glm(y.1 ~ snags, data = dat, family = binomial())

summary(m1)

library(ggeffects)
predict_response(m1) |> plot()
predict_response(m1, terms = "snags [all]") |> plot()

head(dat)


library(DHARMa)
plot(m1) # difficult for interpretation
plot(simulateResiduals(m1))

     

# Exercise 2 (splines)

mnmoose <- data.frame(
  year = 2005:2020,
  estimate = c(
    8160, 8840, 6860, 7890, 7840, 5700,
    4900, 4230, 2760, 4350, 3450, 4020, 
    3710, 3030, 4180, 3150))



m1 <- lm(estimate ~ poly(year, 1), data = mnmoose)
m2 <- lm(estimate ~ poly(year, 2), data = mnmoose)


library(ggplot2)
library(tidyverse)
l <- lapply(1:5, function(p) lm(estimate ~ poly(year, p), data = mnmoose))

r <- lapply(1:5, function(m) predict_response(l[[m]], terms = "year") |> 
              as.data.frame() |> 
              mutate(order = m))

bind_rows(r) |> 
  ggplot(aes(x, predicted, color = factor(order))) + geom_line()

str(r)


# using a list column
res <- tibble(
  order = 1:5
)

res <- res |> 
  mutate(mod = map(order, ~ lm(estimate ~ poly(year, .x), data = mnmoose)))


res$mod[[4]]
res <- mutate(res, pred = map(
  mod, ~  predict_response(.x, terms = "year") |>  as.data.frame()))


res |> select(-mod) |> unnest(cols = pred) |> 
  ggplot(aes(x, predicted, col = factor(order))) + geom_line()