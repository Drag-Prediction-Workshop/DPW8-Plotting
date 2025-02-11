#!MC 1410
$!Page Name = 'Untitled'
$!PageControl Create
$!NewLayout

$!FrameLayout ShowBorder = No
$!PrintSetup  Palette = Color
$!ExportSetup UseSuperSampleAntiAliasing = Yes
$!ExportSetup ImageWidth = 2000
$!IF 1 == 1
   $!ExportSetup ExportFormat = EPS
   $!Varset |ImageFile| = 'eps'
$!ELSE
   $!ExportSetup ExportFormat = png
   $!Varset |ImageFile| = 'png'
$!ENDIF

$!VarSet |NumALPHA| = "10"
$!VarSet |NumGRID|  = "7"

#$!VarSet |NumALPHA| = "1"
#$!VarSet |NumGRID|  = "1"

# Include Preliminary Text on Plots: Set to 1
$!VarSet |Preliminary| = 1

$!IF |Preliminary| == 1
 $!AttachText 
  AnchorPos { X = 50 Y = 50 }
  TextShape { IsBold = No SizeUnits = Frame Height = 8 }
  Color = Custom2
  Angle = 45
  Anchor = MidCenter
  Text = 'Preliminary'
$!ENDIF

#===================================================================
# Create Macro Function: UpdateHeaderText
#-------------------------------------
$!MACROFUNCTION
  NAME = "UpdateHeaderText"

   $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'JunkText' Box { BoxType = Filled }
   $!IF 0 == 1
    $!Pick AddAtPosition
     X = 5.75
     Y = 0.35
     ConsiderStyle = Yes
   $!ELSE
    $!PICK ADDALLINRECT
     SelectText = Yes
     X1 = 1.0
     X2 = 7.6
     Y1 = 0.0
     Y2 = 1.5
   $!ENDIF
   $!PICK CLEAR
   $!IF 0 == 1
      $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1a: ONERA OAT15A

\ \ \ \ \ Sectional Cuts: Grid |GRID|

\ \ \ \ \ \ \ Angle of Attack |ALPHA|)"
   $!ELSE
      $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1a: ONERA OAT15A\nSectional Cuts: Grid |GRID|\nAngle of Attack |ALPHA|"
   $!ENDIF

$!ENDMACROFUNCTION
#===================================================================

#==================================================================================================
$!INCLUDEMACRO "|MACROFILEPATH|/Load.mcr"

#==================================================================================================

#==================================================================================================

#-------------------------------------------------
# Turbulence Model Variants
$!VarSet |ALL_Maps|        = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44"
$!VarSet |SA_Maps|         = "  2,      6,    9,10,   12,         16,17,18,19,            24,25,26,27,28,   30,   32,33,34,35,36,37,38,39,40,   42,43,44"
$!VarSet |SAQ_Maps|        = "1,    4,5,  7,8,           13,   15,                                                                                      "
$!VarSet |SST_Maps|        = "    3,               11,      14,               20,21,22,23,               29,   31,                           41         "
$!VarSet |WMLES_Maps|      = "                                                                                                                           45"
$!VarSet |WMLES_Maps|      = "                                                                                                                           "

# Grid Type Variants
$!VarSet |ALL_Maps|        = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44"
$!VarSet |CadenceStr_Maps| = "      4,        9,10,   12,13,14,15,16,         20,                                 32,   34                   41,42      "
$!VarSet |CadenceUnS_Maps| = "1,2,3,    6,7,8,     11,               17,         21,      24,25,26,   28,29,30,31,   33,   35,36,37,38,39,40            "
$!VarSet |HeldenUnSt_Maps| = "        5,                                18,         22                                                                  "
$!VarSet |OneraStruc_Maps| = "                                             19,         23                                                               "
$!VarSet |CstmUsrAdp_Maps| = "                                                                     27,                                             43,44"
$!VarSet |CstmUsrStr_Maps| = "                                                                                                                          "
$!VarSet |CstmUsrUns_Maps| = "                                                                                                                           45"
$!VarSet |CstmUsrUns_Maps| = "                                                                                                                          "
#-------------------------------------------------

#-------------------------------------------------
$!LineMap [1-|NumLineMaps|]  Symbols { Size = 1.5 }
$!XYLineAxis XDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 4 } }
$!XYLineAxis YDetail 1 { CoordScale = Linear Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 9 } }
$!XYLineAxis GridArea  { DrawBorder = Yes LineThickness = 0.1 }

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

