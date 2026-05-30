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
$!VarSet |CadenceUnS_Maps| = ''
$!VarSet |HeldenUnSt_Maps| = ''
$!VarSet |AmesOverSt_Maps| = ''
$!VarSet |VassbergOvrSt_Maps| = ''
$!VarSet |CstmUsrAdp_Maps| = ''
$!VarSet |CstmUsrUns_Maps| = ''
$!VarSet |CstmUsrStr_Maps| = ''
#-------------------------------------------------
# DPW7 Variants
#------------------------------
$!VarSet |DPW7_Maps| = ''
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
  $!IF     |ALPHA| == 2.50
    $!VarSet |Increment| = 7
  $!ELSEIF |ALPHA| == 1.50
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
  $!IF     '|2|' == 'CadenceUnS_Maps'
     $!VarSet |CadenceUnS_Maps| = '|CadenceUnS_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'HeldenUnSt_Maps'
     $!VarSet |HeldenUnSt_Maps|    = '|HeldenUnSt_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'AmesOverSt_Maps'
     $!VarSet |AmesOverSt_Maps|    = '|AmesOverSt_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'VassbergOvrSt_Maps'
     $!VarSet |VassbergOvrSt_Maps| = '|VassbergOvrSt_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrAdp_Maps|    = '|CstmUsrAdp_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrUns_Maps'
     $!VarSet |CstmUsrUns_Maps|    = '|CstmUsrUns_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrStr_Maps|    = '|CstmUsrStr_Maps|    |NumLineMaps|,'
  $!ELSEIF '|2|' == 'DPW7_Maps'
     $!VarSet |DPW7_Maps|          = '|DPW7_Maps|          |NumLineMaps|,'
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
# Map01: 002.01
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/002_Embraer/01_CFD++_Cadence-Rev00_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map02: 002.02
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/002_Embraer/02_CFD++_HeldenMesh-Rev00_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "HeldenUnSt_Maps" )
#-------------------------------------------------
# Map03: 003.01
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/01_FELight_HeldenMesh_Unstructured_REV00_SA-neg-QCR2000/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "HeldenUnSt_Maps" )
#-------------------------------------------------
# Map04: 003.02
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/02_FELight_Cadence_Unstructured_REV00_SA-neg-QCR2000/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map05: 003.03
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/03_OVERFLOW_Ames_Overset_REV00_SA-neg-QCR2000/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "AmesOverSt_Maps" )
#-------------------------------------------------
# Map06: 003.04
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/04_FELight_HeldenMesh_Unstructured_REV00_SA-neg-RC-QCR2000/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SARCQ_Maps" "HeldenUnSt_Maps" )
#-------------------------------------------------
# Map07: 003.05
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/05_FELight_Cadence_Unstructured_REV00_SA-neg-RC-QCR2000/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SARCQ_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map08: 003.06
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/06_OVERFLOW_Ames_Overset_REV00_SA-neg-RC-QCR2000/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SARCQ_Maps" "AmesOverSt_Maps" )
#-------------------------------------------------
# Map09: 003.07
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/07_FELight_HeldenMesh_Unstructured_REV00_SA-neg/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "HeldenUnSt_Maps" )
#-------------------------------------------------
# Map10: 003.08
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/08_FELight_Cadence_Unstructured_REV00_SA-neg/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CadenceUnS_Maps" )
#-------------------------------------------------
# Map11: 003.09
$!VarSet |Z| = ( |NumZones| + 7 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/003_Boeing/09_OVERFLOW_Ames_Overset_REV00_SA-neg/DPW8-AePW4_ForceMoment_v6.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "AmesOverSt_Maps" )
#-------------------------------------------------
# Map12: 009.01
$!VarSet |Z| = ( |NumZones| + 6 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/009_ONERA/01_elsA_Vassberg_SA/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "VassbergOvrSt_Maps" )
#-------------------------------------------------
# Map13: 009.02
$!VarSet |Z| = ( |NumZones| + 6 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/009_ONERA/02_elsA_Vassberg_SA-QCR2000/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "VassbergOvrSt_Maps" )
$!VarSet |Z| = ( |Z| + 1 )
#-------------------------------------------------
# Map14: 010.01
$!VarSet |Z| = ( |NumZones| + 14 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase2a/011_HEMLAB/01_Adaptive/DPW8-AePW4_ForceMoment_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps" "CstmUsrAdp_Maps" )
#-------------------------------------------------
$!LineMap  [1]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\A'}}}
$!LineMap  [2]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\a'}}}
$!LineMap  [3]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\B'}}}
$!LineMap  [4]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\b'}}}
$!LineMap  [5]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\B'}}}
$!LineMap  [6]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\C'}}}
$!LineMap  [7]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\c'}}}
$!LineMap  [8]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\C'}}}
$!LineMap  [9]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\D'}}}
$!LineMap [10]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\d'}}}
$!LineMap [11]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\D'}}}
$!LineMap [12]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\E'}}}
$!LineMap [13]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\e'}}}
$!LineMap [14]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\F'}}}

#==================================================================================================
$!IF 1 == 1
#==================================================================================================
# Dataset: 7.D1
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW7/D1-RiderB-CommonOverset-Overflow-SARCQCR/D1-RiderB-CommonOverset-Overflow-SARCQCR-DPW-VII.DataForm_ForceMoment_v7.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SARCQ_Maps" "DPW7_Maps" )
$!LineMap [|NumLineMaps|]  Name = 'DPW7'
$!LineMap [|NumLineMaps|]  Assign{ShowInLegend = Auto}
#-------------------------------------------------
# Dataset: 7.E1
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW7/E1-KamenetskiyD-EPIC-GGNS_T1-SA/E1-KamenetskiyD-EPIC-GGNS_T1-SA-DPW-VII.DataForm_ForceMoment_v7.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SA_Maps"  "DPW7_Maps" )
$!LineMap [|NumLineMaps|]  Name = 'DPW7'
$!LineMap [|NumLineMaps|]  Assign{ShowInLegend = Never}
# Remove DPW7 SA-neg result
#$!ActiveLineMaps -= [|NumLineMaps|]
#-------------------------------------------------
# Dataset: 7.E2
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW7/E2-KamenetskiyD-EPIC-GGNS_T1-SA-QCR/E2-KamenetskiyD-EPIC-GGNS_T1-SA-QCR-DPW-VII.DataForm_ForceMoment_v7.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SAQ_Maps" "DPW7_Maps" )
$!LineMap [|NumLineMaps|]  Name = 'DPW7'
$!LineMap [|NumLineMaps|]  Assign{ShowInLegend = Never}
#-------------------------------------------------
# Dataset: 7.E3
$!VarSet |Z| = ( |NumZones| + 1 )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/DPW7/E3-KamenetskiyD-EPIC-GGNS_T1-SARC-QCR/E3-KamenetskiyD-EPIC-GGNS_T1-SARC-QCR-DPW-VII.DataForm_ForceMoment_v7.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( "SARCQ_Maps" "DPW7_Maps" )
$!LineMap [|NumLineMaps|]  Name = 'DPW7'
$!LineMap [|NumLineMaps|]  Assign{ShowInLegend = Never}
#==================================================================================================
$!ENDIF
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
  Equation = '{CD - CL<sup>2</sup>/(<greek>p</greek>*AR)} = {CD_TOT} - {CL_TOT}*{CL_TOT}/(3.141592653589*9.0)'
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
$!RenameDataSetVar Var = |CDi|  Name = 'CD - CL<sup>2</sup>/(<greek>p</greek>*AR)<sub> </sub>x<sub> </sub>10<sup>4</sup>'

#==================================================================================================
$!LineMap [1-|NumLineMaps|]  Symbols { Size = 1.0 }
$!XYLineAxis XDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset =  6 } }
$!XYLineAxis YDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset =  9 } }
$!XYLineAxis GridArea  { DrawBorder = Yes LineThickness = 0.1 }

$!LineMap  [1-|NumLineMaps|]      Lines   { LineThickness = 0.25 LinePattern = Solid  } Symbols { Size = 1.0 }
$!LineMap  [|DPW7_Maps|]          Lines   { LineThickness = 0.25 LinePattern = Dashed } Symbols { Size = 1.0 }

# Remove DPW7 data?
$!IF 1 == 1
   $!ActiveLineMaps -= [|DPW7_Maps|]
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
