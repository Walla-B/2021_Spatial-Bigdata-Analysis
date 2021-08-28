# Title     : TODO
# Objective : TODO
# Created by: dev
# Created on: 2021-08-28

# download packages
# in console,
# install.packages("package_name")

# load libraries
# library("package_name")

# using ggplot
a <- c(1,2,3,4,5,6)
b <- c(10,23,44,33,52,9)

df = data.frame(a,b)

library(ggplot2)

# using library funcions after loading as normal function
ggplot(df, aes(a,b)) + geom_point()
