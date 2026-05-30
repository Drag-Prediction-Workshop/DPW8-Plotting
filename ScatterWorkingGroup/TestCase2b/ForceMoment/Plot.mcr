#!MC 1410

$!IF "|GRID|" != "0"

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
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 2b: NASA CRM Wing/Body

\ \ \ \ \ \ \ \ \ \ \ \ \ \ Polar Study

\ \ \ \ \ \ \ \ \ \ \ \ \ Grid Level |GRID|)"
  $!ELSE
   #$!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 2b: NASA CRM\nWing/Body Polar\nGrid Level |GRID|"
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 2b: NASA CRM\nWing/Body Polar"
  $!ENDIF
  $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA'
  $!AttachText AnchorPos { X = 76 Y = 91 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA+QCR'
  $!AttachText AnchorPos { X = 76 Y = 89 } TextShape { Height = 12 IsBold = No  } Color = Blue   Anchor = HeadLeft Text = '     SA+RC+QCR'
  $!AttachText AnchorPos { X = 76 Y = 87 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'

  $!Pick AddAll
    SELECTFRAMES = YES
  $!Pick Copy

$!IF 1 == 1
 # CL
  $!VarSet |PlotName|  = 'CL_Alpha_Turb'
  $!PageName = '|PlotName|'
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = 7}
  $!XYLineAxis XDetail 1 {IsReversed = No}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = 2.25     RangeMax = 4.50}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {RangeMin = 0.480    RangeMax = 0.720 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

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
 #$!XYLineAxis XDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!XYLineAxis YDetail 1 {RangeMin = 2.25 RangeMax = 4.50}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

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
  $!XYLineAxis XDetail 1 {RangeMin = 250.0    RangeMax = 525.0}
 #$!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!XYLineAxis YDetail 1 {RangeMin = 0.480    RangeMax = 0.720 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

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
  $!XYLineAxis XDetail 1 {RangeMin = 150.0    RangeMax = 350.0}
 #$!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!XYLineAxis YDetail 1 {RangeMin = 0.480    RangeMax = 0.720 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
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
  $!VarSet |PlotName|  = 'CL_Alpha_Grid'
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
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 2b: NASA CRM Wing/Body

\ \ \ \ \ \ \ \ \ \ \ \ \ \ Polar Study

\ \ \ \ \ \ \ \ \ \ \ \ \ Grid Level |GRID|)"
  $!ELSE
   #$!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 2b: NASA CRM\nWing/Body Polar\nGrid Level |GRID|"
    $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 2b: NASA CRM\nWing/Body Polar"
  $!ENDIF

  $!AttachText AnchorPos { X = 73 Y = 95 } TextShape { Height = 12 IsBold = Yes} Color = Black  Anchor = HeadLeft Text = 'Grid Family:                              \n\n\n\n\n' Box { BoxType = Filled }
  $!AttachText AnchorPos { X = 73 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstructured'
  $!AttachText AnchorPos { X = 73 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
  $!AttachText AnchorPos { X = 73 Y = 89 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     Ames Overset Structured'
  $!AttachText AnchorPos { X = 73 Y = 87 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'
  $!AttachText AnchorPos { X = 73 Y = 85 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     DPW7: Vassberg Structured'

 # CL
  $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = 7}
  $!XYLineAxis XDetail 1 {IsReversed = No}
  $!View NiceFit
  $!View MakeCurrentViewNice
  $!XYLineAxis XDetail 1 {RangeMin = 2.25     RangeMax = 4.50}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis YDetail 1 {RangeMin = 0.480    RangeMax = 0.720 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

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
 #$!XYLineAxis XDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!XYLineAxis YDetail 1 {RangeMin = 2.25 RangeMax = 4.50}
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

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
  $!XYLineAxis XDetail 1 {RangeMin = 250.0    RangeMax = 525.0}
 #$!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!XYLineAxis YDetail 1 {RangeMin = 0.480    RangeMax = 0.720 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )

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
  $!XYLineAxis XDetail 1 {RangeMin = 150.0    RangeMax = 350.0}
 #$!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 1}}}
  $!XYLineAxis XDetail 1 {TickLabel {NumFormat {Formatting = Integer}}}
  $!XYLineAxis YDetail 1 {RangeMin = 0.480    RangeMax = 0.720 }
  $!XYLineAxis YDetail 1 {TickLabel {NumFormat {Formatting = FixedFloat Precision = 2}}}
  $!RUNMACROFUNCTION "ExportAndSave" ( '|MACROFILEPATH|' 'Grid|GRID|_|PlotName|' '|ImageFormat|' '|ImageFormat2|' )
$!ENDIF

$!ENDIF
