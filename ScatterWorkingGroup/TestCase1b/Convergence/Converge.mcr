#!MC 1410
$!Page Name = 'Untitled'
$!PageControl Create
$!NewLayout 

$!VarSet |ImageFormat|  = 'eps'
$!VarSet |ImageFormat2| = 'png'

$!VarSet |ScatterRepo| = 'DPW8-Scatter'

$!VarSet |ScatterRepo| = 'DPW8-DPW-Scatter'

$!VarSet |InactiveMaps| = ''

#===================================================================
#$!RUNMACROFUNCTION "CopyCreateNewPage" ( '|Page|',  '|BasePage|' )
#-------------------------------------
$!MACROFUNCTION
  NAME = "CopyCreateNewPage"
  $!PageControl Create
  $!PageName = '|1|'
  $!PageControl SetCurrentByName
    Name = '|2|'
  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy
  $!PageControl SetCurrentByName
    Name = '|1|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
$!ENDMACROFUNCTION
#===================================================================
#===================================================================
#$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|',  'Grid|GRID|_|PlotName|',  '|ImageFormat|', '|ImageFormat2|' )
#$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', 'Alpha|ALPHA|_|PlotName|', '|ImageFormat|', '|ImageFormat2|' )
#-------------------------------------
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
#===================================================================
#$!RUNMACROFUNCTION "SetUpZones"
#-------------------------------------
$!MACROFUNCTION
  NAME = "SetUpZones"
  $!VarSet |Mx| = (|NUMZONES| - |N| + 1)
  $!LOOP |Mx|
     $!VarSet |M| = ( |N| + |LOOP| - 1)
     $!IF |LOOP| == 1
        $!VarSet |Color| = "Red"
     $!ELSEIF |LOOP| == 2
        $!VarSet |Color| = "Yellow"
     $!ELSEIF |LOOP| == 3
        $!VarSet |Color| = "Green"
     $!ELSEIF |LOOP| == 4
        $!VarSet |Color| = "Blue"
     $!ELSEIF |LOOP| == 5
        $!VarSet |Color| = "Custom3"
     $!ELSEIF |LOOP| == 6
        $!VarSet |Color| = "Purple"
     $!ELSEIF |LOOP| == 7
        $!VarSet |Color| = "Cyan"
     $!ELSE
        $!VarSet |Color| = "Black"
     $!ENDIF
     $!LineMap [|M|]  Assign{Zone = |M| XAxisVar = 1 YAxisVar = 4}
     $!LineMap [|M|]  Name = '&(ZONENAME[|M|]%6.6s)'
     $!LineMap [|M|]  Lines{Color = |Color|}
     $!LineMap [|M|]  Symbols{Size = 1 SkipMode = ByFrameUnits Skipping = 10 Color = |Color| FillMode = UseLineColor FillColor = |Color|}
  $!ENDLOOP
  $!ActiveLineMaps = [|N|-|NumLineMaps|]

  $!VarSet |XMIN| = |MINVAR[1]|
  $!VarSet |XMAX| = |MAXVAR[1]|
  $!AlterData  [|N|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V1=(V1-|XMIN|)/(|XMAX|-|XMIN|)'
#   Equation = 'V1=V1/|XMAX|'
$!ENDMACROFUNCTION
#===================================================================

$!GlobalLinePlot Legend{Show = Yes}
#$!GlobalLinePlot Legend{TextShape{SizeUnits = Frame Height = 2}}
$!GlobalLinePlot Legend{TextShape{SizeUnits = Point Height = 7}}
$!GlobalLinePlot Legend{RowSpacing = 1}
$!GlobalLinePlot Legend{XYPos{X = 98 Y = 98}}
$!GlobalLinePlot Legend{Box{BoxType = None Margin = 0}}

$!VarSet |N| = 1
$!VarSet |LFDSFN1| = '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1b/012_NASA_LARC_AB/01_FUN3D_NCFV_Classic_Quad/DPW8-AePW4_Convergence_v5.dat"'
$!VarSet |LFDSVL1| = '"ITERATION" "GRID_LEVEL" "GRID_SIZE" "CONTINUITY" "TURB1" "CL_TOT" "CD_TOT" "CM_TOT"'
$!ReadDataSet  '|LFDSFN1|'
  InitialPlotType = XYLine
  IncludeText = No
  IncludeGeom = No
  ResetStyle = No
  AssignStrandIDs = Yes
  VarLoadMode = ByName
  VarNameList = '|LFDSVL1|'
$!RemoveVar |LFDSVL1|
$!RemoveVar |LFDSFN1|
$!AlterData  [1-|NUMZONES|]
  IgnoreDivideByZero = Yes
  Equation = '{MOMENTUMX}=0.0'
$!AlterData  [1-|NUMZONES|]
  IgnoreDivideByZero = Yes
  Equation = '{MOMENTUMY}=0.0'
$!AlterData  [1-|NUMZONES|]
  IgnoreDivideByZero = Yes
  Equation = '{MOMENTUMZ}=0.0'
$!AlterData  [1-|NUMZONES|]
  IgnoreDivideByZero = Yes
  Equation = '{ENERGY}=0.0'
$!AlterData  [1-|NUMZONES|]
  IgnoreDivideByZero = Yes
  Equation = '{TURB2}=0.0'

$!ActiveLineMaps -= [1-|NumLineMaps|]
$!DeleteLineMaps    [1-|NumLineMaps|]

$!RUNMACROFUNCTION "SetUpZones"
$!VarSet |L1| = (|NumLineMaps|-5)
$!VarSet |L2| = (|NumLineMaps|-1)
$!VarSet |InactiveMaps| = '|InactiveMaps| |L1|-|L2|'

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$!VarSet |N| = (|NUMZONES|+1)
$!VarSet |LFDSFN2| = '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1b/012_NASA_LARC_AB/02_FUN3D_SFE_Classic_Quad/DPW8-AePW4_Convergence_v5.dat" '
$!ReadDataSet  '|LFDSFN2|'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"ITERATION" "GRID_LEVEL" "GRID_SIZE" "CONTINUITY" "TURB1" "CL_TOT" "CD_TOT" "CM_TOT" "MOMENTUMX" "MOMENTUMY" "MOMENTUMZ" "ENERGY" "TURB2"'

$!RUNMACROFUNCTION "SetUpZones"
$!VarSet |L1| = (|NumLineMaps|-5)
$!VarSet |L2| = (|NumLineMaps|-1)
$!VarSet |InactiveMaps| = '|InactiveMaps| |L1|-|L2|'

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$!VarSet |N| = (|NUMZONES|+1)
$!VarSet |LFDSFN2| = '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1b/012_NASA_LARC_AB/03_FUN3D_NCFV_Adapt_Thin_BL/DPW8-AePW4_Convergence_v5.dat" '
$!ReadDataSet  '|LFDSFN2|'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"ITERATION" "GRID_LEVEL" "GRID_SIZE" "CONTINUITY" "TURB1" "CL_TOT" "CD_TOT" "CM_TOT" "MOMENTUMX" "MOMENTUMY" "MOMENTUMZ" "ENERGY" "TURB2"'

$!RUNMACROFUNCTION "SetUpZones"
$!VarSet |L1| = (|NumLineMaps|-15)
$!VarSet |L2| = (|NumLineMaps|-1)
$!VarSet |InactiveMaps| = '|InactiveMaps| |L1|-|L2|'

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$!VarSet |N| = (|NUMZONES|+1)
$!VarSet |LFDSFN2| = '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1b/012_NASA_LARC_AB/04_FUN3D_SFE_Adapt_Thin_BL/DPW8-AePW4_Convergence_v5.dat" '
$!ReadDataSet  '|LFDSFN2|'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"ITERATION" "GRID_LEVEL" "GRID_SIZE" "CONTINUITY" "TURB1" "CL_TOT" "CD_TOT" "CM_TOT" "MOMENTUMX" "MOMENTUMY" "MOMENTUMZ" "ENERGY" "TURB2"'

$!RUNMACROFUNCTION "SetUpZones"
$!VarSet |L1| = (|NumLineMaps|-15)
$!VarSet |L2| = (|NumLineMaps|-1)
$!VarSet |InactiveMaps| = '|InactiveMaps| |L1|-|L2|'

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$!VarSet |N| = (|NUMZONES|+1)
$!VarSet |LFDSFN2| = '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1b/012_NASA_LARC_AB/05_FUN3D_NCFV_Adapt_Full_BL/DPW8-AePW4_Convergence_v5.dat" '
$!ReadDataSet  '|LFDSFN2|'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"ITERATION" "GRID_LEVEL" "GRID_SIZE" "CONTINUITY" "TURB1" "CL_TOT" "CD_TOT" "CM_TOT" "MOMENTUMX" "MOMENTUMY" "MOMENTUMZ" "ENERGY" "TURB2"'

$!RUNMACROFUNCTION "SetUpZones"
$!VarSet |L1| = (|NumLineMaps|-15)
$!VarSet |L2| = (|NumLineMaps|-1)
$!VarSet |InactiveMaps| = '|InactiveMaps| |L1|-|L2|'

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$!VarSet |N| = (|NUMZONES|+1)
$!VarSet |LFDSFN2| = '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1b/012_NASA_LARC_AB/06_FUN3D_SFE_Adapt_Full_BL/DPW8-AePW4_Convergence_v5.dat" '
$!ReadDataSet  '|LFDSFN2|'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"ITERATION" "GRID_LEVEL" "GRID_SIZE" "CONTINUITY" "TURB1" "CL_TOT" "CD_TOT" "CM_TOT" "MOMENTUMX" "MOMENTUMY" "MOMENTUMZ" "ENERGY" "TURB2"'

$!RUNMACROFUNCTION "SetUpZones"
$!VarSet |L1| = (|NumLineMaps|-15)
$!VarSet |L2| = (|NumLineMaps|-1)
$!VarSet |InactiveMaps| = '|InactiveMaps| |L1|-|L2|'

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$!VarSet |N| = (|NUMZONES|+1)
$!VarSet |LFDSFN2| = '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1b/040_QinetiQ/040_ANSYS-FLUENT_Joukowski_RANS_Classic_quad_SA/DPW8-AePW4_Convergence_v5.dat" '
$!ReadDataSet  '|LFDSFN2|'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"ITERATION" "GRID_LEVEL" "GRID_SIZE" "CONTINUITY" "TURB1" "CL_TOT" "CD_TOT" "CM_TOT" "MOMENTUMX" "MOMENTUMY" "MOMENTUMZ" "ENERGY" "TURB2"'

$!RUNMACROFUNCTION "SetUpZones"
$!VarSet |L1| = (|NumLineMaps|-5)
$!VarSet |L2| = (|NumLineMaps|-1)
$!VarSet |InactiveMaps| = '|InactiveMaps| |L1|-|L2|'

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
$!IF 0 == 1
  $!VarSet |N| = (|NUMZONES|+1)
  $!VarSet |LFDSFN2| = '"|MACROFILEPATH|/../../../../|ScatterRepo|/TestCase1a/011_HEMLAB/01_Structured/DPW8-AePW4_Convergence_v5.dat" '
  $!ReadDataSet  '|LFDSFN2|'
    ReadDataOption = Append
    ResetStyle = No
    VarLoadMode = ByName
    AssignStrandIDs = Yes
    VarNameList = '"ITERATION" "GRID_LEVEL" "GRID_SIZE" "CONTINUITY" "TURB1" "CL_TOT" "CD_TOT" "CM_TOT" "MOMENTUMX" "MOMENTUMY" "MOMENTUMZ" "ENERGY" "TURB2"'

  $!RUNMACROFUNCTION "SetUpZones"
  $!VarSet |L1| = (|NumLineMaps|-5)
  $!VarSet |L2| = (|NumLineMaps|-1)
  $!VarSet |InactiveMaps| = '|InactiveMaps| |L1|-|L2|'
$!ENDIF
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

$!LOOP |NUMZONES|
   $!ActiveLineMaps = [|LOOP|]
   $!GetFieldValue |CDfinal|
       Zone = |LOOP|
       Var = 7
       Index = |MaxI|
   $!GetFieldValue |ResidContfinal|
       Zone = |LOOP|
       Var = 4
       Index = |MaxI|
   $!GetFieldValue |ResidTurbfinal|
       Zone = |LOOP|
       Var = 5
       Index = |MaxI|
  #--------------
  $!IF 0 == 1
   $!VarSet |m1| = (|MaxI| -((|MaxI| - |MaxI|%10.0)/10.0))
   $!GetFieldValue |CDfinalm1|
       Zone = |LOOP|
       Var = 7
       Index = |m1|
   $!VarSet |dCDm1| = ((|CDfinal| - |CDfinalm1|)*10000.0)
   $!IF (ABS(|dCDm1|)) >  0.01
      $!Pause 'M = |LOOP|\ndCDm1 = |dCDm1%8.6f| cnts'
   $!ENDIF
  $!ENDIF
  #--------------
   $!AlterData  [|LOOP|]
       IgnoreDivideByZero = Yes
       Equation = '{<greek>D</greek>CD<sub>Tot</sub>} = V7 - |CDfinal|'
  #--------------
  $!IF 0 == 1
   $!AlterData  [|LOOP|]
       IgnoreDivideByZero = Yes
       Equation = '{ContimuityMod} = V4 / |ResidContfinal| * |ResidMin|'
  $!ENDIF
  #--------------
$!ENDLOOP

$!XYLineAxis GridArea{DrawBorder = Yes}
$!ActiveLineMaps = [1-|NumLineMaps|]
#$!ActiveLineMaps -= [1-5,7-11,13-17,19-23,25-30,32-36,38-42,44-49,51-56,58-62,64-68,70-74,76-80]
$!ActiveLineMaps -= [|InactiveMaps|]

$!RenameDataSetVar 
  Var = 1
  Name = 'Iteration/IterMax<sub>GridFamily</sub>'
$!RenameDataSetVar 
  Var = 4
  Name = 'Continuity<sub>Resid</sub>'
$!RenameDataSetVar 
  Var = 5
  Name = 'Turbulence<sub>Resid</sub>'
$!RenameDataSetVar 
  Var = 6
  Name = 'CL<sub>Tot</sub>'
$!RenameDataSetVar 
  Var = 7
  Name = 'CD<sub>Tot</sub>'
$!RenameDataSetVar 
  Var = 8
  Name = 'CM<sub>Tot</sub>'
$!RenameDataSetVar 
  Var = 9
  Name = 'X-Momentum<sub>Resid</sub>'
$!RenameDataSetVar 
  Var = 10
  Name = 'Y-Momentum<sub>Resid</sub>'
$!RenameDataSetVar 
  Var = 11
  Name = 'Z-Momentum<sub>Resid</sub>'
$!RenameDataSetVar 
  Var = 12
  Name = 'Energy<sub>Resid</sub>'
$!RenameDataSetVar 
  Var = 13
  Name = 'TurbulenceEq2<sub>Resid</sub>'

#----------------------------
# Convert drag quantities into counts
$!AlterData 
  IgnoreDivideByZero = Yes
  Equation = 'V7 = V7 * 10000.0'

#$!Varset |ResidMin| = '1E-16'
$!Varset |ResidMin| = '9E-18'
$!Varset |ResidMax| = '1E+2'

# X-axis to Iter/IterMax
$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 1}
$!XYLineAxis XDetail 1 { CoordScale = Linear RangeMin = -0.025 RangeMax = 1.025 GRSpacing = 0.20 Title{Offset = 6} Gridlines{Show = Yes} MinorGridlines{Show = No }}
$!XYLineAxis XDetail 1 { AutoGrid = No GRSpacing = 0.10 }

