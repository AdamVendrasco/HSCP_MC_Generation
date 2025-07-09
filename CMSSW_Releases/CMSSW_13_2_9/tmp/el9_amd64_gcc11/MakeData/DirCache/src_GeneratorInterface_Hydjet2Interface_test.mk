ifeq ($(strip $(Hydjet2Analyzer)),)
Hydjet2Analyzer := self/src/GeneratorInterface/Hydjet2Interface/test
Hydjet2Analyzer_files := $(patsubst src/GeneratorInterface/Hydjet2Interface/test/%,%,$(foreach file,Hydjet2Analyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Hydjet2Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Hydjet2Interface/test/$(file). Please fix src/GeneratorInterface/Hydjet2Interface/test/BuildFile.))))
Hydjet2Analyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Hydjet2Interface/test/BuildFile
Hydjet2Analyzer_LOC_USE := self   boost root heppdt FWCore/Framework SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimDataFormats/HiGenData SimGeneral/HepPDTRecord CommonTools/UtilAlgos FWCore/ServiceRegistry FWCore/Utilities 
Hydjet2Analyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,Hydjet2Analyzer,Hydjet2Analyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Hydjet2Interface/test))
Hydjet2Analyzer_PACKAGE := self/src/GeneratorInterface/Hydjet2Interface/test
ALL_PRODS += Hydjet2Analyzer
Hydjet2Analyzer_INIT_FUNC        += $$(eval $$(call Library,Hydjet2Analyzer,src/GeneratorInterface/Hydjet2Interface/test,src_GeneratorInterface_Hydjet2Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
Hydjet2Analyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,Hydjet2Analyzer,src/GeneratorInterface/Hydjet2Interface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_Hydjet2Interface_test
src_GeneratorInterface_Hydjet2Interface_test_parent := GeneratorInterface/Hydjet2Interface
src_GeneratorInterface_Hydjet2Interface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Hydjet2Interface_test,src/GeneratorInterface/Hydjet2Interface/test,TEST))
