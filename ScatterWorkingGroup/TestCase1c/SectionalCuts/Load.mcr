#!MC 1410
$!FrameLayout ShowBorder = No
$!PrintSetup  Palette = Color
$!ExportSetup UseSuperSampleAntiAliasing = Yes
$!ExportSetup ImageWidth = 2000

#-------------------------------------------------
# Turbulence Model Variants
#------------------------------
$!VarSet |SA_Maps|         = ''
$!VarSet |SAQ_Maps|        = ''
$!VarSet |SST_Maps|        = ''
$!VarSet |WMLES_Maps|      = ''
#-------------------------------------------------
# Grid Type Variants
#------------------------------
$!VarSet |CadenceStr_Maps| = ''
$!VarSet |CadenceUnS_Maps| = ''
$!VarSet |HeldenUnSt_Maps| = ''
$!VarSet |OneraStruc_Maps| = ''
$!VarSet |CstmUsrAdp_Maps| = ''
$!VarSet |CstmUsrUns_Maps| = ''
$!VarSet |CstmUsrStr_Maps| = ''
#-------------------------------------------------
# Maps with placeholder data
#------------------------------
$!VarSet |000_Maps|        = ''
#-------------------------------------------------

#===================================================================
# Create Macro Function: PlotData ( '|ALPHA|', |GRID|, 'Turb or Grid', 'Cf or Cp' )
#-------------------------------------
$!MACROFUNCTION
  NAME = "PlotData"
  $!VarSet |ALPHAstr| = '|1|'
  $!VarSet |GRIDstr|  = '|2|'
  $!VarSet |PlotCol|  = '|3|'
  $!VarSet |PlotVar|  = '|4|'
  $!VarSet |PlotName| = '|PlotVar|_|PlotCol|'
  $!RUNMACROFUNCTION "UpdatePlotType" ( '|PlotCol|' )
  $!RUNMACROFUNCTION "AssignZones"    ( '|ALPHAstr|', |GRIDstr| )
  $!IF '|GRIDstr|' == '7'
    $!VarSet |GRIDstr| = 'N'
  $!ENDIF

  $!PageName = '|PlotName|'
  $!IF '|PlotVar|' == 'Cf'
    $!VarSet |Yvar| = 5
    $!VarSet |Evar| = 7 
  $!ELSEIF '|PlotVar|' == 'Cp'
    $!VarSet |Yvar| = 4
    $!VarSet |Evar| = 6 
  $!ENDIF
  $!LineMap [1-|NumLineMaps|] Assign{XAxisVar = 9 YAxisVar = |Yvar|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -0.010 RangeMax = 1.010 }
  $!IF '|PlotVar|' == 'Cf'
    $!XYLineAxis YDetail 1 {RangeMin = -0.002 RangeMax = 0.014 IsReversed = No  AutoGrid = Yes }
    $!XYLineAxis YDetail 1 {GRSpacing = 0.002 }
  $!ELSEIF '|PlotVar|' == 'Cp'
    $!XYLineAxis YDetail 1 {RangeMin = -1.600 RangeMax = 1.200 IsReversed = Yes AutoGrid = Yes }
    $!XYLineAxis YDetail 1 {GRSpacing = 0.500 }
  $!ENDIF
  $!IF |IncludeTestCase1b| == 1
    $!LineMap [45] ErrorBars { Var = |Evar| Show = Yes SkipMode = ByFrameUnits Skipping = 5 }
    $!LineMap [57] ErrorBars { Var = |Evar| Show = Yes SkipMode = ByFrameUnits Skipping = 5 }
    $!LineMap [58] ErrorBars { Var = |Evar| Show = Yes SkipMode = ByFrameUnits Skipping = 5 }
    $!LineMap [59] ErrorBars { Var = |Evar| Show = Yes SkipMode = ByFrameUnits Skipping = 5 }
    $!LineMap [60] ErrorBars { Var = |Evar| Show = Yes SkipMode = ByFrameUnits Skipping = 5 }
  $!ENDIF
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|', 'Alpha|ALPHAstr|_Grid|GRIDstr|_|PlotName|', '|ImageFormat|', '|ImageFormat2|' )
$!ENDMACROFUNCTION
#===================================================================
# Create Macro Function: UpdateHeaderText ( '|ALPHA|', '|GRID|' )
#-------------------------------------
$!MACROFUNCTION
  NAME = "UpdateHeaderText"
  $!VarSet |ALPHAstr| = '|1|'
  $!VarSet |GRIDstr|  = '|2|'

  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Box { BoxType = Filled } Text = 'JunkText'
    $!Pick DeselectAll
    $!IF 0 == 1
      $!Pick AddAtPosition
        X = 5.50
        Y = 4.25
        ConsiderStyle = Yes
    $!ELSE
      $!Pick AddAllInRect
        SelectText = Yes
        X1 = 2.75
        X2 = 8.25
        Y1 = 1.75
        Y2 = 6.75
    $!ENDIF
    $!Pick Clear
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF

  $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Box { BoxType = Filled } Text = 'JunkText'
  $!Pick DeselectAll
  $!IF 0 == 1
    $!Pick AddAtPosition
      X = 5.75
      Y = 0.35
      ConsiderStyle = Yes
  $!ELSE
    $!Pick AddAllInRect
      SelectText = Yes
      X1 = 1.0
      X2 = 7.6
      Y1 = 0.0
      Y2 = 1.5
  $!ENDIF
  $!Pick Clear
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1a: ONERA OAT15A

\ \ \ \ \ Sectional Cuts: Grid |GRIDstr|

\ \ \ \ \ \ \ Angle of Attack |ALPHAstr|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1a: ONERA OAT15A\nSectional Cuts: Grid |GRIDstr|\nAngle of Attack |ALPHAstr|"
  $!ENDIF
  $!Pick DeselectAll
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "AppendDataSetFile"
#-------------------------------------
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
#-------------------------------------
$!MACROFUNCTION
  NAME = "AddLineMap"
  $!VarSet |Z| = |3|
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
  $!ELSEIF '|1|' == 'SST_Maps'
     $!VarSet |SST_Maps|        = '|SST_Maps| |NumLineMaps|,'
  $!ELSEIF '|1|' == 'WMLES_Maps'
     $!VarSet |WMLES_Maps|      = '|WMLES_Maps| |NumLineMaps|,'
  $!ENDIF
  # Assign LineMap to Grid Type Label
  $!IF     '|2|' == 'CadenceStr_Maps'
     $!VarSet |CadenceStr_Maps| = '|CadenceStr_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CadenceUnS_Maps'
     $!VarSet |CadenceUnS_Maps| = '|CadenceUnS_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'HeldenUnSt_Maps'
     $!VarSet |HeldenUnSt_Maps| = '|HeldenUnSt_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'OneraStruc_Maps'
     $!VarSet |OneraStruc_Maps| = '|OneraStruc_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrAdp_Maps| = '|CstmUsrAdp_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrUns_Maps'
     $!VarSet |CstmUsrUns_Maps| = '|CstmUsrUns_Maps| |NumLineMaps|,'
  $!ELSEIF '|2|' == 'CstmUsrAdp_Maps'
     $!VarSet |CstmUsrStr_Maps| = '|CstmUsrStr_Maps| |NumLineMaps|,'
  $!ENDIF