# Y-axis to Continuity
$!LineMap [1-|NumLineMaps|]  Assign{YAxisVar = 4}
$!XYLineAxis YDetail 1 { CoordScale = Log    RangeMin = |ResidMin|  RangeMax = 1E+2  GRSpacing = 1E+2 Title{Offset = 8} Gridlines{Show = Yes} MinorGridlines{Show = No }}

## Y-axis to CD_Total
#$!LineMap [1-|NumLineMaps|]  Assign{YAxisVar = 7}
#$!XYLineAxis YDetail 1 { CoordScale = Linear RangeMin = 0.0148 RangeMax = 0.0156 GRSpacing = 0.0002 Title{Offset = 6} Gridlines{Show = Yes} MinorGridlines{Show = Yes}}

## X-axis to CD_Total
#$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 7}
#$!XYLineAxis XDetail 1 { CoordScale = Linear RangeMin = 0.0149 RangeMax = 0.0156 GRSpacing = 0.0001 Title{Offset = 6} Gridlines{Show = Yes} MinorGridlines{Show = Yes}}
#
## Y-axis to Iter/IterMax
#$!LineMap [1-|NumLineMaps|]  Assign{YAxisVar = 1}
#$!XYLineAxis YDetail 1 { CoordScale = Linear IsReversed=Yes RangeMin = -0.025 RangeMax = 1.025 GRSpacing = 0.20 Title{Offset = 8} Gridlines{Show = Yes} MinorGridlines{Show = Yes}}
#$!XYLineAxis YDetail 1 { AutoGrid = No GRSpacing = 0.10 }

