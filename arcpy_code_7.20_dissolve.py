# -*- coding: utf-8 -*-
"""
Created on Tue Jul 20 17:31:27 2021

@author: Owner
"""


from arcpy import env
from arcpy.sa import *
import os
import pandas as pd
import geopandas
import numpy as np
arcpy.env.overwriteOutput = True
arcpy.env.workspace = r"C:\Users\Owner\Desktop\Summer Project\urban\finishing_steps"
outFolder = r"C:\Users\Owner\Desktop\Summer Project\urban\finishing_steps"


polys = arcpy.ListFeatureClasses()

        
test = polys[0]
test =r"C:\Users\Owner\Desktop\Summer Project\urban\finishing_steps\test4.shp"
result = r"C:\Users\Owner\Desktop\Summer Project\urban\finishing_steps\test4_disolve.shp"
dissolvefield = ["ZONE_LID_V"]
arcpy.Dissolve_management(test,result, dissolvefield)

for InPoly in polys:
    outFolder = r"C:\Users\Owner\Desktop\Summer Project\urban\finishing_steps"
    zone = "ZONE_LID_V"
    arcpy.Dissolve_management(InPoly,
                          outFolder+"\\"+InPoly[0:11]+"dissolve.shp", zone, 
                         # [[zone, {"COUNT"}]], "MULTI_PART",
                          "DISSOLVE_LINES")
    #union?
    
    
    
    
for pol in polys:
    arcpy.Dissolve_management(pol,
                          ["ZONE_LID_V"],
                          [["ZONE_LID_V", {"COUNT"}]], "MULTI_PART",
                          "DISSOLVE_LINES")
    #union?
