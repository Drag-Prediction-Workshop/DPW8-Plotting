#!MC 1410
# Include Preliminary Text on Plots: Set to 1
$!VarSet |Preliminary| = 0

#==================================================================================================
$!INCLUDEMACRO "|MACROFILEPATH|/Load.mcr"

#==================================================================================================
# NOTE: Input GRID number with quotes
# NOTE: Set 1 or 2 image formats for output (supports eps/png/bmp/jpeg/ps/tiff, otherwise leave as one or more space)
#$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '1', 'eps', '   ' )
#$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '2', 'eps', '   ' )
 $!RUNMACROFUNCTION "LoadAndPlotGrid" ( '3', 'eps', 'png' )
#$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '4', 'eps', '   ' )
#$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '5', 'eps', '   ' )
#$!RUNMACROFUNCTION "LoadAndPlotGrid" ( '6', 'eps', '   ' )
#$!RUNMACROFUNCTION "LoadAndPlotGrid" ( 'N', 'eps', 'png' )
