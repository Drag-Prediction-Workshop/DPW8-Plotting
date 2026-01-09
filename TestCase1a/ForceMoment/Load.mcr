#!MC 1410
$!Page Name = 'Untitled'
$!PageControl Create
$!NewLayout
$!FrameLayout ShowBorder = No
$!PrintSetup Palette = Color
$!ExportSetup UseSuperSampleAntiAliasing = Yes
$!ExportSetup ImageWidth = 2000

#-------------------------------------------------
# Turbulence Model Variants
#------------------------------
$!VarSet |SA_Maps|         = ''
$!VarSet |SAQ_Maps|        = ''
$!VarSet |SST_Maps|        = ''
$!VarSet |WMLES_Maps|      = ''
#-------------------------------------------------
# Grid Type Variants
#------------------------------
$!VarSet |CadenceStr_Maps| = ''
$!VarSet |CadenceUnS_Maps| = ''
$!VarSet |HeldenUnSt_Maps| = ''
$!VarSet |OneraStruc_Maps| = ''
$!VarSet |CstmUsrAdp_Maps| = ''
$!VarSet |CstmUsrUns_Maps| = ''
$!VarSet |CstmUsrStr_Maps| = ''
#-------------------------------------------------

#===================================================================
#$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '|GRID|', '|IMG1|', '|IMG2|' )
##################################################
$!MACROFUNCTION
  NAME = "LoadAndPlotGrid"
  $!NewLayout
  $!VarSet |GRID|  = '|1|'
  $!VarSet |ALPHA| =  '0'
  $!VarSet |IMG1|  = '|2|'
  $!VarSet |IMG2|  = '|3|'
  $!IF '|GRID|' == 'N'
    $!VarSet |Increment| = 6
  $!ELSE
    $!VarSet |Increment| = |GRID|
  $!ENDIF
  $!RUNMACROFUNCTION "LoadData"
  $!INCLUDEMACRO "|MACROFILEPATH|/Plot_Grid.mcr"
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '|ALPHA|', '|IMG1|', '|IMG2|' )
##################################################
$!MACROFUNCTION
  NAME = "LoadAndPlotAlpha"
  $!NewLayout
  $!VarSet |GRID|  =  '0'
  $!VarSet |ALPHA| = '|1|'
  $!VarSet |IMG1|  = '|2|'
  $!VarSet |IMG2|  = '|3|'
  $!IF     |ALPHA| == 1.36
    $!VarSet |Increment| = 7
  $!ELSEIF |ALPHA| == 1.50
    $!VarSet |Increment| = 8
  $!ELSEIF |ALPHA| == 2.50
    $!VarSet |Increment| = 9
  $!ELSEIF |ALPHA| == 3.00
    $!VarSet |Increment| = 10
  $!ELSEIF |ALPHA| == 3.10
    $!VarSet |Increment| = 11
  $!ELSEIF |ALPHA| == 3.25
    $!VarSet |Increment| = 12
  $!ELSEIF |ALPHA| == 3.40
    $!VarSet |Increment| = 13
  $!ELSEIF |ALPHA| == 3.50
    $!VarSet |Increment| = 14
  $!ELSEIF |ALPHA| == 3.60
    $!VarSet |Increment| = 15
  $!ELSEIF |ALPHA| == 3.90
    $!VarSet |Increment| = 16
  $!ENDIF
  $!RUNMACROFUNCTION "LoadData"
  $!INCLUDEMACRO "|MACROFILEPATH|/Plot_Alpha.mcr"
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "AppendDataSetFile"
##################################################
$!MACROFUNCTION
  NAME = "AppendDataSetFile"
  $!ReadDataSet  '|1|'
    ReadDataOption = Append
    ResetStyle = No
    VarLoadMode = ByName
    AssignStrandIDs = Yes
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "AddLineMap"
##################################################
$!MACROFUNCTION
  NAME = "AddLineMap"
  $!IF |Z| > |NumZones|
    $!VarSet |Z| = |NumZones|
  $!ENDIF
  $!CreateLineMap
  $!LineMap [|NumLineMaps|]  Name = '&(ZONENAME[|Z|]%6.6s)'
  $!LineMap [|NumLineMaps|]  Assign{Zone = |Z|}
  $!ActiveLineMaps += [|NumLineMaps|]
  # Assign LineMap to Turbulence Model Label
  $!IF     '|1|' == 'SA_Maps'
     $!VarSet |SA_Maps|         = '|SA_Maps| |NumLineMaps|,'
  $!ELSEIF '|1|' == 'SAQ_Maps'
     $!VarSet |SAQ_Maps|        = '|SAQ_Maps| |NumLineMaps|,'
  $!ELSEIF '|1|' == 'SST_Maps'
     $!VarSet |SST_Maps|        = '|SST_Maps| |NumLineMaps|,'
  $!ELSEIF '|1|' == 'WMLES_Maps'
     $!VarSet |WMLES_Maps|      = '|WMLES_Maps| |NumLineMaps|,'
  $!ENDIF
  # Assign LineMap to Grid Type Label
  $!IF     '|2|' == 'CadenceStr_Maps'
     $!VarSet |CadenceStr_Maps| = '|CadenceStr_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CadenceUnS_Maps'
     $!VarSet |CadenceUnS_Maps| = '|CadenceUnS_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'HeldenUnSt_Maps'
     $!VarSet |HeldenUnSt_Maps| = '|HeldenUnSt_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'OneraStruc_Maps'
     $!VarSet |OneraStruc_Maps| = '|OneraStruc_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrAdp_Maps| = '|CstmUsrAdp_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrUns_Maps'
     $!VarSet |CstmUsrUns_Maps| = '|CstmUsrUns_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrStr_Maps| = '|CstmUsrStr_Maps| |NumLineMaps|,'
  $!ENDIF
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|',  'Grid|GRID|_|PlotName|',  '|ImageFormat|', '|ImageFormat2|' )
#$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', 'Alpha|ALPHA|_|PlotName|', '|ImageFormat|', '|ImageFormat2|' )
##################################################
$!MACROFUNCTION
  NAME = "ExportAndSave"
  $!VarSet |PATH| = '|1|'
  $!VarSet |FILE| = '|2|'
  $!VarSet |IMGF| = '|3|'
  $!VarSet |IMG2| = '|4|'
  $!IF     '|IMGF|' == 'eps'  # do nothing ... supported
  $!ELSEIF '|IMGF|' == 'png'  # do nothing ... supported
  $!ELSEIF '|IMGF|' == 'bmp'  # do nothing ... supported
  $!ELSEIF '|IMGF|' == 'jpeg' # do nothing ... supported
  $!ELSEIF '|IMGF|' == 'ps'   # do nothing ... supported
  $!ELSEIF '|IMGF|' == 'tiff' # do nothing ... supported
  $!ELSE
     $!VarSet |IMGF| = ''     # disabled ... unsupported
  $!ENDIF
  $!IF     '|IMG2|' == 'eps'  # do nothing ... supported
  $!ELSEIF '|IMG2|' == 'png'  # do nothing ... supported
  $!ELSEIF '|IMG2|' == 'bmp'  # do nothing ... supported
  $!ELSEIF '|IMG2|' == 'jpeg' # do nothing ... supported
  $!ELSEIF '|IMG2|' == 'ps'   # do nothing ... supported
  $!ELSEIF '|IMG2|' == 'tiff' # do nothing ... supported
  $!ELSE
     $!VarSet |IMG2| = ''     # disabled ... unsupported
  $!ENDIF
  $!RedrawAll
  $!IF '|IMG2|' != ''
    $!ExportSetup ExportFormat = |IMG2|
    $!ExportSetup ExportFName = '|PATH|/|IMG2|/|FILE|.|IMG2|'
   # Linux Command: Create ouput directory (not general)
   #$!SYSTEM 'mkdir -p |PATH|/|IMG2|'
    $!Export 
      ExportRegion = AllFrames
  $!ENDIF
  $!IF '|IMGF|' != ''
    $!ExportSetup ExportFormat = |IMGF|
    $!ExportSetup ExportFName = '|PATH|/|IMGF|/|FILE|.|IMGF|'
   # Linux Command: Create ouput directory (not general)
   #$!SYSTEM 'mkdir -p |PATH|/|IMGF|'
    $!Export
      ExportRegion = AllFrames
  $!ENDIF
 # Linux Command: Create ouput directory (not general)
 #$!SYSTEM 'mkdir -p |PATH|/lay'
  $!SaveLayout  '|PATH|/lay/|FILE|.lay'
    UseRelativePaths = Yes
  $!ExportSetup ExportFormat = |IMGF|
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "LoadData"
##################################################
$!MACROFUNCTION
  NAME = "LoadData"
