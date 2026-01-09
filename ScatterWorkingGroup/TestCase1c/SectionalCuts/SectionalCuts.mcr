#!MC 1410
$!Page Name = 'Untitled'
$!PageControl Create
$!NewLayout

# Include Test Case1b Data: Set to 1
$!VarSet |IncludeTestCase1b| = 0

# Include Preliminary Text on Plots: Set to 1
$!VarSet |Preliminary| = 0

# NOTE: Set |ImageFormat2| if an additional format is desired, otherwise use '   '
$!VarSet |ImageFormat|  = 'eps'
$!VarSet |ImageFormat2| = '   '
$!VarSet |ImageFormat2| = 'png'

$!VarSet |NumALPHA| = 10
$!VarSet |NumGRID|  = 7

$!VarSet |NumALPHA| = 1
$!VarSet |NumGRID|  = 7

#==================================================================================================
$!INCLUDEMACRO '|MACROFILEPATH|/Load.mcr'
$!RUNMACROFUNCTION "LoadData"

#==================================================================================================
$!LOOP |NumALPHA|
  #---------------------------
  # Assign |ALPHA| Variable
  $!IF     |LOOP| == 1
    $!VarSet |ALPHA| = '1.50'
  $!ELSEIF |LOOP| == 2
    $!VarSet |ALPHA| = '1.36'
  $!ELSEIF |LOOP| == 3
    $!VarSet |ALPHA| = '2.50'
  $!ELSEIF |LOOP| == 4
    $!VarSet |ALPHA| = '3.00'
  $!ELSEIF |LOOP| == 5
    $!VarSet |ALPHA| = '3.10'
  $!ELSEIF |LOOP| == 6
    $!VarSet |ALPHA| = '3.25'
  $!ELSEIF |LOOP| == 7
    $!VarSet |ALPHA| = '3.40'
  $!ELSEIF |LOOP| == 8
    $!VarSet |ALPHA| = '3.50'
  $!ELSEIF |LOOP| == 9
    $!VarSet |ALPHA| = '3.60'
  $!ELSEIF |LOOP| == 10
    $!VarSet |ALPHA| = '3.90'
  $!ENDIF
  $!LOOP |NumGRID|
    #---------------------------
    # Assign |GRID| Variable
    $!VarSet |GRID| = |LOOP|
    #--------------------------------------------------------------------
   $!IF     |LOOP| == |NumGRID|
    # Turbulence Model Variations
#    $!RUNMACROFUNCTION "PlotData"    ( '|ALPHA|', |GRID|, 'Turb', 'Cf' )
    $!RUNMACROFUNCTION "PlotData"    ( '|ALPHA|', |GRID|, 'Grid', 'Cf' )
    $!RUNMACROFUNCTION "PlotData"    ( '|ALPHA|', |GRID|, 'Grid', 'Cp' )
#    $!RUNMACROFUNCTION "PlotData"    ( '|ALPHA|', |GRID|, 'Turb', 'Cp' )
   $!ENDIF
    #--------------------------------------------------------------------
  $!ENDLOOP
$!ENDLOOP
#
$!PageControl SetCurrentByNumber
  PageNum = 1
$!PageControl Delete
#==================================================================================================

#==================================================================================================
# Export additional views
#==================================================================================================
$!IF 1 == 1
#------------------------------------------------
 $!Varset |ALPHA| = '1.50'
 $!Varset |GRID|  = 'N'
