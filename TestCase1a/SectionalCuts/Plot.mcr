#!MC 1410

$!VarSet |GRIDN| = 0
$!IF |GRID| == 7
   $!VarSet |GRID| = 6
   $!VarSet |GRIDN| = 1
$!ENDIF

#------------------------------------------------
$!IF     |ALPHA| == 1.36
   $!VarSet |DELTA| =  1
$!ELSEIF |ALPHA| == 1.50
   $!VarSet |DELTA| =  2
$!ELSEIF |ALPHA| == 2.50
   $!VarSet |DELTA| =  3
$!ELSEIF |ALPHA| == 3.00
   $!VarSet |DELTA| =  4
$!ELSEIF |ALPHA| == 3.10
   $!VarSet |DELTA| =  5
$!ELSEIF |ALPHA| == 3.25
   $!VarSet |DELTA| =  6
$!ELSEIF |ALPHA| == 3.40
   $!VarSet |DELTA| =  7
$!ELSEIF |ALPHA| == 3.50
   $!VarSet |DELTA| =  8
$!ELSEIF |ALPHA| == 3.60
   $!VarSet |DELTA| =  9
$!ELSEIF |ALPHA| == 3.90
   $!VarSet |DELTA| = 10
$!ENDIF

#------------------------------------------------
# Note that the number of Alphas in the file varies (10 vs. 1 vs. 5, etc.)
$!Varset |Z| = (|Z01| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [1] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [1] Assign{Zone = |Z|}
$!Varset |Z| = (|Z02| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [2] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [2] Assign{Zone = |Z|}
$!Varset |Z| = (|Z03| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [3] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [3] Assign{Zone = |Z|}
$!Varset |Z| = (|Z04| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [4] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [4] Assign{Zone = |Z|}
$!Varset |Z| = (|Z05| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [5] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [5] Assign{Zone = |Z|}
$!Varset |Z| = (|Z06| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [6] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [6] Assign{Zone = |Z|}
$!Varset |Z| = (|Z07| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [7] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [7] Assign{Zone = |Z|}
$!Varset |Z| = (|Z08| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [8] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [8] Assign{Zone = |Z|}
$!Varset |Z| = (|Z09| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap  [9] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap  [9] Assign{Zone = |Z|}
$!Varset |Z| = (|Z10| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [10] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [10] Assign{Zone = |Z|}
$!Varset |Z| = (|Z11| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [11] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [11] Assign{Zone = |Z|}
#-----------
# 007.01/007.02/007.03: No alpha=1.36 data, so DELTA-2 instead of DELTA-1
$!Varset |Z| = (|Z12| + (|DELTA|-2) +  1*(|GRID|-1) )
$!LineMap [12] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [12] Assign{Zone = |Z|}
$!Varset |Z| = (|Z13| + (|DELTA|-2) +  1*(|GRID|-1) )
$!LineMap [13] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [13] Assign{Zone = |Z|}
$!Varset |Z| = (|Z14| + (|DELTA|-2) +  1*(|GRID|-1) )
$!LineMap [14] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [14] Assign{Zone = |Z|}
#-----------
$!Varset |Z| = (|Z15| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [15] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [15] Assign{Zone = |Z|}
$!Varset |Z| = (|Z16| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [16] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [16] Assign{Zone = |Z|}
$!Varset |Z| = (|Z17| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [17] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [17] Assign{Zone = |Z|}
$!Varset |Z| = (|Z18| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [18] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [18] Assign{Zone = |Z|}
$!Varset |Z| = (|Z19| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [19] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [19] Assign{Zone = |Z|}
$!Varset |Z| = (|Z20| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [20] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [20] Assign{Zone = |Z|}
$!Varset |Z| = (|Z21| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [21] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [21] Assign{Zone = |Z|}
$!Varset |Z| = (|Z22| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [22] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [22] Assign{Zone = |Z|}
$!Varset |Z| = (|Z23| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [23] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [23] Assign{Zone = |Z|}
$!Varset |Z| = (|Z24| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [24] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [24] Assign{Zone = |Z|}
$!Varset |Z| = (|Z25| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [25] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [25] Assign{Zone = |Z|}
$!Varset |Z| = (|Z26| + (|DELTA|-1) +  5*(|GRID|-1) )
$!LineMap [26] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [26] Assign{Zone = |Z|}
$!Varset |Z| = (|Z27| + (|DELTA|-1) +  5*(|GRID|-1) )
$!LineMap [27] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [27] Assign{Zone = |Z|}
$!Varset |Z| = (|Z28| + (|DELTA|-1) +  5*(|GRID|-1) )
$!LineMap [28] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [28] Assign{Zone = |Z|}
$!Varset |Z| = (|Z29| + (|DELTA|-1) +  5*(|GRID|-1) )
$!LineMap [29] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [29] Assign{Zone = |Z|}
$!Varset |Z| = (|Z30| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [30] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [30] Assign{Zone = |Z|}
$!Varset |Z| = (|Z31| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [31] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [31] Assign{Zone = |Z|}
$!Varset |Z| = (|Z32| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [32] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [32] Assign{Zone = |Z|}
$!Varset |Z| = (|Z33| + (|DELTA|-1) +  3*(|GRID|-1) )
$!LineMap [33] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [33] Assign{Zone = |Z|}
$!Varset |Z| = (|Z34| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [34] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [34] Assign{Zone = |Z|}
$!Varset |Z| = (|Z35| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [35] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [35] Assign{Zone = |Z|}
$!Varset |Z| = (|Z36| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [36] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [36] Assign{Zone = |Z|}
$!Varset |Z| = (|Z37| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [37] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [37] Assign{Zone = |Z|}
$!Varset |Z| = (|Z38| + (|DELTA|-1) +  5*(|GRID|-1) )
$!LineMap [38] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [38] Assign{Zone = |Z|}
$!Varset |Z| = (|Z39| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [39] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [39] Assign{Zone = |Z|}
$!Varset |Z| = (|Z40| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [40] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [40] Assign{Zone = |Z|}
$!Varset |Z| = (|Z41| + (|DELTA|-1) +  5*(|GRID|-1) )
$!LineMap [41] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [41] Assign{Zone = |Z|}
$!Varset |Z| = (|Z42| + (|DELTA|-1) +  5*(|GRID|-1) )
$!LineMap [42] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [42] Assign{Zone = |Z|}
$!Varset |Z| = (|Z43| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [43] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [43] Assign{Zone = |Z|}
$!Varset |Z| = (|Z44| + (|DELTA|-1) + 10*(|GRID|-1) )
$!LineMap [44] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [44] Assign{Zone = |Z|}
#--------------
$!IF 0 == 1
 $!Varset |Z| = (|Z45| + (|DELTA|-1) + 10*(|GRID|-1) )
 $!IF |Z| > |NUMZONES|
  $!Varset |Z| = |NUMZONES|
 $!ENDIF
 $!LineMap [45] Name = '&(ZONENAME[|Z|]%6.6s)'
 $!LineMap [45] Assign{Zone = |Z|}
$!ENDIF

#------------------------------------------------
$!ActiveLineMaps = [1-|NumLineMaps|]

#------------
# 007.01/007.02/007.03: Only Alpha 1.50
$!ActiveLineMaps -= [12,13,14]

#------------
# 007.01/007.02/007.03: Only Alpha 1.50
$!IF |ALPHA| == 1.50
   $!ActiveLineMaps += [12,13,14]
$!ENDIF

#------------
# 004.01/004.02/004.03: Some grids have data set to zero
$!IF |ALPHA| == 1.36
 $!IF |GRID| >= 3
   # 004.01/004.02/004.03: Data for ALPHA=1.36, GRID > 2 is all set to zero
   $!ActiveLineMaps -= [6,7,8]
 $!ENDIF
$!ENDIF
$!IF |ALPHA| >= 1.50
 $!IF |GRID| >= 4
   # 004.01:  Data for ALPHA >= 1.50, GRID > 3 is all set to zero
   $!ActiveLineMaps -= [6]
 $!ENDIF
 $!IF |GRID| >= 5
   # 004.02/004.03: Data for ALPHA >= 1.50, GRID > 4 is all set to zero
   $!ActiveLineMaps -= [7,8]
 $!ENDIF
$!ENDIF

#------------
# 014.01: Data is all over the place ... not sure it should be included
$!IF |ALPHA| == 2.50
 $!IF |GRID| >= 2
   $!ActiveLineMaps -= [27]
 $!ENDIF
$!ENDIF
$!IF |ALPHA| >= 3.00
 $!IF |GRID| >= 1
   $!ActiveLineMaps -= [27]
 $!ENDIF
$!ENDIF

#------------
# Submissions that do not include all 6 grid levels
$!IF |GRID| >= 4
  # 020.02
   $!ActiveLineMaps -= [33]
  # 027.01
   $!ActiveLineMaps -= [41]
  # 010.01
  #$!ActiveLineMaps -= [45]
$!ENDIF
$!IF |GRID| >= 5
  # 014.01/014.02
   $!ActiveLineMaps -= [26,27]
  # 027.02
   $!ActiveLineMaps -= [42]
$!ENDIF
$!IF |GRID| >= 6
  # 002.05
  #$!ActiveLineMaps -= [5]
  # 018.01/018.02
   $!ActiveLineMaps -= [30,31]
$!ENDIF

#------------
# Submissions that do not include ALPHA > 2.50
$!IF |ALPHA| > 2.50
   $!ActiveLineMaps -= [33]
$!ENDIF
# Submissions that do not include ALPHA > 3.10
$!IF |ALPHA| > 3.10
   $!ActiveLineMaps -= [26,27,28,29,38,41,42]
$!ENDIF

#------------
# Add lines for highest grid submitted
$!IF |GRIDN| == 1
#
#------------------
# 004.01        has  Cp=0/Cf=0 for GRID > 3
# 004.02/004.03 have Cp=0/Cf=0 for GRID > 4
   $!Varset |Z| = (|Z06| + (|DELTA|-1) + 10*(|GRID|-1 - 4) )
   $!LineMap  [6] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap  [6] Assign{Zone = |Z|}
   $!ActiveLineMaps += [6]
   $!Varset |Z| = (|Z07| + (|DELTA|-1) + 10*(|GRID|-1 - 2) )
   $!LineMap  [7] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap  [7] Assign{Zone = |Z|}
   $!ActiveLineMaps += [7]
   $!Varset |Z| = (|Z08| + (|DELTA|-1) + 10*(|GRID|-1 - 2) )
   $!LineMap  [8] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap  [8] Assign{Zone = |Z|}
   $!ActiveLineMaps += [8]

#------------------
# No longer needed after update to 002.05
#   $!Varset |Z| = (|Z05| + (|DELTA|-1) + 10*(|GRID|-1 - 1) )
#   $!LineMap  [5] Name = '&(ZONENAME[|Z|]%6.6s)'
#   $!LineMap  [5] Assign{Zone = |Z|}
#    $!ActiveLineMaps += [5]

   $!Varset |Z| = (|Z30| + (|DELTA|-1) + 10*(|GRID|-1 - 1) )
   $!LineMap [30] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap [30] Assign{Zone = |Z|}
   $!ActiveLineMaps += [30]
   $!Varset |Z| = (|Z31| + (|DELTA|-1) + 10*(|GRID|-1 - 1) )
   $!LineMap [31] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap [31] Assign{Zone = |Z|}
   $!ActiveLineMaps += [31]

   $!Varset |Z| = (|Z26| + (|DELTA|-1) +  5*(|GRID|-1 - 2) )
   $!LineMap [26] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap [26] Assign{Zone = |Z|}
   $!ActiveLineMaps += [26]
   $!Varset |Z| = (|Z27| + (|DELTA|-1) +  5*(|GRID|-1 - 2) )
   $!LineMap [27] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap [27] Assign{Zone = |Z|}
   $!IF |ALPHA| <= 2.50
      $!ActiveLineMaps += [27]
   $!ENDIF
   $!Varset |Z| = (|Z42| + (|DELTA|-1) +  5*(|GRID|-1 - 2) )
   $!LineMap [42] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap [42] Assign{Zone = |Z|}
   $!ActiveLineMaps += [42]

   $!Varset |Z| = (|Z33| + (|DELTA|-1) +  3*(|GRID|-1 - 3) )
   $!LineMap [33] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap [33] Assign{Zone = |Z|}
   $!ActiveLineMaps += [33]
   $!Varset |Z| = (|Z41| + (|DELTA|-1) +  5*(|GRID|-1 - 3) )
   $!LineMap [41] Name = '&(ZONENAME[|Z|]%6.6s)'
   $!LineMap [41] Assign{Zone = |Z|}
   $!ActiveLineMaps += [41]
  #------------------------------
   $!VarSet |GRID| = "N"
   $!RUNMACROFUNCTION "UpdateHeaderText"
$!ENDIF

#------------
# 020.02: 1st order .. needs to be resubmitted
$!ActiveLineMaps -= [33]

#------------------------------------------------
# Cf
$!IF 1 == 1
   $!PageName = 'CF_|TYPE|'
   $!LineMap [1-|NumLineMaps|] Assign{XAxisVar = 9 YAxisVar = 5}
   $!View NiceFit
   $!View MakeCurrentViewNice
   $!XYLineAxis XDetail 1 {RangeMin = -0.010 RangeMax = 1.010 }
   $!XYLineAxis YDetail 1 {RangeMin = -0.002 RangeMax = 0.014 IsReversed = No  AutoGrid = Yes }
   $!XYLineAxis YDetail 1 {GRSpacing = 0.002 }

#$!LineMap [45] ErrorBars { Var = 14 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }

   $!RedrawAll
   $!ExportSetup ExportFName = '|MACROFILEPATH|/|ImageFile|/Alpha|ALPHA|_Grid|GRID|_CF_|TYPE|.|ImageFile|'
   $!Export 
     ExportRegion = AllFrames

###$!PAUSE 'ok'

$!ENDIF
#------------------------------------------------

#------------------------------------------------
# Cp
$!IF 1 == 1
   $!PageName = 'CP_|TYPE|'
   $!LineMap [1-|NumLineMaps|] Assign{XAxisVar = 9 YAxisVar = 4}
   $!View NiceFit
   $!View MakeCurrentViewNice
   $!XYLineAxis XDetail 1 {RangeMin = -0.010 RangeMax = 1.010 }
   $!XYLineAxis YDetail 1 {RangeMin = -1.600 RangeMax = 1.200 IsReversed = Yes AutoGrid = Yes }
   $!XYLineAxis YDetail 1 {GRSpacing = 0.500 }

#$!LineMap [|NumLineMaps|] ErrorBars { Var = 12 Show = Yes Color = Cyan SkipMode = ByFrameUnits Skipping = 5 }

   $!RedrawAll
   $!ExportSetup ExportFName = '|MACROFILEPATH|/|ImageFile|/Alpha|ALPHA|_Grid|GRID|_CP_|TYPE|.|ImageFile|'
   $!Export 
     ExportRegion = AllFrames

###$!PAUSE 'ok'

$!ENDIF
#------------------------------------------------

$!IF |GRIDN| == 1
   $!VarSet |GRID| = 7
$!ENDIF
