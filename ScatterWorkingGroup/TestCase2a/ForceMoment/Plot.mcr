#!MC 1410

$!LinePlotLayers
  ShowSymbols = Yes

# NOTE: Set |ImageFormat2| if an additional format is desired
$!VarSet |ImageFormat|  = '|IMG1|'
$!VarSet |ImageFormat2| = '|IMG2|'

#==================================================================================================
# Plots colored by turbulence model variations
#-----------------------------------
# SA        variant
# SA+QCR    variants
# SA+RC+QCR variants
# SST       variants
$!IF 1 == 1
  $!LineMap  [|SA_Maps|]    Lines   { Color = Red   } Symbols { Color = Red   FillColor = Red   }
  $!LineMap  [|SAQ_Maps|]   Lines   { Color = Green } Symbols { Color = Green FillColor = Green }
  $!LineMap  [|SARCQ_Maps|] Lines   { Color = Blue  } Symbols { Color = Blue  FillColor = Blue  }
  $!LineMap  [|SST_Maps|]   Lines   { Color = Black } Symbols { Color = Black FillColor = Black }

 #$!LineMap  [|DPW7_Maps|]  Lines   { Color = Custom1 } Symbols { Color = Custom1 FillMode = None }

  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 2a: NASA CRM Wing/Body

\ \ \ \ \ Grid Convergence Study

\ \ \ \ \ \ \ Angle of Attack |ALPHA|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 2a: NASA CRM Wing/Body\nGrid Convergence Study\nAngle of Attack |ALPHA|"
  $!ENDIF
  $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA'
  $!AttachText AnchorPos { X = 76 Y = 91 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA+QCR'
  $!AttachText AnchorPos { X = 76 Y = 89 } TextShape { Height = 12 IsBold = No  } Color = Blue   Anchor = HeadLeft Text = '     SA+RC+QCR'
  $!AttachText AnchorPos { X = 76 Y = 87 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy

  # Assign x-axis variable
  $!IF 0 == 1
    $!VarSet |xAxis| = |1_h|
    $!VarSet |xRngMin| = 6.0E-10
    $!VarSet |xRngMax| = 6.0E-05
  $!ELSEIF 0 == 1
    $!VarSet |xAxis| = |1_h1o2|
    $!VarSet |xRngMin| = 4.0E-05
    $!VarSet |xRngMax| = 4.0E-03
  $!ELSEIF 0 == 1
    $!VarSet |xAxis| = |1_h1o3|
    $!VarSet |xRngMin| = 5.0E-04
    $!VarSet |xRngMax| = 5.0E-02
  $!ELSEIF 1 == 1
    $!VarSet |xAxis| = |1_h2o3|
    $!VarSet |xRngMin| = 5.0E-07
    $!VarSet |xRngMax| = 1.0E-04
  $!ENDIF

$!IF 1 == 1
 # CL
  $!VarSet |PlotName|  = 'CL_Turb'
  $!PageName = '|PlotName|'
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 7}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 0.495   RangeMax = 0.525}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CD
  $!VarSet |PlotName|  = 'CD_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 8}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 257.0   RangeMax = 277.0}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CMy
  $!VarSet |PlotName|  = 'CMy_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 9}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = -0.1100   RangeMax = -0.0850}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CDpress
  $!VarSet |PlotName|  = 'CDpress_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 13}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 143.0   RangeMax = 163.0}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CDskinfric
  $!VarSet |PlotName|  = 'CDskinfric_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 14}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 110.0   RangeMax = 120.0}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

$!ENDIF

#==================================================================================================
# Plots colored by grid variations
#-----------------------------------
# Cadence Unstructured Grid
# Helden Unstructured Grid
# Ames Overset Structured Grid
# Vassberg Structured Grid
# Custom User Adapted Grid
## Custom User Grid Structured
## Custom User Grid Unstructured
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CL_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1

  $!LineMap  [|CadenceUnS_Maps|]    Lines   { Color = Black  } Symbols { Color = Black  FillColor = Black  }
  $!LineMap  [|AmesOverSt_Maps|]    Lines   { Color = Red    } Symbols { Color = Red    FillColor = Red    }
  $!LineMap  [|HeldenUnSt_Maps|]    Lines   { Color = Blue   } Symbols { Color = Blue   FillColor = Blue   }
  $!LineMap  [|AmesOverSt_Maps|]    Lines   { Color = Red    } Symbols { Color = Red    FillColor = Red    }
  $!LineMap  [|VassbergOvrSt_Maps|] Lines   { Color = Green  } Symbols { Color = Green  FillColor = Green  }
  $!LineMap  [|CstmUsrAdp_Maps|]    Lines   { Color = Purple } Symbols { Color = Purple FillColor = Purple }

 #$!LineMap  [|CstmUsrUns_Maps|]    Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
 #$!LineMap  [|CstmUsrStr_Maps|]    Lines   { Color = Yellow } Symbols { Color = Yellow FillColor = Yellow }

  $!LineMap  [|DPW7_Maps|]          Lines   { Color = Custom1 } Symbols { Color = Custom1 FillMode = None }

  $!Pick AddAll
     SELECTTEXT=YES
  $!Pick Clear
  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 2a: NASA CRM Wing/Body

\ \ \ \ \ Grid Convergence Study

\ \ \ \ \ \ \ Angle of Attack |ALPHA|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 2a: NASA CRM Wing/Body\nGrid Convergence Study\nAngle of Attack |ALPHA|"
  $!ENDIF

  $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = Yes} Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstructured'
  $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
  $!AttachText AnchorPos { X = 75 Y = 89 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     Ames Overset Structured'
  $!AttachText AnchorPos { X = 75 Y = 87 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'

 # CL
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 7}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 #$!XYLineAxis XDetail 1 {AutoGrid = No GRSpacing = 0.01}
  $!XYLineAxis YDetail 1 {RangeMin = 0.495   RangeMax = 0.525}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy

 # CD
  $!VarSet |PlotName|  = 'CD_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 8}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 257.0   RangeMax = 277.0}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CMy
  $!VarSet |PlotName|  = 'CM_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 9}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = -0.1100   RangeMax = -0.0850}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CDpress
  $!VarSet |PlotName|  = 'CDpress_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 13}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 1 { Include = No } }
  $!Blanking Value { Constraint 2 { Include = Yes ValueCutoff = -900 VarA = 13 } }
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 143.0   RangeMax = 163.0}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!Blanking Value { Include = No }

 # CDskinfric
  $!VarSet |PlotName|  = 'CDskinfric_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 14}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 1 { Include = No } }
  $!Blanking Value { Constraint 2 { Include = Yes ValueCutoff = -900 VarA = 14 } }
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 110.0   RangeMax = 120.0}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!Blanking Value { Include = No }

$!ENDIF
