# 공간빅데이터분석 과제2
# Created 11 November 2021
# by B913038 박기태
# R versiton : R(3.6.3), Encoding : UTF-8

setwd("C:\\Users\\dev\\Desktop\\2021_Spatial-Bigdata-Analysis\\Assignment\\Assignment02")

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

# 4.4.1 테이블 데이터 불러오기
sh <- read.csv("shelter.csv")
pt <- data.frame(longitude=sh$경도, latitude=sh$위도)
cs <- CRS("+proj=longlat +datum=WGS84")
spt <- SpatialPoints(pt, proj4string = cs)

shelt <- SpatialPointsDataFrame(spt, data = sh)
spplot(shelt, zcol = "최대수용인원")

# 4.4.2 쉐이프 파일 불러오기
admin <- readOGR(dsn=".",layer="TL_SCCO_SIG_W")
dule <- readOGR(dsn=".",layer="DoDreamWay01_L_W")
road <- readOGR(dsn=".",layer="SDE_TL_SPRD_RW_2017_W")

cs = CRS("+proj=longlat +datum=WGS84")

proj4string(admin) = cs
proj4string(dule) = cs
proj4string(road) = cs
spplot(admin, zcol = "SHAPE_AREA")

# 4.4.3 생성된 데이터 저장하기
names(shelt) = c("no", "name", "addr", "maxn", "curn", "tel", "admincode", "adminname", "long", "lat")
writeOGR(shelt, dsn = ".", layer = "shelter2", driver = "ESRI Shapefile")
