# Title     : TODO
# Objective : TODO
# Created by: dev
# Created on: 2021-08-30

library(datasets)

head(iris)

plot(iris$Species)
plot(iris$Petal.Length)
plot(iris$Species, iris$Petal.Width)
plot(iris$Petal.Length, iris$Petal.Width)
plot(iris)

# plot with options
plot(iris$Petal.Length, iris$Petal.Width,
     col = "#cc0000",
     pch = 19,
     main = "Iris: Petal Length vs Petal Width",
     xlab = "Petal Length",
     ylab = "Petal Width" )

# formulas in plot()
plot(cos, 0, 2*pi)
plot(exp, 1, 5)
plot(dnorm, -3, +3)

plot(dnorm, -3, +3,
     col = "#cc0000",
     lwd = 5,
     main = "Std norm distribution",
     xlab = "xlabel",
     ylab = "ylabel")

