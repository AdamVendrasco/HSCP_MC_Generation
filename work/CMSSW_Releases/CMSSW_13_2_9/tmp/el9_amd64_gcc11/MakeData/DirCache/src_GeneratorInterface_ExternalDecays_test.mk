ifeq ($(strip $(EvtGenTestAnalyzer)),)
EvtGenTestAnalyzer := self/src/GeneratorInterface/ExternalDecays/test
EvtGenTestAnalyzer_files := $(patsubst src/GeneratorInterface/ExternalDecays/test/%,%,$(foreach file,EvtGenTestAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/ExternalDecays/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/ExternalDecays/test/$(file). Please fix src/GeneratorInterface/ExternalDecays/test/BuildFile.))))
EvtGenTestAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ExternalDecays/test/BuildFile
EvtGenTestAnalyzer_LOC_USE := self   boost hepmc root FWCore/Framework CommonTools/UtilAlgos FWCore/ServiceRegistry SimDataFormats/GeneratorProducts 
EvtGenTestAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,EvtGenTestAnalyzer,EvtGenTestAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/ExternalDecays/test))
EvtGenTestAnalyzer_PACKAGE := self/src/GeneratorInterface/ExternalDecays/test
ALL_PRODS += EvtGenTestAnalyzer
EvtGenTestAnalyzer_INIT_FUNC        += $$(eval $$(call Library,EvtGenTestAnalyzer,src/GeneratorInterface/ExternalDecays/test,src_GeneratorInterface_ExternalDecays_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
EvtGenTestAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,EvtGenTestAnalyzer,src/GeneratorInterface/ExternalDecays/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExternalDecays_test
src_GeneratorInterface_ExternalDecays_test_parent := GeneratorInterface/ExternalDecays
src_GeneratorInterface_ExternalDecays_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExternalDecays_test,src/GeneratorInterface/ExternalDecays/test,TEST))
