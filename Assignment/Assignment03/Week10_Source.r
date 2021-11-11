####공간빅데이터분석/08주차/교재 Chapter05/코드북####

####실습환경####
  # 버전정보: R(3.6.0), R Studio(1.3.1093), Notepad++(7.8.9(x64))
  # 인코딩(encoding): UTF-8
  # 작업공간: 큰따옴표("")안에 작업공간의 경로를 입력한다.
setwd("C:/Users/jubi/Dropbox (UNR)/Y20Q3_LT_HongikUniv/workshop/Assignment05")
  # 라이브러리: 실습에 필요한 라이브러리를 선언한다.
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

####[5]공간정보의 시각화####

####[5-1]기본적인 시각화 함수 plot####

plot(admin, axes = TRUE)
plot(shelt, add = TRUE)

plot(admin, col = "green", border = "red", axes = TRUE)
plot(shelt, add = TRUE, col = "blue", pch = 2, cex = 0.5)
title("서울시 대피소 위치")

####[5-2]속성정보를 이용한 시각화 함수 spplot####

spplot(admin, "SHAPE_AREA", cuts = 5)

install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all(n = 5, exact, n = FALSE)

pal <- brewer.pal(5, "OrRd")

spplot(admin, "SHAPE_AREA", cut = 5, col.regions = pal)

install.packages("classint")
library(classint)
brk <- classintervals(admin$SHAPE_AREA, n = 5, style = "quantile")

spplot(admin, "SHAPE_AREA", col.regions = pal, at = brk$brks)

brk2 <- c(0, 0.001, 0.002, 0.003, 0.004, 0.005)
spplot(admin, "SHAPE_AREA", col.regions = pal, at = brk2, main = "서울시 면적")

####[5-3]속성정보를 이용한 단계구분도 작성####

  #[5-3-1]단계구분도 작성을 위한 데이터 준비
head(admin@data)

admin@data$SHAPE_AREA
admin$SHAPE_AREA

pop <- read.csv("seoul.csv")
admin <- merge(admin, pop, by.x = "SIG_CD", by.y = "code")
head(admin@data)

utm_k <- CRS("+proj=tmerc +lat_0=38.0 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs")
admin_utm <- spTransform(admin, utm_k)

install.packages("rgeos")
library(rgeos)
admin_utm$area <- gArea(admin_utm, byid = TRUE)

admin_utm$popden <- admin_utm$pop2017 / (admin_utm$area / 1000000)

  #[5-3-2]spplot을 이용한 단계구분도 제작
library(classint)
brk <- classintervals(admin_utm@data$popden, n = 5, style = "jenks")
library(RColorBrewer)
pal <- brewer.pal(5, "OrRd")
spplot(admin_utm, "popden", ccol.regions = pal, at = brk$brks, main = "서울시 구별 인구밀도")

  #[5-3-3]tmap을 이용한 단계구분도 제작
  #패키지 설치 및 라이브러리 선언(tmap)
install.packages("tmap")
library(tmap)

tm_shape(admin_utm) + tm_polygons(col="popden")

tm_shape(admin_utm) + tm_polygons(col = "popden", n = 6, style = "jenks")

tm_shape(admin_utm) + tm_polygons(col = "popden",, n = 6, style = "jenks", palette = "OrRd") + tm_legend(outside = TRUE)

tm_shape(admin_utm) + tm_polygons(col = "popden", breaks = c(0, 10000, 20000, 30000), label = c("under 10,000", "10,000-20,000", "over 20,000"), palette =  "OrRd") + tm_legend(outside = TRUE)

####[5-4]구글 지도를 이용한 시각화####

  #패키지 설치 및 라이브러리 선언(ggmap)
install.packages("ggmap")
library(ggmap)

  #구글맵 플랫폼 홈페이지(https://cloud.google.com/maps-platform)에서 사용승인 및 API 키 발급절차 수행
api_key = "A*****************************"
register_google(key = api_key, write = TRUE)

  #점 데이터(point) 시각화
    #(1)배경으로 삼을 구글 지도를 가져온다.
gmap <- get_map(location = c(lon = 127, lat = 37.55), zoom = 11, maptype = "roadmap")
    #(2)공간 데이터를 데이터 프레임 형태로 변환한다.
mapdata <- data.frame(shelt)
    #(3)geom_point 함수를 이용하여 데이터프레임 mapdata를 지도화하고, ggmap 함수를 통해 (1)에서 작성한 gmap을 구글 지도로 변환하여 결합한다.
gmap.map <- ggmap(gmap) + geom_point(data = mapdata, aes(x = longitude, y = latitude, colour = mapdata$최대수용인원, size = mapdata$최대수용인원), alpha = 1)
gmap.map

  #면 데이터(polygon) 시각화
    #(1)배경으로 삼을 구글 지도를 가져온다.
gmap <- get_map(location = c(lon = 127, lat = 37.55), zoom = 11, maptype = "roadmap")
    #(2)공간 데이터를 데이터프레임으로 변환한다. 폴리곤 데이터는 fortify 함수를 이용하여 변환한다.
admin.f <- fortify(admin)
    #(3)fortify 함수에 의해 속성정보가 사라진 데이터프레임에 공간 객체의 속성값을 결합한다.
admin@data$id <- rownames(admin@data)
    #(4)merge 함수를 이용하여 데이터프레임(admin.f)와 속성정보(admin@data)를 결합한다. 이때 (3)에서 작성한 id 항목을 기준으로 결합한다.
admin.m <- merge(admin.f, admin@data, by = "id")
    #(5)geom_polygon 함수를 이용하여 공간 데이터를 표현하고 이를 ggmap 함수에 의한 구글 지도와 결합한다.
gmap.map <- ggmap(gmap) + geom_polygon(data = admin.m, aes(x = long, y = lat, group = group, fill = pop2017), alpha = 0.4)
gmap.map



