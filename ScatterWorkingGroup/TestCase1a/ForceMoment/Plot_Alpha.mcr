#!MC 1410

# NOTE: Set |ImageFormat2| if an additional format is desired
$!VarSet |ImageFormat|  = '|IMG1|'
$!VarSet |ImageFormat2| = '|IMG2|'

# Assign x-axis variable
$!IF 0 == 1
  $!VarSet |xAxis| = |1_h|
  $!VarSet |xRngMin| = 2.5E-04
  $!VarSet |xRngMax| = 2.5E-02
$!ELSEIF 1 == 1
  $!VarSet |xAxis| = |1_h1o2|
  $!VarSet |xRngMin| = 2.5E-04
  $!VarSet |xRngMax| = 2.5E-02
$!ELSEIF 0 == 1
  $!VarSet |xAxis| = |1_h1o3|
  $!VarSet |xRngMin| = 4.0E-04
  $!VarSet |xRngMax| = 5.0E-02
$!ELSEIF 0 == 1
  $!VarSet |xAxis| = |1_h2o3|
  $!VarSet |xRngMin| = 9.0E-07
  $!VarSet |xRngMax| = 1.4E-03
$!ENDIF

$!PageName = 'Template_Turb'

#==================================================================================================
# Plots colored by turbulence model variations
#-----------------------------------
# SA+    variant
# SA+QCR variants
# SST    variants
  $!LineMap  [|SA_Maps|]    Lines   { Color = Red   } Symbols { Color = Red   FillColor = Red   }
  $!LineMap  [|SAQ_Maps|]   Lines   { Color = Green } Symbols { Color = Green FillColor = Green }
  $!LineMap  [|SST_Maps|]   Lines   { Color = Black } Symbols { Color = Black FillColor = Black }

  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1a: ONERA OAT15A

\ \ \ \ \ Grid Convergence Study

\ \ \ \ \ \ \ Angle of Attack |ALPHA|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1a: ONERA OAT15A\nGrid Convergence Study\nAngle of Attack |ALPHA|"
  $!ENDIF
#==================================================================================================
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 0
  $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
  $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA + QCR'
  $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'
$!ELSE
  $!LineMap  [|WMLES_Maps|] Lines   { Color = Cyan  } Symbols { Color = Cyan  FillColor = Cyan  }
  $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
  $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA + QCR'
  $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'
  $!AttachText AnchorPos { X = 76 Y = 91 } TextShape { Height = 12 IsBold = No  } Color = Cyan   Anchor = HeadLeft Text = '     WMLES'
$!ENDIF
#==================================================================================================

#------------------
# Copy Template_Turb page
  $!PageControl Create
  $!PageName = 'Template_Grid'
 $!PageControl SetCurrentByName
   Name = 'Template_Turb'
 $!Pick AddAll
   SELECTFRAMES = YES
 $!Pick Copy
 $!PageControl SetCurrentByName
   Name = 'Template_Grid'
 $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
 #------------------
#==================================================================================================
# Plots colored by grid variations
#-----------------------------------
# Cadence Structured Grid
# Cadence Unstructured Grid
# Helden Unstructured Grid
# Onera Structured Grid
# Custom User Adapted Grid
# Custom User Grid Structured
# Custom User Grid Unstructured

  $!LineMap  [|CadenceStr_Maps|] Lines   { Color = Red     } Symbols { Color = Red     FillColor = Red     }
  $!LineMap  [|CadenceUnS_Maps|] Lines   { Color = Black   } Symbols { Color = Black   FillColor = Black   }
  $!LineMap  [|HeldenUnSt_Maps|] Lines   { Color = Blue    } Symbols { Color = Blue    FillColor = Blue    }
  $!LineMap  [|OneraStruc_Maps|] Lines   { Color = Green   } Symbols { Color = Green   FillColor = Green   }
  $!LineMap  [|CstmUsrAdp_Maps|] Lines   { Color = Purple  } Symbols { Color = Purple  FillColor = Purple  }
 #$!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Cyan    } Symbols { Color = Cyan    FillColor = Cyan    }
  $!LineMap  [|CstmUsrStr_Maps|] Lines   { Color = Custom3 } Symbols { Color = Custom3 FillColor = Custom3 }

  $!Pick AddAll
     SELECTTEXT=YES
  $!Pick Clear
  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1a: ONERA OAT15A

\ \ \ \ \ Grid Convergence Study

\ \ \ \ \ \ \ Angle of Attack |ALPHA|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1a: ONERA OAT15A\nGrid Convergence Study\nAngle of Attack |ALPHA|"
  $!ENDIF
