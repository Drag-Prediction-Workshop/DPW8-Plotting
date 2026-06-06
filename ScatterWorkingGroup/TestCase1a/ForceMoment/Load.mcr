#!MC 1410
$!Page Name = 'Untitled'
$!PageControl Create
$!NewLayout
$!FrameLayout ShowBorder = No
$!PrintSetup Palette = Color
$!ExportSetup UseSuperSampleAntiAliasing = Yes
$!ExportSetup ImageWidth = 2000

$!VarSet |ScatterRepo|   = 'DPW8-Scatter'
$!VarSet |BuffetRepo|    = 'DPW8-Buffet'
$!VarSet |StaticDefRepo| = 'DPW8-Static-Deform'

#===================================================================
#$!RUNMACROFUNCTION "Initialize"
##################################################
$!MACROFUNCTION
  NAME = "Initialize"
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
# TestCase Variants
#------------------------------
$!VarSet |TestCase1aa_Maps| = ''
$!VarSet |TestCase1a_Maps| = ''
$!VarSet |TestCase1b_Maps| = ''
$!VarSet |TestCase1c_Maps| = ''
#-------------------------------------------------
# Inactive Maps (non-existing data)
#------------------------------
$!VarSet |Inactive_Maps| = ''
#-------------------------------------------------
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '|CASE|' '|ALPHA|' )
##################################################
$!MACROFUNCTION
  NAME = "ReplaceTitleAlpha"
  #-----------------
  $!Pick AddAtPosition
    X = 5.0
    Y = 0.50
    ConsiderStyle = Yes
  $!Pick Clear
  $!AttachText 
    AnchorPos { X = 50 Y = 99 }
    TextShape { IsBold = No Height = 20 }
    Anchor = HeadCenter
  Text = 'Test Case |1|: ONERA OAT15A\nGrid Convergence Study\nAngle of Attack |2|'
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
##################################################
# Copy Template page
$!MACROFUNCTION
  NAME = "CopyPage"
  $!PageControl SetCurrentByName
    Name = '|1|'
  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy
  $!PageControl SetCurrentByName
    Name = '|2|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "AddYRange" ( 'CASE' '|COLOR|' 'X1' 'Y1' 'DY' 'Y2' )
##################################################
$!MACROFUNCTION
  NAME = "AddYRange"
  $!AttachGeom 
    AnchorPos { X = |3| Y = |4| }
    Color = |2|
    LineThickness = 0.4
    DrawOrder = BeforeData
    RawData
