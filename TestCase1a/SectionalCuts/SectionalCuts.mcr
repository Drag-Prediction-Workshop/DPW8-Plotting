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
#$!VarSet |ImageFormat2| = 'png'

$!VarSet |NumALPHA| = 10
$!VarSet |NumGRID|  = 7

#$!VarSet |NumALPHA| = 2
#$!VarSet |NumGRID|  = 7

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
#    $!VarSet |ALPHA| = '1.36'
    $!VarSet |ALPHA| = '1.50'
  $!ELSEIF |LOOP| == 2
    $!VarSet |ALPHA| = '1.50'
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
    # Turbulence Model Variations
    $!RUNMACROFUNCTION "PlotData"    ( '|ALPHA|', |GRID|, 'Turb', 'Cf' )
    $!RUNMACROFUNCTION "PlotData"    ( '|ALPHA|', |GRID|, 'Grid', 'Cf' )
    $!RUNMACROFUNCTION "PlotData"    ( '|ALPHA|', |GRID|, 'Grid', 'Cp' )
    $!RUNMACROFUNCTION "PlotData"    ( '|ALPHA|', |GRID|, 'Turb', 'Cp' )
    #--------------------------------------------------------------------
  $!ENDLOOP
$!ENDLOOP
#==================================================================================================
