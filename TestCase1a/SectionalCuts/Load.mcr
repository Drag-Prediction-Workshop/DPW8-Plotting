#!MC 1410

#-------------------------------------------------
$!Varset |Z01| = (0 + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/01_CFD++_CadenceUnstructured_SA-RC-QCR/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = New
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"X" "Y" "Z" "CP" "CF" "CFX" "CFY" "CFZ" "X/C";"XoC"'

$!ActiveLineMaps -= [1-|NumLineMaps|]
$!DeleteLineMaps  [1-|NumLineMaps|]

$!Varset |Z| = |Z01|
$!CreateLineMap
#$!LineMap [|NumLineMaps|] Name = '&ZN&'
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z02| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/02_CFD++_CadenceUnstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z02|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z03| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/03_CFD++_CadenceUnstructured_SST/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z03|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z04| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/04_CFD++_CadenceStructured_SA-RC-QCR/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z04|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z05| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/05_CFD++_HeldenMesh_SA-RC-QCR/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z05|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z06| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/01_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z06|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z07| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/02_SAR/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z07|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z08| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/03_SAQCR/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z08|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z09| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/01_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z09|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z10| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/02_SARC_CC/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z10|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z11| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/006/01_LociChem/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z11|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z12| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/01_FaSTAR_Cadence-Structured_SA-noft2/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z12|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z13| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/02_FaSTAR_Cadence-Structured_SA-noft2-R-QCR2000/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z13|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z14| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/03_FaSTAR_Cadence-Structured_SST-2003sust/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z14|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z15| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/008_Metacomp/01_CFD++_Cadence_Structured/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z15|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z16| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/01_elsA_Cadence-structured_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z16|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

$!Varset |Z17| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/02_elsA_Cadence-unstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z17|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

$!Varset |Z18| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/03_elsA_Helden-unstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z18|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

$!Varset |Z19| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/04_elsA_ONERA-Structured_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z19|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

$!Varset |Z20| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/05_elsA_Cadence-structured_kwSST/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z20|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

$!Varset |Z21| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/06_elsA_Cadence-unstructured_kwSST/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z21|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

$!Varset |Z22| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/07_elsA_Helden-unstructured_kwSST/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z22|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

$!Varset |Z23| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/08_elsA_ONERA-structured_kwSST/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z23|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z24| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/011_HEMLAB/01_Structured/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z24|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z25| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/011_HEMLAB/02_Adaptive/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z25|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z26| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/014_IISc/01_SU2_Symmetric_BC/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/014_IISc/01_SU2_Symmetric_BC/DPW8-AePW4_SectionalCuts_v5.dat-sorted"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z26|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z27| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/014_IISc/02_SU2_Periodic_BC/DPW8-AePW4_SectionalCuts_v5.dat"'
#$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/014_IISc/02_SU2_Periodic_BC/DPW8-AePW4_SectionalCuts_v5.dat-sorted"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z27|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}

#-------------------------------------------------
$!Varset |Z28| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/01_FUN3D/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z28|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z29| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/02_FUN3D/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z29|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z30| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/01_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z30|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z31| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/02_SST-V-2003/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z31|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z32| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA/DPW8-AePW4_SectionalCuts_v5.dat-sorted"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z32|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
# 020.02: Sorting does not work because there is not enough precision
$!Varset |Z33| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_SectionalCuts_v5.dat-sorted"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z33|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z34| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg/DPW8-AePW4_SectionalCuts_v5.dat-sorted"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z34|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z35| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg/DPW8-AePW4_SectionalCuts_v5.dat-sorted"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z35|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z36| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/023_PolytechniqueMontreal/01_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z36|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z37| = (|NUMZONES| + 1)
# File won't load
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/024_UniversityofLiverpool/01_SAneg/DPW8-AePW4_SectionalCuts_v5.dat"'
#$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z37|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z38| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/025_TLGAerospace/01_STARCCM_CadenceUnstr_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z38|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z39| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/01_SA/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z39|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z40| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/02_SA_comp/DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z40|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z41| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/027_RMIT/01_SST/DPW8-AePW4_SurfaceCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/027_RMIT/01_SST/DPW8-AePW4_SurfaceCuts_v5.dat-sorted"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z41|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z42| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/027_RMIT/02_SA/DPW8-AePW4_SurfaceCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/027_RMIT/02_SA/DPW8-AePW4_SurfaceCuts_v5.dat-sorted"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z42|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z43| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/01_SANS_refine/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z43|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!Varset |Z44| = (|NUMZONES| + 1)
#$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/02_SANS_Metris/DPW8-AePW4_SectionalCuts_v5.dat"'
$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z44|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

#-------------------------------------------------
$!IF 0 == 1
$!Varset |Z45| = (|NUMZONES| + 1)
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1b/010_Boeing/010_DPW8-AePW4_UnsteadySectionalCuts_v5.dat"'
#$!ReadDataSet  '"|MACROFILEPATH|/000_00_DPW8-AePW4_SectionalCuts_v5.dat"'
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = |Z45|
$!CreateLineMap
$!LineMap [|NumLineMaps|] Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|NumLineMaps|] Assign{Zone = |Z|}
#$!LineMap [|NumLineMaps|] Assign{ShowInLegend = Never}
$!ActiveLineMaps += [|NumLineMaps|]

#---------------------
# 010.01 Assign CP_AVG and CF_AVG from Unsteady Cuts datafile to CP/CF from Steady Cuts datafile
$!AlterData  [|Z45|-|NUMZONES|]
  IgnoreDivideByZero = Yes
  Equation = 'V4 = V11'
$!AlterData  [|Z45|-|NUMZONES|]
  IgnoreDivideByZero = Yes
  Equation = 'V5 = V13'
