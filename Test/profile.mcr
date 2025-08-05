#!MC 1410
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   DPW-8/AePW-4 SECTIONAL CUTTER (Version 2 - OcTober 16, 2024)
#      To BE USED WITH:
#          DPW8-AePW4_SectionalCuts_v5.dat
#
#       INSTRUCTIONS:
#                  1.   Load Fuselage and Wing Surface Zones inTo Tecplot
#                  2.   Assign ParticipantID variable as the identIfier of the dataset
#                  3.   Assign OutputFileName variable To the path where you would like the data
#                  4.   Assign (Xvar,Yvar,Zvar) variables To the variable number in dataset (typically 1,2,3)
#                  5.   Assign CPvar    variable To the variable number in dataset (If it exists); either CPvar or Mvar must exist
#                  6.   Assign Mvar     variable To the variable number in dataset (If it exists); either CPvar or Mvar must exist
#                  7.   Assign CPRMSvar variable To the variable number in dataset (If it exists)
#                  8.   Assign MRMSvar  variable To the variable number in dataset (If it exists)
#                  9.   Assign BodyMaps variable To define which zones define the fuselage surface(s)
#                 10.   Assign WingMaps variable To define which zones define the wing surface(s)
#                 11.   Assign PlotTime variable (If multiple time steps are included in dataset) To define which solution time should be used; set To 999999 If only one time step is loaded inTo the Tecplot session
#                 12.   Assemble boundary-layer profile data inTo data form
#                       DPW8-AePW4_Profiles_v1.dat
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
$!DrawGraphics False

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            USER CUSTOM READ DATA COMMAND
#            - Go To Scripting --> Record Macro
#            - Manually read your dataset and sTop recording
#            - Copy the resulting macro command here
#            - Note the required variables for entry below (variable numbers, Maps, etc.)
#
#$!ReadDataSet ...
#  ...
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            FILE OUTPUT LOCATION
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

$!VarSet |ParticipantID|       = '001.01'       # Participant ID for this data set
$!VarSet |OutputFileName|      = 'profiles.dat' # File name

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#            PLOT TITLE SOLUTION INFORMATION
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
$!VarSet |Xvar|     =  1      # Variable number To use for X coordinate (running from fuselage nose To tail)
$!VarSet |Yvar|     =  2      # Variable number To use for Y coordinate (running from symmetry plane To wing tip)
$!VarSet |Zvar|     =  3      # Variable number To use for Z coordinate (running from fuselage keel To crown)
$!VarSet |CPvar|    =  4      # Variable number To use for Cp
$!VarSet |Mvar|     =  5      # Variable number To use for Mach number
$!VarSet |CPRMSvar| =  ''     # Variable number To use for Cp root mean square, If available; use '' If not available
$!VarSet |MRMSvar|  =  ''     # Variable number To use for Mach number root mean square, If available; use '' If not available

$!VarSet |BodyMaps| = '5'     # Zone numbers for the body/fuselage surface ('1-2','1,3,5-6',etc.)... will need To be the same as a wing map If a specIfic body map does not exist
$!VarSet |WingMaps| = '6'     # Zone numbers for the wing surface          ('1-2','1,3,5-6',etc.)
$!VarSet |VolMaps|  = '1'     # Zone numbers for the volume                ('1-2','1,3,5-6',etc.)
$!VarSet |PlotTime| = ''      # NoTE: Use |PlotTime| == '' If no solution time needs To be set.

$!VarSet |Xrev|      =  0      # Set To 1 ONLY If X-axis is running from fuselage tail To nose (negative drag direction)
$!VarSet |Yrev|      =  0      # Set To 1 ONLY If Y-axis is running from wing tip To the symmetry plane
$!VarSet |Zrev|      =  0      # Set To 1 ONLY If Z-axis is running from fuselage crown To keel (negative lIft direction)


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
# ! ! ! E N D   O F   U S E R   I N P U T ! ! !
#
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

$!SetStyleBase FacTory
$!GlobalPaper
  PaperSizeInfo { Letter { Width = 8.5 Height = 11 LeftHardClipOffset = 0.125 RightHardClipOffset = 0.125 TopHardClipOffset = 0.125 BotTomHardClipOffset = 0.125 } }
$!Page
  Name = 'Untitled'
  PaperAttributes
    {
    BackgroundColor = White
    IsTransparent = Yes
    OrientPortrait = No
    ShowGrid = Yes
    ShowRuler = No
    ShowPaper = No
    PaperSize = Letter
    RulerSpacing = OneInch
    PaperGridSpacing = HalfInch
    RegionInWorkArea { X1 = 1  Y1 = 0.25 X2 = 10 Y2 = 8.25 }
    }

