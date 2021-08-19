library(tidyverse)
library(data.table)
library(sf)
library(leaflet)
library(raster)
library(rgeos)
library(readr)

# that is the most important part - the frm_d_2 - these are all of the panels and importantly, 
# what I name each of the files (aka Completed_37xxxxxxx)


setwd("C:\\Users\\Owner\\Documents\\Summer 2021 Work\\GIS_flood_zone_project_for_Miyuki_Hino\\urban")
mydir = "6.28_1"
myfiles = list.files(path=mydir, pattern="*.shp$", full.names=TRUE)
myfiles_complete <- Filter(function(x) grepl("Complete", x), myfiles)
substr(myfiles_complete, 17, 27) # test


x = "3710984400J_multi_to_single.shp"
myfiles = list.files(path=mydir, pattern=x, full.names=TRUE)
myfiles_complete <- Filter(function(x) grepl("Complete", x), myfiles)
substr(myfiles, 8, 18) # test

list_poly <- list()

firm <- st_read("C:\\Users\\Owner\\Documents\\Summer 2021 Work\\GIS_flood_zone_project_for_Miyuki_Hino\\urban_firm_panels_fixed.shp")
# testing this

#poly1 = substr(myfiles, 27, 37)
#firm1 <- firm %>% filter(frm_d_2 == poly1)

myfiles1=myfiles_complete[1]
myfiles1=myfiles[1]

for (polygon in myfiles1) {
  poly1 = substr(polygon, 8, 18) # change when you go to a new folder; it needs to be the name of the panel.
  # such as, "3710976400J". This should not include shp or the folder name. 
  firm1 <- firm %>% filter(frm_d_2 == poly1)
  read1 <- st_read(polygon)
  read1 <- read1 %>% st_set_crs(st_crs(firm1))
  read2 <- st_transform(read1, st_crs(firm1))
  st_crs(firm1) ==st_crs(read2)
  subset <- read2[firm1, ] #clip
  #subset2 <- gUnaryUnion(subset, id = 'ZONE_LID_V')
  list_poly[[polygon]] <- subset
  
}

for (object1 in seq_along(list_poly)) {
  st_write(list_poly[[object1]], 
           paste(names(list_poly)[object1], "_clip_7.28.shp", sep= ""),
           sep = "\t",overwrite = TRUE)
}


#st_write(, "C:\\Users\\Owner\\Desktop\\Summer Project\\urban\\finishing_steps\\test4_dissol.shp")

#for (object1 in seq_along(list_poly)) {
#  st_write(list_poly[[object1]], 
 #             paste(names(list_poly)[object1], "_clip3.shp", sep= ""),
  #             sep = "\t",overwrite = TRUE)
#}