$!ENDIF
#-------------------------------------------------

#==================================================================================================
$!LineMap  [1] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\A'}}}
$!LineMap  [2] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\a'}}}
$!LineMap  [3] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\A'}}}
$!LineMap  [4] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\a'}}}
$!LineMap  [5] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\A'}}}
$!LineMap  [6] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\B'}}}
$!LineMap  [7] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\b'}}}
$!LineMap  [8] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\B'}}}
$!LineMap  [9] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\C'}}}
$!LineMap [10] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\c'}}}
$!LineMap [11] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\D'}}}
$!LineMap [12] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\E'}}}
$!LineMap [13] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\e'}}}
$!LineMap [14] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\E'}}}
$!LineMap [15] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\F'}}}
$!LineMap [16] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\G'}}}
$!LineMap [17] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\g'}}}
$!LineMap [18] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\G'}}}
$!LineMap [19] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\g'}}}
$!LineMap [20] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\G'}}}
$!LineMap [21] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\g'}}}
$!LineMap [22] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\H'}}}
$!LineMap [23] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\h'}}}
$!LineMap [24] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\I'}}}
$!LineMap [25] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\i'}}}
$!LineMap [26] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\J'}}}
$!LineMap [27] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\j'}}}
$!LineMap [28] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\K'}}}
$!LineMap [29] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\k'}}}
$!LineMap [30] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\L'}}}
$!LineMap [31] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\l'}}}
$!LineMap [32] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\M'}}}
$!LineMap [33] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\m'}}}
$!LineMap [34] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\M'}}}
$!LineMap [35] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\m'}}}
$!LineMap [36] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\N'}}}
$!LineMap [37] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\O'}}}
$!LineMap [38] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\P'}}}
$!LineMap [39] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\Q'}}}
$!LineMap [40] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\q'}}}
$!LineMap [41] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\R'}}}
$!LineMap [42] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\r'}}}
$!LineMap [43] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\S'}}}
$!LineMap [44] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\s'}}}
$!IF 0 == 1
# Konrad Goc (TestCase 1b submission)
$!LineMap [45] Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\T'}}}
$!ENDIF
#==================================================================================================

#==================================================================================================
$!RenameDataSetVar Var = 4  Name = 'C<sub>P</sub>'
$!RenameDataSetVar Var = 5  Name = 'C<sub>F</sub>'
$!RenameDataSetVar Var = 6  Name = 'C<sub>Fx</sub>'
$!RenameDataSetVar Var = 7  Name = 'C<sub>Fy</sub>'
$!RenameDataSetVar Var = 8  Name = 'C<sub>Fz</sub>'
$!RenameDataSetVar Var = 9  Name = 'X/C'

#==================================================================================================
$!LineMap [1-|NumLineMaps|] Symbols {Size = 1}
$!LineMap [1-|NumLineMaps|] Symbols {SkipMode = ByFrameUnits Skipping = 10}
$!LineMap [1-|NumLineMaps|] ErrorBars {Var = 2 Show = No}

#==================================================================================================
# Value blanking for data with X/C < -998
#-------------------------------------------------
$!Blanking Value { Include = Yes }
$!Blanking Value { Constraint 1 { Include = Yes ValueCutoff = -998 VarA = 9 } }

#==================================================================================================
# Data Alterations
#-------------------------------------------------
# 002.01/002.02/002.03/002.04 Submissionas have X/C all over the place
$!VarSet |Z| = (|Z05|-1)
$!AlterData  [|Z01|-|Z|]
  IgnoreDivideByZero = Yes
  Equation = 'V9 = V1/0.23'

## 014.01/014.02 submissions have X/C from -1 to 0 (so use absolute value)
#$!VarSet |Z| = (|Z28|-1)
#$!AlterData [|Z26|-|Z|]
#  IgnoreDivideByZero = Yes
#  Equation = '{X/C} = abs({X/C})'

#==================================================================================================
# Handle data that is not ordered well
#-------------------------------------------------
## 014.01/014.02 submissions are not ordered well
#$!LineMap [26] Lines   { Show = Yes LinePattern = Dashed PatternLength =  5 LineThickness = 0.02 }
#$!LineMap [27] Lines   { Show = Yes LinePattern = Dashed PatternLength =  5 LineThickness = 0.02 }

#-------------------------------------------------
## 020-01 submission is not ordered well
#$!LineMap [32] Lines   { Show = Yes LinePattern = Dotted PatternLength = 50 LineThickness = 0.02 }
#$!LineMap [32] Symbols { SkipMode = ByIndex Skipping = 1E+1 }

#-------------------------------------------------
# 020-02 submission is not ordered well and can not be sorted
$!LineMap [33] Lines   { Show = Yes LinePattern = Dotted PatternLength = 50 LineThickness = 0.02 }
$!LineMap [33] Symbols { SkipMode = ByIndex Skipping = 3 }
$!LineMap [33] Lines   { Show = No }

#-------------------------------------------------
## 020-03 submission is not ordered well
#$!LineMap [34] Lines   { Show = Yes LinePattern = Dotted PatternLength = 50 LineThickness = 0.02 }

#-------------------------------------------------
## 020-04 submission is not ordered well
#$!LineMap [35] Lines   { Show = Yes LinePattern = Dotted PatternLength = 50 LineThickness = 0.02 }

#-------------------------------------------------
## 027-01/027.02 submissions are not ordered well
#$!LineMap [41] Lines   { Show = Yes LinePattern = Dashed PatternLength =  5 LineThickness = 0.02 }
#$!LineMap [42] Lines   { Show = Yes LinePattern = Dashed PatternLength =  5 LineThickness = 0.02 }

#==================================================================================================