$!GlobalLinePlot Legend{Show = No}
$!LineMap [1-|NumLineMaps|]  Lines{Color = Green}
$!LineMap [77-82] Lines{Color = Blue LineThickness = 0.40}

$!VarSet |Page| = 'Resid_Continuity'
$!PageName = '|Page|'
$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', '|Page|', '|ImageFormat|', '|ImageFormat2|' )

#------------------
# Copy Resid_Continuity page
$!VarSet |Page| = 'Resid_Turb'
$!RUNMACROFUNCTION "CopyCreateNewPage" ( '|Page|',  'Resid_Continuity' )

$!XYLineAxis XDetail 1 {AutoGrid = Yes}
$!XYLineAxis YDetail 1 {AutoGrid = Yes}
$!LineMap [1-|NumLineMaps|]  Assign{YAxisVar = 5}
$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', '|Page|', '|ImageFormat|', '|ImageFormat2|' )

#------------------
# Copy CD_Resid_Continuity page
$!VarSet |Page| = 'CD_Resid_Continuity'
$!RUNMACROFUNCTION "CopyCreateNewPage" ( '|Page|',  'Resid_Continuity' )

$!LineMap [1-|NumLineMaps|]  Lines{LineThickness = 0.10}
$!XYLineAxis XDetail 1 {AutoGrid = Yes}
$!XYLineAxis YDetail 1 {AutoGrid = Yes}
$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 4}
$!LineMap [1-|NumLineMaps|]  Assign{YAxisVar = 7}
$!XYLineAxis XDetail 1 { CoordScale = Log    RangeMin = |ResidMin|   RangeMax = 1E+2                       Title{Offset = 6} Gridlines{Show = Yes} MinorGridlines{Show = Yes }}
$!XYLineAxis YDetail 1 { CoordScale = Linear RangeMin = 78.6         RangeMax = 80.4    GRSpacing = 0.2    Title{Offset = 9} Gridlines{Show = Yes} MinorGridlines{Show = Yes }}
$!XYLineAxis YDetail 1 {Gridlines{Show = No} MinorGridlines{Show = No}}
$!XYLineAxis XDetail 1 {Gridlines{Show = No} MinorGridlines{Show = No}}
$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', '|Page|', '|ImageFormat|', '|ImageFormat2|' )