#-------------------------------------------------
# Map00:
#$!VarSet |Z| = ( 0 + |Increment| )
#$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_ForceMoment_v5.dat"'
#-------------------------------------------------
# Map01: 002.01
$!VarSet |Z| = ( 0 + |Increment| )
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/01_CFD++_CadenceUnstructured_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"'
  ReadDataOption = New
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"GRID_LEVEL" "GRID_SIZE" "GRID_FAC" "MACH" "REY" "ALPHA" "CL_TOT" "CD_TOT" "CM_TOT" "CL_WING" "CD_WING" "CM_WING" "CD_PR" "CD_SF" "CL_TAIL" "CD_TAIL" "CM_TAIL" "CL_FUS" "CD_FUS" "CM_FUS" "CL_NAC" "CD_NAC" "CM_NAC" "CL_PY" "CD_PY" "CM_PY" "CPU_Hours" "DELTAT" "CTUSTART" "CTUAVG" "Q/E"'
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!IF 0 == 1
    $!IF |Increment| > 6
      $!VarSet |Z| = ( |Z| + 1 )
    $!ENDIF
  $!ELSE
    $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
    $!DeleteZones  [|Zdel|]
  $!ENDIF
$!ActiveLineMaps -= [1-|NumLineMaps|]
$!DeleteLineMaps    [1-|NumLineMaps|]
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map02: 002.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/02_CFD++_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
  $!DeleteZones  [|Zdel|]
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map03: 002.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/03_CFD++_CadenceUnstructured_SST/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
  $!DeleteZones  [|Zdel|]
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map04: 002.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/04_CFD++_CadenceStructured_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
  $!DeleteZones  [|Zdel|]
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceStr_Maps" )
#-------------------------------------------------
# Map05: 002.05
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/05_CFD++_HeldenMesh_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
  $!DeleteZones  [|Zdel|]
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "HeldenUnSt_Maps" )
#-------------------------------------------------
# Map06: 004.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map07: 004.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/02_SAR/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map08: 004.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/03_SAQCR/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map09: 005.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" )
#-------------------------------------------------
# Map10: 005.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/02_SARC_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" )
#-------------------------------------------------
# Map11: 006.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/006/01_LociChem/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map12: 007.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/01_FaSTAR_Cadence-Structured_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" )
  # CUSTOM: Alpha (only ALPHA=1.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map13: 007.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/02_FaSTAR_Cadence-Structured_SA-noft2-R-QCR2000/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceStr_Maps" )
  # CUSTOM: Alpha (only ALPHA=1.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map14: 007.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/03_FaSTAR_Cadence-Structured_SST-2003sust/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceStr_Maps" )
  # CUSTOM: Alpha (only ALPHA=1.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map15: 008.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/008_Metacomp/01_CFD++_Cadence_Structured/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceStr_Maps" )
