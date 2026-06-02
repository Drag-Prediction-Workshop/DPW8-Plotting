#!MC 1410

$!IF "|GRID|" != "0"

# NOTE: Set |ImageFormat2| if an additional format is desired
$!VarSet |ImageFormat|  = '|IMG1|'
$!VarSet |ImageFormat2| = '|IMG2|'

$!VarSet |PlotLabel| = 'Grid|GRID|'
#$!VarSet |PlotLabel| = 'TestCase1e'

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

  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1e: DPW-III Wing1/2

\ \ \ \ \ \ \ \ \ \ \ \ \ \ Polar Study)"
  $!ELSE
   #$!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1e: DPW-III Wing1/2\nPolar Study\nGrid Level |GRID|"
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1e: DPW-III Wing1/2\nPolar Study"
  $!ENDIF
  $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA'
  $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA+QCR'
  $!AttachText AnchorPos { X = 76 Y = 91 } TextShape { Height = 12 IsBold = No  } Color = Blue   Anchor = HeadLeft Text = '     SA+RC+QCR'
  $!AttachText AnchorPos { X = 76 Y = 89 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy

$!IF 0 == 1
 # CL
  $!VarSet |PlotName|  = 'CL_Alpha_Turb'
  $!PageName = '|PlotName|'
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = 7}
  $!XYLineAxis XDetail 1 {IsReversed = No}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -1.20   RangeMax =  3.20 }
  $!XYLineAxis YDetail 1 {RangeMin =  0.25   RangeMax =  0.75 }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy

 # CMy
  $!VarSet |PlotName|  = 'CM_Alpha_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 9 YAxisVar = 6}
  $!XYLineAxis XDetail 1 {IsReversed = Yes}
  $!View NiceFit
  $!View MakeCurrentViewNice
 #$!XYLineAxis XDetail 1 {RangeMin = -0.074  RangeMax = -0.054}
  $!XYLineAxis XDetail 1 {RangeMin = -0.080  RangeMax = -0.040}
  $!XYLineAxis YDetail 1 {RangeMin = -1.20   RangeMax =  3.20 }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # CD
  $!VarSet |PlotName|  = 'CD_CL_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 8 YAxisVar = 7}
  $!XYLineAxis XDetail 1 {IsReversed = No}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin =  120.0 RangeMax =  540.0}
  $!XYLineAxis YDetail 1 {RangeMin =  0.25   RangeMax =  0.75 }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # CDi
  $!VarSet |PlotName|  = 'CDi_CL_Turb'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |CDi| YAxisVar = 7}
  $!XYLineAxis XDetail 1 {IsReversed = No}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -5.0 RangeMax =  95.0}
  $!XYLineAxis XDetail 1 {AutoGrid = No}
  $!XYLineAxis XDetail 1 {GRSpacing = 10.0}
  $!XYLineAxis YDetail 1 {RangeMin =  0.25   RangeMax =  0.75 }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF
$!ENDIF

$!ENDIF

#==================================================================================================
# Plots colored by grid variations
#-----------------------------------
# Cadence Unstructured TetFF REV00 Grid
# Cadence Unstructured VoxFF REV00 Grid
# Cadence Unstructured TetFF REV01 Grid
# Cadence Unstructured VoxFF REV01 Grid
# Helden Unstructured Grid
# Onera Structured Grid
# Custom User Adapted Grid
# Custom User Grid Structured
# Custom User Grid Unstructured
$!IF 1 == 1
  $!VarSet |PlotName|  = 'CL_Alpha_Grid'

 ### No need for this if skipping turbulence model variations above
 #$!PageControl Create

  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1

  $!LineMap  [|CadenceUnSTet_Maps|] Lines   { Color = Red     } Symbols { Color = Red     FillColor = Red     }
  $!LineMap  [|CadenceUnSVox_Maps|] Lines   { Color = Black   } Symbols { Color = Black   FillColor = Black   }
  $!LineMap  [|HeldenUnSt_Maps|]    Lines   { Color = Blue    } Symbols { Color = Blue    FillColor = Blue    }
  $!LineMap  [|CstmUsrAdp_Maps|]    Lines   { Color = Purple  } Symbols { Color = Purple  FillColor = Purple  }
  $!LineMap  [|CadenceUnSTet1_Maps|] Lines  { Color = Custom3 } Symbols { Color = Custom3 FillColor = Custom3 }
  $!LineMap  [|CadenceUnSVox1_Maps|] Lines  { Color = Green   } Symbols { Color = Green   FillColor = Green   }

  $!LineMap  [|WING1_Maps|]         Lines   { LineThickness = 0.25 LinePattern = Solid  } Symbols { Size = 1.0 } Assign  { ShowInLegend = Auto }
  $!LineMap  [|WING2_Maps|]         Lines   { LineThickness = 0.25 LinePattern = LongDash PatternLength = 0.8 } Symbols { Size = 1.0 } Assign  { ShowInLegend = Never }

 # Turn off all Wing2 lines
 #$!ActiveLineMaps -= [|WING2_Maps|]

 #$!LineMap  [|DPW3_Maps|]          Lines   { LineThickness = 0.40 } Symbols { Size = 1.5 }
  $!LineMap  [|DPW3_Maps|]          Lines   { LineThickness = 0.25 Color = Custom1 } Symbols { Size = 1.0 Color = Custom1 SymbolShape {GeomShape = Square} }
  $!LineMap  [|DPW3_Maps|]          Assign  { ShowInLegend = Never }
  $!LineMap  [|DPW3_Map1|]          Assign  { ShowInLegend = Auto  }

  $!Pick AddAll
     SELECTTEXT=YES
  $!Pick Clear
  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1e: DPW-III Wing1/2