#------------------
# Copy CD_Resid_Turb page
$!VarSet |Page| = 'CD_Resid_Turb'
$!RUNMACROFUNCTION "CopyCreateNewPage" ( '|Page|',  'Resid_Continuity' )

$!LineMap [1-|NumLineMaps|]  Lines{LineThickness = 0.10}
$!XYLineAxis XDetail 1 {AutoGrid = Yes}
$!XYLineAxis YDetail 1 {AutoGrid = Yes}
$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 5}
$!LineMap [1-|NumLineMaps|]  Assign{YAxisVar = 7}
$!XYLineAxis XDetail 1 { CoordScale = Log    RangeMin = |ResidMin|   RangeMax = 1E+2                       Title{Offset = 6} Gridlines{Show = Yes} MinorGridlines{Show = Yes }}
$!XYLineAxis YDetail 1 { CoordScale = Linear RangeMin = 78.6         RangeMax = 80.4    GRSpacing = 0.2    Title{Offset = 9} Gridlines{Show = Yes} MinorGridlines{Show = Yes }}
$!XYLineAxis YDetail 1 {Gridlines{Show = No} MinorGridlines{Show = No}}
$!XYLineAxis XDetail 1 {Gridlines{Show = No} MinorGridlines{Show = No}}
$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', '|Page|', '|ImageFormat|', '|ImageFormat2|' )

