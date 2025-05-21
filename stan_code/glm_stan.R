library(rstan)

dat <- read_csv("data/woodp_Occ.csv")
m1 <- glm(y.1 ~ snags, data = dat, family = binomial())
coef(m1)
dat$y.1

scode <- "
  data {
    int<lower=1> N;
    vector [N] x1;
    int<lower=0,upper=1> y[N];
  }
  parameters {
    real b0;
    real b1;
  }
  model {
    vector [N] lp;
    lp = b0 + b1 * x1;
    y ~ bernoulli(inv_logit(lp));

  }
"

fit1 <- stan(
  model_code = scode,  # Stan program
  data = list(y = dat$y.1, N = nrow(dat), x1 = dat$snags),    # named list of data
  chains = 4,             # number of Markov chains
  warmup = 1000,          # number of warmup iterations per chain
  iter = 2000,            # total number of iterations per chain
  cores = 1,              # number of cores (could use one per chain)
  refresh = 1             # no progress shown
)

################################################################################
# Comparison

fit1
glm(y.1 ~ snags, data = dat, family = binomial()) |> 
  coef()

