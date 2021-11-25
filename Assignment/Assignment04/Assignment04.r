
# 공간빅데이터분석 과제3
# Created 25 November 2021
# by B913038 박기태
# R versiton : R(3.6.3), Encoding : UTF-8


setwd("C:\\Users\\dev\\Desktop\\2021_Spatial-Bigdata-Analysis\\Assignment\\Assignment04")

library("sp")
library("rgdal")
library("rgeos")
library("ggmap")
library("tmap")
library("spatstat")
library("raster")
library("spdep")
library("gstat")
library("spgwr")
library("RColorBrewer")
library("classInt")

# 6.6.1
admin <- readOGR(dsn = ".", layer = "admin")
shelt <- readOGR(dsn = ".", layer = "shelter")
dule <- readOGR(dsn = ".", layer = "dule")

#6.6.2
gArea(admin)
gLength(admin)
utm_k = CRS("+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs")
admin_utm = spTransform(admin,utm_k)

gArea(admin_utm)
gLength(admin_utm)

gArea(admin_utm,byid=TRUE)
gLength(admin_utm,byid=TRUE)

#6.6.3
jongro = subset(admin, SIG_CD=="11110")

shelt$jongro <- gContains(jongro,shelt,byid=TRUE)
shelt$jj = as.numeric(shelt$jongro)

plot(shelt, col=shelt$jj+3)
plot(jongro,add=TRUE)

shelt_j = subset(shelt,jj==1)

plot(jongro,axes=TRUE)
plot(shelt_j,add=TRUE)

# 6.6.4

utm_k2 = CRS("+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m")
shelt_utm = spTransform(shelt, utm_k2)
dule_utm = spTransform(dule, utm_k2)

shelt_buf = gBuffer(shelt_utm, width = 500)
dule_buf = gBuffer(dule_utm,width =1000)

plot(dule_buf, col=5)
plot(shelt_buf, add=TRUE)

s_d_intersect = gIntersection(shelt_buf,dule_buf)
plot(s_d_intersect,col=5)

s_d_union = gUnion(shelt_buf,dule_buf)
plot(s_d_union,col=5)

s_d_diff = gDifference(shelt_buf,dule_buf)
plot(s_d_diff, col=5)

# 6,6.5
cen = gCentroid(admin_utm, byid=TRUE)
plot(admin_utm)
plot(cen, cen=TRUE, add=TRUE)

conv=gConvexHull(shelt_utm)
plot(conv)
plot(shelt_utm,add=TRUE,col=3)
