ifeq ($(strip $(AMPTAnalyzer)),)
AMPTAnalyzer := self/src/GeneratorInterface/AMPTInterface/test
AMPTAnalyzer_files := $(patsubst src/GeneratorInterface/AMPTInterface/test/%,%,$(foreach file,AMPTAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/AMPTInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/AMPTInterface/test/$(file). Please fix src/GeneratorInterface/AMPTInterface/test/BuildFile.))))
AMPTAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AMPTInterface/test/BuildFile
AMPTAnalyzer_LOC_USE := self   boost root heppdt GeneratorInterface/AMPTInterface FWCore/Framework SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimGeneral/HepPDTRecord CommonTools/UtilAlgos FWCore/ServiceRegistry FWCore/Utilities 
AMPTAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,AMPTAnalyzer,AMPTAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/AMPTInterface/test))
AMPTAnalyzer_PACKAGE := self/src/GeneratorInterface/AMPTInterface/test
ALL_PRODS += AMPTAnalyzer
AMPTAnalyzer_INIT_FUNC        += $$(eval $$(call Library,AMPTAnalyzer,src/GeneratorInterface/AMPTInterface/test,src_GeneratorInterface_AMPTInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
AMPTAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,AMPTAnalyzer,src/GeneratorInterface/AMPTInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_AMPTInterface_test
src_GeneratorInterface_AMPTInterface_test_parent := GeneratorInterface/AMPTInterface
src_GeneratorInterface_AMPTInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AMPTInterface_test,src/GeneratorInterface/AMPTInterface/test,TEST))
