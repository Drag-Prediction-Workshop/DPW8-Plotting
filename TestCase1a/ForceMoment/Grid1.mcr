#!MC 1410
$!Page Name = 'Untitled'
$!PageControl Create
$!NewLayout

$!VarSet |GRID| = "1"

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/01_CFD++_CadenceUnstructured_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"'
  ReadDataOption = New
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"GRID_LEVEL" "GRID_SIZE" "GRID_FAC" "MACH" "REY" "ALPHA" "CL_TOT" "CD_TOT" "CM_TOT" "CL_WING" "CD_WING" "CM_WING" "CD_PR" "CD_SF" "CL_TAIL" "CD_TAIL" "CM_TAIL" "CL_FUS" "CD_FUS" "CM_FUS" "CL_NAC" "CD_NAC" "CM_NAC" "CL_PY" "CD_PY" "CM_PY" "CPU_Hours" "DELTAT" "CTUSTART" "CTUAVG" "Q/E"'

$!ActiveLineMaps -= [1-|NumLineMaps|]
$!DeleteLineMaps  [1-|NumLineMaps|]

$!Varset |Z| = ( 3 - 2 )
$!Varset |N| = 1
$!CreateLineMap
#$!LineMap [|N|]  Name = '&ZN&'
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/02_CFD++_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 20 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/03_CFD++_CadenceUnstructured_SST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 37 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/04_CFD++_CadenceStructured_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 54 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/002_Embraer/05_CFD++_HeldenMesh_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 71 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/01_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 87 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/02_SAR/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 103 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/03_SAQCR/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 119 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 135 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/02_SARC_CC/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 151 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/006/01_FeCFD/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 167 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/01_FaSTAR_Cadence-Structured_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 183 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/02_FaSTAR_Cadence-Structured_SA-noft2-R-QCR2000/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 190 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/007_JAXA/03_FaSTAR_Cadence-Structured_SST-2003sust/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 197 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/008_Metacomp/01_CFD++_Cadence_Structured/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 204 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/01_elsA_Cadence-structured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 220 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/02_elsA_Cadence-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 236 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/03_elsA_Helden-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 252 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/04_elsA_ONERA-Structured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 267 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/05_elsA_Cadence-structured_kwSST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 286 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/06_elsA_Cadence-unstructured_kwSST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 302 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/07_elsA_Helden-unstructured_kwSST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 318 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/009_ONERA/08_elsA_ONERA-structured_kwSST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 334 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/011_HEMLAB/01_Structured/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 350 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/011_HEMLAB/02_Adaptive/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 357 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/014_IISc/01_SU2_Symmetric_BC/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 377 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/014_IISc/02_SU2_Periodic_BC/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 386 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&ZN&'
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/01_FUN3D/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 395 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/02_FUN3D/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 406 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 417 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/02_SST-V-2003/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 432 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 447 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 463 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 469 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 485 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/023_PolytechniqueMontreal/01_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 501 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/024_UniversityofLiverpool/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat.txt" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 517 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Static-Deform/TestCase1a/025_TLGAerospace/01_STARCCM_CadenceUnstr_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 533 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/01_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 544 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/02_SA_comp/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 560 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/027_RMIT/01_SST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 576 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Buffet/TestCase1a/027_RMIT/02_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 584 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/01_SANS_refine/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 593 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/02_SANS_Metris/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( 605 - 2 )
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!LineMap  [1]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\A'}}}
$!LineMap  [2]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\a'}}}
$!LineMap  [3]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\A'}}}
$!LineMap  [4]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\a'}}}
$!LineMap  [5]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\A'}}}
$!LineMap  [6]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\B'}}}
$!LineMap  [7]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\b'}}}
$!LineMap  [8]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\B'}}}
$!LineMap  [9]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\C'}}}
$!LineMap [10]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\c'}}}
$!LineMap [11]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\D'}}}
$!LineMap [12]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\E'}}}
$!LineMap [13]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\e'}}}
$!LineMap [14]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\E'}}}
$!LineMap [15]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\F'}}}
$!LineMap [16]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\G'}}}
$!LineMap [17]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\g'}}}
$!LineMap [18]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\G'}}}
$!LineMap [19]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\g'}}}
$!LineMap [20]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\G'}}}
$!LineMap [21]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No                        ASCIIChar = '\g'}}}
$!LineMap [22]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\H'}}}
$!LineMap [23]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\h'}}}
$!LineMap [24]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\I'}}}
$!LineMap [25]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\i'}}}
$!LineMap [26]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\J'}}}
$!LineMap [27]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\j'}}}
$!LineMap [28]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\K'}}}
$!LineMap [29]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\k'}}}
$!LineMap [30]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\L'}}}
$!LineMap [31]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\l'}}}
$!LineMap [32]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\M'}}}
$!LineMap [33]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\m'}}}
$!LineMap [34]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\M'}}}
$!LineMap [35]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {UseBaseFont = No FontOverride = Greek   ASCIIChar = '\m'}}}
$!LineMap [36]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\N'}}}
$!LineMap [37]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\O'}}}
$!LineMap [38]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\P'}}}
$!LineMap [39]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\Q'}}}
$!LineMap [40]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\q'}}}
$!LineMap [41]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\R'}}}
$!LineMap [42]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\r'}}}
$!LineMap [43]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\S'}}}
$!LineMap [44]  Symbols {SymbolShape {IsASCII = Yes ASCIIShape {                 FontOverride = UserDef ASCIIChar = '\s'}}}

