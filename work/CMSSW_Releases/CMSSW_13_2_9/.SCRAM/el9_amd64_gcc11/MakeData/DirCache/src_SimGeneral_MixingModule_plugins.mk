ifeq ($(strip $(SimGeneralMixingModulePlugins)),)
SimGeneralMixingModulePlugins := self/src/SimGeneral/MixingModule/plugins
PLUGINS:=yes
SimGeneralMixingModulePlugins_files := $(patsubst src/SimGeneral/MixingModule/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/MixingModule/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/MixingModule/plugins/$(file). Please fix src/SimGeneral/MixingModule/plugins/BuildFile.))))
SimGeneralMixingModulePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/MixingModule/plugins/BuildFile
SimGeneralMixingModulePlugins_LOC_USE := self   DataFormats/Common DataFormats/Provenance FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities FWCore/PluginManager Mixing/Base SimDataFormats/CaloHit SimDataFormats/CrossingFrame SimDataFormats/Track SimDataFormats/TrackingHit SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimGeneral/MixingModule clhep CondFormats/RunInfo CondCore/DBOutputService DataFormats/TrackerRecHit2D 
SimGeneralMixingModulePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralMixingModulePlugins,SimGeneralMixingModulePlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/MixingModule/plugins))
SimGeneralMixingModulePlugins_PACKAGE := self/src/SimGeneral/MixingModule/plugins
ALL_PRODS += SimGeneralMixingModulePlugins
SimGeneral/MixingModule_forbigobj+=SimGeneralMixingModulePlugins
SimGeneralMixingModulePlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralMixingModulePlugins,src/SimGeneral/MixingModule/plugins,src_SimGeneral_MixingModule_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralMixingModulePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralMixingModulePlugins,src/SimGeneral/MixingModule/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_MixingModule_plugins
src_SimGeneral_MixingModule_plugins_parent := SimGeneral/MixingModule
src_SimGeneral_MixingModule_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_plugins,src/SimGeneral/MixingModule/plugins,PLUGINS))