1
4
0.00005 0.0
0.00000 0.0
0.00000 |5|
0.00005 |5|
  $!Varset |X2| = (|3| - 0.00003)
  $!AttachText 
    PositionCoordSys = Grid
    AnchorPos { X = |X2| Y = |6| }
    TextShape { IsBold = Yes Height = 14 }
    Color = |2|
    Angle = 90
    Anchor = Center
    Text = '|1|'
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "ClearYRange"
##################################################
$!MACROFUNCTION
  NAME = "ClearYRange"
  $!Pick AddAllInRect
    SelectText = Yes
    SelectGeoms = Yes
    SelectMaps = Yes
    ConsiderStyle = Yes
    X1 = 2.25
    X2 = 3.35
    Y1 = 1.80
    Y2 = 7.20
  $!Pick Clear
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "ClearLabels"
##################################################
$!MACROFUNCTION
  NAME = "ClearLabels"
  $!AttachText 
    AnchorPos { X = 87.7 Y = 62.70 }
    TextShape { IsBold = No Height = 10 }
    Box { BoxType = Hollow }
    Anchor = Right
    Text = 'tmp'
  $!Pick AddAllInRect
    SelectText = Yes
    SelectGeoms = No
    SelectMaps = No
    ConsiderStyle = Yes
    X1 = 7.6
    X2 = 9.0
    Y1 = 2.9
    Y2 = 6.6
  $!Pick Clear
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "AddLabel" ( 'VAR' 'PAR' 'X' 'Y' )
##################################################
$!MACROFUNCTION
  NAME = "AddLabel"
  $!AttachText 
    AnchorPos { X = |3| Y = |4| }
    TextShape { IsBold = No Height = 10 }
    Box { BoxType = Hollow }
    Anchor = Right
    Text = '<greek>D</greek>|1| = |2|'
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "SetAxisView" ( 'XVar' 'YVar' )
##################################################
$!MACROFUNCTION
  NAME = "SetAxisView"
  $!XYLineAxis XDetail 1 {AutoGrid = Yes}
  $!XYLineAxis YDetail 1 {AutoGrid = Yes}
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |1| YAxisVar = |2|}
  $!View NiceFit
  $!View MakeCurrentViewNice
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '|GRID|', '|IMG1|', '|IMG2|' )
##################################################
$!MACROFUNCTION
  NAME = "LoadAndPlotGrid"
  $!RUNMACROFUNCTION "Initialize"
  $!NewLayout
  $!VarSet |GRID|  = '|1|'
  $!VarSet |ALPHA| = '-999'
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
  $!RUNMACROFUNCTION "Initialize"
  $!NewLayout
  $!VarSet |GRID|  = '-1'
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
  $!ELSEIF '|2|' == 'CstmUsrStr_Maps'
     $!VarSet |CstmUsrStr_Maps| = '|CstmUsrStr_Maps| |NumLineMaps|,'
  $!ENDIF
  # Assign LineMap to Test Case Label
  $!IF     '|3|' == '1aa'
     $!VarSet |TestCase1aa_Maps| = '|TestCase1aa_Maps| |NumLineMaps|,'
  $!ELSEIF '|3|' == '1a'
     $!VarSet |TestCase1a_Maps| = '|TestCase1a_Maps| |NumLineMaps|,'
  $!ELSEIF '|3|' == '1b'
     $!VarSet |TestCase1b_Maps| = '|TestCase1b_Maps| |NumLineMaps|,'
  $!ELSEIF '|3|' == '1c'
     $!VarSet |TestCase1c_Maps| = '|TestCase1c_Maps| |NumLineMaps|,'
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
# Map??:
#$!VarSet |Z| = ( 0 + |Increment| )
#$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_ForceMoment_v5.dat"'
#-------------------------------------------------
# Map??: 002.01
$!VarSet |Z| = ( 0 + |Increment| )
$!ReadDataSet  '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/002_Embraer/01_CFD++_CadenceUnstructured_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"'
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
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 002.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/002_Embraer/02_CFD++_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
  $!DeleteZones  [|Zdel|]
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 002.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/002_Embraer/03_CFD++_CadenceUnstructured_SST/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
  $!DeleteZones  [|Zdel|]
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 002.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/002_Embraer/04_CFD++_CadenceStructured_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
  $!DeleteZones  [|Zdel|]
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceStr_Maps" "1a" )
#-------------------------------------------------
# Map??: 002.05
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/002_Embraer/05_CFD++_HeldenMesh_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (Includes ALPHA=0.00 ... either skip that zone by incrementing |Z| or delete the zone)
  $!VarSet |Zdel| = ( |Z| - |Increment| + 7 )
  $!DeleteZones  [|Zdel|]
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "HeldenUnSt_Maps" "1a" )
#-------------------------------------------------
# Map??: 004.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/004_NASALangleyCAB/01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 004.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/004_NASALangleyCAB/02_SAR/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 004.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/004_NASALangleyCAB/03_SAQCR/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 005.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/005_LAVA_SteadyRANS_Results/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1aa" )
#-------------------------------------------------
# Map??: 005.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/005_LAVA_SteadyRANS_Results/02_SARC_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1aa" )
#-------------------------------------------------
# Map??: 006.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/006/01_LociChem/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 007.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/007_JAXA/01_FaSTAR_Cadence-Structured_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1aa" )
  # CUSTOM: Alpha (only ALPHA=1.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 007.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/007_JAXA/02_FaSTAR_Cadence-Structured_SA-noft2-R-QCR2000/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceStr_Maps" "1aa" )
  # CUSTOM: Alpha (only ALPHA=1.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 007.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/007_JAXA/03_FaSTAR_Cadence-Structured_SST-2003sust/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceStr_Maps" "1aa" )
  # CUSTOM: Alpha (only ALPHA=1.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 008.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/008_Metacomp/01_CFD++_Cadence_Structured/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceStr_Maps" "1aa" )
#-------------------------------------------------
# Map??: 009.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/009_ONERA/01_elsA_Cadence-structured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1a" )
#-------------------------------------------------
# Map??: 009.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/009_ONERA/02_elsA_Cadence-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 009.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/009_ONERA/03_elsA_Helden-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 5 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" "1a" )
  # CUSTOM: Grid (only 5 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 5
      $!ActiveLineMaps -= [|NumLineMaps|]
     $!IF "|GRID|" != "N"
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
     $!ENDIF
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map??: 009.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/009_ONERA/04_elsA_ONERA_O-structured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (9 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-9) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-9) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "OneraStruc_Maps" "1a" )
#-------------------------------------------------
# Map??: 009.05
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/009_ONERA/05_elsA_ONERA_O-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceStr_Maps" "1a" )
#-------------------------------------------------
# Map??: 009.06
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/009_ONERA/06_elsA_ONERA-Structured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 009.07
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/009_ONERA/07_CODA_ONERA-Structured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "HeldenUnSt_Maps" "1a" )
#-------------------------------------------------
# Map??: 011.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/011_HEMLAB/01_Structured/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1a" )
  # CUSTOM: Alpha (only ALPHA=1.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 011.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/011_HEMLAB/02_Adaptive/DPW8-AePW4_ForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1a" )
  # CUSTOM: Alpha (only ALPHA=1.50 and 2.50 submitted)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| == 1.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSEIF |ALPHA| == 2.50
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 014.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/014_IISc/01_SU2_Symmetric_BC/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 4 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
  # CUSTOM: Grid (only 4 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 4
      $!ActiveLineMaps -= [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map??: 014.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/014_IISc/02_SU2_Periodic_BC/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 4 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-4) )
  $!ENDIF
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
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
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map??: 015.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|StaticDefRepo|/TestCase1a/015_USArmySRD/01_FUN3D/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 015.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|StaticDefRepo|/TestCase1a/015_USArmySRD/02_FUN3D/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" "1aa" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 018.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/018_zCFD_steadyRANS/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 5 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
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
# Map??: 018.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/018_zCFD_steadyRANS/02_SST-V-2003/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 5 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-5) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" "1aa" )
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
# Map??: 020.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1aa" )
  # CUSTOM: 020.01 data needs updated (for Alpha=1.50).
  $!IF |ALPHA| == 1.50
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 020.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (only 3 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-3) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-3) )
  $!ENDIF
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
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
  $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map??: 020.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1aa" )
