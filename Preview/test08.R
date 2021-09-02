# Title     : TODO
# Objective : TODO
# Created by: dev
# Created on: 2021-09-01

# Bar charts
library(datasets)

# quick lookup for datasets
?mtcars
head(mtcars)

# this will iterate through each cases, not what we want
barplot(mtcars$cyl)

#make a table with frequencies for each category
cylinders <- table(mtcars$cyl)
cylinders
barplot(cylinders)
