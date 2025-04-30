# Review question

f1 <- function(x = 1, y) {
  x + y
}

f2 <- function(x, y = 1) {
  x + y
}

f1(x = 1, y = 1)
f1(1, 1)
f1(1, x = 1)
f2(1)
f1(y = 1)

f1(1)
f1(2, 5)
f1(, 1)
plot(x = 1, y = 2, col = "red")

# Exercise 1


S <- expand.grid(d1 = 1:6, 
                 d2 = 1:6, 
                 d3 = 1:6, 
                 d4 = 1:6)
nrow(S)


replicate(4, 1:6, simplify = FALSE)
S <- expand.grid(replicate(4, 1:6, simplify = FALSE))
nrow(S)
range(S)
O <- rowSums(S)
range(O)
barplot(table(O))
barplot(table(O)/length(O))
mean(O > 10)
mean(O <= 5)


# Sapply
f1 <- function(x) {
  choose(4, x) / 16
}

f1(0)
f1(1)
f1(2)

for (i in 0:10)
  print(f1(i))

sapply(0:10, function(x) f1(x))
sapply(0:10, f1)


f2 <- function(x, n) {
  choose(4, x) / n
}

sapply(0:10, f2, n = 16)
sapply(0:10, function(x) f2(x, n = 16))


# Exercise 2
f3 <- function(x, k) {
  2 * x / (k * (k + 1))
}

# for k = 5
f3(1:5, 5)
sum(f3(1:5, 5))

# Exercise 3
dbinom(10, size = 20, prob = 0.86)
sum(dbinom(10:20, size = 20, prob = 0.86))
sum(dbinom(6:15, size = 20, prob = 0.86))

# Exercise 4

pt(-1.8452, 9) * 2

x <- seq(-4, 4, 0.01)
plot(x, dt(x, 9), type = "l")
abline(v = -1.8)
pt(-1.8, df = 9)




x <- rnorm(10)

tstat <- mean(x) - 0 / sd(x) / sqrt(10)
tstat

t.test(x) 
pt(-0.41711, df = 9) * 2

