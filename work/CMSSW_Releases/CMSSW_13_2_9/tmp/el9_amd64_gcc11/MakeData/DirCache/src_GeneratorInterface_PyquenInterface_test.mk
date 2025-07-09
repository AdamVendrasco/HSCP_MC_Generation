ifeq ($(strip $(PyquenAnalyzer)),)
PyquenAnalyzer := self/src/GeneratorInterface/PyquenInterface/test
PyquenAnalyzer_files := $(patsubst src/GeneratorInterface/PyquenInterface/test/%,%,$(foreach file,PyquenAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/PyquenInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/PyquenInterface/test/$(file). Please fix src/GeneratorInterface/PyquenInterface/test/BuildFile.))))
PyquenAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PyquenInterface/test/BuildFile
PyquenAnalyzer_LOC_USE := self   boost root SimDataFormats/GeneratorProducts SimDataFormats/HiGenData CommonTools/UtilAlgos FWCore/Framework 
PyquenAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,PyquenAnalyzer,PyquenAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/PyquenInterface/test))
PyquenAnalyzer_PACKAGE := self/src/GeneratorInterface/PyquenInterface/test
ALL_PRODS += PyquenAnalyzer
PyquenAnalyzer_INIT_FUNC        += $$(eval $$(call Library,PyquenAnalyzer,src/GeneratorInterface/PyquenInterface/test,src_GeneratorInterface_PyquenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
PyquenAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,PyquenAnalyzer,src/GeneratorInterface/PyquenInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_PyquenInterface_test
src_GeneratorInterface_PyquenInterface_test_parent := GeneratorInterface/PyquenInterface
src_GeneratorInterface_PyquenInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_PyquenInterface_test,src/GeneratorInterface/PyquenInterface/test,TEST))
