#!MC 1410
# Include Test Case1b Data: Set to 1
$!VarSet |IncludeTestCase1b| = 1

# Include Preliminary Text on Plots: Set to 1
$!VarSet |Preliminary| = 1

#==================================================================================================
$!INCLUDEMACRO "|MACROFILEPATH|/Load.mcr"

#==================================================================================================
# NOTE: Input ALPHA value with quotes
# NOTE: Set 1 or 2 image formats for output (supports eps/png/bmp/jpeg/ps/tiff, otherwise leave as one or more space)
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '1.36', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '1.50', 'eps', 'png' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '2.50', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '3.00', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '3.10', 'eps', 'png' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '3.25', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '3.40', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '3.50', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '3.60', 'eps', '   ' )
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '3.90', 'eps', 'png' )
