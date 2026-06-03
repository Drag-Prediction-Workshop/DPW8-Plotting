#!MC 1410

$!IF "|GRID|" != "0"

# NOTE: Set |ImageFormat2| if an additional format is desired
$!VarSet |ImageFormat|  = '|IMG1|'
$!VarSet |ImageFormat2| = '|IMG2|'

$!IF '|GRID|' == 'N'
  $!GlobalLinePlot Legend { TextShape { Height = 0.98 } XYPos { X = 90 Y = 2 } }
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

\ \ \ \ \ \ \ \ \ \ \ \ \ \ Polar Study

\ \ \ \ \ \ \ \ \ \ \ \ \ Grid Level |GRID|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1a: ONERA OAT15A\nPolar Study\nGrid Level |GRID|"
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

\ \ \ \ \ \ \ \ \ \ \ \ \ \ Polar Study

\ \ \ \ \ \ \ \ \ \ \ \ \ Grid Level |GRID|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1a: ONERA OAT15A\nPolar Study\nGrid Level |GRID|"
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

# CL_Alpha_Turb
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CL_Alpha_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Turb' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '6' '7' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = 1.20   RangeMax = 4.00}
  $!XYLineAxis XDetail 1 {GRSpacing = 0.2}
  $!XYLineAxis XDetail 1 {AutoGrid = No}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!IF '|GRID|' == 'N'
    $!XYLineAxis YDetail 1 {RangeMin = 0.66   RangeMax = 1.10}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.05}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
    $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!ENDIF
 #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

# CM_Alpha_Turb
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CM_Alpha_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Turb' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '6' '9' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = 1.20   RangeMax = 4.00}
  $!XYLineAxis XDetail 1 {GRSpacing = 0.2}
  $!XYLineAxis XDetail 1 {AutoGrid = No}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!IF '|GRID|' == 'N'
    $!XYLineAxis YDetail 1 {RangeMin = -0.17  RangeMax = -0.11}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.01}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
    $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!ENDIF
 #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

# CD_CL_Turb
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CD_CL_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Turb' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '8' '7' )
  #------------------
  $!IF '|GRID|' == 'N'
    $!XYLineAxis XDetail 1 {RangeMin = 100   RangeMax = 600}
    $!XYLineAxis XDetail 1 {GRSpacing = 50}
    $!XYLineAxis XDetail 1 {AutoGrid = No}
    $!XYLineAxis XDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
    $!XYLineAxis YDetail 1 {RangeMin = 0.66   RangeMax = 1.10}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.05}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
    $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!ENDIF
 #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

# CL_Alpha_Grid
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CL_Alpha_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '6' '7' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = 1.20   RangeMax = 4.00}
  $!XYLineAxis XDetail 1 {GRSpacing = 0.2}
  $!XYLineAxis XDetail 1 {AutoGrid = No}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!IF '|GRID|' == 'N'
    $!XYLineAxis YDetail 1 {RangeMin = 0.66   RangeMax = 1.10}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.05}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
    $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!ENDIF
 #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

# CM_Alpha_Grid
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CM_Alpha_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '6' '9' )
  #------------------
  $!XYLineAxis XDetail 1 {RangeMin = 1.20   RangeMax = 4.00}
  $!XYLineAxis XDetail 1 {GRSpacing = 0.2}
  $!XYLineAxis XDetail 1 {AutoGrid = No}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!IF '|GRID|' == 'N'
    $!XYLineAxis YDetail 1 {RangeMin = -0.17  RangeMax = -0.11}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.01}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
    $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!ENDIF
 #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

# CD_CL_Grid
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CD_CL_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!RUNMACROFUNCTION "CopyPage" ( 'Template_Grid' '|PlotName|' )
  #------------------
  $!RUNMACROFUNCTION "SetAxisView" ( '8' '7' )
  #------------------
  $!IF '|GRID|' == 'N'
    $!XYLineAxis XDetail 1 {RangeMin = 100   RangeMax = 600}
    $!XYLineAxis XDetail 1 {GRSpacing = 50}
    $!XYLineAxis XDetail 1 {AutoGrid = No}
    $!XYLineAxis XDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
    $!XYLineAxis YDetail 1 {RangeMin = 0.66   RangeMax = 1.10}
    $!XYLineAxis YDetail 1 {GRSpacing = 0.05}
    $!XYLineAxis YDetail 1 {AutoGrid = No}
    $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!ENDIF
 #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

$!ENDIF
