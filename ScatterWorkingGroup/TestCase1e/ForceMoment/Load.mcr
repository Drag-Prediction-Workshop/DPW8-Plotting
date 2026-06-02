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
$!VarSet |CadenceUnSTet_Maps| = ''
$!VarSet |CadenceUnSVox_Maps| = ''
$!VarSet |CadenceUnSTet1_Maps| = ''
$!VarSet |CadenceUnSVox1_Maps| = ''
$!VarSet |HeldenUnSt_Maps| = ''
$!VarSet |CstmUsrAdp_Maps| = ''
$!VarSet |CstmUsrUns_Maps| = ''
$!VarSet |CstmUsrStr_Maps| = ''
#-------------------------------------------------
# Wing Type Variants
#------------------------------
$!VarSet |WING1_Maps| = ''
$!VarSet |WING2_Maps| = ''
#-------------------------------------------------
# DPW3 Variants
#------------------------------
$!VarSet |DPW3_Maps| = ''
$!VarSet |DPW3_Map1| = ''
#-------------------------------------------------

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
  $!IF     |ALPHA| == 0.50
    $!VarSet |Increment| = 8
  $!ELSEIF |ALPHA| == 1.50
    $!VarSet |Increment| = 8
  $!ENDIF
  $!RUNMACROFUNCTION "LoadData"
  $!INCLUDEMACRO "|MACROFILEPATH|/Plot.mcr"