$!FrameLayout
  ShowHeader = No
  HeaderColor = Red
  XYPos { X = 1 Y = 0.25 }
  Width = 9
  Height = 8
$!FrameName  = 'Frame 001'

$!PlotType = Cartesian3D

$!ThreeDAxis
  AspectRatioLimit = 25
  BoxAspectRatioLimit = 25
  XDetail { VarNum = |Xvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing = 10 AxisLine { Edge = 2 } }
  YDetail { VarNum = |Yvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing = 10 AxisLine { Edge = 3 } }
  ZDetail { VarNum = |Zvar| ShowAxis = No RangeMin = 0.0 RangeMax = 1.0 GRSpacing =  5 AxisLine { Edge = 2 } }
  AxisMode = XYZDepEndent
  XYDepXToYRatio = 1
  DepXToYRatio = 1
  DepXToZRatio = 1
  EdgeautoReset = Yes
# FrameAxis { Size = 4 XYPos { X = 10 Y = 10 } }

$!GlobalRGB
  RedChannelVar = 3
  GreenChannelVar = 3
  BlueChannelVar = 3
  RangeMin = 0
  RangeMax = 1

$!Interface ZoneBoundingBoxMode = Off

#===================================================================
# Populate variables and standardize variable names
#===================================================================
$!VarSet |TotalZones|   = |NUMZONES|
$!VarSet |FirstProfile| = ( |NUMZONES| + 1 )

$!RenameDataSetVar
  Var = |Xvar|
  Name = 'X'
$!RenameDataSetVar
  Var = |Yvar|
  Name = 'Y'
$!RenameDataSetVar
  Var = |Zvar|
  Name = 'Z'
$!If "|CPvar|" == ""
  $!AlterData Equation  = "{CP} = -999"
  $!VarSet |CPvar|      = "|NUMVARS|"
$!EndIf
$!If "|Mvar|" == ""
  $!AlterData Equation = "{M} = -999"
  $!VarSet |Mvar|      = "|NUMVARS|"
$!EndIf
$!If "|CPRMSvar|" == ""
  $!AlterData Equation  = "{CP_RMS} = -999"
  $!VarSet |CPRMSvar|   = "|NUMVARS|"
$!EndIf
$!If "|MRMSvar|" == ""
  $!AlterData Equation = "{M_RMS} = -999"
  $!VarSet |MRMSvar|      = "|NUMVARS|"
$!EndIf

$!RenameDataSetVar
  Var = |Mvar|
  Name = 'M'
$!RenameDataSetVar
  Var = |CPvar|
  Name = 'CP'
$!RenameDataSetVar
  Var = |MRMSvar|
  Name = 'M_RMS'
$!RenameDataSetVar
  Var = |CPRMSvar|
  Name = 'CP_RMS'


#===================================================================
# Scaling/Translating Dataset (wind tunnel/metric->inches/etc.)
#===================================================================
# Reverse coordinate axes, If required by user input
#-------------------------------------
$!If |Xrev| == 1
  $!AlterData
    Equation = '{X} = -{X}'
$!EndIf
$!If |Yrev| == 1
  $!AlterData
    Equation = '{Y} = -{Y}'
$!EndIf
$!If |Zrev| == 1
  $!AlterData
    Equation = '{Z} = -{Z}'
$!EndIf

# Calculate scaling based on grid coordinate ranges... put tip at y=1156.75, regardless of the underlying loft
#-------------------------------------
$!ActiveFieldMaps = [|WingMaps|]
#$!Pause 'Xrange = (|MINX%.12f|,|MAXX%.12f|)\nYrange = (|MINY%.12f|,|MAXY%.12f|)\nZrange = (|MINZ%.12f|,|MAXZ%.12f|)'
$!VarSet |Scale|  = (|MAXY%.12f|)

$!AlterData
  Equation = '{X} = {X} / |Scale| * 1176.75'
$!AlterData
  Equation = '{Y} = {Y} / |Scale| * 1176.75'
$!AlterData
  Equation = '{Z} = {Z} / |Scale| * 1176.75'
#$!Pause 'Xrange = (|MINX%.12f|,|MAXX%.12f|)\nYrange = (|MINY%.12f|,|MAXY%.12f|)\nZrange = (|MINZ%.12f|,|MAXZ%.12f|)'

# Store for later processing and whatnot
$!AlterData
  Equation = '{XOrig} = {X}'
$!VarSet |XOrigvar| = |NUMVARS|
$!AlterData
  Equation = '{YOrig} = {Y}'
$!VarSet |YOrigvar| = |NUMVARS|
$!AlterData
  Equation = '{ZOrig} = {Z}'
$!VarSet |ZOrigvar| = |NUMVARS|

