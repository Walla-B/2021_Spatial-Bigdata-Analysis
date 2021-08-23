# Title     : TODO
# Objective : TODO
# Created by: dev
# Created on: 2021-08-24

a = 1 + 2     # store variable
a <- 5        # another way to store variable

# R has several types.
# 1. numeric values
mynumeric_decimal <- 0.2
mynumeric_integer <- 5

# 2. character values
mycharacter <- "Hello World"

# 3. boolean values
mylogical_True <- TRUE    # Can be TRUE or T
mylogical_False <- F      # Can be FALSE or F

# 4. factor values
myfactor <- as.factor("red")


# vectors
# c() means concatenate
# can only store same datatypes
vec1 <- c(1, 2, 3, 4)      # Vectors of integer
vec2 <- c(T, F, T, T)      # Vectors of logical values
vec3 <- c("a", "b", "c", "d") # Vectors of char values

vec4 <- as.factor(c("red", "blue", "red", "blue")) # Vectors of factors

# if multiple datatypes are fed in Vector, some will change
# to match other's datatype
vec5 <- c(1, TRUE, "b") # variable's datatype : char
vec6 <- c(0, FALSE)     # variable's datatype : integer (T=1, F=0)


