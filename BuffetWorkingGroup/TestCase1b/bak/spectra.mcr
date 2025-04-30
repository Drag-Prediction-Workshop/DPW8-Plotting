#!MC 1410
$!DrawGraphics True


######################################################
# Create Macro Functions
######################################################
$!MacroFunction
  NAME = "PngLooper"
  $!ReadStyleSheet  "sty/spectra/|1|.sty"
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
  $!ExportSetup ExportFName = "png/spectra/|1|.png"
  $!Export 
    ExportRegion = AllFrames
$!EndMacroFunction


$!MacroFunction
  NAME = "EpsLooper"
  $!ReadStyleSheet  "sty/spectra/|1|.sty"
    IncludePlotStyle = Yes
    IncludeText = Yes
    IncludeGeom = Yes
    IncludeAuxData = Yes
    IncludeStreamPositions = Yes
    IncludeContourLevels = Yes
    Merge = No
    IncludeFrameSizeAndPosition = No

  $!ExportSetup ExportFormat = EPS
  $!ExportSetup ExportFName = "eps/spectra/|1|.eps"
  $!Export 
    ExportRegion = AllFrames
$!EndMacroFunction



######################################################
# Call Macro
######################################################
$!RunMacroFunction "PngLooper" ('allData',2400)
$!RunMacroFunction "PngLooper" ('tunnel',2400)

$!RunMacroFunction "EpsLooper" ('allData')
$!RunMacroFunction "EpsLooper" ('tunnel')
