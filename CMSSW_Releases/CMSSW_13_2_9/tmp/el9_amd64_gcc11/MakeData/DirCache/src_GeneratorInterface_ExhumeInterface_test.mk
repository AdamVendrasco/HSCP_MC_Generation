ifeq ($(strip $(ExhumeAnalyzer)),)
ExhumeAnalyzer := self/src/GeneratorInterface/ExhumeInterface/test
ExhumeAnalyzer_files := $(patsubst src/GeneratorInterface/ExhumeInterface/test/%,%,$(foreach file,ExhumeAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/ExhumeInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/ExhumeInterface/test/$(file). Please fix src/GeneratorInterface/ExhumeInterface/test/BuildFile.))))
ExhumeAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ExhumeInterface/test/BuildFile
ExhumeAnalyzer_LOC_USE := self   FWCore/Framework FWCore/ParameterSet DataFormats/HepMCCandidate CommonTools/UtilAlgos roothistmatrix 
ExhumeAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,ExhumeAnalyzer,ExhumeAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/ExhumeInterface/test))
ExhumeAnalyzer_PACKAGE := self/src/GeneratorInterface/ExhumeInterface/test
ALL_PRODS += ExhumeAnalyzer
ExhumeAnalyzer_INIT_FUNC        += $$(eval $$(call Library,ExhumeAnalyzer,src/GeneratorInterface/ExhumeInterface/test,src_GeneratorInterface_ExhumeInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
ExhumeAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,ExhumeAnalyzer,src/GeneratorInterface/ExhumeInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExhumeInterface_test
src_GeneratorInterface_ExhumeInterface_test_parent := GeneratorInterface/ExhumeInterface
src_GeneratorInterface_ExhumeInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExhumeInterface_test,src/GeneratorInterface/ExhumeInterface/test,TEST))
