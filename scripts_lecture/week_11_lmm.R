library(tidyverse)

# Task 1
dat <- read_delim("data/pines/Data1.txt")
head(dat)

ggplot(dat, aes(age, DBH, group = core.code)) + 
  geom_line(alpha = 0.3)

# Task 2
# 2. Fit the following models:

#  a. A model 𝐷𝐵𝐻 = 𝛽0 + 𝛽1𝑎𝑔𝑒 for each individual tree.

dat |> nest(trees = -core.code) |> 
  mutate(mod = lapply(trees, function(x) lm(DBH ~ age, data = x)))

m1 <- dat |> nest(trees = -core.code) |> 
  mutate(mod = map(trees, ~ lm(DBH ~ age, data = .)))

library(broom)
m1 <- m1 |> mutate(mod = map(mod, tidy)) |> 
  select(-trees) |> 
  unnest(cols = mod)

# to wide
m1 |> select(core.code:estimate) |> 
  pivot_wider(names_from = term, values_from = estimate)

m1 |> group_by(term) |> summarize(mean = mean(estimate))

# b. A global model 𝐷𝐵𝐻 = 𝛽0 + 𝛽1𝑎𝑔𝑒.
m2 <- lm(DBH ~ age, data = dat)
m2

# c. A global model 𝐷𝐵𝐻 = 𝛽0 + 𝛽1𝑎𝑔𝑒 + 𝛽2 𝑖𝑑 + 𝛽3𝑎𝑔𝑒 ⋅ 𝑖𝑑.
m3 <- lm(DBH ~ age * core.code, data = dat)
summary(m3)


# d. The same model as in b), but with a random intercept.
library(lme4)
m4 <- lmer(DBH ~ age + (1 | core.code), data = dat)

summary(m4)
fixef(m4)
ranef(m4)


# e. The same model as in b), but with a random intercept and random slope.

m5 <- lmer(DBH ~ age + (age | core.code), data = dat)
dat$age1 <- scale(dat$age)
m5 <- lmer(DBH ~ age1 + (age1 | core.code), data = dat)

summary(m5)

# Task3
m2 <- lm(DBH ~ age1, data = dat)
m4 <- lmer(DBH ~ age1 + (1 | core.code), data = dat)
m5 <- lmer(DBH ~ age1 + (age1 | core.code), data = dat)

library(broom.mixed)

bind_rows(
m2 |> tidy(conf.int = TRUE) |> 
  select(term, estimate, conf.low, conf.high) |> 
  mutate(model = "global model"),
m4 |> tidy(conf.int = TRUE, effects = "fixed") |> 
  select(term, estimate, conf.low, conf.high) |> 
  mutate(model = "random intercept model"),
m5 |> tidy(conf.int = TRUE, effects = "fixed") |> 
  select(term, estimate, conf.low, conf.high) |> 
  mutate(model = "random slope model")
) |> ggplot(
  aes(model, estimate, ymin = conf.low, ymax = conf.high)
) + geom_pointrange() +
  facet_wrap(~ term, scale = "free")