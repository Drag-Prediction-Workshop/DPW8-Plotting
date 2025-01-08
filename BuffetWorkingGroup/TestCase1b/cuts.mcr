#!MC 1410
$!DrawGraphics True


######################################################
# Create Macro Functions
######################################################
$!MacroFunction
  NAME = "PngLooper"
  $!ReadStyleSheet  "sty/cuts/|1|.sty"
    IncludePlotStyle = Yes
    IncludeText = Yes
    IncludeGeom = Yes
    IncludeAuxData = Yes
    IncludeStreamPositions = Yes
    IncludeContourLevels = Yes
    Merge = No
    IncludeFrameSizeAndPosition = No

  $!PrintSetup Palette = Color
  $!ExportSetup ImageWidth = |2|
  $!ExportSetup UseSuperSampleAntiAliasing = Yes
  $!ExportSetup ExportFName = "png/cuts/|1|.png"
  $!Export 
    ExportRegion = AllFrames
$!EndMacroFunction


$!MacroFunction
  NAME = "EpsLooper"
  $!ReadStyleSheet  "sty/cuts/|1|.sty"
    IncludePlotStyle = Yes
    IncludeText = Yes
    IncludeGeom = Yes
    IncludeAuxData = Yes
    IncludeStreamPositions = Yes
    IncludeContourLevels = Yes
    Merge = No
    IncludeFrameSizeAndPosition = No

  $!ExportSetup ExportFormat = EPS
  $!ExportSetup ExportFName = "eps/cuts/|1|.eps"
  $!Export 
    ExportRegion = AllFrames
$!EndMacroFunction



######################################################
# Call Macro
######################################################
$!RunMacroFunction "PngLooper" ('cp',2400)
$!RunMacroFunction "PngLooper" ('cprms',2400)

$!RunMacroFunction "EpsLooper" ('cp')
$!RunMacroFunction "EpsLooper" ('cprms')