$!ENDMACROFUNCTION
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
# Create Macro Function: UpdatePlotType ( '|TYPE|' )
#-------------------------------------
$!MACROFUNCTION
  NAME = "UpdatePlotType"
  $!VarSet |TYPE| = '|1|'

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy
  $!PageControl Create
  $!PageName = 'CP_|TYPE|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1

  $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'JunkText' Box { BoxType = Filled }
  $!PICK ADDALLINRECT
    SelectText = Yes
    X1 = 7.7
    X2 = 10.2
    Y1 = 0.0
    Y2 = 1.7
  $!PICK CLEAR
  $!IF '|TYPE|' == 'Turb'
    $!LineMap  [|SA_Maps|]    Lines   { Color = Red   } Symbols { Color = Red   FillColor = Red   } ErrorBars   { Color = Red   }
    $!LineMap  [|SAQ_Maps|]   Lines   { Color = Green } Symbols { Color = Green FillColor = Green } ErrorBars   { Color = Green }
    $!LineMap  [|SST_Maps|]   Lines   { Color = Black } Symbols { Color = Black FillColor = Black } ErrorBars   { Color = Black }
    #==================================================================================================
    # Include TestCase1b Data?
    $!IF |IncludeTestCase1b| == 0
      $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n' Box { BoxType = Filled }
      $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
      $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     SA + QCR'
      $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     SST'
    $!ELSE
      $!LineMap  [|WMLES_Maps|] Lines   { Color = Cyan  } Symbols { Color = Cyan  FillColor = Cyan  }
      $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n\n' Box { BoxType = Filled }
      $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
      $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     SA + QCR'
      $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     SST'
      $!AttachText AnchorPos { X = 76 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Cyan   Anchor = HeadLeft Text = '     WMLES'
    $!ENDIF
    #==================================================================================================
  $!ELSEIF '|TYPE|' == 'Grid'
    $!LineMap  [|CadenceStr_Maps|] Lines   { Color = Red    } Symbols { Color = Red    FillColor = Red    } ErrorBars   { Color = Red    }
    $!LineMap  [|CadenceUnS_Maps|] Lines   { Color = Black  } Symbols { Color = Black  FillColor = Black  } ErrorBars   { Color = Black  }
    $!LineMap  [|HeldenUnSt_Maps|] Lines   { Color = Blue   } Symbols { Color = Blue   FillColor = Blue   }
    $!LineMap  [|OneraStruc_Maps|] Lines   { Color = Green  } Symbols { Color = Green  FillColor = Green  }
    $!LineMap  [|CstmUsrAdp_Maps|] Lines   { Color = Purple } Symbols { Color = Purple FillColor = Purple }
    $!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
    $!LineMap  [|CstmUsrStr_Maps|] Lines   { Color = Yellow } Symbols { Color = Yellow FillColor = Yellow }
    #==================================================================================================
    # Include TestCase1b Data?
    $!IF |IncludeTestCase1b| == 0
      $!AttachText AnchorPos { X = 75 Y = 99 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n' Box { BoxType = Filled }
      $!AttachText AnchorPos { X = 75 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     Cadence Structured'
      $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstructured'
      $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
     #$!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     ONERA Structured'
      $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'
    $!ELSE
      $!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
      $!AttachText AnchorPos { X = 75 Y = 99 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n\n\n' Box { BoxType = Filled }
      $!AttachText AnchorPos { X = 75 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     Cadence Structured'
      $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstructured'
      $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
     #$!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     ONERA Structured'
      $!AttachText AnchorPos { X = 75 Y = 89 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'
      $!AttachText AnchorPos { X = 75 Y = 87 } TextShape { Height = 12 IsBold = No } Color = Cyan   Anchor = HeadLeft Text = '     User Unstructured Grid'
    $!ENDIF
    #==================================================================================================
  $!ENDIF
$!ENDMACROFUNCTION
#===================================================================
# Create Macro Function: AssignZones ( |ALPHA| |GRID| )
#-------------------------------------
$!MACROFUNCTION
  NAME = "AssignZones"
  $!VarSet |ALPHAstr| = '|1|'
  $!VarSet |GRID|     =  |2|

  # Update Header based on |GRID|/|ALPHA| variables
  #------------------------------------------------
  $!VarSet |GRDN| = 0
  $!IF |GRID| == 7
    $!VarSet |GRID| = 6
    $!VarSet |GRDN| = 1
    $!RUNMACROFUNCTION "UpdateHeaderText" ( '|ALPHAstr|',   'N'    )
  $!ELSE
    $!RUNMACROFUNCTION "UpdateHeaderText" ( '|ALPHAstr|', '|GRID|' )
  $!ENDIF

  # Activate correct zones based on |GRID|/|ALPHA| variables
  #------------------------------------------------
  $!IF     '|ALPHAstr|' == '1.36'
    $!VarSet |DELTA| =  1
  $!ELSEIF '|ALPHAstr|' == '1.50'
    $!VarSet |DELTA| =  2
  $!ELSEIF '|ALPHAstr|' == '2.50'
    $!VarSet |DELTA| =  3
  $!ELSEIF '|ALPHAstr|' == '3.00'
    $!VarSet |DELTA| =  4
  $!ELSEIF '|ALPHAstr|' == '3.10'
    $!VarSet |DELTA| =  5
  $!ELSEIF '|ALPHAstr|' == '3.25'
    $!VarSet |DELTA| =  6
  $!ELSEIF '|ALPHAstr|' == '3.40'
    $!VarSet |DELTA| =  7
  $!ELSEIF '|ALPHAstr|' == '3.50'
    $!VarSet |DELTA| =  8
  $!ELSEIF '|ALPHAstr|' == '3.60'
    $!VarSet |DELTA| =  9
  $!ELSEIF '|ALPHAstr|' == '3.90'
    $!VarSet |DELTA| = 10
  $!ENDIF

  #------------------------------------------------
  # Note that the number of Alphas in the file varies (10 vs. 1 vs. 5, etc.)
  $!Varset |Z| = (|Z01| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [1] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z02| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [2] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z03| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [3] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z04| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [4] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z05| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [5] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z06| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [6] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z07| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [7] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z08| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [8] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z09| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap  [9] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z10| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [10] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z11| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [11] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  #-----------
  # 007.01/007.02/007.03: No alpha=1.36 data, so DELTA-2 instead of DELTA-1
  $!Varset |Z| = (|Z12| + (|DELTA|-2) +  1*(|GRID|-1) )
  $!LineMap [12] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z13| + (|DELTA|-2) +  1*(|GRID|-1) )
  $!LineMap [13] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z14| + (|DELTA|-2) +  1*(|GRID|-1) )
  $!LineMap [14] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  #-----------
  $!Varset |Z| = (|Z15| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [15] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z16| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [16] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z17| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [17] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z18| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [18] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z19| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [19] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z20| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [20] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z21| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [21] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z22| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [22] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z23| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [23] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z24| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [24] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z25| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [25] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z26| + (|DELTA|-1) +  5*(|GRID|-1) )
  $!LineMap [26] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z27| + (|DELTA|-1) +  5*(|GRID|-1) )
  $!LineMap [27] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z28| + (|DELTA|-1) +  5*(|GRID|-1) )
  $!LineMap [28] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z29| + (|DELTA|-1) +  5*(|GRID|-1) )
  $!LineMap [29] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z30| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [30] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z31| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [31] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z32| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [32] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z33| + (|DELTA|-1) +  3*(|GRID|-1) )
  $!LineMap [33] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z34| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [34] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z35| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [35] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z36| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [36] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z37| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [37] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z38| + (|DELTA|-1) +  5*(|GRID|-1) )
  $!LineMap [38] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z39| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [39] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z40| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [40] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z41| + (|DELTA|-1) +  5*(|GRID|-1) )
  $!LineMap [41] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z42| + (|DELTA|-1) +  5*(|GRID|-1) )
  $!LineMap [42] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z43| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [43] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z44| + (|DELTA|-1) + 10*(|GRID|-1) )
  # 029.02: No alpha=1.36 data, so DELTA-2 instead of DELTA-1
  #$!Varset |Z| = (|Z44| + (|DELTA|-2) + 10*(|GRID|-1) )
  #$!Varset |Z| = (|Z44| + 0 )
  $!LineMap [44] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  #--------------
  $!IF |IncludeTestCase1b| == 1
   $!Varset |Z| = (|Z45| + (|DELTA|-1) + 10*(|GRID|-1) )
   $!IF |Z| > |NUMZONES|
    $!Varset |Z| = |NUMZONES|
   $!ENDIF
   $!LineMap [45] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!ENDIF
  #--------------
  $!Varset |Z| = (|Z46| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [46] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z47| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [47] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z48| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [48] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z49| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [49] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z50| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [50] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z51| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [51] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z52| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [52] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z53| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [53] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z54| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [54] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z55| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [55] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z56| + (|DELTA|-1) + 10*(|GRID|-1) )
  $!LineMap [56] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!IF |IncludeTestCase1b| == 1
   $!Varset |Z| = (|Z57| + (|DELTA|-1) + 10*(|GRID|-1) )
   $!LineMap [57] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
   $!Varset |Z| = (|Z58| + (|DELTA|-1) + 10*(|GRID|-1) )
   $!LineMap [58] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
   $!Varset |Z| = (|Z59| + (|DELTA|-1) + 10*(|GRID|-1) )
   $!LineMap [59] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
   $!Varset |Z| = (|Z60| + (|DELTA|-1) + 10*(|GRID|-1) )
   $!LineMap [60] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!ENDIF
  #------------------------------------------------
  $!VarSet |DELTA| = 1
  $!Varset |Z| = (|Z61| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [61] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z62| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [62] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z63| + (|DELTA|-1) +  1*(|GRID|-1) )
     $!Varset |Z| = (|Z| + 1 )
  $!LineMap [63] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z64| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [64] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z65| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [65] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z66| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [66] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z67| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [67] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z68| + (|DELTA|-1) +  1*(|GRID|-1) )
     $!Varset |Z| = (|Z| + 1 )
  $!LineMap [68] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z69| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [69] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z70| + (|DELTA|-1) +  1*(|GRID|-1) )
     $!Varset |Z| = (|Z| - 1 )
  $!LineMap [70] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z71| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [71] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z72| + (|DELTA|-1) +  1*(|GRID|-1) )
     $!Varset |Z| = (|Z| - 2 )
  $!LineMap [72] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z73| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [73] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z74| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [74] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z75| + (|DELTA|-1) +  1*(|GRID|-1) )
     $!Varset |Z| = (|Z| + 1 )
  $!LineMap [75] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z76| + (|DELTA|-1) +  1*(|GRID|-1) )
     $!Varset |Z| = (|Z| + 1 )
  $!LineMap [76] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z77| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [77] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  $!Varset |Z| = (|Z78| + (|DELTA|-1) +  1*(|GRID|-1) )
  $!LineMap [78] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