$!ENDMACROFUNCTION
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
#$!RUNMACROFUNCTION "CalculateDeltas" ( 8 16 )
##################################################
$!MACROFUNCTION
  NAME = "CalculateDeltas"
 #-----------------------
  $!AlterData  [|1|,|2|]
    Equation = '{<greek>D</greek>CL<sub>Total</sub>}        = 0.0'
  $!IF "|dCL|" == ""
    $!VarSet |dCL| = |NumVars|
  $!ENDIF
  $!AlterData  [|1|,|2|]
    Equation = '{<greek>D</greek>CMy<sub>Total</sub>}       = 0.0'
  $!IF "|dCMy|" == ""
    $!VarSet |dCMy| = |NumVars|
  $!ENDIF
  $!AlterData  [|1|,|2|]
    Equation = '{<greek>D</greek>CD<sub>Total</sub>}        = 0.0'
  $!IF "|dCD|" == ""
    $!VarSet |dCD| = |NumVars|
  $!ENDIF
  $!AlterData  [|1|,|2|]
    Equation = '{<greek>D</greek>CD<sub>Pressure</sub>}     = 0.0'
  $!IF "|dCDp|" == ""
    $!VarSet |dCDp| = |NumVars|
  $!ENDIF
  $!AlterData  [|1|,|2|]
    Equation = '{<greek>D</greek>CD<sub>SkinFriction</sub>} = 0.0'
  $!IF "|dCDv|" == ""
    $!VarSet |dCDv| = |NumVars|
  $!ENDIF
 #-----------------------
  $!AlterData  [|1|]
    IgnoreDivideByZero = Yes
    Equation = '{<greek>D</greek>CL<sub>Total</sub>}        = ({CL_TOT}[|2|] - {CL_TOT}[|1|])'
  $!AlterData  [|1|]
    IgnoreDivideByZero = Yes
    Equation = '{<greek>D</greek>CMy<sub>Total</sub>}       = ({CM_TOT}[|2|] - {CM_TOT}[|1|])'
  $!AlterData  [|1|]
    IgnoreDivideByZero = Yes
    Equation = '{<greek>D</greek>CD<sub>Total</sub>}        = ({CD_TOT}[|2|] - {CD_TOT}[|1|])'
  $!AlterData  [|1|]
    IgnoreDivideByZero = Yes
    Equation = '{<greek>D</greek>CD<sub>Pressure</sub>}     = ({CD_PR}[|2|]  - {CD_PR}[|1|])'
  $!AlterData  [|1|]
    IgnoreDivideByZero = Yes
    Equation = '{<greek>D</greek>CD<sub>SkinFriction</sub>} = ({CD_SF}[|2|]  - {CD_SF}[|1|])'
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
  $!IF     '|2|' == 'CadenceUnSTet_Maps'
     $!VarSet |CadenceUnSTet_Maps| = '|CadenceUnSTet_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CadenceUnSVox_Maps'
     $!VarSet |CadenceUnSVox_Maps| = '|CadenceUnSVox_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CadenceUnSTet1_Maps'
     $!VarSet |CadenceUnSTet1_Maps| = '|CadenceUnSTet1_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CadenceUnSVox1_Maps'
     $!VarSet |CadenceUnSVox1_Maps| = '|CadenceUnSVox1_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'HeldenUnSt_Maps'
     $!VarSet |HeldenUnSt_Maps|    = '|HeldenUnSt_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrAdp_Maps|    = '|CstmUsrAdp_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrUns_Maps'
     $!VarSet |CstmUsrUns_Maps|    = '|CstmUsrUns_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrStr_Maps|    = '|CstmUsrStr_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'DPW3_Maps'
     $!VarSet |DPW3_Maps|          = '|DPW3_Maps|          |NumLineMaps|,'
  $!ENDIF
  # Assign LineMap to Wing Type Label
  $!IF     '|3|' == 'WING1'
    $!VarSet |WING1_Maps| = '|WING1_Maps| |NumLineMaps|,'
  $!ELSEIF '|3|' == 'WING2'
    $!VarSet |WING2_Maps| = '|WING2_Maps| |NumLineMaps|,'
  $!ENDIF
  # Do not show WING2 linemaps
  $!IF     '|3|' == 'WING2'
    $!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
  $!ENDIF
  # Do not show DPW3_Maps linemaps
  $!IF     '|2|' == 'DPW3_Maps'
    $!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
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
#==================================================================================================
# Map00: Placeholder file
#-------------------------------------------------
$!VarSet |Z| = ( 0 + |Increment| )
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_ForceMoment_v6.dat"'
  ReadDataOption = New
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"GRID_LEVEL" "GRID_SIZE" "GRID_FAC" "MACH" "REY" "ALPHA" "CL_TOT" "CD_TOT" "CM_TOT" "CL_WING" "CD_WING" "CM_WING" "CD_PR" "CD_SF" "CL_TAIL" "CD_TAIL" "CM_TAIL" "CL_FUS" "CD_FUS" "CM_FUS" "CL_NAC" "CD_NAC" "CM_NAC" "CL_PY" "CD_PY" "CM_PY" "CPU_Hours" "DELTAT" "CTUSTART" "CTUAVG" "Q/E"'
$!ActiveLineMaps -= [1-|NumLineMaps|]
$!DeleteLineMaps    [1-|NumLineMaps|]
#==================================================================================================
#-------------------------------------------------
# Establish deltas between Wing1/Wing2
#----------------------------
$!VarSet |dCL|  = ""
$!VarSet |dCMy| = ""
$!VarSet |dCD|  = ""
$!VarSet |dCDp| = ""
$!VarSet |dCDv| = ""
#==================================================================================================
$!IF 1 == 1
#==================================================================================================
# Dataset: 301.01
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW3/301_FUN3D_Lee-Rausch_Rumsey/01_SA/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING1" )
$!VarSet |DPW3_Map1| = |NumLineMaps|
$!LineMap [|NumLineMaps|]  Name = 'DPW3'
$!LineMap [|NumLineMaps|]  Assign{ShowInLegend = Auto}
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 2 )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
# Calculate deltas between Wing1/Wing2
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#
#$!VarSet |N0| = ( |NumLineMaps| - 1 )
#$!LineMap [|N0|-|NumLineMaps|]  Lines   { Color = Red    } Symbols {Color = Red    FillColor = Red    SymbolShape {IsASCII = Yes ASCIIShape {FontOverride = UserDef ASCIIChar = '\1'}}}
#-------------------------------------------------
# Dataset: 302.01
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW3/302_NSU3D_Mavriplis/01_SA/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 2 )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#
#$!VarSet |N0| = ( |NumLineMaps| - 1 )
#$!LineMap [|N0|-|NumLineMaps|]  Lines   { Color = Green  } Symbols {Color = Green  FillColor = Green  SymbolShape {IsASCII = Yes ASCIIShape {FontOverride = UserDef ASCIIChar = '\2'}}}
#-------------------------------------------------
# Dataset: 303.01
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW3/303_OVERFLOW_Sclafani/01_SA/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 2 )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#
#$!VarSet |N0| = ( |NumLineMaps| - 1 )
#$!LineMap [|N0|-|NumLineMaps|]  Lines   { Color = Blue   } Symbols {Color = Blue   FillColor = Blue   SymbolShape {IsASCII = Yes ASCIIShape {FontOverride = UserDef ASCIIChar = '\3'}}}
#-------------------------------------------------
# Dataset: 305.01
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW3/305_NSU3D_Zickuhr/01_SA/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 2 )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#
#$!VarSet |N0| = ( |NumLineMaps| - 1 )
#$!LineMap [|N0|-|NumLineMaps|]  Lines   { Color = Purple } Symbols {Color = Purple FillColor = Purple SymbolShape {IsASCII = Yes ASCIIShape {FontOverride = UserDef ASCIIChar = '\5'}}}
#-------------------------------------------------
# Dataset: 306.01
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW3/306_CFL3D_Tinoco/01_SA/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 2 )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#
#$!VarSet |N0| = ( |NumLineMaps| - 1 )
#$!LineMap [|N0|-|NumLineMaps|]  Lines   { Color = Custom3  } Symbols {Color = Custom3  FillColor = Custom3  SymbolShape {IsASCII = Yes ASCIIShape {FontOverride = UserDef ASCIIChar = '\6'}}}
#-------------------------------------------------
# Dataset: 306.02
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW3/306_CFL3D_Tinoco/02_SST/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 2 )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#
#$!VarSet |N0| = ( |NumLineMaps| - 1 )
#$!LineMap [|N0|-|NumLineMaps|]  Lines   { Color = Custom32 } Symbols {Color = Custom32 FillColor = Custom32 SymbolShape {IsASCII = Yes ASCIIShape {FontOverride = UserDef ASCIIChar = '\7'}}}
#-------------------------------------------------
# Dataset: 307.01
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW3/307_TAU_Brodersen/01_SA/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 2 )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#
#$!VarSet |N0| = ( |NumLineMaps| - 1 )
#$!LineMap [|N0|-|NumLineMaps|]  Lines   { Color = Custom29 } Symbols {Color = Custom29 FillColor = Custom29 SymbolShape {IsASCII = Yes ASCIIShape {FontOverride = UserDef ASCIIChar = '\8'}}}
#-------------------------------------------------
# Dataset: 308.01
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 2 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW3/308_FLUENT_Scheidegger/01_KE/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 2 )
$!RUNMACROFUNCTION "AddLineMap" ( "DPW3_Maps" "DPW3_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#
#$!VarSet |N0| = ( |NumLineMaps| - 1 )
#$!LineMap [|N0|-|NumLineMaps|]  Lines   { Color = Custom15 } Symbols {Color = Custom15 FillColor = Custom15 SymbolShape {IsASCII = Yes ASCIIShape {FontOverride = UserDef ASCIIChar = '\9'}}}
#==================================================================================================
$!ENDIF
#==================================================================================================
# Map01: 003.01
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 4 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1d/003_Boeing/01_FELight_HeldenMesh_Unstructured_REV00_SA-neg/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "HeldenUnSt_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 8 )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "HeldenUnSt_Maps" "WING2")
$!VarSet |Z2| = |Z|
#
$!VarSet |N0| = ( |NumLineMaps| - 1 )
$!LineMap [|N0|-|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\A'}}}
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#-------------------------------------------------
# Map02: 003.02
#-------------------------------------------------
$!IF 0 == 1
  $!VarSet |Z| = ( |NumZones| + 3 )
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1d/003_Boeing/02_FELight_Cadence_Unstructured_HexTrex_TetFF_REV00_SA-neg/DPW8-AePW4_ForceMoment_v6.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSTet_Maps" "WING1" )
 #$!ActiveLineMaps -= [|NumLineMaps|]
  $!VarSet |Z1| = |Z|
  $!VarSet |Z| = ( |Z| + 7 )
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSTet_Maps" "WING2" )
 #$!ActiveLineMaps -= [|NumLineMaps|]
  $!VarSet |Z2| = |Z|
 #
  $!VarSet |N0| = ( |NumLineMaps| - 1 )
  $!LineMap [|N0|-|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\a'}}}
 #
  $!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
$!ENDIF
#-------------------------------------------------
# Map03: 003.03
#-------------------------------------------------
$!IF 0 == 1
  $!VarSet |Z| = ( |NumZones| + 3 )
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1d/003_Boeing/03_FELight_Cadence_Unstructured_HexTrex_VoxFF_REV00_SA-neg/DPW8-AePW4_ForceMoment_v6.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSVox_Maps" "WING1" )
 #$!ActiveLineMaps -= [|NumLineMaps|]
  $!VarSet |Z1| = |Z|
  $!VarSet |Z| = ( |Z| + 7 )
  $!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSVox_Maps" "WING2" )
 #$!ActiveLineMaps -= [|NumLineMaps|]
  $!VarSet |Z2| = |Z|
  #
  $!VarSet |N0| = ( |NumLineMaps| - 1 )
  $!LineMap [|N0|-|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\A'}}}
  #
  $!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
$!ENDIF
#-------------------------------------------------
# Map13: 002.03
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1e/002_Embraer/03_CFD++_HeldenMesh-Rev00_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "HeldenUnSt_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 9 )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "HeldenUnSt_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!VarSet |N0| = ( |NumLineMaps| - 1 )
$!LineMap [|N0|-|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\B'}}}
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#-------------------------------------------------
# Map11: 002.04
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1e/002_Embraer/04_CFD++_CadenceTetFF-Rev01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSTet1_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 9 )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSTet1_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!VarSet |N0| = ( |NumLineMaps| - 1 )
$!LineMap [|N0|-|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\b'}}}
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#-------------------------------------------------
# Map12: 002.05
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1e/002_Embraer/05_CFD++_CadenceVoxFF-Rev01_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSVox1_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 9 )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSVox1_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!VarSet |N0| = ( |NumLineMaps| - 1 )
$!LineMap [|N0|-|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\B'}}}
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#-------------------------------------------------
# Map02: 003.09
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 4 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1d/003_Boeing/09_FELight_Cadence_Unstructured_HexTrex_TetFF_REV01_SA-neg/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSTet1_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 7 )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSTet1_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!VarSet |N0| = ( |NumLineMaps| - 1 )
$!LineMap [|N0|-|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\C'}}}
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#-------------------------------------------------
# Map03: 003.10
#-------------------------------------------------
$!VarSet |Z| = ( |NumZones| + 4 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1d/003_Boeing/10_FELight_Cadence_Unstructured_HexTrex_VoxFF_REV01_SA-neg/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSVox1_Maps" "WING1" )
$!VarSet |Z1| = |Z|
$!VarSet |Z| = ( |Z| + 7 )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnSVox1_Maps" "WING2" )
$!VarSet |Z2| = |Z|
#
$!VarSet |N0| = ( |NumLineMaps| - 1 )
$!LineMap [|N0|-|NumLineMaps|]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\c'}}}
#
$!RUNMACROFUNCTION "CalculateDeltas" ( |Z1|, |Z2| )
#-------------------------------------------------
#==================================================================================================

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
  Equation = '{h = N<sup>-1/2</sup>} = 1/({GRID_SIZE}**(1/2))'
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
# CD-CL^2/(pi*AR)
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{CD - CL<sup>2</sup>/(<greek>p</greek>*AR)} = {CD_TOT} - {CL_TOT}*{CL_TOT}/(3.141592653589*4.0)'
$!VarSet |CDi| = |NumVars|

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
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = '{CD - CL<sup>2</sup>/(<greek>p</greek>*AR)} = {CD - CL<sup>2</sup>/(<greek>p</greek>*AR)} * 10000.0'
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = 'V|dCD| = V|dCD|     * 10000.0'
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = 'V|dCDp| = V|dCDp|   * 10000.0'
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = 'V|dCDv| = V|dCDv|   * 10000.0'

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
$!RenameDataSetVar Var = |CDi|  Name = 'CD - CL<sup>2</sup>/(<greek>p</greek>*AR) x<sub> </sub>10<sup>4</sup>'
$!RenameDataSetVar Var = |dCD|  Name = '<greek>D</greek>CD<sub>Total </sub>x<sub> </sub>10<sup>4</sup>'
$!RenameDataSetVar Var = |dCDp| Name = '<greek>D</greek>CD<sub>Pressure </sub>x<sub> </sub>10<sup>4</sup>'
$!RenameDataSetVar Var = |dCDv| Name = '<greek>D</greek>CD<sub>SkinFriction </sub>x<sub> </sub>10<sup>4</sup>'

#==================================================================================================
$!LineMap [1-|NumLineMaps|]  Symbols { Size = 1.0 }
$!XYLineAxis XDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset =  6 } }
$!XYLineAxis YDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset =  9 } }
$!XYLineAxis GridArea  { DrawBorder = Yes LineThickness = 0.1 }

# Remove DPW3 data?
$!IF 1 == 1
   $!ActiveLineMaps -= [|DPW3_Maps|]
$!ENDIF

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