$!LOOP |NumALPHA|
 $!IF     |LOOP| == 1
   $!VarSet |ALPHA| = '1.36'
 $!ELSEIF |LOOP| == 2
   $!VarSet |ALPHA| = '1.50'
 $!ELSEIF |LOOP| == 3
   $!VarSet |ALPHA| = '2.50'
 $!ELSEIF |LOOP| == 4
   $!VarSet |ALPHA| = '3.00'
 $!ELSEIF |LOOP| == 5
   $!VarSet |ALPHA| = '3.10'
 $!ELSEIF |LOOP| == 6
   $!VarSet |ALPHA| = '3.25'
 $!ELSEIF |LOOP| == 7
   $!VarSet |ALPHA| = '3.40'
 $!ELSEIF |LOOP| == 8
   $!VarSet |ALPHA| = '3.50'
 $!ELSEIF |LOOP| == 9
   $!VarSet |ALPHA| = '3.60'
 $!ELSEIF |LOOP| == 10
   $!VarSet |ALPHA| = '3.90'
 $!ENDIF

#==================================================================================================
# SA/SA-QCR/SST variants
$!IF 1 == 1
   $!Varset |TYPE| = 'Turb'
  
   #-------------------------------------------------
   $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'JunkText' Box { BoxType = Filled }
   $!PICK ADDALLINRECT
     SelectText = Yes
     X1 = 7.7
     X2 = 10.2
     Y1 = 0.0
     Y2 = 1.7
   $!PICK CLEAR
   $!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n' Box { BoxType = Filled }

   $!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
   $!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     SA + QCR'
   $!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     SST'
  #$!AttachText AnchorPos { X = 76 Y = 91 } TextShape { Height = 12 IsBold = No  } Color = Cyan   Anchor = HeadLeft Text = '     WMLES'

   $!LineMap  [|SA_Maps|]    Lines { Color = Red    } Symbols { Color = Red    FillColor = Red    }
   $!LineMap  [|SAQ_Maps|]   Lines { Color = Green  } Symbols { Color = Green  FillColor = Green  }
   $!LineMap  [|SST_Maps|]   Lines { Color = Black  } Symbols { Color = Black  FillColor = Black  }
  #$!LineMap  [|WMLES_Maps|] Lines { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }

   $!LOOP |NumGRID|
     #------------------------------------------------
      $!VarSet |GRID| = |LOOP|
      $!RUNMACROFUNCTION "UpdateHeaderText"
      $!INCLUDEMACRO "|MACROFILEPATH|/Plot.mcr"
     #------------------------------------------------
   $!ENDLOOP

$!ENDIF

#==================================================================================================
# Grid variants
$!IF 1 == 1
   $!Varset |TYPE| = 'Grid'

   $!Pick AddAll
     SELECTFRAMES = YES
   $!Pick Copy

   $!PageControl Create
   $!PageName = 'CP_Grid'
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
   $!AttachText AnchorPos { X = 75 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n\n' Box { BoxType = Filled }

   $!AttachText AnchorPos { X = 75 Y = 97 } TextShape { Height = 12 IsBold = No  } Color = Red    Anchor = HeadLeft Text = '     Cadence Structured'
   $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = No  } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstructured'
   $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No  } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
   $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No  } Color = Green  Anchor = HeadLeft Text = '     ONERA Structured'
   $!AttachText AnchorPos { X = 75 Y = 89 } TextShape { Height = 12 IsBold = No  } Color = Purple Anchor = HeadLeft Text = '     User Custom Adapted'
  #$!AttachText AnchorPos { X = 75 Y = 87 } TextShape { Height = 12 IsBold = No  } Color = Cyan   Anchor = HeadLeft Text = '     User Custom Unstructured'
  #$!AttachText AnchorPos { X = 75 Y = 85 } TextShape { Height = 12 IsBold = No  } Color = Yellow Anchor = HeadLeft Text = '     User Custom Structured'

   $!LineMap  [|CadenceStr_Maps|] Lines   { Color = Red    } Symbols { Color = Red    FillColor = Red    }
   $!LineMap  [|CadenceUnS_Maps|] Lines   { Color = Black  } Symbols { Color = Black  FillColor = Black  }
   $!LineMap  [|HeldenUnSt_Maps|] Lines   { Color = Blue   } Symbols { Color = Blue   FillColor = Blue   }
   $!LineMap  [|OneraStruc_Maps|] Lines   { Color = Green  } Symbols { Color = Green  FillColor = Green  }
   $!LineMap  [|CstmUsrAdp_Maps|] Lines   { Color = Purple } Symbols { Color = Purple FillColor = Purple }
  #$!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
  #$!LineMap  [|CstmUsrStr_Maps|] Lines   { Color = Yellow } Symbols { Color = Yellow FillColor = Yellow }

  $!LOOP |NumGRID|
     #------------------------------------------------
      $!VarSet |GRID| = |LOOP|
      $!RUNMACROFUNCTION "UpdateHeaderText"
      $!INCLUDEMACRO "|MACROFILEPATH|/Plot.mcr"
     #------------------------------------------------
   $!ENDLOOP
$!ENDIF

$!ENDLOOP
