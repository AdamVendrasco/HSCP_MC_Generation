ifeq ($(strip $(HZZ4muExampleAnalyzer)),)
HZZ4muExampleAnalyzer := self/src/GeneratorInterface/Pythia6Interface/test
HZZ4muExampleAnalyzer_files := $(patsubst src/GeneratorInterface/Pythia6Interface/test/%,%,$(foreach file,HZZ4muAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia6Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia6Interface/test/$(file). Please fix src/GeneratorInterface/Pythia6Interface/test/BuildFile.))))
HZZ4muExampleAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia6Interface/test/BuildFile
HZZ4muExampleAnalyzer_LOC_USE := self   FWCore/Framework root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
HZZ4muExampleAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,HZZ4muExampleAnalyzer,HZZ4muExampleAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia6Interface/test))
HZZ4muExampleAnalyzer_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/test
ALL_PRODS += HZZ4muExampleAnalyzer
HZZ4muExampleAnalyzer_INIT_FUNC        += $$(eval $$(call Library,HZZ4muExampleAnalyzer,src/GeneratorInterface/Pythia6Interface/test,src_GeneratorInterface_Pythia6Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
HZZ4muExampleAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,HZZ4muExampleAnalyzer,src/GeneratorInterface/Pythia6Interface/test))
endif
ifeq ($(strip $(SimpleGenTesters)),)
SimpleGenTesters := self/src/GeneratorInterface/Pythia6Interface/test
SimpleGenTesters_files := $(patsubst src/GeneratorInterface/Pythia6Interface/test/%,%,$(foreach file,BasicGenTester.cc TauPhotonTester.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia6Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia6Interface/test/$(file). Please fix src/GeneratorInterface/Pythia6Interface/test/BuildFile.))))
SimpleGenTesters_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia6Interface/test/BuildFile
SimpleGenTesters_LOC_USE := self   FWCore/Framework root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos heppdt SimGeneral/HepPDTRecord 
SimpleGenTesters_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimpleGenTesters,SimpleGenTesters,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia6Interface/test))
SimpleGenTesters_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/test
ALL_PRODS += SimpleGenTesters
SimpleGenTesters_INIT_FUNC        += $$(eval $$(call Library,SimpleGenTesters,src/GeneratorInterface/Pythia6Interface/test,src_GeneratorInterface_Pythia6Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimpleGenTesters_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimpleGenTesters,src/GeneratorInterface/Pythia6Interface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia6Interface_test
src_GeneratorInterface_Pythia6Interface_test_parent := GeneratorInterface/Pythia6Interface
src_GeneratorInterface_Pythia6Interface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia6Interface_test,src/GeneratorInterface/Pythia6Interface/test,TEST))
