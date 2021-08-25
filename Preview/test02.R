# Title     : TODO
# Objective : TODO
# Created by: dev
# Created on: 2021-08-25

# lists
# can contain different datatypes
vec1 <- c(1,2,3,4,5)
vec2 <- c(T,F,T)
vec3 <- c("a","b","c","d","e","f")

mylist1 <- list(vec1,vec2,vec3)
mylist2 <- list("a",T,23,mylist1)

# dataframes
# subtype of list

# should contain same number of rows
# df <- data.frame(vec1,vec2,vec3) , this will cause an error
vec4 <- c(3,4,5,6,7)
vec5 <- c(T,F,T,T,F)
df <- data.frame(vec4, vec5)

# matrix
# matrix(data, row, col) to assign to matrix
# unlike other languages, row and colum starts with index 1
mymatrix <- matrix(vec3, 2,3)


# accessing data with indicies
# vec5[2] will return FALSE
# mymatrix[1,2] will return "c"

# colon operator
# like in python, colon between two integers mean
# successive numbers between two variables.
# 1:5  will return 1 2 3 4 5

# when used as index, will return as following:
# vec3[1:5] will return "a" "b" "c" "d" "e"

# since normal variables are considered as vector with len 1,
# var[1] will return itself (var)








