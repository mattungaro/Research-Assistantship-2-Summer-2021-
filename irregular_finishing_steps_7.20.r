
# Here's the problem that someone will need to figure out with this file - I can't seem to get clip to work.
# It may be a CRS issue?

library(tidyverse)
library(data.table)
library(sf)
library(leaflet)
library(raster)
library(rgeos)
library(readr)

setwd("C:\\Users\\Owner\\Desktop\\Summer Project\\urban\\")
mydir = "finishing_steps"
myfiles = list.files(path=mydir, pattern="*.shp$", full.names=TRUE)
myfiles_complete <- Filter(function(x) grepl("poly", x), myfiles)
substr(myfiles_complete, 17, 27) # testlist_poly <- list()

list_poly <- list()
list_poly2 <- list()
list_firm <- list()
firm <- st_read("C:\\Users\\Owner\\Desktop\\Summer Project\\firm_panel_filtered.shp")

st_crs(firm)

myfiles1=myfiles[1]
for (polygon in myfiles1) {
  
  
  polygon2 <- st_read(polygon)
  polygon2 <- polygon2 %>% st_set_crs(st_crs(firm))
  #polygon2 <- st_set_crs(polygon2, "+proj=utm +zone=19 +ellps=GRS80 +datum=NAD83") 
  #firm <- st_set_crs(firm, "+proj=utm +zone=19 +ellps=GRS80 +datum=NAD83") 
  list_poly[[polygon]] <- polygon2
  
  ifelse(st_crs(firm) ==st_crs(polygon2),print("Ok"), print("didn't work"))
} 
st_crs(firm)
st_crs(polygon2)


for (feature in list_poly) {
  for (poly in myfiles1) {
    poly1 = substr(poly, 17, 27)
    firm1 <- firm %>% filter(frm_d_2 == poly1)
  }
  
  subset <- feature[firm1, ] #clip - this here doesn't seem to do what it should. ANY THOUGHTS?
  #subset <- raster::intersect(feature, firm1 ) # attempt that doesn't work either
  subset2 <- subset %>% 
    mutate(ZONE_LID_V= ifelse(gridcode == 0,'X', 
                              ifelse(gridcode == 1, 'AE', 
                                     'X')))%>% 
    mutate(ZONESUB_LI= ifelse(gridcode == 0,NA, 
                              ifelse(gridcode == 1, NA, 
                                     '1 PCT FUTURE CONDITIONS')))
  # mutating gridcode to create a ZONE_LID_V column, like in the original dataset.
  #subset2 <- gUnaryUnion(subset, id = 'ZONE_LID_V')
  list_poly2 <- list(subset2)
  plot(subset$geometry)
}