$!ExtEndedCommand 
  CommandProcessorID = 'CFDAnalyzer4'
  Command = 'Calculate Function=\'GRIDKUNITNormal\' Normalization=\'None\' ValueLocation=\'CellCentered\' CalculateOnDemand=\'T\' UseMorePointsForFEGradientCalculations=\'F\''

$!VarSet |XNormvar| = ( |NUMVARS| - 2 )
$!VarSet |YNormvar| = ( |NUMVARS| - 1 )
$!VarSet |ZNormvar| = ( |NUMVARS|     )


#===================================================================
#Create Macro Function: ProfileCutter... tuned To operate at a constant y station, but can be easily generalized
#===================================================================
$!MACROFUNCTION
  Name = "ProfileCutter"
  $!ActiveFieldMaps = [|WingMaps|]
  
  # Extract surface slice to get the x/c mapping
  $!ExtractSliceToZones
    Origin {X = |1| Y = |2| Z = |3|}
    Normal {X = 0   Y = 1   Z = 0  }
    AutoStrandTransientData = Yes
    CopyCellCenteredValues = No
    ExtractMode = SingleZone
    Resulting1DZoneType = IOrderedIfPossible 
    SliceSource = SurfaceZones
    SliceSurface = YPlanes
    TransientOperationMode = SingleSolutionTime
  $!VarSet |SurfaceSliceZone|  = "|NUMZONES|"

  # Extract volume Slice at the span station
  $!ActiveFieldMaps = [|VolMaps|]
  $!ExtractSliceToZones
    Origin {X = |1| Y = |2| Z = |3|}
    Normal {X = 0   Y = 1   Z = 0  }
    AutoStrandTransientData = Yes
    CopyCellCenteredValues = No
    ExtractMode = SingleZone
    SliceSource = VolumeZones
    SliceSurface = YPlanes
    TransientOperationMode = SingleSolutionTime
  $!VarSet |VolumeSliceZone|  = "|NUMZONES|"

  $!VarSet |EtaStation| = ( |2|/1176.75)

  #===================================================================
  # Shift surface cut To Origin and scale To get the closest index
  #-------------------------------------

  # Get X2... need X2 before finding X1
  $!ActiveFieldMaps = [|SurfaceSliceZone|]
  $!VarSet |X2| = -99999
  $!Loop |MaxI|
    $!GetFieldValue |CurrX|
      Zone  = |SurfaceSliceZone|
      Var   = |Xvar|
      Index = |LOOP|
     
    $!GetFieldValue |CurrY|
      Zone  = |SurfaceSliceZone|
      Var   = |Yvar|
      Index = |LOOP|
     
    $!GetFieldValue |CurrZ|
      Zone  = |SurfaceSliceZone|
      Var   = |Zvar|
      Index = |LOOP|

    # Seeking X2
    $!If |CurrX| > |X2|
      $!VarSet |I2| = |LOOP|
      $!VarSet |X2| = |CurrX|
      $!VarSet |Y2| = |CurrY|
      $!VarSet |Z2| = |CurrZ|
     #$!System "printf 'X2...  %6i: (%.4f,  %.4f,  %.4f)\n' |LOOP| |CurrX| |CurrY| |CurrZ|"
    $!EndIf
  $!EndLoop # Find X2

  # Now find X1
  $!ActiveFieldMaps = [|SurfaceSliceZone|]
  $!VarSet |D1| = -999999
  $!Loop |MaxI|
    $!GetFieldValue |CurrX|
      Zone  = |SurfaceSliceZone|
      Var   = |Xvar|
      Index = |LOOP|
     
    $!GetFieldValue |CurrY|
      Zone  = |SurfaceSliceZone|
      Var   = |Yvar|
      Index = |LOOP|
     
    $!GetFieldValue |CurrZ|
      Zone  = |SurfaceSliceZone|
      Var   = |Zvar|
      Index = |LOOP|
    
    $!VarSet |CurrD| = ( (|X2|-|CurrX|)**2 + (|Y2|-|CurrY|)**2 + (|Z2|-|CurrZ|)**2 )
   #$!System "printf '  CurrD...  %.4f\n' |CurrD|"

    $!If |CurrD| > |D1|
      $!VarSet |I1| = |LOOP|
      $!VarSet |X1| = |CurrX|
      $!VarSet |Y1| = |CurrY|
      $!VarSet |Z1| = |CurrZ|
      $!VarSet |D1| = |CurrD|
     #$!System "printf 'X1...  %6i: (%.4f,  %.4f,  %.4f)    %.1f\n' |LOOP| |CurrX| |CurrY| |CurrZ| |CurrD|"
    $!EndIf
  $!EndLoop # Find X1

 #$!System "printf 'Index %4i: (x1, y1, z1) (%.4f,  %.4f,  %.4f)\n' |I1| |X1| |Y1| |Z1|"
 #$!System "printf 'Index %4i: (x2, y2, z2) (%.4f,  %.4f,  %.4f)\n' |I2| |X2| |Y2| |Z2|"
  
  # Shift LE To Origin
  $!VarSet |DeltaX| = ( |X2| - |X1| )
  $!VarSet |DeltaY| = ( |Y2| - |Y1| )
  $!VarSet |DeltaZ| = ( |Z2| - |Z1| )
  
  $!AlterData  [|SurfaceSliceZone|] Equation = '{X} = {X} - |X1|'
  $!AlterData  [|SurfaceSliceZone|] Equation = '{Y} = {Y} - |Y1|'
  $!AlterData  [|SurfaceSliceZone|] Equation = '{Z} = {Z} - |Z1|'
  

  # Taylor series expansion To estimate arctangent
  $!VarSet |TangentValue| = ( |DeltaZ| / |DeltaX| )
  $!VarSet |AlphaSecRad| = ( |TangentValue| - (|TangentValue|**3)/3 + (|TangentValue|**5)/5 - (|TangentValue|**7)/7 + (|TangentValue|**9)/9 - (|TangentValue|**11)/11 + (|TangentValue|**13)/13 )
  $!VarSet |AlphaSecDeg| = ( |AlphaSecRad| * 180 / 3.14159265 )
  
  $!RotateData 
    ZoneList =  [|SurfaceSliceZone|]
    Angle = |AlphaSecDeg|
    XVar = 'X'
    YVar = 'Y'
    ZVar = 'Z'
    OriginX = 0
    OriginY = 0
    OriginZ = 0
    NormalX = 0
    NormalY = 1
    NormalZ = 0

  $!ActiveFieldMaps = [|SurfaceSliceZone|]
  $!VarSet |X2New|  = ( |MAXX%.12f| )
  
  $!VarSet |C| = ( |X2New|)
  $!VarSet |DeltaZBlank| = ( |C|*0.25 )
  $!AlterData  [|SurfaceSliceZone|] Equation = '{X} = {X} / |C|'
  $!AlterData  [|SurfaceSliceZone|] Equation = '{Y} = {Y} / |C|'
  $!AlterData  [|SurfaceSliceZone|] Equation = '{Z} = {Z} / |C|'
  
  $!FieldMap [1-|NUMZONES|] Scatter{Show = No}
  $!FieldMap [|NUMZONES|]   Mesh   {Show = Yes}
  $!FieldLayers ShowMesh = Yes

  

  #===================================================================
  # Get coordinates and info at each target x/c value
  #-------------------------------------
  $!If '|4|' == 'auto'
    $!VarSet |NumXoCs| = 1#21
  $!Else
    # Hand work
    $!VarSet |NumXoCs| = 1
  $!EndIf

  $!Loop |NumXoCs|
    $!If '|4|' == 'auto'
      $!VarSet |LoopM1|    = ( |LOOP| - 1 )
      $!VarSet |XoCTarget| = ( |LoopM1| / 20 )
      $!If |LoopM1| == 20
        $!VarSet |XoCTarget| = 0.995
      $!EndIf
    $!Else
      # Hand work
      $!VarSet |XoCTarget| = ( "|4|" )
    $!EndIf
    
    $!VarSet |XoCTarget| = 0.10
    
    # Go through each index... get normals and store If it's the nearest To target x/c
    $!VarSet |DXoCus| =  999999
    $!VarSet |DXoCls| =  999999
    $!Loop |MaxI| 
      $!GetFieldValue |CurrX|
        Zone  = |SurfaceSliceZone|
        Var   = |Xvar|
        Index = |LOOP|
     
      $!GetFieldValue |CurrY|
        Zone  = |SurfaceSliceZone|
        Var   = |Yvar|
        Index = |LOOP|
     
      $!GetFieldValue |CurrZ|
        Zone  = |SurfaceSliceZone|
        Var   = |Zvar|
        Index = |LOOP|
      
      # Find the upper surface
      # This includes some hand modIfications for the CRM airfoil To account for
      # the reflexed lower surface
      $!VarSet |ZToBlank| = 0.00
      $!If |XoCTarget| > 0.80
        $!VarSet |ZToBlank| = 0.008
      $!EndIf
      
      $!If |CurrZ| >= |ZToBlank|
        # Upper surface... how close To the target x/c?
        $!VarSet |DeltaNow| = ( abs(|CurrX|-|XoCTarget|) )
        $!If |DeltaNow| < |DXoCus|
          $!VarSet |I3|     = |LOOP|
          $!VarSet |X3|     = |CurrX|
          $!VarSet |Y3|     = |CurrY|
          $!VarSet |Z3|     = |CurrZ|
          $!VarSet |DXoCus|   = |DeltaNow|
         #$!System "printf 'Upper x/c %.2f...  Distance of %.4f... Index %3i   (%.4f, %.4f, %.4f)\n' |XoCTarget| |DeltaNow| |I3| |X3| |Y3| |Z3|"
        $!EndIf # Closer?
      $!EndIf # Upper Surface?

      $!If |CurrZ| < |ZToBlank|
        # Lower surface... how close To the target x/c?
        $!VarSet |DeltaNow| = ( abs(|CurrX|-|XoCTarget|) )
        $!If |DeltaNow| < |DXoCls|
          $!VarSet |I4|     = |LOOP|
          $!VarSet |X4|     = |CurrX|
          $!VarSet |Y4|     = |CurrY|
          $!VarSet |Z4|     = |CurrZ|
          $!VarSet |DXoCls|   = |DeltaNow|
         #$!System "printf 'Lower x/c %.2f...  Distance of %.4f... Index %3i   (%.4f, %.4f, %.4f)\n' |XoCTarget| |DeltaNow| |I4| |X4| |Y4| |Z4|"
        $!EndIf # Closer?
      $!EndIf # Lower surface?
      
      # Careful treatment if the leading edge
      $!If |LOOP| == 1
        $!VarSet |I4| = |I3|
      $!EndIf
    $!EndLoop # Checking each point index to get index of closest point
      
    # Show airfoil profile with key points
    $!If 1 == 1
      $!CreateNewFrame XYPos { X = 1.0 Y = 6.25 } Width = 9 Height = 2.0
      $!FrameControl ActivateByNumber
        Frame = 2
      $!FrameLayout ShowHeader = No
      $!PlotType = XYLine
      
      $!DeleteLineMaps 
      $!CreateLineMap 
      $!LineMap [1]  Name = 'Airfoil'
      $!LineMap [1]  Assign{XAxisVar = 'X' YAxisVar = 'Z' Zone = |SurfaceSliceZone|}
      $!LineMap [1]  Lines{LineThickness = 1.2}
      $!LineMap [1]  Symbols{Show = No Size = 2 FillMode = UseLineColor}
      $!XYLineAxis ViewportPosition{X1 = 10 X2 = 95 Y1 = 10 Y2 = 97 }
    
      $!XYLineAxis XDetail 1 {RangeMin = -0.01 RangeMax = 1.01 Gridlines{Show = Yes} Title{ShowOnAxisLine = No} TickLabel{TextShape{SizeUnits = Point Height = 14}} Gridlines{LinePattern = Solid} Gridlines{PatternLength = 0.2} }
      $!XYLineAxis YDetail 1 {RangeMin = -0.07 RangeMax = 0.07 Gridlines{Show = Yes} Title{ShowOnAxisLine = No} TickLabel{TextShape{SizeUnits = Point Height = 14}} Gridlines{LinePattern = Solid} Gridlines{PatternLength = 0.2} }
      
      $!CreateLineMap 
      $!DuplicateLineMap 
        SourceMap = 1
        DestinationMap = 2
      $!CreateLineMap 
      $!DuplicateLineMap 
        SourceMap = 1
        DestinationMap = 3
      $!DuplicateLineMap 
        SourceMap = 1
        DestinationMap = 4
      $!DuplicateLineMap 
        SourceMap = 1
        DestinationMap = 5
    
      $!LineMap [2]  Symbols{Show = Yes Color = Green SymbolShape{GeomShape = Square}}
      $!LineMap [3]  Symbols{Show = Yes Color = Blue  SymbolShape{GeomShape = Diamond}}
      $!LineMap [4]  Symbols{Show = Yes Color = Black SymbolShape{GeomShape = Del}}
      $!LineMap [5]  Symbols{Show = Yes Color = Black SymbolShape{GeomShape = Grad}}
    
      $!LineMap [2]  Indices{IRange{Min = |I1| Max = |I1|}}
      $!LineMap [3]  Indices{IRange{Min = |I2| Max = |I2|}}
      $!LineMap [4]  Indices{IRange{Min = |I3| Max = |I3|}}
      $!LineMap [5]  Indices{IRange{Min = |I4| Max = |I4|}}
    
      $!ActiveLineMaps = [1-|NUMLINEMAPS|]
      $!LinePlotLayers ShowLines = Yes
      $!LinePlotLayers ShowSymbols = Yes
    
      $!AttachText 
        AnchorPos { X = 99 Y = 99}
        TextShape { IsBold = No Height = 12 }
        Box { BoxType = Filled }
        Anchor = HeadRight
        Text = 'US: |X3|'
      $!AttachText 
        AnchorPos { X = 99 Y =   1}
        TextShape { IsBold = No Height = 12 }
        Box { BoxType = Filled }
        Anchor = Right
        Text = 'LS: |X4|'
      
      $!RedrawAll
      $!Pause 'Key points found'
      $!FrameControl DeleteActive
    $!EndIf # Show key points or not

    # Get full-scale coordinates and normals
    $!GetFieldValue |X3orig|
      Zone  = |SurfaceSliceZone|
      Var   = |XOrigvar|
      Index = |I3|

    $!GetFieldValue |Y3orig|
      Zone  = |SurfaceSliceZone|
      Var   = |YOrigvar|
      Index = |I3|

    $!GetFieldValue |Z3orig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZOrigvar|
      Index = |I3|

    $!GetFieldValue |X3normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |XNormvar|
      Index = |I3|

    $!GetFieldValue |Y3normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |YNormvar|
      Index = |I3|

    $!GetFieldValue |Z3normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZNormvar|
      Index = |I3|

    # X4
    $!GetFieldValue |X4orig|
      Zone  = |SurfaceSliceZone|
      Var   = |XOrigvar|
      Index = |I4|

    $!GetFieldValue |Y4orig|
      Zone  = |SurfaceSliceZone|
      Var   = |YOrigvar|
      Index = |I4|

    $!GetFieldValue |Z4orig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZOrigvar|
      Index = |I4|

    $!GetFieldValue |X4normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |XNormvar|
      Index = |I4|

    $!GetFieldValue |Y4normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |YNormvar|
      Index = |I4|

    $!GetFieldValue |Z4normorig|
      Zone  = |SurfaceSliceZone|
      Var   = |ZNormvar|
      Index = |I4|
  
  
    #===================================================================
    # Extract upper surface profile
    #-------------------------------------
    $!ActiveFieldMaps = [|VolumeSliceZone|]
    $!RedrawAll
    
    $!VarSet |ZBlank1| = ( |Z3Orig| +     |DeltaZBlank| )
    $!VarSet |ZBlank2| = ( |Z3Orig| - 0.1*|DeltaZBlank| )
    $!Blanking Value{Include = Yes}
    $!Blanking Value{Constraint 1 {Include = Yes VarA = 'Z' Include = Yes RelOp = GreaterThan ValueCutoff = |ZBlank1|}}
    $!Blanking Value{Constraint 2 {Include = Yes VarA = 'Z' Include = Yes RelOp = LessThan    ValueCutoff = |ZBlank2|}}

   #$!System "printf 'Target: (%.4f,  %.4f,  %.4f) and normal (%.4f,  %.4f,  %.4f)\n' |X3Orig| |Y3Orig| |Z3Orig| |X3NormOrig| |Y3NormOrig| |Z3NormOrig|"
    
    # Rotate the vector 90 degrees around y to get the plane-normal vector... 
    # So a plane with equation (a,b,c) turns into a normal of (c,b,-a)
    $!VarSet |XNormOut| = (      |Z3NormOrig| )
    $!VarSet |YNormOut| = (      |Y3NormOrig| ) # Not actually used, because I extract in the x-z plane
    $!VarSet |ZNormOut| = ( -1 * |X3NormOrig| )

    $!SliceLayers Show = Yes
    $!SliceAttributes 1  SliceSource = SurfaceZones
    $!SliceAttributes 1  EdgeLayer{Show = Yes}
    $!SliceAttributes 1  SliceSurface = Arbitrary
    $!SliceAttributes 1  PrimaryPosition{X = |X3Orig|   Y = |Y3Orig| Z = |Z3Orig|  }
    $!SliceAttributes 1  Normal{         X = |XNormOut| Y = 0        Z = |ZNormOut|}
    $!RedrawAll 
    $!ExtractSlices 
      Group = 1
      TransientOperationMode = SingleSolutionTime
    
    # Height from surface
    $!AlterData [|NUMZONES|] Equation = "{H}   = sqrt( ({X}-|X3Orig|)**2 + ({Y}-|Y3Orig|)**2 + ({Z}-|Z3Orig|)**2  )"
    $!AlterData [|NUMZONES|] Equation = "{HoC} = {H} / |C|"
    
    $!RenameDataSetZone
      Zone = |NUMZONES|
      Name = '|ParticipantID| - eta=|EtaStation| - x/c=|XoCTarget| - Upper Surface'
      
      
    #===================================================================
    # Extract lower surface profile
    #-------------------------------------
    $!ActiveFieldMaps = [|VolumeSliceZone|]
    $!RedrawAll
    
    $!VarSet |ZBlank1| = ( |Z4Orig| -     |DeltaZBlank| )
    $!VarSet |ZBlank2| = ( |Z4Orig| + 0.1*|DeltaZBlank| )
    $!Blanking Value{Include = Yes}
    $!Blanking Value{Constraint 1 {Include = Yes VarA = 'Z' Include = Yes RelOp = LessThan    ValueCutoff = |ZBlank1|}}
    $!Blanking Value{Constraint 2 {Include = Yes VarA = 'Z' Include = Yes RelOp = GreaterThan ValueCutoff = |ZBlank2|}}

   #$!System "printf 'Target: (%.4f,  %.4f,  %.4f) and normal (%.4f,  %.4f,  %.4f)\n' |X4Orig| |Y4Orig| |Z4Orig| |X4NormOrig| |Y4NormOrig| |Z4NormOrig|"
    
    # Rotate the vector 90 degrees around y to get the plane-normal vector... 
    # So a plane with equation (a,b,c) turns into a normal of (c,b,-a)
    $!VarSet |XNormOut| = (      |Z4NormOrig| )
    $!VarSet |YNormOut| = (      |Y4NormOrig| ) # Not actually used, because I extract in the x-z plane
    $!VarSet |ZNormOut| = ( -1 * |X4NormOrig| )

    $!SliceLayers Show = Yes
    $!SliceAttributes 1  SliceSource = SurfaceZones
    $!SliceAttributes 1  EdgeLayer{Show = Yes}
    $!SliceAttributes 1  SliceSurface = Arbitrary
    $!SliceAttributes 1  PrimaryPosition{X = |X4Orig|   Y = |Y4Orig| Z = |Z4Orig|  }
    $!SliceAttributes 1  Normal{         X = |XNormOut| Y = 0        Z = |ZNormOut|}
    $!RedrawAll 
    $!ExtractSlices 
      Group = 1
      TransientOperationMode = SingleSolutionTime
    
    # Height from surface
    $!AlterData [|NUMZONES|] Equation = "{H}   = sqrt( ({X}-|X4Orig|)**2 + ({Y}-|Y4Orig|)**2 + ({Z}-|Z4Orig|)**2  )"
    $!AlterData [|NUMZONES|] Equation = "{HoC} = {H} / |C|"
    
    $!RenameDataSetZone
      Zone = |NUMZONES|
      Name = '|ParticipantID| - eta=|EtaStation| - x/c=|XoCTarget| - Upper Surface'      
      
    $!ActiveFieldMaps = [|WingMaps|,|FirstProfile|-|NUMZONES|]
  $!EndLoop # |NumXoCs|    going through each x/c
  
  $!DeleteZones  [|SurfaceSliceZone|,|VolumeSliceZone|]
