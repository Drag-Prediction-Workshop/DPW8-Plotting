#!MC 1410
$!DrawGraphics True


######################################################
# Create Macro Functions
######################################################
$!MacroFunction
  NAME = "PngLooper"
  $!ReadStyleSheet  "sty/cuts/outlier/|1|.sty"
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
  $!ExportSetup ExportFName = "png/cuts/outlier/|1|.png"
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
$!RunMacroFunction "PngLooper" ('outlier1',2400)
$!RunMacroFunction "PngLooper" ('outlier2',2400)
$!RunMacroFunction "PngLooper" ('outlier3',2400)
$!RunMacroFunction "PngLooper" ('outlier4',2400)
$!RunMacroFunction "PngLooper" ('outlier5',2400)
$!RunMacroFunction "PngLooper" ('outlier6',2400)
$!RunMacroFunction "PngLooper" ('outlier7',2400)
$!RunMacroFunction "PngLooper" ('outlier8',2400)
$!RunMacroFunction "PngLooper" ('outlier9',2400)
$!RunMacroFunction "PngLooper" ('outlier10',2400)
$!RunMacroFunction "PngLooper" ('outlier11',2400)
$!RunMacroFunction "PngLooper" ('outlier12',2400)
$!RunMacroFunction "PngLooper" ('outlier13',2400)
$!RunMacroFunction "PngLooper" ('outlier14',2400)
$!RunMacroFunction "PngLooper" ('outlier15',2400)
$!RunMacroFunction "PngLooper" ('outlier16',2400)
$!RunMacroFunction "PngLooper" ('outlier17',2400)
$!RunMacroFunction "PngLooper" ('outlier18',2400)
$!RunMacroFunction "PngLooper" ('outlier19',2400)
$!RunMacroFunction "PngLooper" ('outlier20',2400)

$!RunMacroFunction "PngLooper" ('outlier22',2400)
$!RunMacroFunction "PngLooper" ('outlier23',2400)
$!RunMacroFunction "PngLooper" ('outlier24',2400)
$!RunMacroFunction "PngLooper" ('outlier25',2400)
$!RunMacroFunction "PngLooper" ('outlier26',2400)
$!RunMacroFunction "PngLooper" ('outlier27',2400)





#$!RunMacroFunction "EpsLooper" ('cp')
#$!RunMacroFunction "EpsLooper" ('cprms')
