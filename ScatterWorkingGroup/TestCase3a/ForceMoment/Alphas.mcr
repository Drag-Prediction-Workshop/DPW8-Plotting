#!MC 1410

# Include Preliminary Text on Plots: Set to 1
$!VarSet |Preliminary| = 1

#==================================================================================================
$!INCLUDEMACRO "|MACROFILEPATH|/Load.mcr"

#==================================================================================================
# NOTE: Input ALPHA value with quotes
# NOTE: Set 1 or 2 image formats for output (supports eps/png/bmp/jpeg/ps/tiff, otherwise leave as one or more space)
$!RUNMACROFUNCTION "LoadAndPlotAlpha" ( '0.50', 'eps', 'png' )