$!EndMacroFunction


#===================================================================
$!If "|PlotTime|" != ""
  $!GlobalTime
    SolutionTime = |PlotTime|
$!EndIf

$!FieldMap  [|BodyMaps|,|WingMaps|]
  Mesh { Show = No Color = Black LineThickness = 0.1 }
  ConTour
    {
    ConTourType = BothLinesAndFlood
    LineConTourGroup = 1
    FloodColoring = Group1
    Color = CusTom2
    UseLightingEffect = Yes
    }
  VecTor { Color = Black }
  Scatter { Color = Black }
  Shade { Color = CusTom2 }
  EdgeLayer { Show = No Color = Black LineThickness = 0.1 }
  Points { PointsToPlot = SurfaceNodes }
  Surfaces { SurfacesToPlot = KPlanes IRange { Max = 1 } }
  VolumeMode { VolumeObjectsToPlot { ShowIsosurfaces = No ShowSlices = No ShowStreamtraces = No } }
  Effects { LightingEffect = Gouraud }

$!FieldLayers
  ShowMesh = Yes
  ShowContour = No
  ShowShade = Yes
  ShowEdge = No
$!StreamTraceLayers
  Show = No

$!View Fit
$!FrameControl ActivateByNumber
  Frame = 1

$!GlobalThreeD
  AxisScaleFact { X = 1 Y = 1 Z = 1 }
  LightSource
    {
    XYZDirection{ X = 0.1 Y = -0.1 Z = 0.95 }
    Intensity = 75
    BackgroundLight = 25
    IncludeSpecular = Yes
    SpecularIntensity = 40
    SpecularShininess = 60
    }
  LineLIftFraction = 0.2
  SymbolLIftFraction = 0.6
  VecTorLIftFraction = 0.7
  NearPlaneFraction = 0.1

