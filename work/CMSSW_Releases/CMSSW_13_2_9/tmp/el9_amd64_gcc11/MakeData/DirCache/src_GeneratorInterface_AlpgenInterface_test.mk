ifeq ($(strip $(GeneratorInterfaceAlpgenExtractor)),)
GeneratorInterfaceAlpgenExtractor := self/src/GeneratorInterface/AlpgenInterface/test
GeneratorInterfaceAlpgenExtractor_files := $(patsubst src/GeneratorInterface/AlpgenInterface/test/%,%,$(foreach file,AlpgenExtractor.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/AlpgenInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/AlpgenInterface/test/$(file). Please fix src/GeneratorInterface/AlpgenInterface/test/BuildFile.))))
GeneratorInterfaceAlpgenExtractor_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AlpgenInterface/test/BuildFile
GeneratorInterfaceAlpgenExtractor_LOC_USE := self   FWCore/Framework FWCore/ParameterSet SimDataFormats/GeneratorProducts 
GeneratorInterfaceAlpgenExtractor_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceAlpgenExtractor,GeneratorInterfaceAlpgenExtractor,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/AlpgenInterface/test))
GeneratorInterfaceAlpgenExtractor_PACKAGE := self/src/GeneratorInterface/AlpgenInterface/test
ALL_PRODS += GeneratorInterfaceAlpgenExtractor
GeneratorInterfaceAlpgenExtractor_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAlpgenExtractor,src/GeneratorInterface/AlpgenInterface/test,src_GeneratorInterface_AlpgenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceAlpgenExtractor_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceAlpgenExtractor,src/GeneratorInterface/AlpgenInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_AlpgenInterface_test
src_GeneratorInterface_AlpgenInterface_test_parent := GeneratorInterface/AlpgenInterface
src_GeneratorInterface_AlpgenInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AlpgenInterface_test,src/GeneratorInterface/AlpgenInterface/test,TEST))