#  $!Varset |Z| = (|Z79| + (|DELTA|-1) +  1*(|GRID|-1) )
#     $!Varset |Z| = (|Z| + 2 )
#  $!LineMap [79] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
#  $!Varset |Z| = (|Z80| + (|DELTA|-1) +  1*(|GRID|-1) )
#     $!Varset |Z| = (|Z| + 0 )
#  $!LineMap [80] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  # 029.02
  $!Varset |Z| = (|Z79| + 0 )
  $!LineMap [79] Name = '&(ZONENAME[|Z|]%6.6s)' Assign{Zone = |Z|}
  #------------------------------------------------
  # Activate all LineMaps
  $!ActiveLineMaps = [1-|NumLineMaps|]
  #------------------------------------------------
  # Activate only LineMaps that should be plotted (HARDCODED BASED ON SUBMITTED DATA!!!)
  $!RUNMACROFUNCTION "AssignActiveZones" ( '|ALPHAstr|', |GRID| )
  #------------------------------------------------
  # Deactivate all Test Case 1a LineMaps ( except 44: 029.02 )
  $!ActiveLineMaps -= [1-43,44,45-60]
$!ENDMACROFUNCTION
#===================================================================
# Create Macro Function: AssignActiveZones ( |ALPHA|, |GRID| )
#-------------------------------------
$!MACROFUNCTION
  NAME = "AssignActiveZones"
  $!VarSet |ALPHAstr| = '|1|'
  $!VarSet |GRID|     =  |2|
  $!VarSet |ALPHAnum| = |ALPHAstr|
  #------------------------------------------------
  # 007.01/007.02/007.03: Only Alpha 1.50
  $!ActiveLineMaps -= [12,13,14]
  $!IF |ALPHAnum| == 1.50
     $!ActiveLineMaps += [12,13,14]
  $!ENDIF
  #------------------------------------------------
  # 004.01/004.02/004.03: Some grids have data set to zero
  $!IF |ALPHAnum| == 1.36
   $!IF |GRID| >= 3
     # 004.01/004.02/004.03: Data for ALPHA=1.36, GRID > 2 is all set to zero
     $!ActiveLineMaps -= [6,7,8]
   $!ENDIF
  $!ENDIF
  $!IF |ALPHAnum| >= 1.50
   $!IF |GRID| >= 4
     # 004.01:  Data for ALPHA >= 1.50, GRID > 3 is all set to zero
    $!ActiveLineMaps -= [6]
   $!ENDIF
   $!IF |GRID| >= 5
     # 004.02/004.03: Data for ALPHA >= 1.50, GRID > 4 is all set to zero
     $!ActiveLineMaps -= [7,8]
   $!ENDIF
  $!ENDIF
  #------------------------------------------------