#-------------------------------------------------
# Turbulence Model Variants
$!VarSet |ALL_Maps|        = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44"
$!VarSet |SA_Maps|         = "  2,      6,    9,10,   12,         16,17,18,19,            24,25,26,27,28,   30,   32,33,34,35,36,37,38,39,40,   42,43,44"
$!VarSet |SAQ_Maps|        = "1,    4,5,  7,8,           13,   15,                                                                                      "
$!VarSet |SST_Maps|        = "    3,               11,      14,               20,21,22,23,               29,   31,                           41         "

# Grid Type Variants
$!VarSet |ALL_Maps|        = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44"
$!VarSet |CadenceStr_Maps| = "      4,        9,10,   12,13,14,15,16,         20,                                 32,   34                   41,42      "
$!VarSet |CadenceUnS_Maps| = "1,2,3,    6,7,8,     11,               17,         21,      24,25,26,   28,29,30,31,   33,   35,36,37,38,39,40            "
$!VarSet |HeldenUnSt_Maps| = "        5,                                18,         22                                                                  "
$!VarSet |OneraStruc_Maps| = "                                             19,         23                                                               "
$!VarSet |CstmUsrAdp_Maps| = "                                                                     27,                                             43,44"
#$!VarSet |CstmUsrStr_Maps| = "                                                                                                                          "
#$!VarSet |CstmUsrUns_Maps| = "                                                                                                                          "
#-------------------------------------------------

#-------------------------------------------------
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{1/h} = 1/{GRID_SIZE}'
$!Varset |1_h| = |NumVars|
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{1/h<sup>2</sup>} = 1/({GRID_SIZE}**(1/2))'
$!Varset |1_h2| = |NumVars|
$!AlterData
  IgnoreDivideByZero = Yes
  Equation = '{1/h<sup>2/3</sup>} = 1/({GRID_SIZE}**(2/3))'

$!RenameDataSetVar Var = 6  Name = 'AoA'
$!RenameDataSetVar Var = 7  Name = 'CL<sub>Total</sub>'
$!RenameDataSetVar Var = 8  Name = 'CD<sub>Total</sub>'
$!RenameDataSetVar Var = 9  Name = 'CMy<sub>Total</sub>'
$!RenameDataSetVar Var = 10 Name = 'CL<sub>Wing</sub>'
$!RenameDataSetVar Var = 11 Name = 'CD<sub>Wing</sub>'
$!RenameDataSetVar Var = 12 Name = 'CMy<sub>Wing</sub>'
$!RenameDataSetVar Var = 13 Name = 'CD<sub>Pressure</sub>'
$!RenameDataSetVar Var = 14 Name = 'CD<sub>SkinFriction</sub>'
$!RenameDataSetVar Var = 15 Name = 'CL<sub>Tail</sub>'
$!RenameDataSetVar Var = 16 Name = 'CD<sub>Tail</sub>'
$!RenameDataSetVar Var = 17 Name = 'CMy<sub>Tail</sub>'
$!RenameDataSetVar Var = 18 Name = 'CL<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 19 Name = 'CD<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 20 Name = 'CMy<sub>Fuselage</sub>'
$!RenameDataSetVar Var = 18 Name = 'CL<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 19 Name = 'CD<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 20 Name = 'CMy<sub>Nacelle</sub>'
$!RenameDataSetVar Var = 18 Name = 'CL<sub>Pylon</sub>'
$!RenameDataSetVar Var = 19 Name = 'CD<sub>Pylon</sub>'
$!RenameDataSetVar Var = 20 Name = 'CMy<sub>Pylon</sub>'

