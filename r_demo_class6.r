########################
# R Script for Class 6 #
########################

# t distribution
x <- seq(-4, 4, length=100)
hx <- dnorm(x)

degf <- c(1, 3, 8, 30)
colors <- c("red", "blue", "darkgreen", "gold", "black")
labels <- c("t df=1", "t df=3", "t df=8", "t df=30", "normal")

plot(x, hx, type="l", lty=2, xlab="x value",
     ylab="Density", main="Comparison of t and normal Distributions")

for (i in 1:4){
  lines(x, dt(x,degf[i]), lwd=2, col=colors[i])
}

legend("topright",
       labels, lwd=2, lty=c(1, 1, 1, 1, 2), col=colors)


# checking p-values
1-pnorm(1.96)
1-pt(1.96, 15)

# loading data
D = read.csv2('shoesize.csv')
D


# exploring height
D$Height
mean(D$Height)
sd(D$Height)
quantile(D$Height)
hist(D$Height)
plot(density(D$Height))

sd(D$Height)/sqrt(408)


# Assumming this data is a random sample of the full school populatio, what is our best estimate of the mean height of all students at this university? Provide a point estimate and 95% confidence interval.



# Assumming this data is a random sample of the full school populatio, what is our best estimate of the mean shoe sizeght of all students at this university? Provide a point estimate and 95% confidence interval.

hist(D$Size)
mean(D$Size)
sd(D$Size)

mean(D$Size)+(2*(sd(D$Size)/sqrt(408)))
mean(D$Size)-(2*(sd(D$Size)/sqrt(408)))


# What is the relationship between height and shoe size?

plot(D$Height, D$Size)
cor(D$Height, D$Size)


M = lm(D$Height~D$Size)
summary(M)

M = lm(D$Height~D$Size+D$Gender)
summary(M)

M = lm(D$Height~D$Size+D$Gender + D$Size*D$Gender )
summary(M)

# family planning data
library(foreign)
library(calibrate)

D = read.dta('effort.dta')
head(D)

plot(change~effort, data=D, ylab="CBR change", xlab="program effort", pch=20, col="#000099dd", cex=2)

M = lm(change~effort, data=D)
summary(M)

M = lm(change~effort+setting, data=D)
summary(M)