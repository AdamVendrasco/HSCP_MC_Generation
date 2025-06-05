ALL_SUBSYSTEMS+=GeneratorInterface
subdirs_src_GeneratorInterface = src_GeneratorInterface_Pythia8Interface
subdirs_src += src_GeneratorInterface
ALL_PACKAGES += GeneratorInterface/Pythia8Interface
subdirs_src_GeneratorInterface_Pythia8Interface := src_GeneratorInterface_Pythia8Interface_plugins src_GeneratorInterface_Pythia8Interface_python src_GeneratorInterface_Pythia8Interface_src src_GeneratorInterface_Pythia8Interface_test
ifeq ($(strip $(PyGeneratorInterfacePythia8Interface)),)
PyGeneratorInterfacePythia8Interface := self/src/GeneratorInterface/Pythia8Interface/python
src_GeneratorInterface_Pythia8Interface_python_parent := src/GeneratorInterface/Pythia8Interface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Pythia8Interface/python)
PyGeneratorInterfacePythia8Interface_files := $(patsubst src/GeneratorInterface/Pythia8Interface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Pythia8Interface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfacePythia8Interface_LOC_USE := self   
PyGeneratorInterfacePythia8Interface_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/python
ALL_PRODS += PyGeneratorInterfacePythia8Interface
PyGeneratorInterfacePythia8Interface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfacePythia8Interface,src/GeneratorInterface/Pythia8Interface/python,src_GeneratorInterface_Pythia8Interface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfacePythia8Interface,src/GeneratorInterface/Pythia8Interface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia8Interface_python
src_GeneratorInterface_Pythia8Interface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia8Interface_python,src/GeneratorInterface/Pythia8Interface/python,PYTHON))
ALL_SUBSYSTEMS+=Configuration
subdirs_src_Configuration = src_Configuration_GenProduction
subdirs_src += src_Configuration
ALL_PACKAGES += Configuration/GenProduction
subdirs_src_Configuration_GenProduction := src_Configuration_GenProduction_python
ifeq ($(strip $(PyConfigurationGenProduction)),)
PyConfigurationGenProduction := self/src/Configuration/GenProduction/python
src_Configuration_GenProduction_python_parent := src/Configuration/GenProduction
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/Configuration/GenProduction/python)
PyConfigurationGenProduction_files := $(patsubst src/Configuration/GenProduction/python/%,%,$(wildcard $(foreach dir,src/Configuration/GenProduction/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyConfigurationGenProduction_LOC_USE := self   
PyConfigurationGenProduction_PACKAGE := self/src/Configuration/GenProduction/python
ALL_PRODS += PyConfigurationGenProduction
PyConfigurationGenProduction_INIT_FUNC        += $$(eval $$(call PythonProduct,PyConfigurationGenProduction,src/Configuration/GenProduction/python,src_Configuration_GenProduction_python))
else
$(eval $(call MultipleWarningMsg,PyConfigurationGenProduction,src/Configuration/GenProduction/python))
endif
ALL_COMMONRULES += src_Configuration_GenProduction_python
src_Configuration_GenProduction_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_Configuration_GenProduction_python,src/Configuration/GenProduction/python,PYTHON))
ifeq ($(strip $(TestGeneratorInterfacePythia8ConcurrentGeneratorFilter)),)
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter := self/src/GeneratorInterface/Pythia8Interface/test
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_files := 1
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += TestGeneratorInterfacePythia8ConcurrentGeneratorFilter
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfacePythia8ConcurrentGeneratorFilter,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_CLASS := TEST
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_TEST_RUNNER_CMD :=  ${LOCALTOP}/src/GeneratorInterface/Pythia8Interface/test/test_Pythia8ConcurrentGeneratorFilter_WZ_TuneCP5_13TeV-pythia8.sh
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfacePythia8ConcurrentGeneratorFilter,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(TestGeneratorInterfacePythia8InterfaceCompareExternal)),)
TestGeneratorInterfacePythia8InterfaceCompareExternal := self/src/GeneratorInterface/Pythia8Interface/test
TestGeneratorInterfacePythia8InterfaceCompareExternal_files := 1
TestGeneratorInterfacePythia8InterfaceCompareExternal_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
TestGeneratorInterfacePythia8InterfaceCompareExternal_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
TestGeneratorInterfacePythia8InterfaceCompareExternal_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += TestGeneratorInterfacePythia8InterfaceCompareExternal
TestGeneratorInterfacePythia8InterfaceCompareExternal_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfacePythia8InterfaceCompareExternal,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfacePythia8InterfaceCompareExternal_CLASS := TEST
TestGeneratorInterfacePythia8InterfaceCompareExternal_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/Pythia8Interface/test/compare_external_generators_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfacePythia8InterfaceCompareExternal,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(TestGeneratorInterfacePythia8InterfaceCompareExternalStreams)),)
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams := self/src/GeneratorInterface/Pythia8Interface/test
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_files := 1
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += TestGeneratorInterfacePythia8InterfaceCompareExternalStreams
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfacePythia8InterfaceCompareExternalStreams,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_CLASS := TEST
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/Pythia8Interface/test/compare_external_generators_streams_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfacePythia8InterfaceCompareExternalStreams,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(TestGeneratorInterfacePythia8InterfaceCompareIdentical)),)
TestGeneratorInterfacePythia8InterfaceCompareIdentical := self/src/GeneratorInterface/Pythia8Interface/test
TestGeneratorInterfacePythia8InterfaceCompareIdentical_files := 1
TestGeneratorInterfacePythia8InterfaceCompareIdentical_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
TestGeneratorInterfacePythia8InterfaceCompareIdentical_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
TestGeneratorInterfacePythia8InterfaceCompareIdentical_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += TestGeneratorInterfacePythia8InterfaceCompareIdentical
TestGeneratorInterfacePythia8InterfaceCompareIdentical_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfacePythia8InterfaceCompareIdentical,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfacePythia8InterfaceCompareIdentical_CLASS := TEST
TestGeneratorInterfacePythia8InterfaceCompareIdentical_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/Pythia8Interface/test/compare_identical_generators_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfacePythia8InterfaceCompareIdentical,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(testGeneratorInterfacePythia8InterfaceTP)),)
testGeneratorInterfacePythia8InterfaceTP := self/src/GeneratorInterface/Pythia8Interface/test
testGeneratorInterfacePythia8InterfaceTP_files := $(patsubst src/GeneratorInterface/Pythia8Interface/test/%,%,$(foreach file,test_catch2_*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/test/$(file). Please fix src/GeneratorInterface/Pythia8Interface/test/BuildFile.))))
testGeneratorInterfacePythia8InterfaceTP_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
testGeneratorInterfacePythia8InterfaceTP_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos FWCore/TestProcessor catch2 
testGeneratorInterfacePythia8InterfaceTP_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += testGeneratorInterfacePythia8InterfaceTP
testGeneratorInterfacePythia8InterfaceTP_INIT_FUNC        += $$(eval $$(call Binary,testGeneratorInterfacePythia8InterfaceTP,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testGeneratorInterfacePythia8InterfaceTP_CLASS := TEST
testGeneratorInterfacePythia8InterfaceTP_TEST_RUNNER_CMD :=  testGeneratorInterfacePythia8InterfaceTP 
else
$(eval $(call MultipleWarningMsg,testGeneratorInterfacePythia8InterfaceTP,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(ZJetsTestAnalyzer)),)
ZJetsTestAnalyzer := self/src/GeneratorInterface/Pythia8Interface/test
ZJetsTestAnalyzer_files := $(patsubst src/GeneratorInterface/Pythia8Interface/test/%,%,$(foreach file,ZJetsAnalyzer.cc analyserhepmc/LeptonAnalyserHepMC.cc analyserhepmc/JetInputHepMC.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/test/$(file). Please fix src/GeneratorInterface/Pythia8Interface/test/BuildFile.))))
ZJetsTestAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
ZJetsTestAnalyzer_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
ZJetsTestAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,ZJetsTestAnalyzer,ZJetsTestAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia8Interface/test))
ZJetsTestAnalyzer_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += ZJetsTestAnalyzer
ZJetsTestAnalyzer_INIT_FUNC        += $$(eval $$(call Library,ZJetsTestAnalyzer,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
ZJetsTestAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,ZJetsTestAnalyzer,src/GeneratorInterface/Pythia8Interface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia8Interface_test
src_GeneratorInterface_Pythia8Interface_test_parent := GeneratorInterface/Pythia8Interface
src_GeneratorInterface_Pythia8Interface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia8Interface_test,src/GeneratorInterface/Pythia8Interface/test,TEST))