#  # 014.01: Data is all over the place ... not sure it should be included
#  $!IF |ALPHAnum| == 2.50
#   $!IF |GRID| >= 2
#     $!ActiveLineMaps -= [27]
#   $!ENDIF
#  $!ENDIF
#  $!IF |ALPHAnum| >= 3.00
#   $!IF |GRID| >= 1
#     $!ActiveLineMaps -= [27]
#   $!ENDIF
#  $!ENDIF
  #------------------------------------------------
  # Submissions that do not include all 6 grid levels
  $!IF |GRID| >= 2
   $!IF |IncludeTestCase1b| == 1
    # 005.03
    $!ActiveLineMaps -= [57]
    # 005.04
    $!ActiveLineMaps -= [58]
    # 005.05
    $!ActiveLineMaps -= [59]
    # 008.02
    $!ActiveLineMaps -= [60]
   $!ENDIF
  $!ENDIF
  $!IF |GRID| >= 4
    # 020.02
    $!ActiveLineMaps -= [33]
    # 027.01
    $!ActiveLineMaps -= [41]
   $!IF |IncludeTestCase1b| == 1
    # 010.01
    $!ActiveLineMaps -= [45]
   $!ENDIF
  $!ENDIF
  $!IF |GRID| >= 5
    # 014.01/014.02
    $!ActiveLineMaps -= [26,27]
    # 027.02
    $!ActiveLineMaps -= [42]
  $!ENDIF
  $!IF |GRID| >= 6
    # 018.01/018.02
    $!ActiveLineMaps -= [30,31]
  $!ENDIF
  #------------------------------------------------
  # Submissions that do not include ALPHA > 2.50
  $!IF |ALPHAnum| > 2.50
    $!ActiveLineMaps -= [33]
  $!ENDIF
  # Submissions that do not include ALPHA > 3.10
  $!IF |ALPHAnum| > 3.10
    $!ActiveLineMaps -= [26,27,28,29,38,41,42]
  $!ENDIF
  #------------------------------------------------
  # Add lines for highest grid submitted
  $!IF |GRDN| == 1
  #------------------
    # Map6: 004.01 has Cp=0/Cf=0 for GRID > 3
    $!Varset |Z| = (|Z06| + (|DELTA|-1) + 10*(|GRID|-1 - 4) )
    $!LineMap  [6] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap  [6] Assign{Zone = |Z|}
    $!ActiveLineMaps += [6]
    #------------------------------
    # Map7: 004.02 has Cp=0/Cf=0 for GRID > 4
    $!Varset |Z| = (|Z07| + (|DELTA|-1) + 10*(|GRID|-1 - 2) )
    $!LineMap  [7] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap  [7] Assign{Zone = |Z|}
    $!ActiveLineMaps += [7]
    #------------------------------
    # Map8: 004.03 has Cp=0/Cf=0 for GRID > 4
    $!Varset |Z| = (|Z08| + (|DELTA|-1) + 10*(|GRID|-1 - 2) )
    $!LineMap  [8] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap  [8] Assign{Zone = |Z|}
    $!ActiveLineMaps += [8]
    #------------------------------
    # Map30: 018.01 has 5 grids
    $!Varset |Z| = (|Z30| + (|DELTA|-1) + 10*(|GRID|-1 - 1) )
    $!LineMap [30] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [30] Assign{Zone = |Z|}
    $!ActiveLineMaps += [30]
    #------------------------------
    # Map31: 018.02 has 5 grids
    $!Varset |Z| = (|Z31| + (|DELTA|-1) + 10*(|GRID|-1 - 1) )
    $!LineMap [31] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [31] Assign{Zone = |Z|}
    $!ActiveLineMaps += [31]
    #------------------------------
    # Map26: 014.01 has 4 grids for |ALPHA| <= 3.10
    $!Varset |Z| = (|Z26| + (|DELTA|-1) +  5*(|GRID|-1 - 2) )
    $!LineMap [26] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [26] Assign{Zone = |Z|}
    $!ActiveLineMaps += [26]
    $!IF |ALPHAnum| > 3.10
      $!ActiveLineMaps -= [26]
    $!ENDIF
    #------------------------------
    # Map27: 014.02 has 4 grids for |ALPHA| <= 3.10
    $!Varset |Z| = (|Z27| + (|DELTA|-1) +  5*(|GRID|-1 - 2) )
    $!LineMap [27] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [27] Assign{Zone = |Z|}
    $!ActiveLineMaps += [27]
    $!IF |ALPHAnum| > 3.10
      $!ActiveLineMaps -= [27]
    $!ENDIF
    #------------------------------
    # Map42: 027.02 has 4 grids for |ALPHA| <= 3.10
    $!Varset |Z| = (|Z42| + (|DELTA|-1) +  5*(|GRID|-1 - 2) )
    $!LineMap [42] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [42] Assign{Zone = |Z|}
    $!ActiveLineMaps += [42]
    $!IF |ALPHAnum| > 3.10
      $!ActiveLineMaps -= [42]
    $!ENDIF
    #------------------------------
    # Map33: 020.02 has 3 grids for |ALPHA| <= 3.25
    $!Varset |Z| = (|Z33| + (|DELTA|-1) +  3*(|GRID|-1 - 3) )
    $!LineMap [33] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [33] Assign{Zone = |Z|}
    $!ActiveLineMaps += [33]
    $!IF |ALPHAnum| > 2.50
      $!ActiveLineMaps -= [33]
    $!ENDIF
    #------------------------------
    # Map41: 027.01 has 3 grids for |ALPHA| <= 3.10
    $!Varset |Z| = (|Z41| + (|DELTA|-1) +  5*(|GRID|-1 - 3) )
    $!LineMap [41] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [41] Assign{Zone = |Z|}
    $!ActiveLineMaps += [41]
    $!IF |ALPHAnum| > 3.10
      $!ActiveLineMaps -= [41]
    $!ENDIF
    #------------------------------
   $!IF |IncludeTestCase1b| == 1
    # Map45: 010.01 has 3 grids
    $!Varset |Z| = (|Z45| + (|DELTA|-1) + 10*(|GRID|-1 - 3) )
    $!LineMap [45] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [45] Assign{Zone = |Z|}
    $!ActiveLineMaps += [45]
    # Map57: 005.03 has 1 grid
    $!Varset |Z| = (|Z57| + (|DELTA|-1) + 10*(|GRID|-1 - 5) )
    $!LineMap [57] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [57] Assign{Zone = |Z|}
    $!ActiveLineMaps += [57]
    # Map58: 005.04 has 1 grid
    $!Varset |Z| = (|Z58| + (|DELTA|-1) + 10*(|GRID|-1 - 5) )
    $!LineMap [58] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [58] Assign{Zone = |Z|}
    $!ActiveLineMaps += [58]
    # Map59: 005.05 has 1 grid
    $!Varset |Z| = (|Z59| + (|DELTA|-1) + 10*(|GRID|-1 - 5) )
    $!LineMap [59] Name = '&(ZONENAME[|Z|]%6.6s)'
    $!LineMap [59] Assign{Zone = |Z|}
    $!ActiveLineMaps += [59]
   $!ENDIF
    #------------------------------
    $!VarSet |GRID| = 7
  $!ENDIF
  #------------------------------------------------
  # 020.02: 1st order .. needs to be resubmitted
  $!ActiveLineMaps -= [33]
  #------------------------------------------------
  # Deactiveate all linemaps that read in placeholder data
  $!ActiveLineMaps -= [|000_Maps|]
  $!LineMap [|000_Maps|] Assign{ShowInLegend = Never}
$!ENDMACROFUNCTION
#===================================================================
#$!RUNMACROFUNCTION "LoadData"
#-------------------------------------
$!MACROFUNCTION
  NAME = "LoadData"
