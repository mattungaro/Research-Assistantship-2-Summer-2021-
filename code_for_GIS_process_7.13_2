# -*- coding: utf-8 -*-
"""
Created on Tue Jul 13 13:16:31 2021

@author: Owner
"""


import arcpy
from arcpy import env
from arcpy.sa import *
import os
arcpy.env.overwriteOutput = True
arcpy.env.workspace = r"C:\Users\Owner\Desktop\Summer Project\urban\all_split"


clipped_HAZ_AR = r"C:\Users\Owner\Desktop\Summer Project\HAZ_AR_clipped.shp"
outFolder =r"C:\Users\Owner\Desktop\Summer Project\urban\all_split"

rasters = arcpy.ListRasters("*", "TIF")
# make this folder only have tiff raster files - don't do this with png files


for inRaster in rasters:
    # This loop reclassifies the raster, converts the raster to a polygon,
    # unites the polygons into major parts, and then seperates them for editing in ArcGIS or QGIS
    clipped_HAZ_AR = r"C:\Users\Owner\Desktop\Summer Project\HAZ_AR_clipped.shp"
        # old note: get the coordinate system by describing a feature class
  # old note:  dsc = arcpy.Describe(clipped_HAZ_AR)
   # old note: coord_sys = dsc.spatialReference
    
    # old note: run the tool
   # old note: arcpy.DefineProjection_management(inRaster, coord_sys)
    
    
    reclassField = "Value"
    outReclassify = Reclassify(inRaster, reclassField, RemapValue([[0, 1], [255, 2], [1, 0]]), "NODATA")
    poly = arcpy.RasterToPolygon_conversion(outReclassify, 
                         outFolder+"\\"+inRaster[0:11]+"poly.shp",
                                        
                                            "NO_SIMPLIFY","VALUE")

    union = arcpy.Union_analysis([poly, clipped_HAZ_AR], 
                     outFolder+"\\"+inRaster[0:11]+"union.shp")

    arcpy.MultipartToSinglepart_management(union,
                    outFolder+"\\"+inRaster[0:11]+"multisingle.shp")