# Value blanking for data with AOA <= 1.0
$!Blanking Value { Include = Yes }
$!Blanking Value { Constraint 1 { Include = Yes ValueCutoff = 1.0 VarA = 6 } }

#-------------------------------------------------
$!LineMap [1-|NumLineMaps|]  Symbols { Size = 1.5 }
$!XYLineAxis XDetail 1 {CoordScale = Linear RangeMin = -1.0E-06 RangeMax = 4.0E-05 GRSpacing = 1E-05 Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 6 } }
$!XYLineAxis YDetail 1 {CoordScale = Linear                                                          Gridlines { Show = Yes } MinorGridlines { Show = Yes } Title { Offset = 9 } }
$!XYLineAxis GridArea  { DrawBorder = Yes LineThickness = 0.1 }

$!LinePlotLayers
  ShowSymbols = Yes

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

$!PrintSetup Palette = Color
$!ExportSetup ImageWidth = 450
$!ExportSetup UseSuperSampleAntiAliasing = Yes

#==================================================================================================
# SA/SA-QCR/SST variants
$!LineMap  [|SA_Maps|]  Lines   { Color = Red   } Symbols { Color = Red   FillColor = Red   }
$!LineMap  [|SAQ_Maps|] Lines   { Color = Green } Symbols { Color = Green FillColor = Green }
$!LineMap  [|SST_Maps|] Lines   { Color = Black } Symbols { Color = Black FillColor = Black }

$!IF 0 == 1
      $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1a: ONERA OAT15A

\ \ \ \ \ \ \ \ \ \ \ \ \ \ Polar Study

\ \ \ \ \ \ \ \ \ \ \ \ \ Grid Level |GRID|)"
$!ELSE
   $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1a: ONERA OAT15A\nPolar Study\nGrid Level |GRID|"
$!ENDIF
$!AttachText AnchorPos { X = 76 Y = 99 } TextShape { Height = 12 IsBold = Yes } Color = Black  Anchor = HeadLeft Text = 'Turbulence Model:    \n\n\n' Box { BoxType = Filled }
$!AttachText AnchorPos { X = 76 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     SA (+R/RC/CC)'
$!AttachText AnchorPos { X = 76 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     SA + QCR'
$!AttachText AnchorPos { X = 76 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     SST'

# CL
$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = 7}
#$!View Fit
#$!View NiceFit
$!View DataFit
$!View MakeCurrentViewNice
#$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
$!ExportSetup ExportFName = 'Grid|GRID|_CL_Alpha_Turb.png'
$!Export 
  ExportRegion = AllFrames

# CMy
$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 9 YAxisVar = 6}
$!View DataFit
$!View MakeCurrentViewNice
#$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
#$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
$!ExportSetup ExportFName = 'Grid|GRID|_CM_Alpha_Turb.png'
$!Export 
  ExportRegion = AllFrames

# CD
$!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 8 YAxisVar = 7}
$!View DataFit
$!View MakeCurrentViewNice
#$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
#$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
$!ExportSetup ExportFName = 'Grid|GRID|_CD_CL_Turb.png'
$!Export 
  ExportRegion = AllFrames

