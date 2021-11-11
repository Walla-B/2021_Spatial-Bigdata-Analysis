# 공간빅데이터분석 과제1
# Created 28 October 2021
# by B913038 박기태
# R versiton : R(3.6.3), Encoding : UTF-8

setwd("C:\Users\dev\Desktop\2021_Spatial-Bigdata-Analysis\Assignment")

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

# 3.6.1 포인트 객체 만들기

x <- c(127.0079, 126.9708, 127.0275, 126.9075)              # 벡터 x 작성
y <- c(37.5651, 37.5551, 37.4979, 37.5154)                  # 벡터 y 작성
name <- c("동대문역사문화공원", "서울역", "강남역", "영등포역")   # 벡터 name 작성
station <- data.frame(Longitude = x, Latitude = y)          # dataframe 작성
cs <- CRS("+proj=longlat +datum=WGS84")                     # 좌표계 정의
sp <- SpatialPoints(station, proj4string = cs)              # SpatialPoints 생성
spdf <- SpatialPointsDataFrame(sp, data = data.frame(Name = name))
plot(spdf, axes = T, pch = 10)                              # 그래프 출력
text(spdf, name, pos = 1, offset = 0.3)

# 3.6.2 선 객체 만들기

x1 <- c(127.0756,127.071,127.0414,127.0364,127.0317,127.0233)
y1 <- c(37.6627,37.6586,37.6516,37.651,37.6436,37.6358)
x2 <- c(127.0459,127.044,127.045,127.052,127.0584,127.0588)
y2 <- c(37.6813,37.67,37.6597,37.643,37.6367,37.6316)       # 1호선, 4호선 지하철 노선 데이터

l1 <- cbind(x1,y1)
l2 <- cbind(x2,y2)                                          # 각 x, y좌표로 구성된 매트릭스 작성

ln1 <- Line(l1)
ln2 <- Line(l2)                                             # Line 객체 생성
lns1 <- Lines(list(ln1), ID = 1)
lns2 <- Lines(list(ln2), ID = 2)                            # Lines 객체 작성
cs <- CRS("+proj=longlat +datum=WGS84")                     # 좌표계 정의
slns <- SpatialLines(list(lns1, lns2), projstring = cs)     # SpatialLines 작성
subno <- data.frame(ID = c(1, 2), name = c("4호선", "1호선"))# Dataframe 작성
slnsdf <- SpatialLinesDataFrame(slns, data = subno)         # SpatialDataFrame 작성
plot(slnsdf, axes = T, col = 1:2)                           # 그래프로 출력

# 3.6.3 면 객체 만들기

x3 <- c(126.925,126.9241,126.9241,126.9242,126.9248,126.9252,126.9256,126.9261,126.9263,126.9265,126.9267,126.927,126.9274,126.9255)
y3 <- c(37.553,37.5527,37.5498,37.5492,37.5492,37.5486,37.5477,37.5478,37.55,37.55,37.5507,37.5507,37.5515,37.5525)

x4 <- c(126.924,126.9248,126.9253,126.9259,126.9259,126.9247)
y4 <- c(37.5546,37.5541,37.5543,37.5543,37.5547,37.5554)

p1 <- cbind(x3,y3)
p2 <- cbind(x4,y4)        # x,y좌표로 구성된 매트릭스 작성
pl1 <- Polygon(p1)
pl2 <- Polygon(p2)        # Polygon 객체 생성

polys1 <- Polygons(list(pl1), ID = 1)
polys2 <- Polygons(list(pl2), ID = 2)
cs <- CRS("+proj=longlat +datum=WGS84")
spolys <- SpatialPolygons(list(polys1, polys2), proj4string = cs)
edu <- data.frame(ID = c(1, 2), name = c("홍익대학교", "서교초등학교"))
spolysdf <- SpatialPolygonsDataFrame(spolys, data = edu)
plot(spolysdf, axes = T, col=1:2)

# 3.6.4 래스터 객체 만들기

r <- raster(ncol = 10, nrow = 10, xmn = 126.5, xmx = 127, ymn = 37, ymx = 37.5) # RasterLayer 생성
values(r) <- 1:100
r2 <- r*r
r3 <- sqrt(r)
rs <- stack(r, r2, r3)
rb <- brick(rs)
plot(r)
plot(rb)


# 3.6.5 공간 데이터 좌표변환

cs2 <- CRS("+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m")
spdf2 <- spTransform(spdf,cs2)
slnsdf2 <- spTransform(slnsdf, cs2)
spolysdf2 <- spTransform(spolysdf, cs2)
plot(spdf2, axes=T, pch=10)
plot(slnsdf2, axes=T, col=1:2)
plot(spolysdf2, axes=T, col=1:2)