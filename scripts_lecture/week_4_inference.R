# only the first camera
dbinom(1, 14, prob = 0.5)
dbinom(1, 14, prob = 0.3)
dbinom(1, 14, prob = 0.1)
dbinom(1, 14, prob = 0.0)
dbinom(1, 14, prob = 0.05)

# first and second camera
dbinom(1, 14, prob = 0.05) * dbinom(10, 14, prob = 0.05)
dbinom(1, 14, prob = 0.5) * dbinom(10, 14, prob = 0.5)

# Exercise 1
# 1) p should be between 0 and 1
# 2)

y <- c(1, 10, 2, 5, 0)
prod(dbinom(y, size = 14, p = ?))
sum(log(dbinom(y, size = 14, p = ?)))
sum(dbinom(y, size = 14, p = ?, log = TRUE))

f1 <- function(p, K = 14, data = y) {
  sum(dbinom(data, size = K, p = p, log = TRUE))
}

pp <- seq(0, 1, length = 100)

f1(pp[2])

L <- sapply(pp, f1)

which.max(L)
pp[which.max(L)]

plot(pp, L)
abline(v = pp[which.max(L)])

sum(y) / (5 * 14)


# Exercise 2
betabin <- function(N, a, b, y, K) {
  current <- 0.5
  pi <- rep(0, N)
  for (i in 1:N) {
    sim <- one_iter(a, b, current, y = y, K = K)
    pi[i] <- sim$next_stop
    current <- sim$next_stop
  }
  r <- data.frame(iter = 1:N, pi)
}

one_iter <- function(a, b, current, y, K) {
  # a and b are parameters of the prior distribution
  # we use a beta prior here
  # Step 1: propose the next value
  proposal <- runif(1, 0, 1)
  # Step 2:
  prop_plaus <- dbeta(proposal, a, b) *
    prod(dbinom(y, K, prob = proposal)) # The likelihood
  prop_q <- dbeta(proposal, a, b)
  current_plaus <- dbeta(current, a, b) *
    prod(dbinom(y, K, prob = current)) # The likelihood
  current_q <- dbeta(current, a, b)
  alpha <- min(1, prop_plaus / current_plaus * current_q / prop_q)
  
  next_stop <- sample(c(proposal, current), size = 1, prob = c(alpha, 1 - alpha))
  data.frame(proposal, alpha, next_stop)
}


### How to chose a and b

curve(dbeta(x, 2, 4), from = 0, to = 1)




set.seed(100)
y <- c(1, 10, 2, 5, 0)
posterior <- betabin(1000, 1, 1, y, K = 14)
mean(posterior$pi)

hist(posterior$pi)

posterior <- betabin(1e4, 1, 1, y, K = 14)
mean(posterior$pi)
median(posterior$pi)
quantile(posterior$pi, probs = c(0.025, 0.975))
hist(posterior$pi)

curve(dbeta(x, 20, 30), form = 0, to = 1)
posterior <- betabin(1e3, 20, 30, y, K = 14)

hist(posterior$pi)
mean(posterior$pi)

posterior <- betabin(1e4, 1, 1, y, K = 14)
hist(posterior$pi)

posterior <- betabin(1e4, 20, 30, y, K = 14)
hist(posterior$pi)

# Credible interval
quantile(posterior$pi, probs = c(0.025, 0.975))

# Informative prior
posterior <- betabin(1e4, 5, 5, y, K = 14)
hist(posterior$pi)

# Credible interval
quantile(posterior$pi, probs = c(0.025, 0.975))