#-------------------------------------------------
# Map00:
$!Varset |Z00| = (0 + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Plotting/TestCase1a/SectionalCuts/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = New
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"X" "Y" "Z" "CP" "CF" "CFX" "CFY" "CFZ" "X/C";"XoC"'
$!ActiveLineMaps -= [1-|NumLineMaps|]
$!DeleteLineMaps    [1-|NumLineMaps|]
#-------------------------------------------------
# Map01: 002.01
$!Varset |Z01| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/01_CFD++_CadenceUnstructured_SA-RC-QCR/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceUnS_Maps', |Z01| )
#-------------------------------------------------
# Map02: 002.02
$!Varset |Z02| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/02_CFD++_CadenceUnstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z02| )
#-------------------------------------------------
# Map03: 002.03
$!Varset |Z03| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/03_CFD++_CadenceUnstructured_SST/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'CadenceUnS_Maps', |Z03| )
#-------------------------------------------------
# Map04: 002.04
$!Varset |Z04| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/04_CFD++_CadenceStructured_SA-RC-QCR/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceStr_Maps', |Z04| )
#-------------------------------------------------
# Map05: 002.05
$!Varset |Z05| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/05_CFD++_HeldenMesh_SA-RC-QCR/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'HeldenUnSt_Maps', |Z05| )
#-------------------------------------------------
# Map06: 004.01
$!Varset |Z06| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/01_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z06| )
#-------------------------------------------------
# Map07: 004.02
$!Varset |Z07| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/02_SAR/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceUnS_Maps', |Z07| )
#-------------------------------------------------
# Map08: 004.03
$!Varset |Z08| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/03_SAQCR/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceUnS_Maps', |Z08| )
#-------------------------------------------------
# Map09: 005.01
$!Varset |Z09| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/01_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceStr_Maps', |Z09| )
#-------------------------------------------------
# Map10: 005.02
$!Varset |Z10| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/02_SARC_CC/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceStr_Maps', |Z10| )
#-------------------------------------------------
# Map11: 006.01
$!Varset |Z11| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/006/01_LociChem/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'CadenceUnS_Maps', |Z11| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map12: 007.01
$!Varset |Z12| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/007_JAXA/01_FaSTAR_Cadence-Structured_SA-noft2/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceStr_Maps', |Z12| )
#-------------------------------------------------
# Map13: 007.02
$!Varset |Z13| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/007_JAXA/02_FaSTAR_Cadence-Structured_SA-noft2-R-QCR2000/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceStr_Maps', |Z13| )
#-------------------------------------------------
# Map14: 007.03
$!Varset |Z14| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/007_JAXA/03_FaSTAR_Cadence-Structured_SST-2003sust/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'CadenceStr_Maps', |Z14| )
#-------------------------------------------------
# Map15: 008.01
$!Varset |Z15| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/008_Metacomp/01_CFD++_Cadence_Structured/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceStr_Maps', |Z15| )
#-------------------------------------------------
# Map16: 009.01
$!Varset |Z16| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/01_elsA_Cadence-structured_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceStr_Maps', |Z16| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map17: 009.02
$!Varset |Z17| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/02_elsA_Cadence-unstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z17| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map18: 009.03
$!Varset |Z18| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/03_elsA_Helden-unstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'HeldenUnSt_Maps', |Z18| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map19: 009.04
$!Varset |Z19| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/04_elsA_ONERA-Structured_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'OneraStruc_Maps', |Z19| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map20: 009.05
$!Varset |Z20| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/05_elsA_Cadence-structured_kwSST/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'CadenceStr_Maps', |Z20| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map21: 009.06
$!Varset |Z21| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/06_elsA_Cadence-unstructured_kwSST/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'CadenceUnS_Maps', |Z21| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map22: 009.07
$!Varset |Z22| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/07_elsA_Helden-unstructured_kwSST/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'HeldenUnSt_Maps', |Z22| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map23: 009.08
$!Varset |Z23| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/08_elsA_ONERA-structured_kwSST/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'OneraStruc_Maps', |Z23| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map24: 011.01
$!Varset |Z24| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/011_HEMLAB/01_Structured/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceStr_Maps', |Z24| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map25: 011.02
$!Varset |Z25| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ('"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/011_HEMLAB/02_Adaptive/DPW8-AePW4_SectionalCuts_v5.dat"'  )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CstmUsrAdp_Maps', |Z25| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map26: 014.01
$!Varset |Z26| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/014_IISc/01_SU2_Symmetric_BC/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/014_IISc/01_SU2_Symmetric_BC/DPW8-AePW4_SectionalCuts_v5.dat-sorted"' )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z26| )
##$!ActiveLineMaps -= [|NumLineMaps|]
##$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
#$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map27: 014.02
$!Varset |Z27| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/014_IISc/02_SU2_Periodic_BC/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/014_IISc/02_SU2_Periodic_BC/DPW8-AePW4_SectionalCuts_v5.dat-sorted"' )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z27| )
##$!ActiveLineMaps -= [|NumLineMaps|]
##$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
#$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map28: 015.01
$!Varset |Z28| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/01_FUN3D/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z28| )
#-------------------------------------------------
# Map29: 015.02
$!Varset |Z29| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/02_FUN3D/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'CadenceUnS_Maps', |Z29| )
#-------------------------------------------------
# Map30: 018.01
$!Varset |Z30| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/01_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z30| )
#-------------------------------------------------
# Map31: 018.02
$!Varset |Z31| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/02_SST-V-2003/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'CadenceUnS_Maps', |Z31| )
#-------------------------------------------------
# Map32: 020.01
$!Varset |Z32| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA/DPW8-AePW4_SectionalCuts_v5.dat-sorted"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceStr_Maps', |Z32| )
#-------------------------------------------------
# Map33: 020.02
$!Varset |Z33| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat-sorted"' )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z33| )
#-------------------------------------------------
# Map34: 020.03
$!Varset |Z34| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg/DPW8-AePW4_SectionalCuts_v5.dat-sorted"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceStr_Maps', |Z34| )
#-------------------------------------------------
# Map35: 020.04
$!Varset |Z35| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg/DPW8-AePW4_SectionalCuts_v5.dat-sorted"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z35| )
#-------------------------------------------------
# Map36: 023.01
$!Varset |Z36| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/023_PolytechniqueMontreal/01_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z36| )
#-------------------------------------------------
# Map37: 024.01
$!Varset |Z37| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/024_UniversityofLiverpool/01_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z37| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map38: 025.01
$!Varset |Z38| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Static-Deform/TestCase1a/025_TLGAerospace/01_STARCCM_CadenceUnstr_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z38| )
#-------------------------------------------------
# Map39: 026.01
$!Varset |Z39| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/01_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z39| )
#-------------------------------------------------
# Map40: 026.02
$!Varset |Z40| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/02_SA_comp/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z40| )
#-------------------------------------------------
# Map41: 027.01
$!Varset |Z41| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/027_RMIT/01_SST/DPW8-AePW4_SurfaceCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/027_RMIT/01_SST/DPW8-AePW4_SurfaceCuts_v5.dat-sorted"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SST_Maps', 'CadenceStr_Maps', |Z41| )
#-------------------------------------------------
# Map42: 027.02
$!Varset |Z42| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/027_RMIT/02_SA/DPW8-AePW4_SurfaceCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/027_RMIT/02_SA/DPW8-AePW4_SurfaceCuts_v5.dat-sorted"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceStr_Maps', |Z42| )
#-------------------------------------------------
# Map43: 029.01
$!Varset |Z43| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/01_SANS_refine/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CstmUsrAdp_Maps', |Z43| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map44: 029.02
$!Varset |Z44| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/02_SANS_Metris/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CstmUsrAdp_Maps', |Z44| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#==================================================================================================
# Include TestCase1b Data?
#-------------------------------------------------
# Map45: 010.01 (TestCase1b)
$!Varset |Z45| = (|NUMZONES| + 1)
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 1
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1b/010_Boeing/010_DPW8-AePW4_UnsteadySectionalCuts_v5.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'WMLES_Maps', 'CstmUsrUns_Maps', |Z45| )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CP_AVG/CF_AVG from unsteady datafile to CP/CF from steady datafile
  $!AlterData  [|Z45|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V4 = {CP_AVG}'
  $!AlterData  [|Z45|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V5 = {CF_AVG}'
  # CUSTOM: Assign TestCase1b CP_RMS/CF_RMS from unsteady datafile to CFX/CFY from steady datafile
  $!AlterData  [|Z45|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V6 = {CP_RMS}'
  $!AlterData  [|Z45|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CF_RMS}'
  #-------------------------------------------------
$!ELSE
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'WMLES_Maps', 'CstmUsrUns_Maps', |Z45| )
#  $!ActiveLineMaps -= [|NumLineMaps|]
#  $!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
  $!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
$!ENDIF
#==================================================================================================
#-------------------------------------------------
# Map46: 012.01
$!Varset |Z46| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/01_SFE_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z46| )
#-------------------------------------------------
# Map47: 012.02
$!Varset |Z47| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/02_SFE_SAneg_CC/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z47| )
#-------------------------------------------------
# Map48: 012.03
$!Varset |Z48| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/03_SFE_SAneg_QCR_CC/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceUnS_Maps', |Z48| )
#-------------------------------------------------
# Map49: 012.04
$!Varset |Z49| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/04_NCFV_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z49| )
#-------------------------------------------------
# Map50: 012.05
$!Varset |Z50| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/05_NCFV_SAneg_2ndOrderTurbConv/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z50| )
#-------------------------------------------------
# Map51: 012.06
$!Varset |Z51| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/06_NCFV_SAneg_CC/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z51| )
#-------------------------------------------------
# Map52: 012.07
$!Varset |Z52| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/07_NCFV_SAneg_CC_2ndOrderTurbConv/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CadenceUnS_Maps', |Z52| )
#-------------------------------------------------
# Map53: 012.08
$!Varset |Z53| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/08_NCFV_SAneg_QCR/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceUnS_Maps', |Z53| )
#-------------------------------------------------
# Map54: 012.09
$!Varset |Z54| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/09_NCFV_SAneg_QCR_CC_2ndOrderTurbConv/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceUnS_Maps', |Z54| )
#-------------------------------------------------
# Map55: 012.10
$!Varset |Z55| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/10_NCFV_SAneg_QCR_RC_CC/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceUnS_Maps', |Z55| )
#-------------------------------------------------
# Map56: 012.11
$!Varset |Z56| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/11_NCFV_SAneg_QCR_RC_CC_2ndOrderTurbConv/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'CadenceUnS_Maps', |Z56| )
#==================================================================================================
# Include TestCase1b Data?
#-------------------------------------------------
# Map57: 005.03 (TestCase1b)
$!Varset |Z57| = (|NUMZONES| + 1)
$!IF |IncludeTestCase1b| == 1
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/03_ZDES_SAneg/DPW8-AePW4_UnsteadySectionalCuts_LAVA_OAT15A_ZDES_SAneg_005.03.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'OneraStruc_Maps', |Z57| )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CP_AVG/CF_AVG from unsteady datafile to CP/CF from steady datafile
  $!AlterData  [|Z57|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V4 = {CP_AVG}'
  $!AlterData  [|Z57|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V5 = {CF_AVG}'
  # CUSTOM: Assign TestCase1b CP_RMS/CF_RMS from unsteady datafile to CFX/CFY from steady datafile
  $!AlterData  [|Z57|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V6 = {CP_RMS}'
  $!AlterData  [|Z57|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CF_RMS}'
  #-------------------------------------------------
$!ELSE
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'OneraStruc_Maps', |Z57| )
#  $!ActiveLineMaps -= [|NumLineMaps|]
#  $!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
  $!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
$!ENDIF
#-------------------------------------------------
# Map58: 005.04 (TestCase1b)
$!Varset |Z58| = (|NUMZONES| + 1)
$!IF |IncludeTestCase1b| == 1
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/04_ZDES_SAneg_blend2/DPW8-AePW4_UnsteadySectionalCuts_LAVA_OAT15A_ZDES_SAneg_005.04.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'OneraStruc_Maps', |Z58| )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CP_AVG/CF_AVG from unsteady datafile to CP/CF from steady datafile
  $!AlterData  [|Z58|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V4 = {CP_AVG}'
  $!AlterData  [|Z58|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V5 = {CF_AVG}'
  # CUSTOM: Assign TestCase1b CP_RMS/CF_RMS from unsteady datafile to CFX/CFY from steady datafile
  $!AlterData  [|Z58|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V6 = {CP_RMS}'
  $!AlterData  [|Z58|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CF_RMS}'
  #-------------------------------------------------
$!ELSE
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'OneraStruc_Maps', |Z58| )
#  $!ActiveLineMaps -= [|NumLineMaps|]
#  $!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
  $!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
$!ENDIF
#-------------------------------------------------
# Map59: 005.05 (TestCase1b)
$!Varset |Z59| = (|NUMZONES| + 1)
$!IF |IncludeTestCase1b| == 1
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/05_URANS_SARCcomp/DPW8-AePW4_UnsteadySectionalCuts_LAVA_OAT15A_URANS_SARC_CC_005.05.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'OneraStruc_Maps', |Z59| )
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CP_AVG/CF_AVG from unsteady datafile to CP/CF from steady datafile
  $!AlterData  [|Z59|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V4 = {CP_AVG}'
  $!AlterData  [|Z59|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V5 = {CF_AVG}'
  # CUSTOM: Assign TestCase1b CP_RMS/CF_RMS from unsteady datafile to CFX/CFY from steady datafile
  $!AlterData  [|Z59|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V6 = {CP_RMS}'
  $!AlterData  [|Z59|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CF_RMS}'
  #-------------------------------------------------
$!ELSE
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'OneraStruc_Maps', |Z59| )
#  $!ActiveLineMaps -= [|NumLineMaps|]
#  $!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
  $!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
$!ENDIF
#-------------------------------------------------
# Map60: 008.02 (TestCase1b)
$!Varset |Z60| = (|NUMZONES| + 1)
$!IF |IncludeTestCase1b| == 1
 #$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1b/008_Metacomp/02_CFD++_Deck/DPW8-AePW4_UnsteadySectionalCuts_008.02.dat"' )
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'OneraStruc_Maps', |Z60| )
#  $!ActiveLineMaps -= [|NumLineMaps|]
#  $!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
  $!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
  #-------------------------------------------------
  # CUSTOM: Assign TestCase1b CP_AVG/CF_AVG from unsteady datafile to CP/CF from steady datafile
  $!AlterData  [|Z60|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V4 = {CP_AVG}'
  $!AlterData  [|Z60|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V5 = {CF_AVG}'
  # CUSTOM: Assign TestCase1b CP_RMS/CF_RMS from unsteady datafile to CFX/CFY from steady datafile
  $!AlterData  [|Z60|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V6 = {CP_RMS}'
  $!AlterData  [|Z60|-|NUMZONES|]
    IgnoreDivideByZero = Yes
    Equation = 'V7 = {CF_RMS}'
  #-------------------------------------------------
$!ELSE
  $!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
  $!RUNMACROFUNCTION "AddLineMap" ( 'SAQ_Maps', 'OneraStruc_Maps', |Z60| )
#  $!ActiveLineMaps -= [|NumLineMaps|]
#  $!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
  $!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
$!ENDIF
#==================================================================================================
# Map61: TestCase1c/002.01
$!Varset |Z61| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/002_Embraer/01_CFD++_CadenceUnstructured-Rev02_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceUnS_Maps', |Z61| )
#-------------------------------------------------
# Map62: TestCase1c/002.02
$!Varset |Z62| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/002_Embraer/02_CFD++_CadenceStructured-Rev02_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceStr_Maps', |Z62| )
#-------------------------------------------------
# Map63: TestCase1c/002.03
$!Varset |Z63| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/002_Embraer/03_CFD++_HeldenMesh-Rev02_SA/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'HeldenUnSt_Maps', |Z63| )
#-------------------------------------------------
# Map64: TestCase1c/003.01
$!Varset |Z64| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/003_Boeing/01_OVERFLOW_Cadence_Structured_REV02_SA-neg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceStr_Maps', |Z64| )
#-------------------------------------------------
# Map65: TestCase1c/003.02
$!Varset |Z65| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/003_Boeing/02_OVERFLOW_Cadence_Structured_REV02_SA-neg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceStr_Maps', |Z65| )
#-------------------------------------------------
# Map66: TestCase1c/003.03
$!Varset |Z66| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/003_Boeing/03_OVERFLOW_Cadence_Structured_REV02_SA-neg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceStr_Maps', |Z66| )
#-------------------------------------------------
# Map67: TestCase1c/003.04
$!Varset |Z67| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/003_Boeing/04_FELight_Cadence_Unstructured_REV02_SA-neg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceUnS_Maps', |Z67| )
#-------------------------------------------------
# Map68: TestCase1c/003.05
$!Varset |Z68| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/003_Boeing/05_FELight_HeldenMesh_Unstructured_REV02_SA-neg/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'HeldenUnSt_Maps', |Z68| )
# Turn off FELight/HeldenMesh ... for now
$!ActiveLineMaps -= [|NumLineMaps|]
$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#-------------------------------------------------
# Map69: TestCase1c/011.01
$!Varset |Z69| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/011_HEMLAB/01_Structured/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceStr_Maps', |Z69| )
#-------------------------------------------------
# Map70: TestCase1c/011.02
$!Varset |Z70| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/011_HEMLAB/02_Adaptive/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CstmUsrAdp_Maps', |Z70| )
#-------------------------------------------------
# Map71: TestCase1c/011.03
$!Varset |Z71| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/011_HEMLAB/03_Unstructured/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceUnS_Maps', |Z71| )
#-------------------------------------------------
# Map72: TestCase1c/011.04
$!Varset |Z72| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/011_HEMLAB/04_HeldenMesh/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'HeldenUnSt_Maps', |Z72| )
#-------------------------------------------------
# Map73: TestCase1c/012.01
$!Varset |Z73| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/012_NASA_LARC_AB/01_FUN3D_NCFV_Cadence/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceUnS_Maps', |Z73| )
#-------------------------------------------------
# Map74: TestCase1c/012.02
$!Varset |Z74| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/012_NASA_LARC_AB/02_FUN3D_SFE_Cadence/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CadenceUnS_Maps', |Z74| )
#-------------------------------------------------
# Map75: TestCase1c/012.03
$!Varset |Z75| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/012_NASA_LARC_AB/03_FUN3D_NCFV_Helden/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'HeldenUnSt_Maps', |Z75| )
#-------------------------------------------------
# Map76: TestCase1c/012.04
$!Varset |Z76| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/012_NASA_LARC_AB/04_FUN3D_SFE_Helden/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'HeldenUnSt_Maps', |Z76| )
#-------------------------------------------------
# Map77: TestCase1c/012.05
$!Varset |Z77| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/012_NASA_LARC_AB/05_FUN3D_NCFV_Adapt/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CstmUsrAdp_Maps', |Z77| )
#-------------------------------------------------
# Map78: TestCase1c/012.06
$!Varset |Z78| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/012_NASA_LARC_AB/06_FUN3D_SFE_Adapt/DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CstmUsrAdp_Maps', |Z78| )
#-------------------------------------------------
## Map79: TestCase1c/003.07
#$!Varset |Z79| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/003_Boeing/07_T1EPIC_Adjoint_SA-neg/DPW8-AePW4_SectionalCuts_v4.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CstmUsrAdp_Maps', |Z79| )
#-------------------------------------------------
## Map80: TestCase1c/003.08
#$!Varset |Z80| = (|NUMZONES| + 1)
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1c/003_Boeing/08_T1EPIC_Hessian_SA-neg/DPW8-AePW4_SectionalCuts_v4.dat"' )
#$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps', 'CstmUsrAdp_Maps', |Z80| )
#-------------------------------------------------
# Map79: 029.02
$!Varset |Z79| = (|NUMZONES| + 1)
$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/02_SANS_Metris/DPW8-AePW4_SectionalCuts_v5.dat"' )
#$!RUNMACROFUNCTION "AppendDataSetFile" ( '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"' )
$!RUNMACROFUNCTION "AddLineMap" ( 'SA_Maps',  'CstmUsrAdp_Maps', |Z79| )
#$!ActiveLineMaps -= [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
#$!VarSet |000_Maps| = '|000_Maps| |NumLineMaps|,'
#==================================================================================================

#==================================================================================================
$!LineMap  [1]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\A'}}}
$!LineMap  [2]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\a'}}}
$!LineMap  [3]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\A'}}}
$!LineMap  [4]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\a'}}}
$!LineMap  [5]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\A'}}}
$!LineMap  [6]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\B'}}}
$!LineMap  [7]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\b'}}}
$!LineMap  [8]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\B'}}}
$!LineMap  [9]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\C'}}}
$!LineMap [10]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\c'}}}
$!LineMap [11]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\D'}}}
$!LineMap [12]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\E'}}}
$!LineMap [13]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\e'}}}
$!LineMap [14]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\E'}}}
$!LineMap [15]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\F'}}}
$!LineMap [16]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\G'}}}
$!LineMap [17]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\g'}}}
$!LineMap [18]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\G'}}}
$!LineMap [19]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\g'}}}
$!LineMap [20]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\G'}}}
$!LineMap [21]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\g'}}}
$!LineMap [22]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\H'}}}
$!LineMap [23]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\h'}}}
$!LineMap [24]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\I'}}}
$!LineMap [25]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\i'}}}
$!LineMap [26]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\J'}}}
$!LineMap [27]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\j'}}}
$!LineMap [28]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\K'}}}
$!LineMap [29]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\k'}}}
$!LineMap [30]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\L'}}}
$!LineMap [31]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\l'}}}
$!LineMap [32]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\M'}}}
$!LineMap [33]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\m'}}}
$!LineMap [34]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\M'}}}
$!LineMap [35]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\m'}}}
$!LineMap [36]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\N'}}}
$!LineMap [37]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\O'}}}
$!LineMap [38]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\P'}}}
$!LineMap [39]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\Q'}}}
$!LineMap [40]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\q'}}}
$!LineMap [41]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\R'}}}
$!LineMap [42]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\r'}}}
$!LineMap [43]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\S'}}}
$!LineMap [44]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\s'}}}
$!LineMap [46]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\U'}}}
$!LineMap [47]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\u'}}}
$!LineMap [48]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\U'}}}
$!LineMap [49]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\u'}}}
$!LineMap [50]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\U'}}}
$!LineMap [51]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\u'}}}
$!LineMap [52]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\V'}}}
$!LineMap [53]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\v'}}}
$!LineMap [54]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\V'}}}
$!LineMap [55]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\v'}}}
$!LineMap [56]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\V'}}}
#==============================
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 1
 $!LineMap [45] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\T'}}}
 $!LineMap [57] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\W'}}}
 $!LineMap [58] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\w'}}}
 $!LineMap [59] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\W'}}}
 $!LineMap [60] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\X'}}}
$!ENDIF
#==============================
$!LineMap [61]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\A'}}}
$!LineMap [62]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\a'}}}
$!LineMap [63]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\A'}}}
$!LineMap [64]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\B'}}}
$!LineMap [65]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\b'}}}
$!LineMap [66]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\B'}}}
$!LineMap [67]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\C'}}}
$!LineMap [68]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\c'}}}
$!LineMap [69]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\D'}}}
$!LineMap [70]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\d'}}}
$!LineMap [71]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\D'}}}
$!LineMap [72]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\d'}}}
$!LineMap [73]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\E'}}}
$!LineMap [74]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\F'}}}
$!LineMap [75]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\e'}}}
$!LineMap [76]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                                        ASCIIChar = '\f'}}}
$!LineMap [77]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\E'}}}
$!LineMap [78]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\F'}}}
#$!LineMap [79]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\H'}}}
#$!LineMap [80]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\h'}}}
$!LineMap [79]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\s'}}}
#==============================