#-------------------------------------------------
# Map16: 009.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/01_elsA_Cadence-structured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" )
#-------------------------------------------------
# Map17: 009.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/02_elsA_Cadence-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map18: 009.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/03_elsA_Helden-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 5 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" )
  # CUSTOM: Grid (only 5 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 5
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map19: 009.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/04_elsA_ONERA-Structured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (9 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-9) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-9) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "OneraStruc_Maps" )
#-------------------------------------------------
# Map20: 009.05
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/05_elsA_Cadence-structured_kwSST/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceStr_Maps" )
#-------------------------------------------------
# Map21: 009.06
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/06_elsA_Cadence-unstructured_kwSST/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map22: 009.07
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/07_elsA_Helden-unstructured_kwSST/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "HeldenUnSt_Maps" )
#-------------------------------------------------
# Map23: 009.08
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/08_elsA_ONERA-structured_kwSST/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (9 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-9) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-9) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "OneraStruc_Maps" )
#-------------------------------------------------
# Map24: 011.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/011_HEMLAB/01_Structured/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" )
  # CUSTOM: Alpha (only ALPHA=1.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map25: 011.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/011_HEMLAB/02_Adaptive/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (18 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-18) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-18) )
  $!ENDIF
  # CUSTOM: Alpha (only ALPHA=1.50 and 2.50 submitted)
  $!IF |Increment| > 6
    $!IF |ALPHA| == 1.50
      $!VarSet |Z| = ( |Z| - |Increment| + 6 + 1 )
    $!ENDIF
    $!IF |ALPHA| == 2.50
      $!VarSet |Z| = ( |Z| - |Increment| + 6 + 2 )
    $!ENDIF
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" )
  # CUSTOM: Alpha (only ALPHA=1.50 and 2.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
    $!IF |ALPHA| == 2.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map26: 014.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/014_IISc/01_SU2_Symmetric_BC/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 4 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
  # CUSTOM: Grid (only 4 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 4
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map27: 014.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/014_IISc/02_SU2_Periodic_BC/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 4 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
  # CUSTOM: Grid (only 4 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 4
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map28: 015.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/01_FUN3D/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map29: 015.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/02_FUN3D/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map30: 018.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 5 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
  # CUSTOM: Grid (only 5 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 5
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map31: 018.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/02_SST-V-2003/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 5 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" )
  # CUSTOM: Grid (only 5 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 5
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map32: 020.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" )
  # CUSTOM: 020.01 data needs updated.
  $!ActiveLineMaps -= [|NumLineMaps|]