#-------------------------------------------------
# Map??: 020.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 023.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/023_PolytechniqueMontreal/01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: (KLUDGE) CM = -1 * CM because it appears to have the wrong sign
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = -1*V9'
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 024.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/024_UniversityofLiverpool/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 025.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|StaticDefRepo|/TestCase1a/025_TLGAerospace/01_STARCCM_CadenceUnstr_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 026.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/026_CorvidTechnologies/01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 026.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/026_CorvidTechnologies/02_SA_comp/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
# Map??: 027.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/027_RMIT/01_SST/DPW8-AePW4_ForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceStr_Maps" "1aa" )
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
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map??: 027.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/027_RMIT/02_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
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
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1aa" )
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
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
#-------------------------------------------------
# Map??: 029.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/029_MIT_SANS/01_SANS_refine/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (7 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-7) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-7) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1a" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#-------------------------------------------------
# Map??: 029.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/029_MIT_SANS/02_SANS_Metris/DPW8-AePW4_ForceMoment_v5.dat"' )
  # CUSTOM: Alpha (8 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-8) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-8) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1a" )
  # CUSTOM: Alpha (only ALPHA<=3.10)
  $!IF |Increment| > 6
    $!ActiveLineMaps -= [|NumLineMaps|]
    $!IF |ALPHA| <= 3.10
      $!ActiveLineMaps += [|NumLineMaps|]
    $!ELSE
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
    $!ENDIF
  $!ENDIF
#==================================================================================================
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 1
#-------------------------------------------------
# Map??: 010.01 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/010_Boeing/010_DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
  $!RUNMACROFUNCTION "AddLineMap" ( "WMLES_Maps" "CstmUsrUns_Maps" "1b" )
  # CUSTOM: Grid (only 3 Grid Zones)
  $!IF |Increment| <= 6
    $!IF |Increment| > 3
      $!ActiveLineMaps -= [|NumLineMaps|]
     $!IF "|GRID|" != "N"
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
     $!ENDIF
    $!ENDIF
  $!ELSE
   $!IF |GRID| == -1
      $!ActiveLineMaps -= [|NumLineMaps|]
      $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
   $!ENDIF
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!ActiveLineMaps += [|NumLineMaps|]
  $!ENDIF
$!ENDIF
#==================================================================================================
#-------------------------------------------------
# Map??: 012.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/01_SFE_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/02_SFE_SAneg_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/03_SFE_SAneg_QCR_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/04_NCFV_SAneg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.05
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/05_NCFV_SAneg_2ndOrderTurbConv/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.06
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/06_NCFV_SAneg_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.07
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/07_NCFV_SAneg_CC_2ndOrderTurbConv/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.08
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/08_NCFV_SAneg_QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.09
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/09_NCFV_SAneg_QCR_CC_2ndOrderTurbConv/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.10
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/10_NCFV_SAneg_QCR_RC_CC/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1a" )
#-------------------------------------------------
# Map??: 012.11
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/012_NASA_LARC_AB/11_NCFV_SAneg_QCR_RC_CC_2ndOrderTurbConv/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1a" )
#==================================================================================================
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 1
#-------------------------------------------------
# Map??: 005.03 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/005_LAVA_Curvilinear/03_ZDES_SAneg/DPW8-AePW4_UnsteadyForceMoment_LAVA_OAT15A_ZDES_SAneg_005.03.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "OneraStruc_Maps" "1b" )
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
    $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 005.04 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/005_LAVA_Curvilinear/04_ZDES_SAneg_blend2/DPW8-AePW4_UnsteadyForceMoment_LAVA_OAT15A_ZDES_SAneg_005.04.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "OneraStruc_Maps" "1b" )
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
    $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 005.05 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/005_LAVA_Curvilinear/05_URANS_SARCcomp/DPW8-AePW4_UnsteadyForceMoment_LAVA_OAT15A_URANS_SARC_CC_005.05.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "OneraStruc_Maps" "1b" )
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
    $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 008.02 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/008_Metacomp/02_CFD++_Deck/DPW8-AePW4_UnsteadyForceMoment_008.02.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "OneraStruc_Maps" "1b" )
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
    $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
