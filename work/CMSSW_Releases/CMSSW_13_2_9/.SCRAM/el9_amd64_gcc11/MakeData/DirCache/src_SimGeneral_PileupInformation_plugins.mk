ifeq ($(strip $(SimGeneralPileupInformationPlugins)),)
SimGeneralPileupInformationPlugins := self/src/SimGeneral/PileupInformation/plugins
PLUGINS:=yes
SimGeneralPileupInformationPlugins_files := $(patsubst src/SimGeneral/PileupInformation/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/PileupInformation/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/PileupInformation/plugins/$(file). Please fix src/SimGeneral/PileupInformation/plugins/BuildFile.))))
SimGeneralPileupInformationPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PileupInformation/plugins/BuildFile
SimGeneralPileupInformationPlugins_LOC_USE := self   FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet SimDataFormats/GeneratorProducts SimDataFormats/PileupSummaryInfo SimDataFormats/Track SimDataFormats/TrackingAnalysis SimGeneral/MixingModule SimGeneral/HepPDTRecord clhep 
SimGeneralPileupInformationPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralPileupInformationPlugins,SimGeneralPileupInformationPlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/PileupInformation/plugins))
SimGeneralPileupInformationPlugins_PACKAGE := self/src/SimGeneral/PileupInformation/plugins
ALL_PRODS += SimGeneralPileupInformationPlugins
SimGeneral/PileupInformation_forbigobj+=SimGeneralPileupInformationPlugins
SimGeneralPileupInformationPlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralPileupInformationPlugins,src/SimGeneral/PileupInformation/plugins,src_SimGeneral_PileupInformation_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralPileupInformationPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralPileupInformationPlugins,src/SimGeneral/PileupInformation/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_PileupInformation_plugins
src_SimGeneral_PileupInformation_plugins_parent := SimGeneral/PileupInformation
src_SimGeneral_PileupInformation_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PileupInformation_plugins,src/SimGeneral/PileupInformation/plugins,PLUGINS))