#-------------------------------------------------
# Map33: 020.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 3 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-3) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-3) )
  $!ENDIF
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
  # CUSTOM: Grid (only 3 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 3
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-3) )
    $!ActiveLineMaps -= [|NumLineMaps|]
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
  # CUSTOM: 020.02 data is 1st order and needs updated.
  $!ActiveLineMaps -= [|NumLineMaps|]
#-------------------------------------------------
# Map34: 020.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" )
#-------------------------------------------------
# Map35: 020.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map36: 023.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/023_PolytechniqueMontreal/01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: (KLUDGE) CM = -1 * CM because it appears to have the wrong sign
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = -1*V9'
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map37: 024.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/024_UniversityofLiverpool/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat.txt"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map38: 025.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/025_TLGAerospace/01_STARCCM_CadenceUnstr_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map39: 026.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map40: 026.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/02_SA_comp/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map41: 027.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/027_RMIT/01_SST/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: (KLUDGE) CM = -1 * CM because it appears to have the wrong sign
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = -1*V9'
  #-------------------------------------------------
  # CUSTOM: Alpha (only 3 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-3) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-3) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceStr_Maps" )
  # CUSTOM: Grid (only 3 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 3
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map42: 027.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/027_RMIT/02_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: (KLUDGE) CM = -1 * CM because it appears to have the wrong sign
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = -1*V9'
  # CUSTOM: Alpha (only 4 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" )
  # CUSTOM: Grid (only 4 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 4
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map43: 029.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/01_SANS_refine/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (7 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-7) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-7) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map44: 029.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/02_SANS_Metris/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (8 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-8) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-8) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
#==================================================================================================
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 1
#-------------------------------------------------
# Map45: 010.01 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1b/010_Boeing/010_DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CL_AVG/CD_AVG/CM_AVG from unsteady datafile to CL/CD/CM from steady datafile
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CL_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V8 = {CD_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = {CM_AVG}'
  #-------------------------------------------------
  # CUSTOM: Alpha (only 3 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-3) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-3) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "WMLES_Maps" "CstmUsrUns_Maps" )
  # CUSTOM: Grid (only 3 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 3
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
$!ELSE
# Map45: 010.01 (TestCase1b)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/01_SFE_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "WMLES_Maps" "CstmUsrUns_Maps" )
$!ActiveLineMaps -= [|NumLineMaps|]
$!ENDIF
#==================================================================================================
#-------------------------------------------------
# Map46: 012.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/01_SFE_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map47: 012.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/02_SFE_SAneg_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map48: 012.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/03_SFE_SAneg_QCR_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map49: 012.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/04_NCFV_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map50: 012.05
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/05_NCFV_SAneg_2ndOrderTurbConv/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map51: 012.06
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/06_NCFV_SAneg_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map52: 012.07
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/07_NCFV_SAneg_CC_2ndOrderTurbConv/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map53: 012.08
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/08_NCFV_SAneg_QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map54: 012.09
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/09_NCFV_SAneg_QCR_CC_2ndOrderTurbConv/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map55: 012.10
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/10_NCFV_SAneg_QCR_RC_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map56: 012.11
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/11_NCFV_SAneg_QCR_RC_CC_2ndOrderTurbConv/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#==================================================================================================
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 1
#-------------------------------------------------
# Map57: 005.03 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/03_ZDES_SAneg/DPW8-AePW4_UnsteadyForceMoment_LAVA_OAT15A_ZDES_SAneg_005.03.dat"' )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CL_AVG/CD_AVG/CM_AVG from unsteady datafile to CL/CD/CM from steady datafile
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CL_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V8 = {CD_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = {CM_AVG}'
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "OneraStruc_Maps" )
  # CUSTOM: Grid (only 1 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 1
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
  # CUSTOM: Alpha (No Alpha Zones)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map58: 005.04 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/04_ZDES_SAneg_blend2/DPW8-AePW4_UnsteadyForceMoment_LAVA_OAT15A_ZDES_SAneg_005.04.dat"' )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CL_AVG/CD_AVG/CM_AVG from unsteady datafile to CL/CD/CM from steady datafile
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CL_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V8 = {CD_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = {CM_AVG}'
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "OneraStruc_Maps" )
  # CUSTOM: Grid (only 1 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 1
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
  # CUSTOM: Alpha (No Alpha Zones)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map59: 005.05 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/05_URANS_SARCcomp/DPW8-AePW4_UnsteadyForceMoment_LAVA_OAT15A_URANS_SARC_CC_005.05.dat"' )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CL_AVG/CD_AVG/CM_AVG from unsteady datafile to CL/CD/CM from steady datafile
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CL_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V8 = {CD_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = {CM_AVG}'
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "OneraStruc_Maps" )
  # CUSTOM: Grid (only 1 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 1
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
  # CUSTOM: Alpha (No Alpha Zones)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map60: 008.02 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1b/008_Metacomp/02_CFD++_Deck/DPW8-AePW4_UnsteadyForceMoment_008.02.dat"' )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CL_AVG/CD_AVG/CM_AVG from unsteady datafile to CL/CD/CM from steady datafile
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CL_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V8 = {CD_AVG}'
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = {CM_AVG}'
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "OneraStruc_Maps" )
  # CUSTOM: Grid (only 1 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 1
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ENDIF
  $!ENDIF
  $!IF '|GRID|' == 'N'
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
  # CUSTOM: Alpha (No Alpha Zones)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
  $!ENDIF
