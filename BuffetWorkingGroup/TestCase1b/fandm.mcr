#!MC 1410
$!DrawGraphics True


######################################################
# Create Macro Functions
######################################################
$!MacroFunction
  NAME = "PngLooper"
  $!ReadStyleSheet  "sty/fandm/|1|.sty"
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
  $!ExportSetup ExportFormat = PNG
  $!ExportSetup ExportFName = "png/fandm/|1|.png"
  $!Export 
    ExportRegion = AllFrames
$!EndMacroFunction


$!MacroFunction
  NAME = "EpsLooper"
  $!ReadStyleSheet  "sty/fandm/|1|.sty"
    IncludePlotStyle = Yes
    IncludeText = Yes
    IncludeGeom = Yes
    IncludeAuxData = Yes
    IncludeStreamPositions = Yes
    IncludeContourLevels = Yes
    Merge = No
    IncludeFrameSizeAndPosition = No

  $!ExportSetup ExportFormat = EPS
  $!ExportSetup ExportFName = "eps/fandm/|1|.eps"
  $!Export 
    ExportRegion = AllFrames
$!EndMacroFunction



######################################################
# Call Macro
######################################################
$!RunMacroFunction "PngLooper" ('cd-Nfac-case1a_SA_variants-vs-SST_AoA150',2400)
$!RunMacroFunction "PngLooper" ('cd-Nfac-case1a_SA_variants-vs-SST_AoA310',2400)
$!RunMacroFunction "PngLooper" ('cd-Nfac-case1a_SA-vs-SST_AoA150',2400)
$!RunMacroFunction "PngLooper" ('cd-Nfac-case1a_SA-vs-SST_AoA310',2400)
$!RunMacroFunction "PngLooper" ('cd-Nfac-case1a_SA-vs-SST_AoA390',2400)
$!RunMacroFunction "PngLooper" ('cl-alpha-case1a',2400)
$!RunMacroFunction "PngLooper" ('cl-alpha_case1a-vs-case1b',2400)
$!RunMacroFunction "PngLooper" ('cl-alpha-case1b',2400)
$!RunMacroFunction "PngLooper" ('cl-cd-case1a',2400)
$!RunMacroFunction "PngLooper" ('cl-cd_case1a-vs-case1b',2400)
$!RunMacroFunction "PngLooper" ('cl-cd-case1b',2400)
$!RunMacroFunction "PngLooper" ('cl-cm-case1a',2400)
$!RunMacroFunction "PngLooper" ('cl-cm_case1a-vs-case1b',2400)
$!RunMacroFunction "PngLooper" ('cl-cm-case1b',2400)
$!RunMacroFunction "PngLooper" ('cl-Nfac-case1a_SA_variants-vs-SST_AoA150',2400)
$!RunMacroFunction "PngLooper" ('cl-Nfac-case1a_SA_variants-vs-SST_AoA310',2400)
$!RunMacroFunction "PngLooper" ('cl-Nfac-case1a_SA-vs-SST_AoA150',2400)
$!RunMacroFunction "PngLooper" ('cl-Nfac-case1a_SA-vs-SST_AoA310',2400)
$!RunMacroFunction "PngLooper" ('cl-Nfac-case1a_SA-vs-SST_AoA390',2400)
$!RunMacroFunction "PngLooper" ('cm-Nfac-case1a_SA_variants-vs-SST_AoA150',2400)
$!RunMacroFunction "PngLooper" ('cm-Nfac-case1a_SA_variants-vs-SST_AoA310',2400)
$!RunMacroFunction "PngLooper" ('cm-Nfac-case1a_SA-vs-SST_AoA150',2400)
$!RunMacroFunction "PngLooper" ('cm-Nfac-case1a_SA-vs-SST_AoA310',2400)
$!RunMacroFunction "PngLooper" ('cm-Nfac-case1a_SA-vs-SST_AoA390',2400)

$!RunMacroFunction "EpsLooper" ('cd-Nfac-case1a_SA_variants-vs-SST_AoA150')
$!RunMacroFunction "EpsLooper" ('cd-Nfac-case1a_SA_variants-vs-SST_AoA310')
$!RunMacroFunction "EpsLooper" ('cd-Nfac-case1a_SA-vs-SST_AoA150')
$!RunMacroFunction "EpsLooper" ('cd-Nfac-case1a_SA-vs-SST_AoA310')
$!RunMacroFunction "EpsLooper" ('cd-Nfac-case1a_SA-vs-SST_AoA390')
$!RunMacroFunction "EpsLooper" ('cl-alpha-case1a')
$!RunMacroFunction "EpsLooper" ('cl-alpha_case1a-vs-case1b')
$!RunMacroFunction "EpsLooper" ('cl-alpha-case1b')
$!RunMacroFunction "EpsLooper" ('cl-cd-case1a')
$!RunMacroFunction "EpsLooper" ('cl-cd_case1a-vs-case1b')
$!RunMacroFunction "EpsLooper" ('cl-cd-case1b')
$!RunMacroFunction "EpsLooper" ('cl-cm-case1a')
$!RunMacroFunction "EpsLooper" ('cl-cm_case1a-vs-case1b')
$!RunMacroFunction "EpsLooper" ('cl-cm-case1b')
$!RunMacroFunction "EpsLooper" ('cl-Nfac-case1a_SA_variants-vs-SST_AoA150')
$!RunMacroFunction "EpsLooper" ('cl-Nfac-case1a_SA_variants-vs-SST_AoA310')
$!RunMacroFunction "EpsLooper" ('cl-Nfac-case1a_SA-vs-SST_AoA150')
$!RunMacroFunction "EpsLooper" ('cl-Nfac-case1a_SA-vs-SST_AoA310')
$!RunMacroFunction "EpsLooper" ('cl-Nfac-case1a_SA-vs-SST_AoA390')
$!RunMacroFunction "EpsLooper" ('cm-Nfac-case1a_SA_variants-vs-SST_AoA150')
$!RunMacroFunction "EpsLooper" ('cm-Nfac-case1a_SA_variants-vs-SST_AoA310')
$!RunMacroFunction "EpsLooper" ('cm-Nfac-case1a_SA-vs-SST_AoA150')
$!RunMacroFunction "EpsLooper" ('cm-Nfac-case1a_SA-vs-SST_AoA310')
$!RunMacroFunction "EpsLooper" ('cm-Nfac-case1a_SA-vs-SST_AoA390')
