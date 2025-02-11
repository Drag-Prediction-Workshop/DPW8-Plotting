#!MC 1410
# Include Test Case1b Data: Set to 1
$!VarSet |IncludeTestCase1b| = 1

# Include Preliminary Text on Plots: Set to 1
$!VarSet |Preliminary| = 1

#==================================================================================================
$!INCLUDEMACRO "|MACROFILEPATH|/Load.mcr"

#==================================================================================================
# NOTE: Input GRID number with quotes
# NOTE: Set 1 or 2 image formats for output (supports eps/png/bmp/jpeg/ps/tiff, otherwise leave as one or more space)
$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '1', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '2', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '3', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '4', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '5', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '6', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotGrid" ( 'N', 'eps', 'png' )