$!ENDIF
#==================================================================================================
#-------------------------------------------------
# Map61: 028.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/028_BRT/01_BCFD_CadenceUnstructured_SA-noft2-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map62: 028.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/028_BRT/02_BCFD_CadenceUnstructured_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" )
#-------------------------------------------------
# Map63: 028.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/028_BRT/03_BCFD_HeldenMesh_SA-noft2-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "HeldenUnSt_Maps" )
#-------------------------------------------------
# Map64: 028.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/028_BRT/04_BCFD_HeldenMesh_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" )
#==================================================================================================

#==================================================================================================
$!LineMap  [1]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\A'}}}
$!LineMap  [2]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\a'}}}
$!LineMap  [3]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\A'}}}
$!LineMap  [4]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\a'}}}
$!LineMap  [5]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\A'}}}
$!LineMap  [6]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\B'}}}
$!LineMap  [7]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\b'}}}
$!LineMap  [8]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\B'}}}
$!LineMap  [9]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\C'}}}
$!LineMap [10]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\c'}}}
$!LineMap [11]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\D'}}}
$!LineMap [12]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\E'}}}
$!LineMap [13]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\e'}}}
$!LineMap [14]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\E'}}}
$!LineMap [15]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\F'}}}
$!LineMap [16]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\G'}}}
$!LineMap [17]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\g'}}}
$!LineMap [18]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\G'}}}
$!LineMap [19]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\g'}}}
$!LineMap [20]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\G'}}}
$!LineMap [21]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\g'}}}
$!LineMap [22]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\H'}}}
$!LineMap [23]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\h'}}}
$!LineMap [24]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\I'}}}
$!LineMap [25]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\i'}}}
$!LineMap [26]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\J'}}}
$!LineMap [27]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\j'}}}
$!LineMap [28]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\K'}}}
$!LineMap [29]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\k'}}}
$!LineMap [30]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\L'}}}
$!LineMap [31]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\l'}}}
$!LineMap [32]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\M'}}}
$!LineMap [33]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\m'}}}
$!LineMap [34]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\M'}}}
$!LineMap [35]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\m'}}}
$!LineMap [36]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\N'}}}
$!LineMap [37]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\O'}}}
$!LineMap [38]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\P'}}}
$!LineMap [39]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\Q'}}}
$!LineMap [40]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\q'}}}
$!LineMap [41]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\R'}}}
$!LineMap [42]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\r'}}}
$!LineMap [43]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\S'}}}
$!LineMap [44]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\s'}}}
$!LineMap [46]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\U'}}}
$!LineMap [47]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\u'}}}
$!LineMap [48]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\U'}}}
$!LineMap [49]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\u'}}}
$!LineMap [50]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\U'}}}
$!LineMap [51]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\u'}}}
$!LineMap [52]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\V'}}}
$!LineMap [53]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\v'}}}
$!LineMap [54]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\V'}}}
$!LineMap [55]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\v'}}}
$!LineMap [56]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\V'}}}
#==============================
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 1
 $!LineMap [45] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\T'}}}
 $!LineMap [57] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\W'}}}
 $!LineMap [58] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\w'}}}
 $!LineMap [59] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\W'}}}
 $!LineMap [60] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\X'}}}