#------------------------------------------------
# Cf
 $!Varset |PlotName| = 'Cf_Grid'
 $!PageControl SetCurrentByName
  Name = 'Cf_Grid'
 $!IF 1 == 1
  $!LineMap [1-|NumLineMaps|] Symbols { SkipMode = ByIndex Skipping = 1 }
  $!XYLineAxis XDetail 1 {RangeMin =  0.000195 RangeMax = 0.000705 AutoGrid = Yes }
  $!XYLineAxis XDetail 1 {GRSpacing = 0.0001 }
  $!XYLineAxis YDetail 1 {RangeMin =  0.00000 RangeMax = 0.00045 IsReversed = No AutoGrid = Yes}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.00005 }
  $!XYLineAxis YDetail 1 {TickLabel { NumFormat { Formatting = FixedFloat Precision = 5 TimeDateFormat = '' } }}
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [|NumLineMaps|] ErrorBars { Var = 6 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RedrawAll
  $!VARSET |FILE| = "Alpha|ALPHA|_Grid|GRID|_|PlotName|_LEzoom"
  $!ExportSetup ExportFormat = png
  $!ExportSetup ExportFName = 'png/|FILE|.png'
  $!Export 
    ExportRegion = AllFrames
  $!ExportSetup ExportFormat = eps
  $!ExportSetup ExportFName = 'eps/|FILE|.eps'
  $!Export
    ExportRegion = AllFrames
 $!ENDIF
 $!IF 1 == 1
  $!LineMap [1-|NumLineMaps|] Symbols { SkipMode = ByFrameUnits Skipping = 5 }
  $!XYLineAxis XDetail 1 {RangeMin =  0.505 RangeMax = 0.585 AutoGrid = Yes }
  $!XYLineAxis XDetail 1 {GRSpacing = 0.01 }
  $!XYLineAxis YDetail 1 {RangeMin =  0.00000 RangeMax = 0.0055 IsReversed = No AutoGrid = Yes}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.0005 }
  $!XYLineAxis YDetail 1 {TickLabel { NumFormat { Formatting = FixedFloat Precision = 4 TimeDateFormat = '' } }}
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [|NumLineMaps|] ErrorBars { Var = 6 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RedrawAll
  $!VARSET |FILE| = "Alpha|ALPHA|_Grid|GRID|_|PlotName|_Shock"
  $!ExportSetup ExportFormat = png
  $!ExportSetup ExportFName = 'png/|FILE|.png'
  $!Export 
    ExportRegion = AllFrames
  $!ExportSetup ExportFormat = eps
  $!ExportSetup ExportFName = 'eps/|FILE|.eps'
  $!Export
    ExportRegion = AllFrames
 $!ENDIF
 $!IF 1 == 1
  $!LineMap [1-|NumLineMaps|] Symbols { SkipMode = ByIndex Skipping = 5 }
  $!XYLineAxis XDetail 1 {RangeMin =  0.9949 RangeMax = 1.0001 AutoGrid = Yes }
  $!XYLineAxis XDetail 1 {GRSpacing = 0.001 }
  $!XYLineAxis YDetail 1 {RangeMin =  0.0000 RangeMax = 0.0075 IsReversed = No AutoGrid = Yes}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.001 }
  $!XYLineAxis YDetail 1 {TickLabel { NumFormat { Formatting = FixedFloat Precision = 3 TimeDateFormat = '' } }}
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [|NumLineMaps|] ErrorBars { Var = 6 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RedrawAll
  $!VARSET |FILE| = "Alpha|ALPHA|_Grid|GRID|_|PlotName|_TEzoom"
  $!ExportSetup ExportFormat = png
  $!ExportSetup ExportFName = 'png/|FILE|.png'
  $!Export 
    ExportRegion = AllFrames
  $!ExportSetup ExportFormat = eps
  $!ExportSetup ExportFName = 'eps/|FILE|.eps'
  $!Export
    ExportRegion = AllFrames
 $!ENDIF
#------------------------------------------------
# Cp
 $!Varset |PlotName| = 'Cp_Grid'
 $!PageControl SetCurrentByName
  Name = 'Cp_Grid'
 $!IF 1 == 1
  $!LineMap [1-|NumLineMaps|] Symbols { SkipMode = ByIndex Skipping = 1 }
  $!XYLineAxis XDetail 1 {RangeMin =  0.000195 RangeMax = 0.000705 AutoGrid = Yes }
  $!XYLineAxis XDetail 1 {GRSpacing = 0.0001 }
  $!XYLineAxis YDetail 1 {RangeMin =  1.1370 RangeMax = 1.1415 IsReversed = Yes AutoGrid = Yes}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.0005 }
  $!XYLineAxis YDetail 1 {TickLabel { NumFormat { Formatting = FixedFloat Precision = 4 TimeDateFormat = '' } }}
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [|NumLineMaps|] ErrorBars { Var = 6 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RedrawAll
  $!VARSET |FILE| = "Alpha|ALPHA|_Grid|GRID|_|PlotName|_LEzoom"
  $!ExportSetup ExportFormat = png
  $!ExportSetup ExportFName = 'png/|FILE|.png'
  $!Export 
    ExportRegion = AllFrames
  $!ExportSetup ExportFormat = eps
  $!ExportSetup ExportFName = 'eps/|FILE|.eps'
  $!Export
    ExportRegion = AllFrames
 $!ENDIF
 $!IF 1 == 1
  $!LineMap [1-|NumLineMaps|] Symbols { SkipMode = ByFrameUnits Skipping = 5 }
  $!XYLineAxis XDetail 1 {RangeMin =  0.505 RangeMax = 0.585 AutoGrid = Yes }
  $!XYLineAxis XDetail 1 {GRSpacing = 0.01 }
  $!XYLineAxis YDetail 1 {RangeMin =  -1.25 RangeMax = -0.55 IsReversed = Yes AutoGrid = Yes}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.1 }
  $!XYLineAxis YDetail 1 {TickLabel { NumFormat { Formatting = FixedFloat Precision = 2 TimeDateFormat = '' } }}
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [|NumLineMaps|] ErrorBars { Var = 6 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RedrawAll
  $!VARSET |FILE| = "Alpha|ALPHA|_Grid|GRID|_|PlotName|_Shock"
  $!ExportSetup ExportFormat = png
  $!ExportSetup ExportFName = 'png/|FILE|.png'
  $!Export 
    ExportRegion = AllFrames
  $!ExportSetup ExportFormat = eps
  $!ExportSetup ExportFName = 'eps/|FILE|.eps'
  $!Export
    ExportRegion = AllFrames
 $!ENDIF
 $!IF 1 == 1
  $!LineMap [1-|NumLineMaps|] Symbols { SkipMode = ByFrameUnits Skipping = 10 }
  $!XYLineAxis XDetail 1 {RangeMin =  0.050 RangeMax = 0.550 AutoGrid = Yes }
  $!XYLineAxis XDetail 1 {GRSpacing = 0.10 }
  $!XYLineAxis YDetail 1 {RangeMin =  -1.215 RangeMax = -1.180 IsReversed = Yes AutoGrid = Yes}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.005 }
  $!XYLineAxis YDetail 1 {TickLabel { NumFormat { Formatting = FixedFloat Precision = 3 TimeDateFormat = '' } }}
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [|NumLineMaps|] ErrorBars { Var = 6 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RedrawAll
  $!VARSET |FILE| = "Alpha|ALPHA|_Grid|GRID|_|PlotName|_Rooftop"
  $!ExportSetup ExportFormat = png
  $!ExportSetup ExportFName = 'png/|FILE|.png'
  $!Export 
    ExportRegion = AllFrames
  $!ExportSetup ExportFormat = eps
  $!ExportSetup ExportFName = 'eps/|FILE|.eps'
  $!Export
    ExportRegion = AllFrames
 $!ENDIF
 $!IF 1 == 1
  $!LineMap [1-|NumLineMaps|] Symbols { SkipMode = ByIndex Skipping = 5 }
  $!XYLineAxis XDetail 1 {RangeMin =  0.9949 RangeMax = 1.0001 AutoGrid = Yes }
  $!XYLineAxis XDetail 1 {GRSpacing = 0.001 }
  $!XYLineAxis YDetail 1 {RangeMin =  0.08 RangeMax = 0.18 IsReversed = Yes AutoGrid = Yes}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.02 }
  $!XYLineAxis YDetail 1 {TickLabel { NumFormat { Formatting = FixedFloat Precision = 2 TimeDateFormat = '' } }}
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [|NumLineMaps|] ErrorBars { Var = 6 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RedrawAll
  $!VARSET |FILE| = "Alpha|ALPHA|_Grid|GRID|_|PlotName|_TEzoom"
  $!ExportSetup ExportFormat = png
  $!ExportSetup ExportFName = 'png/|FILE|.png'
  $!Export 
    ExportRegion = AllFrames
  $!ExportSetup ExportFormat = eps
  $!ExportSetup ExportFName = 'eps/|FILE|.eps'
  $!Export
    ExportRegion = AllFrames
 $!ENDIF
#------------------------------------------------
$!ENDIF
