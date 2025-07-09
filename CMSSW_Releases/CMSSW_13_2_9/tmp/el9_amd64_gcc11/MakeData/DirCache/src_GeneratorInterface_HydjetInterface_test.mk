ifeq ($(strip $(HydjetAnalyzer)),)
HydjetAnalyzer := self/src/GeneratorInterface/HydjetInterface/test
HydjetAnalyzer_files := $(patsubst src/GeneratorInterface/HydjetInterface/test/%,%,$(foreach file,HydjetAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/HydjetInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/HydjetInterface/test/$(file). Please fix src/GeneratorInterface/HydjetInterface/test/BuildFile.))))
HydjetAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HydjetInterface/test/BuildFile
HydjetAnalyzer_LOC_USE := self   boost root heppdt FWCore/Framework SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimDataFormats/HiGenData SimGeneral/HepPDTRecord CommonTools/UtilAlgos FWCore/ServiceRegistry FWCore/Utilities 
HydjetAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,HydjetAnalyzer,HydjetAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/HydjetInterface/test))
HydjetAnalyzer_PACKAGE := self/src/GeneratorInterface/HydjetInterface/test
ALL_PRODS += HydjetAnalyzer
HydjetAnalyzer_INIT_FUNC        += $$(eval $$(call Library,HydjetAnalyzer,src/GeneratorInterface/HydjetInterface/test,src_GeneratorInterface_HydjetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
HydjetAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,HydjetAnalyzer,src/GeneratorInterface/HydjetInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_HydjetInterface_test
src_GeneratorInterface_HydjetInterface_test_parent := GeneratorInterface/HydjetInterface
src_GeneratorInterface_HydjetInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HydjetInterface_test,src/GeneratorInterface/HydjetInterface/test,TEST))