\ \ \ \ \ \ \ \ \ \ \ \ \ \ Polar Study)"
  $!ELSE
   #$!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1e: DPW-III Wing1/2\nPolar Study\nGrid Level |GRID|"
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1e: DPW-III Wing1/2\nPolar Study"
  $!ENDIF

  $!AttachText AnchorPos { X = 75 Y = 99 } TextShape { Height = 12 IsBold = No } Color = Black   Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 75 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red     Anchor = HeadLeft Text = '     Cadence Unstrctrd TetFF'
  $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Black   Anchor = HeadLeft Text = '     Cadence Unstrctrd VoxFF'
  $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Blue    Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
  $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Purple  Anchor = HeadLeft Text = '     User Grid Adaptation'
  $!AttachText AnchorPos { X = 75 Y = 89 } TextShape { Height = 12 IsBold = No } Color = Custom3 Anchor = HeadLeft Text = '     Cadence Unstrc TetFF r01'
  $!AttachText AnchorPos { X = 75 Y = 87 } TextShape { Height = 12 IsBold = No } Color = Green   Anchor = HeadLeft Text = '     Cadence Unstrc VoxFF r01'

  $!AttachText AnchorPos { X = 88.75 Y = 83 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Wing:           \n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 88.75 Y = 81 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '  W1: Solid'
  $!AttachText AnchorPos { X = 88.75 Y = 79 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '  W2: Dash'

 # CL
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = 7}
  $!XYLineAxis XDetail 1 {IsReversed = No}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -1.20   RangeMax =  3.20 }
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {RangeMin =  0.25   RangeMax =  0.75 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy

 # CMy
  $!VarSet |PlotName|  = 'CM_Alpha_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 9 YAxisVar = 6}
  $!XYLineAxis XDetail 1 {IsReversed = Yes}
  $!View NiceFit
  $!View MakeCurrentViewNice
 #$!XYLineAxis XDetail 1 {RangeMin = -0.074  RangeMax = -0.054}
  $!XYLineAxis XDetail 1 {RangeMin = -0.080  RangeMax = -0.040}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!XYLineAxis YDetail 1 {RangeMin = -1.20   RangeMax =  3.20 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # CD
  $!VarSet |PlotName|  = 'CD_CL_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 8 YAxisVar = 7}
  $!XYLineAxis XDetail 1 {IsReversed = No}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin =  120.0  RangeMax =  540.0}
  $!XYLineAxis XDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!XYLineAxis YDetail 1 {RangeMin =  0.25   RangeMax =  0.75 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # CDi
  $!VarSet |PlotName|  = 'CDi_CL_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |CDi| YAxisVar = 7}
  $!XYLineAxis XDetail 1 {IsReversed = No}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -5.0 RangeMax =  95.0}
  $!XYLineAxis XDetail 1 {AutoGrid = No}
  $!XYLineAxis XDetail 1 {GRSpacing = 10.0}
  $!XYLineAxis XDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!XYLineAxis YDetail 1 {RangeMin =  0.25   RangeMax =  0.75 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # dCL
  $!VarSet |PlotName|  = 'dCL_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  # Clear Wing text box
  $!IF 1 == 1
    $!Pick DeselectAll
    $!Pick AddAllInRect
      SelectText = Yes
      SelectGeoms = Yes
      SelectMaps = Yes
      ConsiderStyle = Yes
      X1 =  8.8
      X2 = 10.1
      Y1 =  1.5
      Y2 =  2.2
    $!Pick Clear
    $!AttachText AnchorPos { X = 88.75 Y = 83 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Increment:\n = W2 - W1' Box { BoxType = Filled }
  $!ENDIF
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = |dCL|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -1.20    RangeMax = 3.20}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {RangeMin = -0.05   RangeMax =  0.05}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCL| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!LineMap  [|DPW3_Maps|]          Lines   { LinePattern = LongDash PatternLength = 0.8 }
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # dCMy
  $!VarSet |PlotName|  = 'dCMy_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  # Clear Wing text box
  $!IF 1 == 1
    $!Pick DeselectAll
    $!Pick AddAllInRect
      SelectText = Yes
      SelectGeoms = Yes
      SelectMaps = Yes
      ConsiderStyle = Yes
      X1 =  8.8
      X2 = 10.1
      Y1 =  1.5
      Y2 =  2.2
    $!Pick Clear
    $!AttachText AnchorPos { X = 88.75 Y = 83 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Increment:\n = W2 - W1' Box { BoxType = Filled }
  $!ENDIF
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = |dCMy|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -1.20    RangeMax = 3.20}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {RangeMin = -0.010   RangeMax = 0.010}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 3}}}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 1 { Include = No } }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCMy| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!LineMap  [|DPW3_Maps|]          Lines   { LinePattern = LongDash PatternLength = 0.8 }
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # dCD
  $!VarSet |PlotName|  = 'dCD_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  # Clear Wing text box
  $!IF 1 == 1
    $!Pick DeselectAll
    $!Pick AddAllInRect
      SelectText = Yes
      SelectGeoms = Yes
      SelectMaps = Yes
      ConsiderStyle = Yes
      X1 =  8.8
      X2 = 10.1
      Y1 =  1.5
      Y2 =  2.2
    $!Pick Clear
    $!AttachText AnchorPos { X = 88.75 Y = 83 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Increment:\n = W2 - W1' Box { BoxType = Filled }
  $!ENDIF
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = |dCD|}
 #$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 7 YAxisVar = |dCD|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -1.20    RangeMax = 3.20}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {RangeMin = -2.0   RangeMax = 18.0}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
 #$!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {GRSpacing = 2}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCD| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!LineMap  [|DPW3_Maps|]          Lines   { LinePattern = LongDash PatternLength = 0.8 }
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # dCDpress
  $!VarSet |PlotName|  = 'dCDpress_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  # Clear Wing text box
  $!IF 1 == 1
    $!Pick DeselectAll
    $!Pick AddAllInRect
      SelectText = Yes
      SelectGeoms = Yes
      SelectMaps = Yes
      ConsiderStyle = Yes
      X1 =  8.8
      X2 = 10.1
      Y1 =  1.5
      Y2 =  2.2
    $!Pick Clear
    $!AttachText AnchorPos { X = 88.75 Y = 83 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Increment:\n = W2 - W1' Box { BoxType = Filled }
  $!ENDIF
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = |dCDp|}
 #$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 7 YAxisVar = |dCDp|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -1.20    RangeMax = 3.20}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {RangeMin = -2.0   RangeMax = 18.0}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
 #$!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {GRSpacing = 2}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCDp| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!LineMap  [|DPW3_Maps|]          Lines   { LinePattern = LongDash PatternLength = 0.8 }
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF

 # dCDskinfric
  $!VarSet |PlotName|  = 'dCDskinfric_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  # Clear Wing text box
  $!IF 1 == 1
    $!Pick DeselectAll
    $!Pick AddAllInRect
      SelectText = Yes
      SelectGeoms = Yes
      SelectMaps = Yes
      ConsiderStyle = Yes
      X1 =  8.8
      X2 = 10.1
      Y1 =  1.5
      Y2 =  2.2
    $!Pick Clear
    $!AttachText AnchorPos { X = 88.75 Y = 83 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Increment:\n = W2 - W1' Box { BoxType = Filled }
  $!ENDIF
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = |dCDv|}
 #$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 7 YAxisVar = |dCDv|}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = -1.20    RangeMax = 3.20}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {RangeMin = -6.0   RangeMax = 5.0}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
 #$!XYLineAxis YDetail 1 {TickLabel{NumFormat { Formatting = Integer }}}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {GRSpacing = 1}
  $!Blanking Value { Include = Yes }
  $!Blanking Value { Constraint 2 { Include = Yes RelOp = EqualTo ValueCutoff = 0.00 VarA = |dCDv| } }
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
  $!IF 1 == 1
    $!LineMap  [|DPW3_Maps|]          Lines   { LinePattern = LongDash PatternLength = 0.8 }
    $!ActiveLineMaps = [|DPW3_Maps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_Only_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps = [1-|NumLineMaps|]
    $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' '|PlotLabel|_|PlotName|_DPW3' '|ImageFormat|' '|ImageFormat2|' )
    $!ActiveLineMaps -= [|DPW3_Maps|]
  $!ENDIF
$!ENDIF

$!ENDIF
