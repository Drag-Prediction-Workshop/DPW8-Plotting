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

  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1b: Joukowski Airfoil

\ \ \ \ \ Grid Convergence Study

\ \ \ \ \ \ \ Angle of Attack |ALPHA|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1b: Joukowski Airfoil\nGrid Convergence Study\nAngle of Attack |ALPHA|"
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
  $!ELSEIF 1 == 1
    $!VarSet |xAxis| = |1_h1o2|
    $!VarSet |xRngMin| = 2.0E-04
    $!VarSet |xRngMax| = 6.0E-02
  $!ELSEIF 0 == 1
    $!VarSet |xAxis| = |1_h1o3|
    $!VarSet |xRngMin| = 5.0E-04
    $!VarSet |xRngMax| = 5.0E-02
  $!ELSEIF 0 == 1
    $!VarSet |xAxis| = |1_h2o3|
    $!VarSet |xRngMin| = 1.0E-06
    $!VarSet |xRngMax| = 1.0E-04
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
  $!XYLineAxis YDetail 1 {RangeMin = -0.0010  RangeMax = 0.0010}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
  $!XYLineAxis YDetail 1 {RangeMin = -0.0010  RangeMax = 0.0010}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
  $!XYLineAxis YDetail 1 {RangeMin = 0.0070   RangeMax = 0.0300}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CDzoom
  $!VarSet |PlotName|  = 'CDzoom_Turb'
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
  $!XYLineAxis YDetail 1 {RangeMin = 0.0078925 RangeMax = 0.00796}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 5}}}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {GRSpacing = 2E-05}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 $!IF 0 == 1
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
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0145   RangeMax = 0.0155}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
 #$!XYLineAxis YDetail 1 {RangeMin = 0.0110   RangeMax = 0.0120}
 #$!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 $!ENDIF
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

 ### No need for this if skipping turbulence model variations above
 #$!PageControl Create

  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1

  $!LineMap  [|PythonGrd_Maps|]     Lines   { Color = Black  } Symbols { Color = Black  FillColor = Black  }
  $!LineMap  [|CstmUsrAdp_Maps|]    Lines   { Color = Purple } Symbols { Color = Purple FillColor = Purple }

  $!Pick AddAll
     SELECTTEXT=YES
  $!Pick Clear
  $!IF |Preliminary| == 1
    $!AttachText AnchorPos { X = 50 Y = 50 } TextShape { IsBold = No SizeUnits = Frame Height = 8 } Color = Custom2 Angle = 45 Anchor = MidCenter Text = 'Preliminary'
  $!ENDIF
  $!IF 0 == 1
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1b: Joukowski Airfoil

\ \ \ \ \ Grid Convergence Study

\ \ \ \ \ \ \ Angle of Attack |ALPHA|)"
  $!ELSE
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1b: Joukowski Airfoil\nGrid Convergence Study\nAngle of Attack |ALPHA|"
  $!ENDIF

  $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = Yes} Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Python Mesh Family'
  $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'

 # CL
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = 7}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
 #$!XYLineAxis XDetail 1 {AutoGrid = No GRSpacing = 0.01}
  $!XYLineAxis YDetail 1 {RangeMin = -0.0010  RangeMax = 0.0010}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
  $!XYLineAxis YDetail 1 {RangeMin = -0.0010  RangeMax = 0.0010}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
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
  $!XYLineAxis YDetail 1 {RangeMin = 0.0070   RangeMax = 0.0300}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 # CDzoom
  $!VarSet |PlotName|  = 'CDzoom_Grid'
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
  $!XYLineAxis YDetail 1 {RangeMin = 0.0078925 RangeMax = 0.00796}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 5}}}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {GRSpacing = 2E-05}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

 $!IF 1 == 1
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
  $!XYLineAxis YDetail 1 {RangeMin = 0.0000   RangeMax = 0.0050}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {GRSpacing = 1E-03}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 #$!Blanking Value { Include = No }

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
  $!XYLineAxis YDetail 1 {RangeMin = 0.0050   RangeMax = 0.0100}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 4}}}
  $!XYLineAxis YDetail 1 {AutoGrid = No}
  $!XYLineAxis YDetail 1 {GRSpacing = 1E-03}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
 #$!Blanking Value { Include = No }
 $!ENDIF

 # CDerror
  $!VarSet |PlotName|  = 'CDerror_Grid'
  $!PageControl Create
  $!PageName = '|PlotName|'
  $!Pick Paste
  $!FrameControl DeleteByNumber
    Frame = 1
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = |xAxis| YAxisVar = |CDerror|}
  $!Blanking Value { Include = No }
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = |xRngMin| RangeMax = |xRngMax|}
  $!XYLineAxis XDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {RangeMin = 1E-07   RangeMax = 0.1}
  $!XYLineAxis YDetail 1 {CoordScale = Log}
  $!XYLineAxis YDetail 1 {AutoGrid = Yes}
  #--------------------------------------------------------
  # Add 2nd/4th order curves?
  $!IF 1 == 1
    #-----------
    # 2nd Order
    #-----------
    # 0.00045 0.00015
    # 0.00450 0.01500
    #-----------
    $!AttachGeom 
      AnchorPos { X = 4.5E-04 Y = 1.5E-04 }
      Color = Custom24
      LineThickness = 0.3
      RawData
      1
      2
      0    0 
      0.00405 0.01485
    $!AttachText 
      AnchorPos { X = 30.0 Y = 60.0 }
      TextShape { IsBold = Yes Height = 14 }
      Color = Custom24
      Text = '2'
    #-----------
    # 4th Order
    #-----------
    # 0.0025  0.0000015
    # 0.0250  0.0150000
    #-----------
    $!AttachGeom 
      AnchorPos { X = 2.50E-03 Y = 1.50E-06 }
      Color = Custom24
      LineThickness = 0.3
      RawData
      1
      2
      0    0 
      0.0225 0.0149985
    $!AttachText 
      AnchorPos { X = 55.5 Y = 45.0 }
      TextShape { IsBold = Yes Height = 14 }
      Color = Custom24
      Text = '4'
  $!ENDIF
  #--------------------------------------------------------
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Alpha|ALPHA|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

$!ENDIF