#------------------
# Copy CL_Resid_Continuity page
$!VarSet |Page| = 'CL_Resid_Continuity'
$!RUNMACROFUNCTION "CopyCreateNewPage" ( '|Page|',  'Resid_Continuity' )

$!XYLineAxis XDetail 1 {AutoGrid = Yes}
$!XYLineAxis YDetail 1 {AutoGrid = Yes}
$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 4}
$!LineMap [1-|NumLineMaps|]  Assign{YAxisVar = 6}
$!XYLineAxis XDetail 1 { CoordScale = Log    RangeMin = |ResidMin|   RangeMax = 1E-1                       Title{Offset = 6} Gridlines{Show = Yes} MinorGridlines{Show = Yes }}
$!XYLineAxis YDetail 1 { CoordScale = Linear RangeMin = -0.001       RangeMax = 0.001   GRSpacing = 0.0005 Title{Offset = 9} Gridlines{Show = Yes} MinorGridlines{Show = Yes }}
$!XYLineAxis YDetail 1 {Gridlines{Show = No} MinorGridlines{Show = No}}
$!XYLineAxis XDetail 1 {Gridlines{Show = No} MinorGridlines{Show = No}}
$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', '|Page|', '|ImageFormat|', '|ImageFormat2|' )

#------------------
# Copy CM_Resid_Continuity page
$!VarSet |Page| = 'CM_Resid_Continuity'
$!RUNMACROFUNCTION "CopyCreateNewPage" ( '|Page|',  'Resid_Continuity' )

$!XYLineAxis XDetail 1 {AutoGrid = Yes}
$!XYLineAxis YDetail 1 {AutoGrid = Yes}
$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 4}
$!LineMap [1-|NumLineMaps|]  Assign{YAxisVar = 8}
$!XYLineAxis XDetail 1 { CoordScale = Log    RangeMin = |ResidMin|   RangeMax = 1E-1                       Title{Offset = 6} Gridlines{Show = Yes} MinorGridlines{Show = Yes }}
$!XYLineAxis YDetail 1 { CoordScale = Linear RangeMin = -0.001       RangeMax = 0.001   GRSpacing = 0.0005 Title{Offset = 9} Gridlines{Show = Yes} MinorGridlines{Show = Yes }}
$!XYLineAxis YDetail 1 {Gridlines{Show = No} MinorGridlines{Show = No}}
$!XYLineAxis XDetail 1 {Gridlines{Show = No} MinorGridlines{Show = No}}
$!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', '|Page|', '|ImageFormat|', '|ImageFormat2|' )
