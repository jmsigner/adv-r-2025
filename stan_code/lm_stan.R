dat <- read_rds("data/trees.rds")
dat <- dat |> filter(sp %in% c("spruce"), year == 2020) 
dat <- dat |> filter(!is.na(ele))

# With lm
m.lm <- lm(mean_loss ~ bio18 + ele, data = dat)
summary(m.lm)

# With brms
library(brms)
m.brm <- brm(mean_loss ~ bio18 + ele, data = dat)
summary(m.brm)

# With Stan
library(rstan)

scode <- "
  data {
    int<lower=1> N;
    vector [N] x1;
    vector [N] x2;
    vector [N] y;
  }
  parameters {
    real beta0;
    real beta1;
    real beta2;
    real sigma;
  }
  model {
    vector [N] mu;
    mu = beta0 + beta1 * x1 + beta2 * x2;
    y ~ normal(mu, sigma);
  }
"

m.stan.1 <- stan(
  model_code = scode,  # Stan program
  data = list(y = dat$mean_loss, x1 = dat$bio18, x2 = dat$ele, N = nrow(dat)),    
  chains = 4,             # number of Markov chains
  warmup = 1000,          # number of warmup iterations per chain
  iter = 2000,            # total number of iterations per chain
  cores = 1,              # number of cores (could use one per chain)
  refresh = 1             # no progress shown
)

# With Stan -- Matrix notation
scode <- "
  data {
    int<lower=1> N;
    int<lower=1> p;
    matrix [N, p] X;
    vector [N] y;
  }
  parameters {
    vector [p] beta;
    real sigma;
  }
  model {
    vector [N] mu;
    mu = X * beta;
    y ~ normal(mu, sigma);
  }
"

m.stan.2 <- stan(
  model_code = scode,  # Stan program
  data = list(y = dat$mean_loss, X = cbind(1, dat$bio18, dat$ele), N = nrow(dat), p = 3),    
  chains = 4,             # number of Markov chains
  warmup = 1000,          # number of warmup iterations per chain
  iter = 2000,            # total number of iterations per chain
  cores = 1,              # number of cores (could use one per chain)
  refresh = 1             # no progress shown
)


library(tidybayes)
confint(m.lm)
fixef(m.brm)

summary(m.stan.1)$summary[, c("mean", "2.5%", "97.5%")]
summary(m.stan.2)$summary[, c("mean", "2.5%", "97.5%")]