$!ENDIF
#==================================================================================================
#-------------------------------------------------
# Map??: 028.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/028_BTI/01_BCFD_CadenceUnstructured_SA-noft2-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps"  "CadenceUnS_Maps" "1aa" )
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 028.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/028_BTI/02_BCFD_CadenceUnstructured_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 028.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/028_BTI/03_BCFD_HeldenMesh_SA-noft2-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "HeldenUnSt_Maps" "1aa" )
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 028.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/028_BTI/04_BCFD_HeldenMesh_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: Alpha (only 1 Grid Zones)
  $!IF |Increment| > 6
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
  $!IF "|GRID|" == "N"
    $!VarSet |Z| = ( |Z| - (6-1) )
  $!ENDIF
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" "1aa" )
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
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

#-------------------------------------------------
# Map??: 003.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/003_Boeing/02_OVERFLOW_Cadence_Structured_REV01_Grid3_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1a" )
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 003.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/003_Boeing/03_OVERFLOW_Cadence_Structured_REV01_Grid4_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1a" )
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 003.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/003_Boeing/04_OVERFLOW_UserCustom_Structured_SA_FSOT3/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrStr_Maps" "1a" )
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 003.05
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/003_Boeing/05_OVERFLOW_UserCustom_Structured_SA_FSOT1/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrStr_Maps" "1a" )
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 003.07
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/003_Boeing/07_T1EPIC_Adjoint_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1a" )
  $!AlterData  [|Z|]
     IgnoreDivideByZero = Yes
     Equation = '{GRID_SIZE}={GRID_SIZE}**(2/3)'
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
# Map??: 003.08
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/003_Boeing/08_T1EPIC_Hessian_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1a" )
  $!AlterData  [|Z|]
     IgnoreDivideByZero = Yes
     Equation = '{GRID_SIZE}={GRID_SIZE}**(2/3)'
  $!IF |ALPHA| != 1.50
     $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
  $!ENDIF
#-------------------------------------------------
$!LineMap [65]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\Z'}}}
$!LineMap [66]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\z'}}}
$!LineMap [67]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\Z'}}}
$!LineMap [68]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\z'}}}
$!LineMap [69]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\1'}}}
$!LineMap [70]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\1'}}}

