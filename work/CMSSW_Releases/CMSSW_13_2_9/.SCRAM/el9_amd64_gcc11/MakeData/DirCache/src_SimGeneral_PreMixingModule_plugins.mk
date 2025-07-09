ifeq ($(strip $(SimGeneralPreMixingModulePlugins)),)
SimGeneralPreMixingModulePlugins := self/src/SimGeneral/PreMixingModule/plugins
PLUGINS:=yes
SimGeneralPreMixingModulePlugins_files := $(patsubst src/SimGeneral/PreMixingModule/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/PreMixingModule/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/PreMixingModule/plugins/$(file). Please fix src/SimGeneral/PreMixingModule/plugins/BuildFile.))))
SimGeneralPreMixingModulePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PreMixingModule/plugins/BuildFile
SimGeneralPreMixingModulePlugins_LOC_USE := self   DataFormats/HepMCCandidate FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager FWCore/ServiceRegistry Mixing/Base SimDataFormats/CrossingFrame SimDataFormats/PileupSummaryInfo SimGeneral/MixingModule SimGeneral/PreMixingModule clhep 
SimGeneralPreMixingModulePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralPreMixingModulePlugins,SimGeneralPreMixingModulePlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/PreMixingModule/plugins))
SimGeneralPreMixingModulePlugins_PACKAGE := self/src/SimGeneral/PreMixingModule/plugins
ALL_PRODS += SimGeneralPreMixingModulePlugins
SimGeneral/PreMixingModule_forbigobj+=SimGeneralPreMixingModulePlugins
SimGeneralPreMixingModulePlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralPreMixingModulePlugins,src/SimGeneral/PreMixingModule/plugins,src_SimGeneral_PreMixingModule_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralPreMixingModulePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralPreMixingModulePlugins,src/SimGeneral/PreMixingModule/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_PreMixingModule_plugins
src_SimGeneral_PreMixingModule_plugins_parent := SimGeneral/PreMixingModule
src_SimGeneral_PreMixingModule_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PreMixingModule_plugins,src/SimGeneral/PreMixingModule/plugins,PLUGINS))
