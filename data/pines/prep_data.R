trees <- read_delim(here::here("data/pines/Data2.txt"),
                    delim = "\t")
(m <- mean(trees$longest.core.age))

hist(trees$longest.core.dbhbb)
plot(trees$longest.core.dbhbb, trees$longest.core.age)

names(trees)

t1 <- trees %>% select(id = code.tree, alt = z.coord.tree, slope, age = longest.core.age, 
                 dbh = longest.core.dbhbb, site, ns = NS, ew = EW, 
                 youth_growth = lc.growth.rate50)

t1 %>% write_rds("data/pines/pines.rds")


t2 <- filter(t1, between(age, 100, 150)) 
(m <- mean(t2$dbh))
(s <- sd(t2$dbh))
p1 <- t2 %>%  ggplot(aes(dbh)) + 
  geom_density() + 
  geom_histogram(aes(y = ..density..), alpha = 0.5, bins = 15) + 
  stat_function(fun = dnorm, col = "red", args = list(mean = m, sd = s), lty = 2) +
  geom_vline(xintercept = m, col = "red") +
  scale_x_continuous(limits = c(0, 40)) +
  theme_light()

p1