$!ENDIF
#==============================
$!LineMap [61]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\Y'}}}
$!LineMap [62]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\y'}}}
$!LineMap [63]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\Y'}}}
$!LineMap [64]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\y'}}}

#==================================================================================================
# Data Alterations
#-------------------------------------------------
# Calculate Grid Size Factor(s) based on GRID_SIZE variable
#----------------------------
# 1/h
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{1/h} = 1/({GRID_SIZE}**(1/2))'
$!VarSet |1_h| = |NumVars|
#----------------------------
# 1/(h^2)
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{1/h<sup>2</sup>} = 1/({GRID_SIZE}**(1/2))'
$!VarSet |1_h2| = |NumVars|
#----------------------------
# 1/(h^(2/3))
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{1/h<sup>2/3</sup>} = 1/({GRID_SIZE}**(2/3))'
$!VarSet |1_h2o3| = |NumVars|

#==================================================================================================
# Value blanking for data with AOA <= 1.00
#-------------------------------------------------
$!Blanking Value { Include = Yes }
$!Blanking Value { Constraint 1 { Include = Yes ValueCutoff = 1.00 VarA = 6 } }

#==================================================================================================
# Assign Variable Names
#-------------------------------------------------
$!RenameDataSetVar Var = 6  Name = 'AoA'
$!RenameDataSetVar Var = 7  Name = 'CL<sub>Total</sub>'
$!RenameDataSetVar Var = 8  Name = 'CD<sub>Total</sub>'
$!RenameDataSetVar Var = 9  Name = 'CMy<sub>Total</sub>'
$!RenameDataSetVar Var = 10 Name = 'CL<sub>Wing</sub>'
$!RenameDataSetVar Var = 11 Name = 'CD<sub>Wing</sub>'
$!RenameDataSetVar Var = 12 Name = 'CMy<sub>Wing</sub>'
$!RenameDataSetVar Var = 13 Name = 'CD<sub>Pressure</sub>'
$!RenameDataSetVar Var = 14 Name = 'CD<sub>SkinFriction</sub>'
$!RenameDataSetVar Var = 15 Name = 'CL<sub>Tail</sub>'
$!RenameDataSetVar Var = 16 Name = 'CD<sub>Tail</sub>'
$!RenameDataSetVar Var = 17 Name = 'CMy<sub>Tail</sub>'
$!RenameDataSetVar Var = 18 Name = 'CL<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 19 Name = 'CD<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 20 Name = 'CMy<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 18 Name = 'CL<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 19 Name = 'CD<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 20 Name = 'CMy<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 18 Name = 'CL<sub>Pylon</sub>'
$!RenameDataSetVar Var = 19 Name = 'CD<sub>Pylon</sub>'
$!RenameDataSetVar Var = 20 Name = 'CMy<sub>Pylon</sub>'

#==================================================================================================
$!LineMap [1-|NumLineMaps|]  Symbols { Size = 1.0 }
$!XYLineAxis XDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 6 } }
$!XYLineAxis YDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 9 } }
$!XYLineAxis GridArea  { DrawBorder = Yes LineThickness = 0.1 }

#-------------------------------------------------
$!LinePlotLayers
  ShowSymbols = Yes

$!GlobalLinePlot
  DataLabels { DistanceSkip = 5 }
  Legend {
    Show = Yes
    TextShape { Height = 1.20 }
    Box { BoxType = None Margin = 5 }
    RowSpacing = 1
    XYPos { X = 88 Y = 10 }
    AnchorAlignment = BottomLeft
    }

$!ENDMACROFUNCTION
#===================================================================
