#!/bin/csh

set refdir = ~/crm/hs/dpw-8/github

set dirs = ( DPW8-Scatter/TestCase1a/002_Embraer/01_CFD++_CadenceUnstructured_SA-RC-QCR           \
             DPW8-Scatter/TestCase1a/002_Embraer/02_CFD++_CadenceUnstructured_SA                  \
             DPW8-Scatter/TestCase1a/002_Embraer/03_CFD++_CadenceUnstructured_SST                 \
             DPW8-Scatter/TestCase1a/002_Embraer/04_CFD++_CadenceStructured_SA-RC-QCR             \
             DPW8-Scatter/TestCase1a/002_Embraer/05_CFD++_HeldenMesh_SA-RC-QCR                    \
             DPW8-Buffet/TestCase1a/004_NASALangleyCAB/01_SA                                      \
             DPW8-Buffet/TestCase1a/004_NASALangleyCAB/02_SAR                                     \
             DPW8-Buffet/TestCase1a/004_NASALangleyCAB/03_SAQCR                                   \
             DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/01_SAneg                          \
             DPW8-Buffet/TestCase1a/005_LAVA_SteadyRANS_Results/02_SARC_CC                        \
             DPW8-Scatter/TestCase1a/006/01_LociChem                                              \
             DPW8-Buffet/TestCase1a/007_JAXA/01_FaSTAR_Cadence-Structured_SA-noft2                \
             DPW8-Buffet/TestCase1a/007_JAXA/02_FaSTAR_Cadence-Structured_SA-noft2-R-QCR2000      \
             DPW8-Buffet/TestCase1a/007_JAXA/03_FaSTAR_Cadence-Structured_SST-2003sust            \
             DPW8-Buffet/TestCase1a/007_JAXA/04_FaSTAR_JAXA-Custom-Structured_SA-noft2            \
             DPW8-Buffet/TestCase1a/007_JAXA/05_FaSTAR_JAXA-Custom-Structured_SA-noft2-R          \
             DPW8-Buffet/TestCase1a/007_JAXA/06_FaSTAR_JAXA-Custom-Structured_SA-noft2-R-QCR2000  \
             DPW8-Buffet/TestCase1a/008_Metacomp/01_CFD++_Cadence_Structured                      \
             DPW8-Buffet/TestCase1a/009_ONERA/01_elsA_Cadence-structured_SA                       \
             DPW8-Buffet/TestCase1a/009_ONERA/02_elsA_Cadence-unstructured_SA                     \
             DPW8-Buffet/TestCase1a/009_ONERA/03_elsA_Helden-unstructured_SA                      \
             DPW8-Buffet/TestCase1a/009_ONERA/04_elsA_ONERA-Structured_SA                         \
             DPW8-Buffet/TestCase1a/009_ONERA/05_elsA_Cadence-structured_kwSST                    \
             DPW8-Buffet/TestCase1a/009_ONERA/06_elsA_Cadence-unstructured_kwSST                  \
             DPW8-Buffet/TestCase1a/009_ONERA/07_elsA_Helden-unstructured_kwSST                   \
             DPW8-Buffet/TestCase1a/009_ONERA/08_elsA_ONERA-structured_kwSST                      \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/01_SFE_SAneg                                 \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/02_SFE_SAneg_CC                              \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/03_SFE_SAneg_QCR_CC                          \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/04_NCFV_SAneg                                \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/05_NCFV_SAneg_2ndOrderTurbConv               \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/06_NCFV_SAneg_CC                             \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/07_NCFV_SAneg_CC_2ndOrderTurbConv            \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/08_NCFV_SAneg_QCR                            \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/09_NCFV_SAneg_QCR_CC_2ndOrderTurbConv        \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/10_NCFV_SAneg_QCR_RC_CC                      \
             DPW8-Buffet/TestCase1a/012_NASA_LARC_AB/11_NCFV_SAneg_QCR_RC_CC_2ndOrderTurbConv     \
             DPW8-Buffet/TestCase1a/014_IISc/01_SU2_Symmetric_BC                                  \
             DPW8-Buffet/TestCase1a/014_IISc/02_SU2_Periodic_BC                                   \
             DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/01_SAneg                                  \
             DPW8-Buffet/TestCase1a/018_zCFD_steadyRANS/02_SST-V-2003                             \
             DPW8-Buffet/TestCase1a/020_DukeUniversity/01_Fluent_CadenceStructured_SA             \
             DPW8-Buffet/TestCase1a/020_DukeUniversity/02_Fluent_CadenceUnstructured_SA           \
             DPW8-Buffet/TestCase1a/020_DukeUniversity/03_FUN3D_CadenceStructured_SAneg           \
             DPW8-Buffet/TestCase1a/020_DukeUniversity/04_FUN3D_CadenceUnstructured_SAneg         \
             DPW8-Buffet/TestCase1a/023_PolytechniqueMontreal/01_SA                               \
             DPW8-Buffet/TestCase1a/024_UniversityofLiverpool/01_SAneg                            \
             DPW8-Buffet/TestCase1a/026_CorvidTechnologies/01_SA                                  \
             DPW8-Buffet/TestCase1a/026_CorvidTechnologies/02_SA_comp                             \
             DPW8-Buffet/TestCase1a/027_RMIT/01_SST                                               \
             DPW8-Buffet/TestCase1a/027_RMIT/02_SA                                                \
             DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/03_ZDES_SAneg                            \
             DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/04_ZDES_SAneg_blend2                     \
             DPW8-Buffet/TestCase1b/005_LAVA_Curvilinear/05_URANS_SARCcomp                        \
             DPW8-Scatter/TestCase1a/006/02_LociChem_URANS                                        \
             DPW8-Scatter/TestCase1a/006/03_LociChen_HybridRANSLES                                \
             DPW8-Scatter/TestCase1a/006/04_LociChem_DHRL                                         \
             DPW8-Buffet/TestCase1b/007_JAXA/07_FaSTAR_JAXA-Custom-Structured_SA-noft2            \
             DPW8-Buffet/TestCase1b/007_JAXA/08_FaSTAR_JAXA-Custom-Structured_SA-noft2-R          \
             DPW8-Buffet/TestCase1b/007_JAXA/09_FaSTAR_JAXA-Custom-Structured_SA-noft2-R-QCR2000  \
             DPW8-Buffet/TestCase1b/008_Metacomp/02_CFD++_Deck                                    \
             DPW8-Buffet/TestCase1b/008_Metacomp/03_CFD++_DDES_Deck                               \
             DPW8-Buffet/TestCase1b/010_Boeing                                                    \
             DPW8-Buffet/TestCase1b/012_NASA_LARC_AB/12_NCFV_SST_QRC2020_CC                       \
             DPW8-Buffet/TestCase1b/014_IISc/03_SU2_Symmetric_BC                                  \
             DPW8-Buffet/TestCase1b/027_RMIT/03_SST                                               \
             DPW8-Buffet/TestCase1b/027_RMIT/04_SA                                                )

#set dirs = ( $dirs DPW8-Buffet/TestCase1b/032_KTH-Adaptive_Euler )


foreach dir ( $dirs )
  #echo $dir
  #ls $refdir/$dir/*Force*dat
  n $refdir/$dir/*Force*dat
  sleep 0.2
end
