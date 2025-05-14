# Exercise 1

library(tidyverse)

dat <- read_rds("data/trees.rds")
head(dat)

dat1 <- dat |> filter(year == 2020, sp == "spruce")
dat1 <- dat[dat$year == 2020 & dat$sp == "spruce", ]
dat1 <- subset(dat, year == 2020 & sp == "spruce")

ggplot(dat1, aes(x = bio18, y = mean_loss)) +
  geom_point() +
  geom_smooth(method = "lm")

m1 <- lm(mean_loss ~ bio18, data = dat1)
summary(m1)

y <- dat1$mean_loss
X <- cbind(1, dat1$bio18)

head(X)

b.hat <- solve(t(X) %*% X) %*% t(X) %*% y

model.matrix(m1)

head(dat1)
dat1$low.ele <- c("high", "low")[(dat1$ele < 500) + 1]
dat1$low.ele <- ifelse(dat1$ele < 500, "low", "high")
table(dat1$low.ele)
dat1 <- dat1[!is.na(dat1$low.ele), ]
m2 <- lm(mean_loss ~ bio18 + low.ele, data = dat1)
summary(m2)

y <- dat1$mean_loss
X <- cbind(1, dat1$bio18, as.numeric(dat1$low.ele == "low"))
head(X)
solve(t(X)%*%X) %*% t(X) %*% y
coef(m2)

X <- cbind(1, dat1$bio18, as.numeric(dat1$low.ele != "low"))
solve(t(X)%*%X) %*% t(X) %*% y
coef(m2)


dat1$low.ele <- factor(dat1$low.ele, levels = c("low", "high"))
m3 <- lm(mean_loss ~ bio18 + low.ele, data = dat1)

X <- cbind(1, dat1$bio18, as.numeric(dat1$low.ele != "low"))
solve(t(X)%*%X) %*% t(X) %*% y
coef(m2)
coef(m3)

# 
library(ggeffects)
m2 |> predict_response()
m2 |> predict_response(terms = c("bio18", "low.ele")) |> 
  as.data.frame()

m2 |> predict_response(terms = c("bio18", "low.ele")) |> 
  plot()

m2 |> predict_response(terms = c("bio18", "low.ele")) |> 
  plot() +
  scale_color_viridis_d()

m2 |> predict_response(terms = c("bio18[300:400]", "low.ele")) |>  plot()


m2 |> predict_response(terms = list(
  bio18 = 200:500, 
  low.ele = c("low", "high")
)) |>  plot()

m2 |> predict_response(
  terms = list(low.ele = c("low", "high"), 
               bio18 = c(100, 400, 500))) |> 
  plot()

# Exercise 2
m4 <- lm(mean_loss ~ bio18 + ele, data = dat1)

my.terms <- list(
  bio18 = seq(min(dat1$bio18), max(dat1$bio18), len = 100), 
  ele = quantile(dat1$ele, probs = c(0.25, 0.5, 0.75)))

# none does not work
predict_response(m4, terms = my.terms, interval = "none") |> plot()

predict_response(m4, terms = my.terms, interval = "prediction") |> 
  as.data.frame() |> 
  ggplot(aes(x, predicted, col = factor(group))) + geom_line()


p1 <- predict_response(m4, terms = my.terms, interval = "confidence") |> 
  plot() 
p1$layers[[2]] <- NULL
p1

p1 <- predict_response(m4, terms = my.terms, interval = "confidence", ci_level = NA) |> plot() 
  
p2 <- predict_response(m4, terms = my.terms, interval = "confidence") |> plot()
p3 <- predict_response(m4, terms = my.terms, interval = "prediction") |> plot()

library(patchwork)
p1 / p2 / p3

# Interactions
m5 <- lm(mean_loss ~ bio18 * ele, data = dat1)
summary(m5)

p1 <- predict_response(m5, terms = my.terms, interval = "confidence", ci_level = NA) |> plot() 
p1
