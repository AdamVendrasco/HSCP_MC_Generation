ifeq ($(strip $(TestGeneratorInterfaceLHEInterfaceFileReading)),)
TestGeneratorInterfaceLHEInterfaceFileReading := self/src/GeneratorInterface/LHEInterface/test
TestGeneratorInterfaceLHEInterfaceFileReading_files := 1
TestGeneratorInterfaceLHEInterfaceFileReading_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/test/BuildFile
TestGeneratorInterfaceLHEInterfaceFileReading_LOC_USE := self   
TestGeneratorInterfaceLHEInterfaceFileReading_PACKAGE := self/src/GeneratorInterface/LHEInterface/test
ALL_PRODS += TestGeneratorInterfaceLHEInterfaceFileReading
TestGeneratorInterfaceLHEInterfaceFileReading_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfaceLHEInterfaceFileReading,src/GeneratorInterface/LHEInterface/test,src_GeneratorInterface_LHEInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfaceLHEInterfaceFileReading_CLASS := TEST
TestGeneratorInterfaceLHEInterfaceFileReading_TEST_RUNNER_CMD :=  testMerging.sh
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfaceLHEInterfaceFileReading,src/GeneratorInterface/LHEInterface/test))
endif
ifeq ($(strip $(testGeneratorInterfaceLHEInterface_TP)),)
testGeneratorInterfaceLHEInterface_TP := self/src/GeneratorInterface/LHEInterface/test
testGeneratorInterfaceLHEInterface_TP_files := $(patsubst src/GeneratorInterface/LHEInterface/test/%,%,$(foreach file,test_catch2_*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/LHEInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/LHEInterface/test/$(file). Please fix src/GeneratorInterface/LHEInterface/test/BuildFile.))))
testGeneratorInterfaceLHEInterface_TP_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/test/BuildFile
testGeneratorInterfaceLHEInterface_TP_LOC_USE := self   FWCore/TestProcessor SimDataFormats/GeneratorProducts catch2 
testGeneratorInterfaceLHEInterface_TP_PACKAGE := self/src/GeneratorInterface/LHEInterface/test
ALL_PRODS += testGeneratorInterfaceLHEInterface_TP
testGeneratorInterfaceLHEInterface_TP_INIT_FUNC        += $$(eval $$(call Binary,testGeneratorInterfaceLHEInterface_TP,src/GeneratorInterface/LHEInterface/test,src_GeneratorInterface_LHEInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testGeneratorInterfaceLHEInterface_TP_CLASS := TEST
testGeneratorInterfaceLHEInterface_TP_TEST_RUNNER_CMD :=  testGeneratorInterfaceLHEInterface_TP 
else
$(eval $(call MultipleWarningMsg,testGeneratorInterfaceLHEInterface_TP,src/GeneratorInterface/LHEInterface/test))
endif
ifeq ($(strip $(test_cmsLHEtoEOSManager)),)
test_cmsLHEtoEOSManager := self/src/GeneratorInterface/LHEInterface/test
test_cmsLHEtoEOSManager_files := 1
test_cmsLHEtoEOSManager_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/test/BuildFile
test_cmsLHEtoEOSManager_LOC_USE := self   
test_cmsLHEtoEOSManager_PACKAGE := self/src/GeneratorInterface/LHEInterface/test
ALL_PRODS += test_cmsLHEtoEOSManager
test_cmsLHEtoEOSManager_INIT_FUNC        += $$(eval $$(call Binary,test_cmsLHEtoEOSManager,src/GeneratorInterface/LHEInterface/test,src_GeneratorInterface_LHEInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test_cmsLHEtoEOSManager_CLASS := TEST
test_cmsLHEtoEOSManager_TEST_RUNNER_CMD :=  test_cmsLHEtoEOSManager.sh
else
$(eval $(call MultipleWarningMsg,test_cmsLHEtoEOSManager,src/GeneratorInterface/LHEInterface/test))
endif
ifeq ($(strip $(DummyLHEAnalyzer)),)
DummyLHEAnalyzer := self/src/GeneratorInterface/LHEInterface/test
DummyLHEAnalyzer_files := $(patsubst src/GeneratorInterface/LHEInterface/test/%,%,$(foreach file,DummyLHEAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/LHEInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/LHEInterface/test/$(file). Please fix src/GeneratorInterface/LHEInterface/test/BuildFile.))))
DummyLHEAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/test/BuildFile
DummyLHEAnalyzer_LOC_USE := self   SimDataFormats/GeneratorProducts FWCore/Framework 
DummyLHEAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,DummyLHEAnalyzer,DummyLHEAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/LHEInterface/test))
DummyLHEAnalyzer_PACKAGE := self/src/GeneratorInterface/LHEInterface/test
ALL_PRODS += DummyLHEAnalyzer
DummyLHEAnalyzer_INIT_FUNC        += $$(eval $$(call Library,DummyLHEAnalyzer,src/GeneratorInterface/LHEInterface/test,src_GeneratorInterface_LHEInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
DummyLHEAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,DummyLHEAnalyzer,src/GeneratorInterface/LHEInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_LHEInterface_test
src_GeneratorInterface_LHEInterface_test_parent := GeneratorInterface/LHEInterface
src_GeneratorInterface_LHEInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_LHEInterface_test,src/GeneratorInterface/LHEInterface/test,TEST))