# Cadence Structured Grid
# Cadence Unstructured Grid
# Helden Unstructured Grid
# Onera Structured Grid
# Custom User Adapted Grid
## Custom User Grid Structured
## Custom User Grid Unstructured
$!IF 1 == 1
   $!LineMap  [|CadenceStr_Maps|] Lines   { Color = Red    } Symbols { Color = Red    FillColor = Red    }
   $!LineMap  [|CadenceUnS_Maps|] Lines   { Color = Black  } Symbols { Color = Black  FillColor = Black  }
   $!LineMap  [|HeldenUnSt_Maps|] Lines   { Color = Blue   } Symbols { Color = Blue   FillColor = Blue   }
   $!LineMap  [|OneraStruc_Maps|] Lines   { Color = Green  } Symbols { Color = Green  FillColor = Green  }
   $!LineMap  [|CstmUsrAdp_Maps|] Lines   { Color = Purple } Symbols { Color = Purple FillColor = Purple }
#   $!LineMap  [|CstmUsrStr_Maps|] Lines   { Color = Cyan   } Symbols { Color = Cyan   FillColor = Cyan   }
#   $!LineMap  [|CstmUsrUns_Maps|] Lines   { Color = Yellow } Symbols { Color = Yellow FillColor = Yellow }

   $!PICK ADDALL
      SELECTTEXT=YES
   $!PICK CLEAR
   $!IF 0 == 1
      $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 18 IsBold = No } Color = Black  Anchor = HeadCenter TextType = LaTeX Text = R"(Test Case 1a: ONERA OAT15A

\ \ \ \ \ \ \ \ \ \ \ \ \ \ Polar Study

\ \ \ \ \ \ \ \ \ \ \ \ \ Grid Level |GRID|)"
   $!ELSE
      $!AttachText AnchorPos { X = 50 Y = 99 } TextShape { Height = 20 IsBold = No } Color = Black  Anchor = HeadCenter Text = "Test Case 1a: ONERA OAT15A\nPolar Study\nGrid Level |GRID|"
   $!ENDIF
   $!AttachText AnchorPos { X = 75 Y = 99 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = 'Grid Family:                            \n\n\n\n\n' Box { BoxType = Filled }
   $!AttachText AnchorPos { X = 75 Y = 97 } TextShape { Height = 12 IsBold = No } Color = Red    Anchor = HeadLeft Text = '     Cadence Structured'
   $!AttachText AnchorPos { X = 75 Y = 95 } TextShape { Height = 12 IsBold = No } Color = Black  Anchor = HeadLeft Text = '     Cadence Unstructured'
   $!AttachText AnchorPos { X = 75 Y = 93 } TextShape { Height = 12 IsBold = No } Color = Blue   Anchor = HeadLeft Text = '     HeldenMesh Unstructured'
   $!AttachText AnchorPos { X = 75 Y = 91 } TextShape { Height = 12 IsBold = No } Color = Green  Anchor = HeadLeft Text = '     ONERA Structured'
   $!AttachText AnchorPos { X = 75 Y = 89 } TextShape { Height = 12 IsBold = No } Color = Purple Anchor = HeadLeft Text = '     User Grid Adaptation'

  # CL
   $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 6 YAxisVar = 7}
   $!View DataFit
   $!View MakeCurrentViewNice
  #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
   $!ExportSetup ExportFName = 'Grid|GRID|_CL_Alpha_Grid.png'
   $!Export 
     ExportRegion = AllFrames

  # CMy
   $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 9 YAxisVar = 6}
   $!View DataFit
   $!View MakeCurrentViewNice
  #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
  #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
   $!ExportSetup ExportFName = 'Grid|GRID|_CM_Alpha_Grid.png'
   $!Export 
     ExportRegion = AllFrames

  # CD
   $!LineMap [1-|NumLineMaps|]  Assign{XAxisVar = 8 YAxisVar = 7}
   $!View DataFit
   $!View MakeCurrentViewNice
  #$!XYLineAxis XDetail 1 {RangeMin = -1.0E-06 RangeMax = 4.0E-05}
  #$!XYLineAxis YDetail 1 {RangeMin = 0.0115   RangeMax = 0.0165}
   $!ExportSetup ExportFName = 'Grid|GRID|_CD_CL_Grid.png'
   $!Export 
     ExportRegion = AllFrames
$!ENDIF