#==================================================================================================
# Data Alterations
#-------------------------------------------------
# 002.01/002.02/002.03/002.04 Submissionas have X/C all over the place
$!VarSet |Z| = (|Z05|-1)
$!AlterData  [|Z01|-|Z|]
  IgnoreDivideByZero = Yes
  Equation = 'V9 = V1/0.23'

## 014.01/014.02 submissions have X/C from -1 to 0 (so use absolute value)
#$!VarSet |Z| = (|Z28|-1)
#$!AlterData [|Z26|-|Z|]
#  IgnoreDivideByZero = Yes
#  Equation = '{X/C} = abs({X/C})'

#==================================================================================================
# Handle data that is not ordered well
#-------------------------------------------------
## 014.01/014.02 submissions are not ordered well
#$!LineMap [26] Lines   { Show = Yes LinePattern = Dashed PatternLength =  5 LineThickness = 0.02 }
#$!LineMap [27] Lines   { Show = Yes LinePattern = Dashed PatternLength =  5 LineThickness = 0.02 }

#-------------------------------------------------
## 020-01 submission is not ordered well
#$!LineMap [32] Lines   { Show = Yes LinePattern = Dotted PatternLength = 50 LineThickness = 0.02 }
#$!LineMap [32] Symbols { SkipMode = ByIndex Skipping = 1E+1 }