$!DrawGraphics True

$!FieldLayers ShowMesh = No
$!FieldLayers ShowContour = No
$!FieldLayers ShowShade = Yes
$!FieldLayers ShowVector = No
$!FieldLayers ShowEdge = No
$!FieldLayers ShowScatter = No
$!FieldLayers UseTranslucency = No
$!SliceLayers Show = No
$!StreamTraceLayers Show = No
$!StreamAttributes AddArrows = No





#===================================================================
# Create Sectional Cuts
#-------------------------------------
# WING SECTION  1: ETA = 0.1050, CHORD=466.466
#$!RunMacroFunction "ProfileCutter" (1342.440, 581.148, 188.658, '0.3040')


# Section E (eta = 0.5): x/c=0.3040 and 0.7903
# Section F (eta = 0.6): x/c=0.3097 and 0.7677



#####...# WING SECTION  1: ETA = 0.1050, CHORD=466.466
#####...$!RunMacroFunction "ProfileCutter" ( 993.728, 121.459, 176.053, 'auto')
#####...
#####...# WING SECTION  2: ETA = 0.1150, CHORD=459.571
#####...$!RunMacroFunction "ProfileCutter" (1002.168, 133.026, 176.306, 'auto')
#####...
#####...# WING SECTION  3: ETA = 0.1250, CHORD=452.687
#####...$!RunMacroFunction "ProfileCutter" (1010.656, 144.594, 176.539, 'auto')
#####...
#####...# WING SECTION  4: ETA = 0.1306, CHORD=448.836
#####...$!RunMacroFunction "ProfileCutter" (1015.435, 151.074, 176.659, 'auto')
#####...
#####...# WING SECTION  5: ETA = 0.2009, CHORD=400.743
#####...$!RunMacroFunction "ProfileCutter" (1076.873, 232.444, 177.509, 'auto')
#####...
#####...# WING SECTION  6: ETA = 0.2828, CHORD=344.991
#####...$!RunMacroFunction "ProfileCutter" (1148.974, 327.074, 178.606, 'auto')
#####...
#####...# WING SECTION  7: ETA = 0.3430, CHORD=304.101
#####...$!RunMacroFunction "ProfileCutter" (1202.038, 396.765, 180.222, 'auto')


