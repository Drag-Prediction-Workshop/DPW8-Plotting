#!MC 1410
$!Page Name = 'Untitled'
$!PageControl Create
$!NewLayout

$!VarSet |ALPHA| = "3.60"

$!Varset |Zi| = 0

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/01_CFD++_CadenceUnstructured_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat"'
  ReadDataOption = New
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes
  VarNameList = '"GRID_LEVEL" "GRID_SIZE" "GRID_FAC" "MACH" "REY" "ALPHA" "CL_TOT" "CD_TOT" "CM_TOT" "CL_WING" "CD_WING" "CM_WING" "CD_PR" "CD_SF" "CL_TAIL" "CD_TAIL" "CM_TAIL" "CL_FUS" "CD_FUS" "CM_FUS" "CL_NAC" "CD_NAC" "CM_NAC" "CL_PY" "CD_PY" "CM_PY" "CPU_Hours" "DELTAT" "CTUSTART" "CTUAVG" "Q/E"'

$!ActiveLineMaps -= [1-|NumLineMaps|]
$!DeleteLineMaps  [1-|NumLineMaps|]

$!Varset |Z| = ( |Zi| + 16 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = 1
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/02_CFD++_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 16 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/03_CFD++_CadenceUnstructured_SST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 16 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/04_CFD++_CadenceStructured_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 16 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/002_Embraer/05_CFD++_HeldenMesh_SA-RC-QCR/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/01_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/02_SAR/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/004_NASALangleyCAB/03_SAQCR/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/02_SARC_CC/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/006/01_FeCFD/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/007_JAXA/01_FaSTAR_Cadence-Structured_SA-noft2/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 7 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/007_JAXA/02_FaSTAR_Cadence-Structured_SA-noft2-R-QCR2000/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 7 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/007_JAXA/03_FaSTAR_Cadence-Structured_SST-2003sust/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 7 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/008_Metacomp/01_CFD++_Cadence_Structured/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/01_elsA_Cadence-structured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/02_elsA_Cadence-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/03_elsA_Helden-unstructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 14 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/04_elsA_ONERA-Structured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 18 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/05_elsA_Cadence-structured_kwSST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/06_elsA_Cadence-unstructured_kwSST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/07_elsA_Helden-unstructured_kwSST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/009_ONERA/08_elsA_ONERA-structured_kwSST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 18 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/011_HEMLAB/01_Structured/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 7 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/011_HEMLAB/02_Adaptive/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 20 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/014_IISc/01_SU2_Symmetric_BC/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 9 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/014_IISc/02_SU2_Periodic_BC/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 9 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&ZN&'
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/01_FUN3D/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 11 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Static-Deform/TestCase1a/015_USArmySRD/02_FUN3D/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 11 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 14 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/02_SST-V-2003/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 14 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 6 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/023_PolytechniqueMontreal/01_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/024_UniversityofLiverpool/01_SAneg/DPW8-AePW4_ForceMoment_v5.dat.txt" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Static-Deform/TestCase1a/025_TLGAerospace/01_STARCCM_CadenceUnstr_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 11 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/01_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/026_CorvidTechnologies/02_SA_comp/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 15 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps += [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/027_RMIT/01_SST/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 8 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Buffet/TestCase1a/027_RMIT/02_SA/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 9 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/01_SANS_refine/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 12 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#-------------------------------------------------
$!ReadDataSet  '"|MACROFILEPATH|/../../../../DPW8-Scatter/TestCase1a/029_MIT_SANS/02_SANS_Metris/DPW8-AePW4_ForceMoment_v5.dat" '
  ReadDataOption = Append
  ResetStyle = No
  VarLoadMode = ByName
  AssignStrandIDs = Yes

$!Varset |Z| = ( |Zi| + 13 )
$!Varset |Zi| = |NumZones|
$!Varset |N| = (|NumLineMaps|+1)
$!CreateLineMap
$!LineMap [|N|]  Name = '&(ZONENAME[|Z|]%6.6s)'
$!LineMap [|N|]  Assign{Zone = |Z|}
$!ActiveLineMaps -= [|N|]

#==================================================================================================
$!INCLUDEMACRO "|MACROFILEPATH|/Alpha_plot.mcr"