#-------------------------------------------------
# 020-02 submission is not ordered well and can not be sorted due to numerical precision limitations
$!LineMap [33] Lines   { Show = Yes LinePattern = Dotted PatternLength = 50 LineThickness = 0.02 }
$!LineMap [33] Symbols { SkipMode = ByIndex Skipping = 3 }
$!LineMap [33] Lines   { Show = No }

#-------------------------------------------------
## 020-03 submission is not ordered well
#$!LineMap [34] Lines   { Show = Yes LinePattern = Dotted PatternLength = 50 LineThickness = 0.02 }

#-------------------------------------------------
## 020-04 submission is not ordered well
#$!LineMap [35] Lines   { Show = Yes LinePattern = Dotted PatternLength = 50 LineThickness = 0.02 }

#-------------------------------------------------
## 027-01/027.02 submissions are not ordered well
#$!LineMap [41] Lines   { Show = Yes LinePattern = Dashed PatternLength =  5 LineThickness = 0.02 }
#$!LineMap [42] Lines   { Show = Yes LinePattern = Dashed PatternLength =  5 LineThickness = 0.02 }

#==================================================================================================
# Value blanking for data with X/C < -998
#-------------------------------------------------
$!Blanking Value { Include = Yes }
$!Blanking Value { Constraint 1 { Include = Yes ValueCutoff = -998 VarA = 9 } }