# WING SECTION  8: ETA = 0.3700, CHORD=285.806
$!RunMacroFunction "ProfileCutter" (1225.822, 427.998, 181.162, 'auto')


#####...# WING SECTION  9: ETA = 0.3971, CHORD=278.111
#####...$!RunMacroFunction "ProfileCutter" (1249.711, 459.370, 182.250, 'auto')
#####...
#####...# WING SECTION 10: ETA = 0.5024, CHORD=248.312
#####...$!RunMacroFunction "ProfileCutter" (1342.440, 581.148, 188.658, 'auto')
#####...
#####...# WING SECTION 11: ETA = 0.6028, CHORD=219.904
#####...$!RunMacroFunction "ProfileCutter" (1430.914, 697.333, 198.060, 'auto')
#####...
#####...# WING SECTION 12: ETA = 0.7268, CHORD=184.844
#####...$!RunMacroFunction "ProfileCutter" (1540.091, 840.704, 213.659, 'auto')
#####...
#####...# WING SECTION 13: ETA = 0.8456, CHORD=151.235
#####...$!RunMacroFunction "ProfileCutter" (1644.738, 978.148, 233.317, 'auto')
#####...
#####...# WING SECTION 14: ETA = 0.9500, CHORD=121.735
#####...$!RunMacroFunction "ProfileCutter" (1736.708,1098.926, 253.727, 'auto')
#####...
#####...# WING SECTION 15: ETA = 0.9700, CHORD=116.095
#####...$!RunMacroFunction "ProfileCutter" (1754.313,1122.048, 257.777, 'auto')
#####...
#####...# WING SECTION 16: ETA = 0.9900, CHORD=110.452
#####...$!RunMacroFunction "ProfileCutter" (1771.927,1145.183, 261.823, 'auto')
#####...
#####...
#####...


#===================================================================
# Visualize Sectional Cuts
#-------------------------------------
#$!FieldMAP [|NUMZONES1| - |NUMZONES| ] MESH{Show = Yes Color = Green LineThickness = 0.80 }
#$!FieldLayers ShowMesh = Yes

$!Blanking Value{Include = No}
$!ActiveFieldMaps = [|WingMaps|,|FirstProfile|-|NUMZONES|]

#===================================================================
$!WriteDataSet  "|ParticipantID|-|OutputFileName|"
  IncludeText = No
  IncludeGeom = No
  IncludeCusTomLabels = No
  IncludeDataShareLinkage = Yes
  ZoneList =  [|FirstProfile| - |NUMZONES|]
  VarList =  ['X','Y','Z','CP','M','CP_RMS','M_RMS','H','HoC']
  Binary = No
  UsePointFormat = Yes
  Precision = 12
  TecplotVersionToWrite = TecplotCurrent
