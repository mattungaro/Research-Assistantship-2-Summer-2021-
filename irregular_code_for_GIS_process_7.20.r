library(rgdal)
library(raster)
library(rgeos)
library(sf)
library(tidyverse)
library(readr)

setwd('C:\\Users\\Owner\\Desktop\\Summer Project\\urban\\all_split')
mydir = "irregular_code_test"
myfiles = list.files(path=mydir, pattern="*.png", full.names=TRUE)
list_raster <- list()
myfiles1 = myfiles[1:3]

for (png in myfiles1) {
  
rast1 <- raster(png, band = 1)

reclass_df <- c(206, 206, 206,
                0,0,0,
                255,255,255,
                1, 205, NA,
                207, 229, NA,
                230, 230, 230,
                231, 254, NA,
                256, Inf, NA)
reclass_df
reclass_m <- matrix(reclass_df,
                    ncol = 3,
                    byrow = TRUE)
reclass_m
chm_classified <- reclassify(rast1,
                             reclass_m)
list_raster[[png]] <- chm_classified


}
for (tif in seq_along(list_raster)) {
  writeRaster(list_raster[[tif]], 
              paste(names(list_raster)[tif], ".tif", sep= ""),
              col.names = FALSE, row.names = FALSE, sep = "\t", quote = FALSE, overwrite = TRUE)
}