#==================================================================================================
# Assign Variable Names
#-------------------------------------------------
$!RenameDataSetVar Var = 4  Name = 'C<sub>P</sub>'
$!RenameDataSetVar Var = 5  Name = 'C<sub>F</sub>'
$!RenameDataSetVar Var = 6  Name = 'C<sub>Fx</sub>'
$!RenameDataSetVar Var = 7  Name = 'C<sub>Fy</sub>'
$!RenameDataSetVar Var = 8  Name = 'C<sub>Fz</sub>'
$!RenameDataSetVar Var = 9  Name = 'X/C'

#==================================================================================================
$!LineMap [1-|NumLineMaps|] Symbols { Size = 1.0 }
$!LineMap [1-|NumLineMaps|] Symbols { SkipMode = ByFrameUnits Skipping = 10 }
$!LineMap [1-|NumLineMaps|] ErrorBars { Var = 2 Show = No }
$!XYLineAxis XDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 4 } }
$!XYLineAxis YDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 9 } }
$!XYLineAxis GridArea  { DrawBorder = Yes LineThickness = 0.1 }

#-------------------------------------------------
$!LinePlotLayers
  ShowLines   = Yes
  ShowSymbols = Yes
  ShowErrorBars = Yes

$!GlobalLinePlot
  DataLabels { DistanceSkip = 5 }
  Legend {
    Show = Yes
    TextShape { Height = 1.5 }
    Box { BoxType = None Margin = 5 }
    RowSpacing = 1
    XYPos { X = 88 Y = 10 }
    AnchorAlignment = BottomLeft
    }

$!ENDMACROFUNCTION
#===================================================================
