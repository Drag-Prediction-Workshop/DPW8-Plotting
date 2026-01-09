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
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 3a: DPW-III Wing1/2\nGrid Convergence Study\nAngle of Attack |ALPHA|"
  $!ENDIF
  $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
  $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA + QCR'
  $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'

  $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
  $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA + QCR'
  $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'

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
  $!ELSEIF 1 == 1
    $!VarSet |xAxis| = |1_h1o3|
    $!VarSet |xRngMin| = 5.0E-04
    $!VarSet |xRngMax| = 5.0E-02
  $!ELSEIF 0 == 1
    $!VarSet |xAxis| = |1_h2o3|
    $!VarSet |xRngMin| = 9.0E-07
    $!VarSet |xRngMax| = 1.4E-03
  $!ENDIF

$!IF 0 == 1
 # CL
  $!VarSet |PlotName|  = 'CL_Turb'
  $!PageName = '|PlotName|'
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 7}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0125   RangeMax = 0.0175}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

$!ENDIF

#==================================================================================================
# Plots colored by grid variations
#-----------------------------------
# Cadence Unstructured TetFF Grid
# Cadence Unstructured VoxFF Grid
# Helden Unstructured Grid
# Onera Structured Grid
# Custom User Adapted Grid
# Custom User Grid Structured
# Custom User Grid Unstructured
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CL_Grid'

 ### No need for this if skipping turbulence model variations above
 #$!PageControl Create

  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1

  $!LineMap  [|CadenceUnSTet_Maps|] Lines   { Color = Red    } Symbols { Color = Red    FillColor = Red    }
  $!LineMap  [|CadenceUnSVox_Maps|] Lines   { Color = Black  } Symbols { Color = Black  FillColor = Black  }
  $!LineMap  [|HeldenUnSt_Maps|]    Lines   { Color = Blue   } Symbols { Color = Blue   FillColor = Blue   }
  $!LineMap  [|CstmUsrAdp_Maps|] Lines   { Color = Purple } Symbols { Color = Purple FillColor = Purple }
 #$!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
 #$!LineMap  [|CstmUsrStr_Maps|] Lines   { Color = Yellow } Symbols { Color = Yellow FillColor = Yellow }

  $!LineMap  [|WING1_Maps|] Lines   { LinePattern = Solid  }
  $!LineMap  [|WING2_Maps|] Lines   { LinePattern = Dashed }

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
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 3a: DPW-III Wing1/2\nGrid Convergence Study\nAngle of Attack |ALPHA|"
  $!ENDIF

  $!AttachText AnchorPos { X = 75 Y = 99 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 75 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     Cadence Unstrctrd TetFF'
  $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstrctrd VoxFF'
  $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
  $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'

  $!AttachText AnchorPos { X = 88.75 Y = 87 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Wing:           \n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 88.75 Y = 85 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '  W1: Solid'
  $!AttachText AnchorPos { X = 88.75 Y = 83 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '  W2: Dash'

 # CL
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 7}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 0.460   RangeMax = 0.500}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
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
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 9}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = -0.0680   RangeMax = -0.0630}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

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
  $!XYLineAxis YDetail 1 {RangeMin = 0.02020   RangeMax = 0.02120}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
  $!XYLineAxis YDetail 1 {RangeMin = 0.0141   RangeMax = 0.0153}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!Blanking Value { Include = No }

 # dCL
  $!VarSet |PlotName|  = 'dCL_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = |dCL|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = -0.026   RangeMax = -0.016}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCL| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # dCMy
  $!VarSet |PlotName|  = 'dCMy_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = |dCMy|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = -0.0020   RangeMax = 0.0005}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 1 { Include = No } }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCMy| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # dCD
  $!VarSet |PlotName|  = 'dCD_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = |dCD|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = -7.00   RangeMax = -2.00}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCD| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # dCDpress
  $!VarSet |PlotName|  = 'dCDpress_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = |dCDp|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = -7.00   RangeMax = -2.00}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCDp| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # dCDskinfric
  $!VarSet |PlotName|  = 'dCDskinfric_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = |dCDv|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 0.2   RangeMax = 0.8}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCDv| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF
