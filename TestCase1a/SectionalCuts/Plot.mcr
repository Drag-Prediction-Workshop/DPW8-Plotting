#!MC 1410
#------------------------------------------------
# Cf
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CF_|TYPE|'
  $!PageName = '|PlotName|'
  $!LineMap [1-|NumLineMaps|] Assign{XAxisVar = 9 YAxisVar = 5}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -0.010 RangeMax = 1.010 }
  $!XYLineAxis YDetail 1 {RangeMin = -0.002 RangeMax = 0.014 IsReversed = No  AutoGrid = Yes }
  $!XYLineAxis YDetail 1 {GRSpacing = 0.002 }
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [45] ErrorBars { Var = 7 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RUNMACROFUNCTION "ExportAndSave" ( "|MACROFILEPATH|" "Alpha|ALPHA|_Grid|GRID|_|PlotName|" "|ImageFormat|" "|ImageFormat2|" )
$!ENDIF
#------------------------------------------------
# Cp
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CP_|TYPE|'
  $!PageName = '|PlotName|'
  $!LineMap [1-|NumLineMaps|] Assign{XAxisVar = 9 YAxisVar = 4}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -0.010 RangeMax = 1.010 }
  $!XYLineAxis YDetail 1 {RangeMin = -1.600 RangeMax = 1.200 IsReversed = Yes AutoGrid = Yes }
  $!XYLineAxis YDetail 1 {GRSpacing = 0.500 }
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [|NumLineMaps|] ErrorBars { Var = 6 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RUNMACROFUNCTION "ExportAndSave" ( "|MACROFILEPATH|" "Alpha|ALPHA|_Grid|GRID|_|PlotName|" "|ImageFormat|" "|ImageFormat2|" )
$!ENDIF
#------------------------------------------------
#$!IF |GRIDN| == 1
#  $!VarSet |GRID|  = 7
#  $!VarSet |GRIDN| = 0
#$!ENDIF
#------------------------------------------------
