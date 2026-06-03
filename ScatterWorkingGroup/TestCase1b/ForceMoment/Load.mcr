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
$!VarSet |SARCQ_Maps|      = ''
$!VarSet |SST_Maps|        = ''
$!VarSet |WMLES_Maps|      = ''
#-------------------------------------------------
# Grid Type Variants
#------------------------------
$!VarSet |PythonGrd_Maps| = ''
$!VarSet |CstmUsrAdp_Maps| = ''
#-------------------------------------------------

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
  $!IF     |ALPHA| == 0.00
    $!VarSet |Increment| = 7
  $!ELSEIF |ALPHA| == 0.50
    $!VarSet |Increment| = 7
  $!ENDIF
  $!RUNMACROFUNCTION "LoadData"
  $!INCLUDEMACRO "|MACROFILEPATH|/Plot.mcr"
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
  $!ELSEIF '|1|' == 'SARCQ_Maps'
     $!VarSet |SARCQ_Maps|      = '|SARCQ_Maps| |NumLineMaps|,'
  $!ELSEIF '|1|' == 'SST_Maps'
     $!VarSet |SST_Maps|        = '|SST_Maps| |NumLineMaps|,'
  $!ELSEIF '|1|' == 'WMLES_Maps'
     $!VarSet |WMLES_Maps|      = '|WMLES_Maps| |NumLineMaps|,'
  $!ENDIF
  # Assign LineMap to Grid Type Label
  $!IF     '|2|' == 'PythonGrd_Maps'
     $!VarSet |PythonGrd_Maps|  = '|PythonGrd_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrAdp_Maps| = '|CstmUsrAdp_Maps| |NumLineMaps|,'
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
#==================================================================================================
# Map01: 002.01
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/002_Embraer/01_CFD++_ClassicQuad_SA/DPW8-AePW4_ForceMoment_v5.dat"'
  ReadDataOption = New
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"GRID_LEVEL" "GRID_SIZE" "GRID_FAC" "MACH" "REY" "ALPHA" "CL_TOT" "CD_TOT" "CM_TOT" "CL_WING" "CD_WING" "CM_WING" "CD_PR" "CD_SF" "CL_TAIL" "CD_TAIL" "CM_TAIL" "CL_FUS" "CD_FUS" "CM_FUS" "CL_NAC" "CD_NAC" "CM_NAC" "CL_PY" "CD_PY" "CM_PY" "CPU_Hours" "DELTAT" "CTUSTART" "CTUAVG" "Q/E"'
$!ActiveLineMaps -= [1-|NumLineMaps|]
$!DeleteLineMaps    [1-|NumLineMaps|]
$!VarSet |Z| = (  0  + |Increment| )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map02: 003.01
$!VarSet |Z| = ( |NumZones| + |Increment| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/003_Boeing/01_OVERFLOW_Classic_Quad_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map03: 003.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/003_Boeing/02_FELight_Classic_Quad_SA-neg/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map04: 009.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/009_ONERA/01_elsA_ClassicQuad/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map05: 011.01
$!VarSet |Z| = ( |NumZones| + |Increment| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/011_HEMLAB/01_Classic/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map06: 011.02
$!VarSet |Z| = ( |NumZones| + |Increment| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/011_HEMLAB/02_Classic/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map07: 011.03
$!VarSet |Z| = ( |NumZones| + |Increment| + 8 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/011_HEMLAB/03_Adaptive/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrAdp_Maps" )
#-------------------------------------------------
# Map08: 011.04
$!VarSet |Z| = ( |NumZones| + |Increment| + 8 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/011_HEMLAB/04_Adaptive/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrAdp_Maps" )
#-------------------------------------------------
# Map09: 012.01
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/012_NASA_LARC_AB/01_FUN3D_NCFV_Classic_Quad/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map10: 012.02
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/012_NASA_LARC_AB/02_FUN3D_SFE_Classic_Quad/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map11: 012.03
$!VarSet |Z| = ( |NumZones| + |Increment| + 10 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/012_NASA_LARC_AB/03_FUN3D_NCFV_Adapt_Thin_BL/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrAdp_Maps" )
#-------------------------------------------------
# Map12: 012.04
$!VarSet |Z| = ( |NumZones| + |Increment| + 10 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/012_NASA_LARC_AB/04_FUN3D_SFE_Adapt_Thin_BL/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrAdp_Maps" )
#-------------------------------------------------
# Map13: 012.05
$!VarSet |Z| = ( |NumZones| + |Increment| + 10 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/012_NASA_LARC_AB/05_FUN3D_NCFV_Adapt_Full_BL/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrAdp_Maps" )
#-------------------------------------------------
# Map14: 012.06
$!VarSet |Z| = ( |NumZones| + |Increment| + 10 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/012_NASA_LARC_AB/06_FUN3D_SFE_Adapt_Full_BL/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrAdp_Maps" )
#-------------------------------------------------
# Map15: 029.01
$!VarSet |Z| = ( |NumZones| + |Increment| + 3 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/029_MIT_SANS/01_SANS_Metris/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrAdp_Maps" )
#-------------------------------------------------
# Map16: 029.02
$!VarSet |Z| = ( |NumZones| + |Increment| + 3 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/029_MIT_SANS/02_SANS_Classic_P1/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map17: 029.03
$!VarSet |Z| = ( |NumZones| + |Increment| + 3 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/029_MIT_SANS/03_SANS_Classic_P2/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map18: 029.04
$!VarSet |Z| = ( |NumZones| + |Increment| + 3 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/029_MIT_SANS/04_SANS_Classic_P3/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map19: 035.01
$!VarSet |Z| = ( |NumZones| + |Increment| - 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/035_MIT/01_STARCCM_Classic_QUAD/AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
#-------------------------------------------------
# Map20: 040.01
$!VarSet |Z0| = ( |NumZones| + 1 )
$!VarSet |Z| = ( |NumZones| + |Increment| )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1b/040_QinetiQ/040_ANSYS-FLUENT_Joukowski_RANS_Classic_quad_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "PythonGrd_Maps" )
$!VarSet |Z| = ( |Z| + 1 )
# CUSTOM
$!IF 1 == 1
  $!AlterData  [|Z0|-|NumZones|]
    IgnoreDivideByZero = Yes
    Equation = '{CD_TOT}={CD_AVG}'
  $!AlterData  [|Z0|-|NumZones|]
    IgnoreDivideByZero = Yes
    Equation = '{CL_TOT}={CL_AVG}'
  $!AlterData  [|Z0|-|NumZones|]
    IgnoreDivideByZero = Yes
    Equation = '{CM_TOT}={CM_AVG}'
  $!DeleteVars  [|NumVars|]
  $!DeleteVars  [|NumVars|]
  $!DeleteVars  [|NumVars|]
  $!DeleteVars  [|NumVars|]
  $!DeleteVars  [|NumVars|]
  $!DeleteVars  [|NumVars|]
$!ENDIF
#-------------------------------------------------
$!LineMap  [1]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\A'}}}
$!LineMap  [2]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\B'}}}
$!LineMap  [3]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\b'}}}
$!LineMap  [4]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\C'}}}
$!LineMap  [5]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\D'}}}
$!LineMap  [6]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\d'}}}
$!LineMap  [7]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\E'}}}
$!LineMap  [8]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\e'}}}
$!LineMap  [9]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\F'}}}
$!LineMap [10]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\f'}}}
$!LineMap [11]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\G'}}}
$!LineMap [12]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\g'}}}
$!LineMap [13]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\H'}}}
$!LineMap [14]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\h'}}}
$!LineMap [15]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\s'}}}
$!LineMap [16]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\S'}}}
$!LineMap [17]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\s'}}}
$!LineMap [18]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\S'}}}
$!LineMap [19]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\T'}}}
$!LineMap [20]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\U'}}}
#==================================================================================================
# Data Alterations
#-------------------------------------------------
# Calculate Grid Size Factor(s) based on GRID_SIZE variable
#----------------------------
# 1/h
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{h = N<sup>-1</sup>} = 1/({GRID_SIZE}**(1/1))'
$!VarSet |1_h| = |NumVars|
#----------------------------
# 1/(h^2)
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{DOF<sup>-1/2</sup>} = 1/({GRID_SIZE}**(1/2))'
# Equation = '{h = N<sup>-1/2</sup>} = 1/({GRID_SIZE}**(1/2))'
$!VarSet |1_h1o2| = |NumVars|
#----------------------------
# 1/(h^3)
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{h = N<sup>-1/3</sup>} = 1/({GRID_SIZE}**(1/3))'
#  Equation = '{1/h<sup>1/3</sup>} = 1/({GRID_SIZE}**(1/3))'
$!VarSet |1_h1o3| = |NumVars|
#----------------------------
# 1/(h^(2/3))
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{h = N<sup>-2/3</sup>} = 1/({GRID_SIZE}**(2/3))'
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

#----------------------------
# Error from average of finest adaptive results from 011.02/012.06/029.01
#                    Level NODES  GRIDFAC                MACH REY        ALPHA  CL_TOT          CD_TOT           CM_TOT          CL_WNG CD_WNG CM_WNG  CD_PR          CD_SF
#    ZONE T="011.03" 14   957937  0.000102906317         0.15 6000000.0  0.00   0.000010791900  0.007908593900  -0.000005425700  -999   -999   -999    -999           -999
#    ZONE T="011.04" 14   939992  0.000104211879         0.15 6000000.0  0.00  -0.000008886000  0.007907217300   0.000003940800  -999   -999   -999    -999           -999
#    ZONE T="012.05" 16  9497454  2.2297792388391213e-05 0.15 6000000.0  0.00   0.000000948649  0.007908687129  -0.000000205063  -999   -999   -999    0.001234991219 0.00667369591   
#    ZONE T="012.06" 16  9423146  2.2414861168829927e-05 0.15 6000000.0  0.00   0.000000023062  0.007903909975  -0.000000016860  -999   -999   -999    0.001234023563 0.006669886412  
#    ZONE T="029.01"  9   900774  4.1081572685535058e-11 0.15 6000000.0  0.00  -0.000027007763  0.007906634607   0.000005655421  -999   -999   -999    0.001240255265 0.006666379341  
# Use 029.01 or an average of a few???
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CD<sub>"Error"</sub>}=abs({CD_TOT} - ( 79.06634606680000565 ))'
#  Equation = '{CD<sub>"Error"</sub>}=abs({CD_TOT} - ( 79.08593900 +  79.07217300 +  79.08687129 +  79.03909975 +  79.06634607)/5)'
$!VarSet |CDerror| = |NumVars|
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CL<sub>"Error"</sub>}=abs({CL_TOT} - ( 0.000010791900 + -0.000008886000 +  0.000000948649 +  0.000000023062 + -0.000027007763)/5)'
$!VarSet |CLerror| = |NumVars|
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CM<sub>"Error"</sub>}=abs({CM_TOT} - (-0.000005425700 +  0.000003940800 + -0.000000205063 + -0.000000016860 +  0.000005655421)/5)'
$!VarSet |CMerror| = |NumVars|

#==================================================================================================
# Value blanking for data with AOA <= 0.00
#-------------------------------------------------
#$!Blanking Value { Include = Yes }
#$!Blanking Value { Constraint 1 { Include = Yes ValueCutoff = 0.00 VarA = 6 } }
#$!Blanking Value { Constraint 1 { Include = No } }

#==================================================================================================
# Assign Variable Names
#-------------------------------------------------
$!RenameDataSetVar Var = 6      Name = 'AoA'
$!RenameDataSetVar Var = 7      Name = 'CL<sub>Total</sub>'
$!RenameDataSetVar Var = 8      Name = 'CD<sub>Total</sub>'
$!RenameDataSetVar Var = 9      Name = 'CMy<sub>Total</sub>'
$!RenameDataSetVar Var = 10     Name = 'CL<sub>Wing</sub>'
$!RenameDataSetVar Var = 11     Name = 'CD<sub>Wing</sub>'
$!RenameDataSetVar Var = 12     Name = 'CMy<sub>Wing</sub>'
$!RenameDataSetVar Var = 13     Name = 'CD<sub>Pressure</sub>'
$!RenameDataSetVar Var = 14     Name = 'CD<sub>SkinFriction</sub>'
$!RenameDataSetVar Var = 15     Name = 'CL<sub>Tail</sub>'
$!RenameDataSetVar Var = 16     Name = 'CD<sub>Tail</sub>'
$!RenameDataSetVar Var = 17     Name = 'CMy<sub>Tail</sub>'
$!RenameDataSetVar Var = 18     Name = 'CL<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 19     Name = 'CD<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 20     Name = 'CMy<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 21     Name = 'CL<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 22     Name = 'CD<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 23     Name = 'CMy<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 24     Name = 'CL<sub>Pylon</sub>'
$!RenameDataSetVar Var = 25     Name = 'CD<sub>Pylon</sub>'
$!RenameDataSetVar Var = 26     Name = 'CMy<sub>Pylon</sub>'
$!RenameDataSetVar Var = 27     Name = 'CPU<sub>Hours</sub>'
$!RenameDataSetVar Var = 28     Name = '<greek>D</greek>T'
$!RenameDataSetVar Var = 29     Name = 'CTU<sub>Start</sub>'
$!RenameDataSetVar Var = 30     Name = 'Q/E'

# Convert drag quantities into counts
$!RenameDataSetVar Var = 8      Name = 'CD<sub>Total </sub>x<sub> </sub>10<sup>4</sup>'
$!RenameDataSetVar Var = 13     Name = 'CD<sub>Pressure </sub>x<sub> </sub>10<sup>4</sup>'
$!RenameDataSetVar Var = 14     Name = 'CD<sub>SkinFriction </sub>x<sub> </sub>10<sup>4</sup>'
$!RenameDataSetVar Var = |CDerror| Name = 'CD<sub>"Error" </sub>x<sub> </sub>10<sup>4</sup>'

#==================================================================================================
$!LineMap [1-|NumLineMaps|]  Symbols { Size = 1.0 }
$!XYLineAxis XDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset =  6 } }
$!XYLineAxis YDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset =  9 } }
$!XYLineAxis GridArea  { DrawBorder = Yes LineThickness = 0.1 }

$!LineMap  [1-|NumLineMaps|]      Lines   { LineThickness = 0.25 LinePattern = Solid  } Symbols { Size = 1.0 } Assign  { ShowInLegend = Auto }

#-------------------------------------------------
$!LinePlotLayers
  ShowSymbols = Yes

$!GlobalLinePlot
  DataLabels { DistanceSkip = 5 }
  Legend {
    Show = Yes
    TextShape { Height = 1.2 }
    Box { BoxType = None Margin = 5 }
    RowSpacing = 1.2
    XYPos { X = 88 Y = 10 }
    AnchorAlignment = BottomLeft
    }

$!ENDMACROFUNCTION
#===================================================================
