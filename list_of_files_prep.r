library(plyr)
library(tidyverse)
library(data.table)
library(sf)
library(leaflet)
library(htmltools)

#setwd("../../Dropbox/Buyouts Project/Data/Buyout data (all sources)")

fldpanels <- st_read("C:\\Users\\Owner\\Desktop\\old files\\firm_panel.shp")
fldpanels$numchar <- sapply(fldpanels$EFFECTIVED, nchar)
fldpanels$yeareff <- mapply(dt = fldpanels$EFFECTIVED, numc = fldpanels$numchar, function(dt, numc) substr(dt, numc-3, numc))
fldpanels$yeareff <- as.numeric(fldpanels$yeareff)

recent <- fldpanels[fldpanels$yeareff >= 2015 & fldpanels$yeareff < 2021, ]
leaflet(st_transform(recent, 4326)) %>% addTiles() %>% addPolygons(popup = ~htmlEscape(recent$FIRM_PAN))
#  330 observations
# Lets get the images in the format that I can use to search for them.
recent2=transform(recent, firm_id_mod = paste(FIRM_ID,SUFFIX, sep = ""))

recent3 <- recent2 %>% mutate(letter = ifelse((SUFFIX == "K"), "J", ifelse((SUFFIX == "L"),"K", "L") ))        
recent3 <- transform(recent3, firm_id_mod2 = paste(FIRM_ID, letter, sep=""))
write_csv(recent3, "C:\\Users\\Owner\\Desktop\\Summer Project\\firm6.15.csv")     
st_write(recent3, "C:\\Users\\Owner\\Desktop\\Summer Project\\firm_panel_filtered.shp")
