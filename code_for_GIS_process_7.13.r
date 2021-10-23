# This process starts in R and finishes in Python. This takes PNG images, reclassifies them, and 
# turns them into TIFFs.

library(rgdal)
library(raster)
library(rgeos)
library(sf)
library(tidyverse)
library(readr)
setwd("C:\\Users\\Owner\\Desktop\\Summer Project\\urban") 
# this is one above your folder. Replace with your information.
mydir = "all_split" 
#this is your folder. Replace with your information
myfiles = list.files(path=mydir, pattern="*.png$", full.names=TRUE) 
# this lists multiple png files within your folder. I advise testing this with only one file
list_raster <- list() 
# run this to later populate
myfiles1 = myfiles[1:17]
# I select a subset of png files, though theoretically with a really good computer, you can probably run them all

for (png in myfiles1) {
  # This is the loop I run to change pngs to tiffs - better for GIS software
  rast1 <- raster(png, band = 3)
  
  
  reclass_df <- c(0, 0, 0,
                  1, 254, NA,
                  255, 255, 255,
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
  # This is the loop I run to export the newly created tiff files. After finishing this, run arcpy_code_7.13.py
  writeRaster(list_raster[[tif]], 
              paste(names(list_raster)[tif], ".tif", sep= ""),
              col.names = FALSE, row.names = FALSE, sep = "\t", quote = FALSE, overwrite = TRUE)
}

