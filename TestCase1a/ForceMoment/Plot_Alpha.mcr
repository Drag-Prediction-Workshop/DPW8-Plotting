#!MC 1410

$!LinePlotLayers
  ShowSymbols = Yes

# NOTE: Set |ImageFormat2| if an additional format is desired
$!VarSet |ImageFormat|  = '|IMG1|'
$!VarSet |ImageFormat2| = '|IMG2|'

#==================================================================================================
# Plots colored by turbulence model variations
#-----------------------------------
# SA+    variant
# SA+QCR variants
# SST    variants
$!IF 1 == 1
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
  $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
  $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA + QCR'
  $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'
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

 # CL
  $!VarSet |PlotName|  = 'CL_Turb'
  $!PageName = '|PlotName|'
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |1_h| YAxisVar = 7}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = 2.5E-04 RangeMax = 2.5E-02}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy

 # CMy
  $!VarSet |PlotName|  = 'CMy_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |1_h| YAxisVar = 9}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = 2.5E-04 RangeMax = 2.5E-02}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CD
  $!VarSet |PlotName|  = 'CD_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |1_h| YAxisVar = 8}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = 2.5E-04 RangeMax = 2.5E-02}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0125   RangeMax = 0.0175}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

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
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CL_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1

  $!LineMap  [|CadenceStr_Maps|] Lines   { Color = Red    } Symbols { Color = Red    FillColor = Red    }
  $!LineMap  [|CadenceUnS_Maps|] Lines   { Color = Black  } Symbols { Color = Black  FillColor = Black  }
  $!LineMap  [|HeldenUnSt_Maps|] Lines   { Color = Blue   } Symbols { Color = Blue   FillColor = Blue   }
  $!LineMap  [|OneraStruc_Maps|] Lines   { Color = Green  } Symbols { Color = Green  FillColor = Green  }
  $!LineMap  [|CstmUsrAdp_Maps|] Lines   { Color = Purple } Symbols { Color = Purple FillColor = Purple }
 #$!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
 #$!LineMap  [|CstmUsrStr_Maps|] Lines   { Color = Yellow } Symbols { Color = Yellow FillColor = Yellow }

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
  $!AttachText AnchorPos { X = 75 Y = 99 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 75 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     Cadence Structured'
  $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstructured'
  $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
  $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     ONERA Structured'
  $!AttachText AnchorPos { X = 75 Y = 89 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'
$!ELSE
  $!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
  $!AttachText AnchorPos { X = 75 Y = 99 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 75 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     Cadence Structured'
  $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstructured'
  $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
  $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     ONERA Structured'
  $!AttachText AnchorPos { X = 75 Y = 89 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'
  $!AttachText AnchorPos { X = 75 Y = 87 } TextShape { Height = 12 IsBold = No } Color = Cyan   Anchor = HeadLeft Text = '     User Unstructured Grid'
$!ENDIF
#==================================================================================================

 # CL
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |1_h| YAxisVar = 7}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = 2.5E-04 RangeMax = 2.5E-02}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy

 # CMy
  $!VarSet |PlotName|  = 'CM_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |1_h| YAxisVar = 9}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = 2.5E-04 RangeMax = 2.5E-02}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CD
  $!VarSet |PlotName|  = 'CD_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |1_h| YAxisVar = 8}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = 2.5E-04 RangeMax = 2.5E-02}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF
