# Title     : TODO
# Objective : TODO
# Created by: dev
# Created on: 2021-08-27


Myfunciton <- function (X, Y) {
  result <- X + Y
  return(result)
}

# for loops
MyForloop <- function (input) {
  for (i in 1:input) {
    print(i)
  }
}

# whlie loops
MyWhileloop <- function (input) {
  x <- 0
  i <- 0
  while (i <= input) {
    x <- x + i

    #indicies should be manually tweaked
    i <- i + 1
  }
  return(x)
}

MyForloop(5)

MyWhileloop(5)