#==================================================================================================
# Include TestCase1b Data?
$!IF |IncludeTestCase1b| == 0
  $!AttachText AnchorPos { X = 74 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black   Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 74 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red     Anchor = HeadLeft Text = '     Cadence Structured'
  $!AttachText AnchorPos { X = 74 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Black   Anchor = HeadLeft Text = '     Cadence Unstructured'
  $!AttachText AnchorPos { X = 74 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Blue    Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
  $!AttachText AnchorPos { X = 74 Y = 91 } TextShape { Height = 12 IsBold = No  } Color = Green   Anchor = HeadLeft Text = '     ONERA Structured'
  $!AttachText AnchorPos { X = 74 Y = 89 } TextShape { Height = 12 IsBold = No  } Color = Purple  Anchor = HeadLeft Text = '     User Grid Adaptation'
$!ELSE
  $!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
  $!AttachText AnchorPos { X = 74 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black   Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 74 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red     Anchor = HeadLeft Text = '     Cadence Structured'
  $!AttachText AnchorPos { X = 74 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Black   Anchor = HeadLeft Text = '     Cadence Unstructured'
  $!AttachText AnchorPos { X = 74 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Blue    Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
  $!AttachText AnchorPos { X = 74 Y = 91 } TextShape { Height = 12 IsBold = No  } Color = Green   Anchor = HeadLeft Text = '     ONERA Structured'
  $!AttachText AnchorPos { X = 74 Y = 89 } TextShape { Height = 12 IsBold = No  } Color = Purple  Anchor = HeadLeft Text = '     User Grid Adaptation'
  $!AttachText AnchorPos { X = 74 Y = 87 } TextShape { Height = 12 IsBold = No  } Color = Cyan    Anchor = HeadLeft Text = '     User Unstructured Grid'
  $!AttachText AnchorPos { X = 74 Y = 85 } TextShape { Height = 12 IsBold = No  } Color = Custom3 Anchor = HeadLeft Text = '     User Structured Grid'
$!ENDIF
#==================================================================================================

# CL_Turb
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CL_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Turb' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '7' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!IF |ALPHA| == 1.50
    $!XYLineAxis YDetail 1 {RangeMin = 0.70   RangeMax = 0.84}
  $!ELSEIF |ALPHA| == 3.10
   #$!XYLineAxis YDetail 1 {RangeMin = 0.70   RangeMax = 0.84}
  $!ENDIF
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF |ExportTestCase1b| == 1
    $!ActiveLineMaps  = [|TestCase1b_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|_TestCase1b' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
  $!ENDIF
  $!IF |ALPHA| == 1.50
   $!IF 0 == 1
    $!ActiveLineMaps  = [|TestCase1c_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
   $!ENDIF
  $!ENDIF
  $!ActiveLineMaps  = [|TestCase1aa_Maps|]
  $!ActiveLineMaps += [|TestCase1a_Maps|]
  $!ActiveLineMaps += [|TestCase1b_Maps|]
  $!ActiveLineMaps += [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
$!ENDIF

# CM_Turb
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CM_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Turb' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '9' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!IF |ALPHA| == 1.50
    $!XYLineAxis YDetail 1 {RangeMin = -0.140   RangeMax = -0.115}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.005}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!ELSEIF |ALPHA| == 3.10
    $!XYLineAxis YDetail 1 {RangeMin = -0.210   RangeMax = -0.070}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.02}
  $!ENDIF
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF |ExportTestCase1b| == 1
    $!ActiveLineMaps  = [|TestCase1b_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|_TestCase1b' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
  $!ENDIF
  $!IF |ALPHA| == 1.50
   $!IF 0 == 1
    $!ActiveLineMaps  = [|TestCase1c_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
   $!ENDIF
  $!ENDIF
  $!ActiveLineMaps  = [|TestCase1aa_Maps|]
  $!ActiveLineMaps += [|TestCase1a_Maps|]
  $!ActiveLineMaps += [|TestCase1b_Maps|]
  $!ActiveLineMaps += [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
$!ENDIF

# CD_Turb
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CD_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Turb' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '8' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!IF |ALPHA| == 1.50
    $!XYLineAxis YDetail 1 {RangeMin = 135.0   RangeMax = 165.0}
  $!ELSEIF |ALPHA| == 3.10
    $!XYLineAxis YDetail 1 {RangeMin = 120.0   RangeMax = 600.0}
    $!XYLineAxis YDetail 1 {GRSpacing = 100}
  $!ENDIF
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF |ExportTestCase1b| == 1
    $!ActiveLineMaps  = [|TestCase1b_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|_TestCase1b' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
  $!ENDIF
  $!IF |ALPHA| == 1.50
   $!IF 0 == 1
    $!ActiveLineMaps  = [|TestCase1c_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
   $!ENDIF
  $!ENDIF
  $!ActiveLineMaps  = [|TestCase1aa_Maps|]
  $!ActiveLineMaps += [|TestCase1a_Maps|]
  $!ActiveLineMaps += [|TestCase1b_Maps|]
  $!ActiveLineMaps += [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
$!ENDIF

# CL_Grid
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CL_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '7' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!IF |ALPHA| == 1.50
    $!XYLineAxis YDetail 1 {RangeMin = 0.70   RangeMax = 0.84}
  $!ELSEIF |ALPHA| == 3.10
   #$!XYLineAxis YDetail 1 {RangeMin = 0.70   RangeMax = 0.84}
  $!ENDIF
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF |ExportTestCase1b| == 1
    $!ActiveLineMaps  = [|TestCase1b_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|_TestCase1b' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
  $!ENDIF
  $!IF |ALPHA| == 1.50
    #-----------------
    $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
    #-----------------
    $!XYLineAxis YDetail 1 {RangeMin = 0.775   RangeMax = 0.825}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.005}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
    $!ActiveLineMaps  = [|TestCase1c_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!ENDIF
  #-----------------
  $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1a' '|ALPHA|' )
  #-----------------
  $!ActiveLineMaps  = [|TestCase1aa_Maps|]
  $!ActiveLineMaps += [|TestCase1a_Maps|]
  $!ActiveLineMaps += [|TestCase1b_Maps|]
  $!ActiveLineMaps += [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
$!ENDIF

# CM_Grid
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CM_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '9' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!IF |ALPHA| == 1.50
    $!XYLineAxis YDetail 1 {RangeMin = -0.140   RangeMax = -0.115}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.005}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!ELSEIF |ALPHA| == 3.10
    $!XYLineAxis YDetail 1 {RangeMin = -0.210   RangeMax = -0.070}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.02}
  $!ENDIF
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF |ExportTestCase1b| == 1
    $!ActiveLineMaps  = [|TestCase1b_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|_TestCase1b' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
  $!ENDIF
  $!IF |ALPHA| == 1.50
    #-----------------
    $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
    #-----------------
    $!ActiveLineMaps  = [|TestCase1c_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!XYLineAxis YDetail 1 {AutoGrid = Yes}
    $!XYLineAxis YDetail 1 {RangeMin = -0.1380 RangeMax = -0.1300}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.002}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!ENDIF
 #$!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
 #$!ActiveLineMaps  = [|TestCase1aa_Maps|]
 #$!ActiveLineMaps += [|TestCase1a_Maps|]
 #$!ActiveLineMaps += [|TestCase1b_Maps|]
 #$!ActiveLineMaps += [|TestCase1c_Maps|]
 #$!ActiveLineMaps -= [|Inactive_Maps|]
$!ENDIF

# CD_Grid
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CD_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '8' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!IF |ALPHA| == 1.50
    $!XYLineAxis YDetail 1 {RangeMin = 135.0   RangeMax = 165.0}
  $!ELSEIF |ALPHA| == 3.10
    $!XYLineAxis YDetail 1 {RangeMin = 120.0   RangeMax = 600.0}
    $!XYLineAxis YDetail 1 {GRSpacing = 100}
  $!ENDIF
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF |ExportTestCase1b| == 1
    $!ActiveLineMaps  = [|TestCase1b_Maps|]
    $!ActiveLineMaps -= [|Inactive_Maps|]
    $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|_TestCase1b' '|ImageFormat|' '|ImageFormat2|' )
    $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
  $!ENDIF
  $!ActiveLineMaps  = [|TestCase1aa_Maps|]
  $!ActiveLineMaps += [|TestCase1a_Maps|]
  $!ActiveLineMaps += [|TestCase1b_Maps|]
  $!ActiveLineMaps += [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
$!ENDIF

# CDp_Grid
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CDp_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '13' )
  #------------------
  $!Blanking Value{Constraint 2 {VarA = 13 Include = Yes ValueCutoff = 30}}
  $!View NiceFit
  $!View MakeCurrentViewNice
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 $!IF |ALPHA| == 1.50
  $!XYLineAxis YDetail 1 {RangeMin = 70.0   RangeMax = 100.0}
 $!ELSEIF |ALPHA| == 3.10

 $!ENDIF
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 $!IF |ExportTestCase1b| == 1
  $!ActiveLineMaps  = [|TestCase1b_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|_TestCase1b' '|ImageFormat|' '|ImageFormat2|' )
  $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
 $!ENDIF
 $!IF |ALPHA| == 1.50
   #-----------------
   $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
   #-----------------
  $!ActiveLineMaps  = [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  $!XYLineAxis YDetail 1 {RangeMin = 83.5   RangeMax = 88.5}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.5}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 $!ENDIF
 #$!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
 #$!ActiveLineMaps  = [|TestCase1aa_Maps|]
 #$!ActiveLineMaps += [|TestCase1a_Maps|]
 #$!ActiveLineMaps += [|TestCase1b_Maps|]
 #$!ActiveLineMaps += [|TestCase1c_Maps|]
 #$!ActiveLineMaps -= [|Inactive_Maps|]
$!ENDIF

# CDv_Grid
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CDv_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '14' )
  #------------------
  $!Blanking Value{Constraint 2 {VarA = 14 Include = Yes ValueCutoff = 5}}
  $!View NiceFit
  $!View MakeCurrentViewNice
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 $!IF |ALPHA| == 1.50
  $!XYLineAxis YDetail 1 {RangeMin = 50.0   RangeMax = 80.0}
 $!ELSEIF |ALPHA| == 3.10

 $!ENDIF
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 $!IF |ExportTestCase1b| == 1
  $!ActiveLineMaps  = [|TestCase1b_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|_TestCase1b' '|ImageFormat|' '|ImageFormat2|' )
  $!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
 $!ENDIF
 $!IF |ALPHA| == 1.50
   #-----------------
   $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
   #-----------------
  $!ActiveLineMaps  = [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  $!XYLineAxis YDetail 1 {RangeMin = 62.0   RangeMax = 67.0}
  $!XYLineAxis YDetail 1 {GRSpacing = 0.5}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 $!ENDIF
 #$!GlobalLinePlot Legend { TextShape { Height = |LegendH| } XYPos { Y = |LegendY| } }
 #$!ActiveLineMaps  = [|TestCase1aa_Maps|]
 #$!ActiveLineMaps += [|TestCase1a_Maps|]
 #$!ActiveLineMaps += [|TestCase1b_Maps|]
 #$!ActiveLineMaps += [|TestCase1c_Maps|]
 #$!ActiveLineMaps -= [|Inactive_Maps|]
$!ENDIF

# CLerror
$!IF 1 == 1
 $!IF |ALPHA| == 1.50
  $!VarSet |PlotName|  = 'CLerror_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '|CLerror|' )
  #------------------
  $!ActiveLineMaps  = [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 1E-6 RangeMax = 1E+0}
  $!XYLineAxis YDetail 1 {CoordScale = Log}
  #-----------------
  $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
  #-----------------
  $!RUNMACROFUNCTION "ClearLabels"
  $!RUNMACROFUNCTION "AddLabel" ( 'CL' '0.01000' '87.7' '62.70' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CL' '0.00100' '87.7' '49.90' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CL' '0.00010' '87.7' '37.10' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CL' '0.00001' '87.7' '24.25' )
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 $!ENDIF
$!ENDIF

# CMerror
$!IF 1 == 1
 $!IF |ALPHA| == 1.50
  $!VarSet |PlotName|  = 'CMerror_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '|CMerror|' )
  #------------------
  $!ActiveLineMaps  = [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 1E-7 RangeMax = 1E-1}
  $!XYLineAxis YDetail 1 {CoordScale = Log}
  #-----------------
  $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
  #-----------------
  $!RUNMACROFUNCTION "ClearLabels"
  $!RUNMACROFUNCTION "AddLabel" ( 'CM' '0.001000' '87.7' '62.70' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CM' '0.000100' '87.7' '49.90' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CM' '0.000010' '87.7' '37.10' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CM' '0.000001' '87.7' '24.25' )
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 $!ENDIF
$!ENDIF

# CDerror
$!IF 1 == 1
 $!IF |ALPHA| == 1.50
  $!VarSet |PlotName|  = 'CDerror_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '|CDerror|' )
  #------------------
  $!ActiveLineMaps  = [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 1E-3 RangeMax = 1E+3}
  $!XYLineAxis YDetail 1 {CoordScale = Log}
  #-----------------
  $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
  #-----------------
  $!RUNMACROFUNCTION "ClearLabels"
  $!RUNMACROFUNCTION "AddLabel" ( 'CD' '10.0 Cnts' '87.7' '62.70' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CD' '1.0 Count' '87.7' '49.90' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CD' '0.10 Cnts' '87.7' '37.10' )
  $!RUNMACROFUNCTION "AddLabel" ( 'CD' '0.01 Cnts' '87.7' '24.25' )
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 $!ENDIF
$!ENDIF

# CD_Grid_1c
$!IF 1 == 1
 $!IF |ALPHA| == 1.50
  $!VarSet |PlotName|  = 'CD_Grid_1c'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
  #-----------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '8' )
  #-----------------
  $!ActiveLineMaps  = [|SA_Maps|]
  $!ActiveLineMaps -= [|TestCase1b_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.15 } }
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 148.0   RangeMax = 158.0}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!XYLineAxis YDetail 1 {GRSpacing = 1.0}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  #-----------------
  $!RUNMACROFUNCTION "AddYRange" ( '1a' 'Custom3' '0.000450' '148.90' '7.5' '152.5' )
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1a_Alpha|ALPHA|_|PlotName|_AllTeams_SA' '|ImageFormat|' '|ImageFormat2|' )
  #-----------------
  $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
  $!RUNMACROFUNCTION "ClearYRange"
  $!RUNMACROFUNCTION "AddYRange" ( '1a' 'Custom3' '0.000450' '149.75' '5.3' '152.5' )
  #-----------------
  # Disable data from non-1c participants
  $!ActiveLineMaps -= [|TestCase1aa_Maps|]
  $!ActiveLineMaps -= [|TestCase1c_Maps|]
# Hardcode: Remove 012.02, 012.06, 012.07
  $!ActiveLineMaps -= [46,50,51]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|_1cTeams_1aData' '|ImageFormat|' '|ImageFormat2|' )
  #-----------------
  $!ActiveLineMaps += [|TestCase1c_Maps|]
  $!RUNMACROFUNCTION "AddYRange" ( '1c' 'Green'   '0.000350' '149.55' '1.7' '150.4' )
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|_1cTeams_1a1cData' '|ImageFormat|' '|ImageFormat2|' )
  #-----------------
  $!RUNMACROFUNCTION "ClearYRange"
  #-----------------
  $!ActiveLineMaps  = [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  #-----------------
  $!RUNMACROFUNCTION "AddYRange" ( '1c' 'Green'   '0.000350' '149.55' '1.7' '150.4' )
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1c_Alpha|ALPHA|_|PlotName|_1cTeams_1cData' '|ImageFormat|' '|ImageFormat2|' )
  #-----------------
 $!ENDIF
$!ENDIF

# CD_Turb_1c
$!IF 1 == 1
 $!IF |ALPHA| == 1.50
  $!VarSet |PlotName|  = 'CD_Turb_1c'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '|1_h1o2|' '8' )
  #-----------------
  $!ActiveLineMaps  = [|SA_Maps|]
  $!ActiveLineMaps -= [|TestCase1b_Maps|]
  $!ActiveLineMaps -= [|TestCase1c_Maps|]
  $!ActiveLineMaps -= [|Inactive_Maps|]
  $!GlobalLinePlot Legend { TextShape { Height = 1.15 } }
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 148.0   RangeMax = 158.0}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!XYLineAxis YDetail 1 {GRSpacing = 1.0}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  #-----------------
  $!RUNMACROFUNCTION "AddYRange" ( '1a' 'Custom3' '0.000450' '148.90' '7.5' '152.5' )
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1a_Alpha|ALPHA|_|PlotName|_AllTeams_SA' '|ImageFormat|' '|ImageFormat2|' )
  #-----------------
  $!RUNMACROFUNCTION "ReplaceTitleAlpha" ( '1c' '|ALPHA|' )
  $!RUNMACROFUNCTION "ClearYRange"
  $!RUNMACROFUNCTION "AddYRange" ( '1a' 'Custom3' '0.000450' '149.75' '5.3' '152.5' )
  #-----------------
  # Disable data from non-1c participants
  $!ActiveLineMaps -= [|TestCase1aa_Maps|]
  $!ActiveLineMaps -= [|TestCase1c_Maps|]
# Hardcode: Remove 012.02, 012.06, 012.07
  $!ActiveLineMaps -= [46,50,51]
  $!GlobalLinePlot Legend { TextShape { Height = 1.25 } XYPos { Y = 10 } }
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1a_Alpha|ALPHA|_|PlotName|_1cTeams' '|ImageFormat|' '|ImageFormat2|' )
  #-----------------
  $!ActiveLineMaps += [|TestCase1c_Maps|]
  $!RUNMACROFUNCTION "AddYRange" ( '1c' 'Green'   '0.000350' '149.55' '1.7' '150.4' )
  #-----------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'TestCase1a_Alpha|ALPHA|_|PlotName|_1cTeams_Add1cData' '|ImageFormat|' '|ImageFormat2|' )
  #-----------------
 $!ENDIF
$!ENDIF