#-------------------------------------------------
# Map??: 006.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/006/02_LociChem_URANS/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\1'}}}
#-------------------------------------------------
# Map??: 006.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/006/03_LociChen_HybridRANSLES/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\2'}}}
#-------------------------------------------------
# Map??: 006.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/006/04_LociChem_DHRL/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\2'}}}
#-------------------------------------------------
# Map??: 007.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/007_JAXA/04_FaSTAR_JAXA-Custom-Structured_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\2'}}}
#-------------------------------------------------
# Map??: 007.05
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/007_JAXA/05_FaSTAR_JAXA-Custom-Structured_SA-noft2-R/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\3'}}}
#-------------------------------------------------
# Map??: 007.06
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/007_JAXA/06_FaSTAR_JAXA-Custom-Structured_SA-noft2-R-QCR2000/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\3'}}}
#-------------------------------------------------
# Map??: 013.01
$!VarSet |Z| = ( |NumZones| + |Increment| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/01_SU2_EW-MC-QCR/DPW8-AePW4_ForceMoment_v5_013.01.dat"' )
  #-------------------------------------------------
  # CUSTOM: (KLUDGE) CM = -1 * CM because it appears to have the wrong sign
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = -1*V9'
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps"  "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\3'}}}
#-------------------------------------------------
# Map??: 013.02
$!VarSet |Z| = ( |NumZones| + |Increment| - 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/02_SU2_EW-MC/DPW8-AePW4_ForceMoment_v5_013.02.dat"' )
  #-------------------------------------------------
  # CUSTOM: (KLUDGE) CM = -1 * CM because it appears to have the wrong sign
  $!VarSet |Z0| = (|Z| - |Increment| + 1)
  $!AlterData  [|Z0|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V9 = -1*V9'
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\4'}}}
#-------------------------------------------------
## Map??: 013.03
#$!VarSet |Z| = ( |NumZones| + |Increment| )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/03_SU2_EW-MC_HLLC/DPW8-AePW4_ForceMoment_v5_013.03.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
##-------------------------------------------------
## Map??: 013.04
#$!VarSet |Z| = ( |NumZones| + |Increment| )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/04_SU2_EW-MC_HLLC2nd/DPW8-AePW4_ForceMoment_v5_013.04.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
##-------------------------------------------------
## Map??: 013.05
#$!VarSet |Z| = ( |NumZones| + |Increment| )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/05_SU2_EW-MC_Roe2nd/DPW8-AePW4_ForceMoment_v5_013.05.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
##-------------------------------------------------
## Map??: 013.06
#$!VarSet |Z| = ( |NumZones| + |Increment| )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/06_SU2_EW-MC_lowDispJST/DPW8-AePW4_ForceMoment_v5_013.06.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
##-------------------------------------------------
## Map??: 013.07
#$!VarSet |Z| = ( |NumZones| + |Increment| )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/07_SU2_EW-MC_HLLC2nc_VanAlbada/DPW8-AePW4_ForceMoment_v5_013.07.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
##-------------------------------------------------
## Map??: 013.08
#$!VarSet |Z| = ( |NumZones| + |Increment| )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/08_SU2_EW-MC_Roe2nd_VanAlbada/DPW8-AePW4_ForceMoment_v5_013.08.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
##-------------------------------------------------
## Map??: 013.09
#$!VarSet |Z| = ( |NumZones| + |Increment| )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/09_SU2_NEG-MC_HLLC2nd/DPW8-AePW4_ForceMoment_v5_013.09.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
##-------------------------------------------------
## Map??: 013.10
#$!VarSet |Z| = ( |NumZones| + |Increment| )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/013_Technion/10_SU2_SST_HLLC2nd/DPW8-AePW4_ForceMoment_v5_013.10.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
##-------------------------------------------------
# Map??: 021.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/021_CREATE/01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
  #-------------------------------------------------
  # CUSTOM: (KLUDGE) CM = -1 * CM because it appears to have the wrong sign
  #$!VarSet |Z0| = (|Z| - |Increment| + 1)
  #$!AlterData  [|Z0|-|NUMZONES|]
  #  IgnoreDivideByZero = Yes
  #  Equation = 'V9 = -1*V9'
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\4'}}}
#-------------------------------------------------
# Map??: 023.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/023_PolytechniqueMontreal/02_SA_BestPractice/DPW8-AePW4_ForceMoment_v5_mesh.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\4'}}}
#-------------------------------------------------
# Map??: 041.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/041_L3Harris/DPW8-AePW4_ForceMoment_v4_041.01.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\5'}}}
#-------------------------------------------------
# Map??: 042.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1a/042_Gulfstream/01_FUN3D_SA-NEG_QCR2000_Custom/SteadyFnM_042.01.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps"  "CadenceUnS_Maps" "1aa" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\5'}}}
#-------------------------------------------------

#==================================================================================================
#==================================================================================================
#==================================================================================================
$!IF 0 == 1
#-------------------------------------------------
# Map??: 005.12
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/005_LAVA_Unstructured/12_WMLES_L3C/005_12_DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "WMLES_Maps" "CstmUsrUns_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\A'}}}
#-------------------------------------------------
$!ENDIF
#-------------------------------------------------
# Map??: 007.07
$!VarSet |Z| = ( |NumZones| + |Increment| - 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/007_JAXA/07_FaSTAR_JAXA-Custom-Structured_SA-noft2/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrStr_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\5'}}}
#-------------------------------------------------
#-------------------------------------------------
# Map??: 007.08
$!VarSet |Z| = ( |NumZones| + |Increment| - 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/007_JAXA/08_FaSTAR_JAXA-Custom-Structured_SA-noft2-R/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrStr_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\6'}}}
#-------------------------------------------------
#-------------------------------------------------
# Map??: 007.09
$!VarSet |Z| = ( |NumZones| + |Increment| - 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/007_JAXA/09_FaSTAR_JAXA-Custom-Structured_SA-noft2-R-QCR2000/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CstmUsrStr_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\6'}}}
#-------------------------------------------------
$!IF 0 == 1
#-------------------------------------------------
# Map??: 008.03 (TestCase1b)
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/008_Metacomp/03_CFD++_DDES_Deck/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "WMLES_Maps" "OneraStruc_Maps" "1b" )
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
#-------------------------------------------------
$!ENDIF
#-------------------------------------------------
# Map??: 009.31
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/009_ONERA/31_elsA_Cadence-structured_SA/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceStr_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\6'}}}
#-------------------------------------------------
#-------------------------------------------------
# Map??: 009.32
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/009_ONERA/32_elsA_Cadence-unstructured_SA/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\7'}}}
#-------------------------------------------------
#-------------------------------------------------
# Map??: 009.33
$!VarSet |Z| = ( |NumZones| + |Increment| - 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/009_ONERA/33_elsA_Helden-unstructured_SA/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "HeldenUnSt_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\7'}}}
#-------------------------------------------------
#-------------------------------------------------
# Map??: 009.34
$!VarSet |Z| = ( |NumZones| + |Increment| - 4 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/009_ONERA/34_elsA_ONERA_O-structured_SA/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "OneraStruc_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\7'}}}
#-------------------------------------------------
#-------------------------------------------------
# Map??: 009.35
$!VarSet |Z| = ( |NumZones| + |Increment| - 4 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/009_ONERA/35_elsA_ONERA_O-unstructured_SA/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrUns_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\8'}}}
#-------------------------------------------------
#-------------------------------------------------
# Map??: 009.36
$!VarSet |Z| = ( |NumZones| + |Increment| + 3 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/009_ONERA/36_elsA_ONERA-Structured_SA/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "OneraStruc_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\8'}}}
#-------------------------------------------------
#-------------------------------------------------
# Map??: 012.12
$!VarSet |Z| = ( |NumZones| + |Increment| + 5 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/012_NASA_LARC_AB/12_NCFV_SST_QRC2020_CC/DPW8-AePW4_UnsteadyForceMoment_012.12.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps" "CadenceUnS_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\8'}}}
#-------------------------------------------------
$!IF 0 == 1
#-------------------------------------------------
# Map??: 013.11
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/013_Technion/11_SU2_EW-MC-QCR_dt=1e-5/DPW8-AePW4_UnsteadyForceMoment_v5_013.11.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1aa" )
#-------------------------------------------------
$!ENDIF
$!IF 0 == 1
#-------------------------------------------------
# Map??: 013.12
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/013_Technion/12_SU2_EW-MC-QCR_dt=2.5e-5/DPW8-AePW4_UnsteadyForceMoment_v5_013.12.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" "1b" )
#-------------------------------------------------
$!ENDIF
$!IF 0 == 1
#-------------------------------------------------
# Map??: 013.13
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/013_Technion/13_SU2_EW-MC_dt=2.5e-6/DPW8-AePW4_UnsteadyForceMoment_v5_013.13.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrStr_Maps" "1b" )
#-------------------------------------------------
$!ENDIF
$!IF 0 == 1
#-------------------------------------------------
# Map??: 013.14
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/013_Technion/14_SU2_EW-MC_dt=1e-5_HLLC/DPW8-AePW4_UnsteadyForceMoment_v5_013.14.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1b" )
#-------------------------------------------------
$!ENDIF
#-------------------------------------------------
# Map??: 013.15
$!VarSet |Z| = ( |NumZones| + |Increment| - 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/013_Technion/15_PowerFLOW_2D_grid_v20/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
    Equation = 'V9 = {CM_AVG}*1'
$!RUNMACROFUNCTION "AddLineMap" ( "WMLES_Maps" "CstmUsrUns_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\9'}}}
#-------------------------------------------------
$!IF 0 == 1
#-------------------------------------------------
# Map??: 014.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/014_IISc/03_SU2_Symmetric_BC/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1b" )
#-------------------------------------------------
$!ENDIF
#-------------------------------------------------
# Map??: 023.01
$!VarSet |Z| = ( |NumZones| + |Increment| - 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/023_PolytechniqueMontreal/01_SA_comp/DPW8-AePW4_UnsteadyForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1b" )
$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\9'}}}
#-------------------------------------------------
$!IF 0 == 1
#-------------------------------------------------
# Map??: 027.03
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/027_RMIT/03_SST/DPW8-AePW4_URANS_ForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" "1b" )
#-------------------------------------------------
$!ENDIF
$!IF 0 == 1
#-------------------------------------------------
# Map??: 027.04
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|BuffetRepo|/TestCase1b/027_RMIT/04_SA/DPW8-AePW4_URANS_ForceMoment_v5.dat"' )
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
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceStr_Maps" "1b" )
#-------------------------------------------------
#$!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Math    ASCIIChar = '\9'}}}
$!ENDIF
#==================================================================================================
#==================================================================================================
#==================================================================================================

#-------------------------------------------------
# Map??: 001.01
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/001_University_of_the_West_of_England/001_01_Fluent_CadenceStructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| - 1 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\0'}}}
$!ELSEIF |ALPHA| == 3.10
   $!VarSet |Z| = ( |NumZones| - 0 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\0'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 001.02
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/001_University_of_the_West_of_England/001_02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| - 1 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\!'}}}
$!ELSEIF |ALPHA| == 3.10
   $!VarSet |Z| = ( |NumZones| - 0 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\!'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 001.03
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/001_University_of_the_West_of_England/001_03_Fluent_CadenceStructured_SST/DPW8-AePW4_ForceMoment_v5.dat"' )
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| - 1 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps"  "CadenceStr_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\@'}}}
$!ELSEIF |ALPHA| == 3.10
   $!VarSet |Z| = ( |NumZones| - 0 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps"  "CadenceStr_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\@'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 001.04
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/001_University_of_the_West_of_England/001_04_Fluent_CadenceUnstructured_SST/DPW8-AePW4_ForceMoment_v5.dat"' )
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| - 1 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps"  "CadenceUnS_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\#'}}}
$!ELSEIF |ALPHA| == 3.10
   $!VarSet |Z| = ( |NumZones| - 0 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SST_Maps"  "CadenceUnS_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\#'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 001.05
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/001_University_of_the_West_of_England/001_05_Fluent_CadenceUnstructured_SA+QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| - 1 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps"  "CadenceUnS_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\$'}}}
$!ELSEIF |ALPHA| == 3.10
   $!VarSet |Z| = ( |NumZones| - 0 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps"  "CadenceUnS_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\$'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 001.05
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/001_University_of_the_West_of_England/001_06_Fluent_CadenceStructured_SA+QCR/DPW8-AePW4_ForceMoment_v5.dat"' )
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| - 1 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps"  "CadenceStr_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\%'}}}
$!ELSEIF |ALPHA| == 3.10
   $!VarSet |Z| = ( |NumZones| - 0 )
   $!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps"  "CadenceStr_Maps" "1aa" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\%'}}}
$!ENDIF
#-------------------------------------------------

#==================================================================================================
#==================================================================================================
#==================================================================================================
#-------------------------------------------------
# Map??: 1c/002.01
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/002_Embraer/01_CFD++_CadenceUnstructured-Rev02_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\A'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/002.02
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/002_Embraer/02_CFD++_CadenceStructured-Rev02_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\B'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/002.03
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 7 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/002_Embraer/03_CFD++_HeldenMesh-Rev02_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\C'}}}
$!ENDIF
#-------------------------------------------------
# Boeing_only_Scatter Plots
$!IF |ALPHA| == 1.50
   #-------------------------------------------------
   # Map??: 1c/003.01
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/003_Boeing/01_OVERFLOW_Cadence_Structured_REV02_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\D'}}}
   #-------------------------------------------------
   # Map??: 1c/003.02
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/003_Boeing/02_OVERFLOW_Cadence_Structured_REV02_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\E'}}}
   #-------------------------------------------------
   # Map??: 1c/003.03
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/003_Boeing/03_OVERFLOW_Cadence_Structured_REV02_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\F'}}}
   #-------------------------------------------------
   # Map??: 1c/003.04
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/003_Boeing/04_FELight_Cadence_Unstructured_REV02_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\G'}}}
   #-------------------------------------------------
   # Map??: 1c/003.05
   $!VarSet |Z| = ( |NumZones| + 7 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/003_Boeing/05_FELight_HeldenMesh_Unstructured_REV02_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\H'}}}
   #-------------------------------------------------
#   $!LineMap [65]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\A'}}}
#   $!LineMap [66]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\B'}}}
#   $!LineMap [67]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\C'}}}
#   $!LineMap [68]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\D'}}}
#   $!LineMap [69]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\E'}}}
#   $!LineMap [70]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\F'}}}
#   $!LineMap [71]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\G'}}}
#   $!LineMap [72]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\H'}}}
#   $!LineMap [73]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\K'}}}
#   $!LineMap [74]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\L'}}}
#   $!LineMap [75]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\M'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/009.01
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/009_ONERA/01_elsA_Cadence-Structured-REV02_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\J'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/011.01
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/011_HEMLAB/01_Structured/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\K'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/011.02
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 10 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/011_HEMLAB/02_Adaptive/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\L'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/011.03
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/011_HEMLAB/03_Unstructured/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\M'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/011.04
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 4 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/011_HEMLAB/04_HeldenMesh/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\N'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/012.01
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/012_NASA_LARC_AB/01_FUN3D_NCFV_Cadence/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\P'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/012.02
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/012_NASA_LARC_AB/02_FUN3D_SFE_Cadence/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\Q'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/012.03
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 7 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/012_NASA_LARC_AB/03_FUN3D_NCFV_Helden/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\R'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/012.04
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 7 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/012_NASA_LARC_AB/04_FUN3D_SFE_Helden/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "HeldenUnSt_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\S'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/012.05
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/012_NASA_LARC_AB/05_FUN3D_NCFV_Adapt/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\T'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/012.06
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/012_NASA_LARC_AB/06_FUN3D_SFE_Adapt/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\U'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 029.01
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + |Increment| )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/029_MIT_SANS/01_SANS_refine/DPW8-AePW4_ForceMoment_v5.dat"' )
     # CUSTOM: Alpha (7 Grid Zones)
     $!IF |Increment| > 6
       $!VarSet |Z| = ( |Z| - (6-7) )
     $!ENDIF
     $!IF "|GRID|" == "N"
       $!VarSet |Z| = ( |Z| - (6-7) )
     $!ENDIF
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1c" )
     # CUSTOM: Alpha (only ALPHA<=3.10)
     $!IF |Increment| > 6
       $!ActiveLineMaps -= [|NumLineMaps|]
       $!IF |ALPHA| <= 3.10
         $!ActiveLineMaps += [|NumLineMaps|]
       $!ELSE
         $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
       $!ENDIF
     $!ENDIF
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\S'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 029.02
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + |Increment| )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/029_MIT_SANS/02_SANS_Metris/DPW8-AePW4_ForceMoment_v5.dat"' )
     # CUSTOM: Alpha (8 Grid Zones)
     $!IF |Increment| > 6
       $!VarSet |Z| = ( |Z| - (6-8) )
     $!ENDIF
     $!IF "|GRID|" == "N"
       $!VarSet |Z| = ( |Z| - (6-8) )
     $!ENDIF
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CstmUsrAdp_Maps" "1c" )
     # CUSTOM: Alpha (only ALPHA<=3.10)
     $!IF |Increment| > 6
       $!ActiveLineMaps -= [|NumLineMaps|]
       $!IF |ALPHA| <= 3.10
         $!ActiveLineMaps += [|NumLineMaps|]
       $!ELSE
         $!VarSet |Inactive_Maps| = '|Inactive_Maps| |NumLineMaps|,'
       $!ENDIF
     $!ENDIF
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\s'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/040.01
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/040_QinetiQ/01_FLUENT_ONERA-OAT15A_Cadence_Unstructured_REV02_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\V'}}}
$!ENDIF
#-------------------------------------------------
# Map??: 1c/040.02
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| + 6 + 1 )
   $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/040_QinetiQ/02_FLUENT_ONERA-OAT15A_Cadence_Structured_REV02_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceStr_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\W'}}}
$!ENDIF
#-------------------------------------------------
#==================================================================================================
#==================================================================================================
#==================================================================================================

#-------------------------------------------------
# Map??: 035.01
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1c/035_MIT/035-01_Onera_ForceMoment.dat"' )
$!IF |ALPHA| == 1.50
   $!VarSet |Z| = ( |NumZones| )
   $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "CadenceUnS_Maps" "1c" )
   $!LineMap [|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = Yes FontOverride = UserDef ASCIIChar = '\^'}}}
$!ENDIF
#-------------------------------------------------

#==================================================================================================
# Data Alterations
#-------------------------------------------------
# Calculate Grid Size Factor(s) based on GRID_SIZE variable
#----------------------------
# 1/h
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{DOF<sup>-1</sup>} = 1/({GRID_SIZE})'
#  Equation = '{1/h} = 1/({GRID_SIZE})'
$!VarSet |1_h| = |NumVars|
#----------------------------
# 1/(h^(1/2))
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{DOF<sup>-1/2</sup>} = 1/({GRID_SIZE}**(1/2))'
# Equation = '{1/h<sup>2</sup>} = 1/({GRID_SIZE}**(1/2))'
$!VarSet |1_h1o2| = |NumVars|
#----------------------------
# 1/(h^(2/3))
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{1/h<sup>2/3</sup>} = 1/({GRID_SIZE}**(2/3))'
$!VarSet |1_h2o3| = |NumVars|

#----------------------------
# Convert drag quantities into counts
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CD_TOT} = {CD_TOT} * 10000.0'
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CD_PR} = {CD_PR}   * 10000.0'
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CD_SF} = {CD_SF}   * 10000.0'
#$!AlterData 
#  IgnoreDivideByZero = Yes
#  Equation = '{CD - CL<sup>2</sup>/(<greek>p</greek>*AR)} = {CD - CL<sup>2</sup>/(<greek>p</greek>*AR)} * 10000.0'

#----------------------------
# Error from average of finest adaptive results from 011.02/012.06/029.01/029.02
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CL<sub>"Error"</sub>}=abs({CL_TOT} - ( 0.8137398421 +  0.8134685241  +  0.8137247413633333926  +  0.8137718973980000436 )/4)'
$!VarSet |CLerror| = |NumVars|
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CD<sub>"Error" </sub>x<sub> </sub>10<sup>4</sup>}=abs({CD_TOT} - ( 150.006597 +  149.9117504 +  150.0363474733333417 +  150.0238274840000330)/4)'
$!VarSet |CDerror| = |NumVars|
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CM<sub>"Error"</sub>}=abs({CM_TOT} - (-0.1331333629 + -0.1331504792  + -0.1331568908766666837  + -0.1331598992830000106 )/4)'
$!VarSet |CMerror| = |NumVars|


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

# Convert drag quantities into counts
$!RenameDataSetVar Var = 8      Name = 'CD<sub>Total </sub>x<sub> </sub>10<sup>4</sup>'
$!RenameDataSetVar Var = 13     Name = 'CD<sub>Pressure </sub>x<sub> </sub>10<sup>4</sup>'
$!RenameDataSetVar Var = 14     Name = 'CD<sub>SkinFriction </sub>x<sub> </sub>10<sup>4</sup>'
#$!RenameDataSetVar Var = |CDi|  Name = 'CD - CL<sup>2</sup>/(<greek>p</greek>*AR) x<sub> </sub>10<sup>4</sup>'

#==================================================================================================
$!LineMap [1-|NumLineMaps|]  Symbols { Size = 1.0 }
$!LineMap [1-|NumLineMaps|]  Lines{LineThickness = 0.2}
$!XYLineAxis XDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 6 } }
$!XYLineAxis YDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 9 } }
$!XYLineAxis GridArea  { DrawBorder = Yes LineThickness = 0.1 }

$!LineMap [|TestCase1b_Maps|]  Lines{LinePattern = LongDash PatternLength = 0.8}

# Disable TestCase1b Maps
$!IF |IncludeTestCase1b| != 1
   $!ActiveLineMaps -= [|TestCase1b_Maps|]
$!ENDIF

# Disable TestCase1c Maps
$!IF 0 == 1
   $!ActiveLineMaps -= [|TestCase1c_Maps|]
$!ENDIF

# Disable inactive maps
$!ActiveLineMaps -= [|Inactive_Maps|]

#-------------------------------------------------
$!LinePlotLayers
  ShowSymbols = Yes

$!VarSet |LegendH| = 1.05
$!VarSet |LegendY| = 2
$!IF |ALPHA| == 1.50
  $!VarSet |LegendH| = 0.69
  $!VarSet |LegendY| = 2
$!ENDIF
$!GlobalLinePlot
  DataLabels { DistanceSkip = 5 }
  Legend {
    Show = Yes
    TextShape { Height = |LegendH| }
    Box { BoxType = None Margin = 5 }
    RowSpacing = 1
    XYPos { X = 88 Y = |LegendY| }
    AnchorAlignment = BottomLeft
    }

$!ENDMACROFUNCTION
#===================================================================
