ifeq ($(strip $(HepPDTAnalyzer)),)
HepPDTAnalyzer := self/src/SimGeneral/HepPDTESSource/test
HepPDTAnalyzer_files := $(patsubst src/SimGeneral/HepPDTESSource/test/%,%,$(foreach file,HepPDTAnalyzer.cc,$(eval xfile:=$(wildcard src/SimGeneral/HepPDTESSource/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/HepPDTESSource/test/$(file). Please fix src/SimGeneral/HepPDTESSource/test/BuildFile.))))
HepPDTAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/HepPDTESSource/test/BuildFile
HepPDTAnalyzer_LOC_USE := self   SimGeneral/HepPDTRecord FWCore/Framework FWCore/ParameterSet SimDataFormats/GeneratorProducts 
HepPDTAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,HepPDTAnalyzer,HepPDTAnalyzer,$(SCRAMSTORENAME_LIB),src/SimGeneral/HepPDTESSource/test))
HepPDTAnalyzer_PACKAGE := self/src/SimGeneral/HepPDTESSource/test
ALL_PRODS += HepPDTAnalyzer
HepPDTAnalyzer_INIT_FUNC        += $$(eval $$(call Library,HepPDTAnalyzer,src/SimGeneral/HepPDTESSource/test,src_SimGeneral_HepPDTESSource_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
HepPDTAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,HepPDTAnalyzer,src/SimGeneral/HepPDTESSource/test))
endif
ALL_COMMONRULES += src_SimGeneral_HepPDTESSource_test
src_SimGeneral_HepPDTESSource_test_parent := SimGeneral/HepPDTESSource
src_SimGeneral_HepPDTESSource_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTESSource_test,src/SimGeneral/HepPDTESSource/test,TEST))
