
art_make_library(LIBRARY_NAME ppfx
                 SOURCE AbsorptionDPIPReweighter.cpp
                        AbsorptionDVOLReweighter.cpp
                        AbsorptionICReweighter.cpp
                        AttenuationMC.cpp
                        CentralValuesAndUncertainties.cpp
                        FillIMapHists.cpp
                        InteractionChainData.cpp
                        InteractionData.cpp
                        MakeReweight.cpp
                        MIPPNumiKaonYieldsReweighter.cpp
                        MIPPNumiMC.cpp
                        MIPPNumiPionYieldsReweighter.cpp
                        MIPPNumiYieldsBins.cpp
                        NucleonAbsorptionOutOfTargetReweighter.cpp
                        nu_g4numi.cpp
                        Numi2Pdg.cpp
                        NuWeight.cpp
                        OtherAbsorptionOutOfTargetReweighter.cpp
                        OtherReweighter.cpp
                        ParameterTable.cpp
                        ParticlesThroughVolumesData.cpp
                        ReweightDriver.cpp
                        TargetAttenuationReweighter.cpp
                        TargetData.cpp
                        ThinTargetBins.cpp
                        ThinTargetMC.cpp
                        ThinTargetMesonIncidentReweighter.cpp
                        ThinTargetnCPionReweighter.cpp
                        ThinTargetnucleonAReweighter.cpp
                        ThinTargetpCKaonReweighter.cpp
                        ThinTargetpCNucleonReweighter.cpp
                        ThinTargetpCPionReweighter.cpp
                 LIBRARIES PRIVATE
                        dk2nu::Tree
                        ROOT::EG
                        ROOT::Tree
                        Boost::filesystem
)


install_source()
