# Title     : TODO
# Objective : TODO
# Created by: dev
# Created on: 2021-08-26

# boolean masking
vec1 <- c("a","b","c","d","e","f")
vec2 <- c(F,T,F,F,F,F)
vec3 <- c(1,2,3,4,5,6)
# vec2 <- vec1[vec2] # will return "b"

# list with names
# "name" = var will assign name to list component.
# if printed, name will be shown as $name
# if name is none, only [[index]] will be shown
mylist <- list("a" = vec1,"b" = vec2,"c" = vec3)

# this function will show names of elements
names(mylist)

# can access components by name using $
mylist$a  # same result as mylist[[1]]
mylist$b  # same result as mylist[[2]]
mylist$c  # same result as mylist[[3]]

df = data.frame("a" = vec1,"b" = vec2, "c" = vec3)
df
# df$a # same result as df[[1]]
df[[1]][2] # will return "b", col1, second element
df[1,2]    # will return FALSE, row 1, col 2
df[[2]][1:3] # will return F T F
df[1,] # will return a, FALSE, 1 all elements in row 1
df[c(1,3,5),] # all elem in row 1, 3, 5
df[,c(1,3)] # all elem in col 1, 3


