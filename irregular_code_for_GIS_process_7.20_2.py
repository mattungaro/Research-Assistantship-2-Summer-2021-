# -*- coding: utf-8 -*-
"""
Created on Tue Jul 20 10:16:31 2021

@author: Owner
"""



import arcpy
from arcpy import env
from arcpy.sa import *
import os
import pandas as pd
import numpy as np
arcpy.env.overwriteOutput = True
arcpy.env.workspace = r"C:\Users\Owner\Desktop\Summer Project\urban\finishing_steps"

panels = r"C:\Users\Owner\Desktop\Summer Project\urban_firm_panels_fixed.shp"
clipped_HAZ_AR = r"C:\Users\Owner\Desktop\Summer Project\HAZ_AR_clipped.shp"
outFolder = r"C:\Users\Owner\Desktop\Summer Project\urban\finishing_steps"


rasters = arcpy.ListRasters("*", "TIF")

# Set local variables


for inRaster in rasters:
    clipped_HAZ_AR = r"C:\Users\Owner\Desktop\Summer Project\HAZ_AR_clipped.shp"
        # get the coordinate system by describing a feature class
  #  dsc = arcpy.Describe(clipped_HAZ_AR)
   # coord_sys = dsc.spatialReference
    
    # run the tool
   # arcpy.DefineProjection_management(inRaster, coord_sys)
    
    
    reclassField = "Value"
    outReclassify = Reclassify(inRaster, reclassField, RemapValue([[230, 1], [206, 2], [0, 0], [255, 0]]), "NODATA")
    poly = arcpy.RasterToPolygon_conversion(outReclassify, 
                         outFolder+"\\"+inRaster[0:11]+"poly.shp",
                                        
                                            "NO_SIMPLIFY","VALUE")
    
    arcpy.MultipartToSinglepart_management(poly,
                    outFolder+"\\"+inRaster[0:11]+"multisingle.shp")
