ifeq ($(strip $(runtestSimGeneralPreMixingModule)),)
runtestSimGeneralPreMixingModule := self/src/SimGeneral/PreMixingModule/test
runtestSimGeneralPreMixingModule_files := 1
runtestSimGeneralPreMixingModule_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PreMixingModule/test/BuildFile
runtestSimGeneralPreMixingModule_LOC_USE := self   
runtestSimGeneralPreMixingModule_PACKAGE := self/src/SimGeneral/PreMixingModule/test
ALL_PRODS += runtestSimGeneralPreMixingModule
runtestSimGeneralPreMixingModule_INIT_FUNC        += $$(eval $$(call Binary,runtestSimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/test,src_SimGeneral_PreMixingModule_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
runtestSimGeneralPreMixingModule_CLASS := TEST
runtestSimGeneralPreMixingModule_TEST_RUNNER_CMD :=  run_testPremixPileupAdjustment.sh
else
$(eval $(call MultipleWarningMsg,runtestSimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/test))
endif
ifeq ($(strip $(SimGeneralPreMixingModuleTestPlugins)),)
SimGeneralPreMixingModuleTestPlugins := self/src/SimGeneral/PreMixingModule/test
SimGeneralPreMixingModuleTestPlugins_files := $(patsubst src/SimGeneral/PreMixingModule/test/%,%,$(foreach file,TestPreMixingPileupAnalyzer.cc,$(eval xfile:=$(wildcard src/SimGeneral/PreMixingModule/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/PreMixingModule/test/$(file). Please fix src/SimGeneral/PreMixingModule/test/BuildFile.))))
SimGeneralPreMixingModuleTestPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PreMixingModule/test/BuildFile
SimGeneralPreMixingModuleTestPlugins_LOC_USE := self   DataFormats/Common FWCore/Framework FWCore/ParameterSet FWCore/Utilities SimDataFormats/PileupSummaryInfo 
SimGeneralPreMixingModuleTestPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralPreMixingModuleTestPlugins,SimGeneralPreMixingModuleTestPlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/PreMixingModule/test))
SimGeneralPreMixingModuleTestPlugins_PACKAGE := self/src/SimGeneral/PreMixingModule/test
ALL_PRODS += SimGeneralPreMixingModuleTestPlugins
SimGeneralPreMixingModuleTestPlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralPreMixingModuleTestPlugins,src/SimGeneral/PreMixingModule/test,src_SimGeneral_PreMixingModule_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralPreMixingModuleTestPlugins_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralPreMixingModuleTestPlugins,src/SimGeneral/PreMixingModule/test))
endif
ALL_COMMONRULES += src_SimGeneral_PreMixingModule_test
src_SimGeneral_PreMixingModule_test_parent := SimGeneral/PreMixingModule
src_SimGeneral_PreMixingModule_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PreMixingModule_test,src/SimGeneral/PreMixingModule/test,TEST))
