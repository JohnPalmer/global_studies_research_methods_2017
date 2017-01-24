#######################################
# Research Methods for Global Studies #
# R demo - class 5	                  #
#######################################

# More on random numbers and chaos: Logistic Map example
n = 5000
r = 3.9
x1 = .5
x = rep(NA, n)
x[1] = x1
for(i in 1:(n-1)){
  x[i+1] = r*x[i]*(1-x[i])
}
plot(x, type="l")

plot(x, jitter(rep(1, n), 10), pch=19, cex=.5, col="#0000ff22")

hist(x)

dx = density(x)
plot(dx)
points(x, jitter(rep(1, n), 10), pch=19, cex=.5, col="#0000ff22")
lines(dx)


# Coin flips
c = rbinom(10, 1, .5)
mean(c)

c = rbinom(100, 100, .5)
hist(c)


# Sampling
pop = x
plot(density(pop))
mean(pop)
var(pop)
sd(pop)
quantile(pop, c(.05, .5, .95))


s = sample(pop, 10, replace=TRUE)
mean(s)
var(s)


s_means = sapply(1:10000, function(i) mean(sample(pop, 50, replace=TRUE)))
plot(density(s_means))

mean(s_means)
mean(pop)
var(s_means)
var(pop)

