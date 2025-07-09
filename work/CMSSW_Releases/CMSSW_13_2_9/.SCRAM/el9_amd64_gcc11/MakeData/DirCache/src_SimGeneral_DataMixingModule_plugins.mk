ifeq ($(strip $(SimGeneralDataMixingModulePlugins)),)
SimGeneralDataMixingModulePlugins := self/src/SimGeneral/DataMixingModule/plugins
PLUGINS:=yes
SimGeneralDataMixingModulePlugins_files := $(patsubst src/SimGeneral/DataMixingModule/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/DataMixingModule/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/DataMixingModule/plugins/$(file). Please fix src/SimGeneral/DataMixingModule/plugins/BuildFile.))))
SimGeneralDataMixingModulePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/DataMixingModule/plugins/BuildFile
SimGeneralDataMixingModulePlugins_LOC_USE := self   CalibFormats/HcalObjects CondFormats/EcalObjects DataFormats/CSCDigi DataFormats/Common DataFormats/DTDigi DataFormats/EcalDigi DataFormats/EcalRecHit DataFormats/HcalDigi DataFormats/HcalRecHit DataFormats/Provenance DataFormats/RPCDigi DataFormats/SiPixelDigi DataFormats/SiStripDigi DataFormats/TrackReco DataFormats/HepMCCandidate FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager FWCore/ServiceRegistry FWCore/Utilities Mixing/Base SimCalorimetry/CaloSimAlgos SimCalorimetry/HcalSimAlgos SimCalorimetry/HcalSimProducers SimDataFormats/PileupSummaryInfo SimDataFormats/CrossingFrame 
SimGeneralDataMixingModulePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralDataMixingModulePlugins,SimGeneralDataMixingModulePlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/DataMixingModule/plugins))
SimGeneralDataMixingModulePlugins_PACKAGE := self/src/SimGeneral/DataMixingModule/plugins
ALL_PRODS += SimGeneralDataMixingModulePlugins
SimGeneral/DataMixingModule_forbigobj+=SimGeneralDataMixingModulePlugins
SimGeneralDataMixingModulePlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralDataMixingModulePlugins,src/SimGeneral/DataMixingModule/plugins,src_SimGeneral_DataMixingModule_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralDataMixingModulePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralDataMixingModulePlugins,src/SimGeneral/DataMixingModule/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_DataMixingModule_plugins
src_SimGeneral_DataMixingModule_plugins_parent := SimGeneral/DataMixingModule
src_SimGeneral_DataMixingModule_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_DataMixingModule_plugins,src/SimGeneral/DataMixingModule/plugins,PLUGINS))
