########################
# R Script for Class 6 #
########################

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