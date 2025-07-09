ifeq ($(strip $(SimDigiDumper)),)
SimDigiDumper := self/src/SimGeneral/Debugging/test
SimDigiDumper_files := $(patsubst src/SimGeneral/Debugging/test/%,%,$(foreach file,SimDigiDumper.cc,$(eval xfile:=$(wildcard src/SimGeneral/Debugging/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/Debugging/test/$(file). Please fix src/SimGeneral/Debugging/test/BuildFile.))))
SimDigiDumper_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/Debugging/test/BuildFile
SimDigiDumper_LOC_USE := self   DataFormats/Common DataFormats/EcalDigi DataFormats/HcalDigi DataFormats/SiStripDigi DataFormats/SiPixelDigi DataFormats/DTDigi DataFormats/CSCDigi DataFormats/RPCDigi DataFormats/FTLDigi FWCore/Framework FWCore/MessageLogger 
SimDigiDumper_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimDigiDumper,SimDigiDumper,$(SCRAMSTORENAME_LIB),src/SimGeneral/Debugging/test))
SimDigiDumper_PACKAGE := self/src/SimGeneral/Debugging/test
ALL_PRODS += SimDigiDumper
SimDigiDumper_INIT_FUNC        += $$(eval $$(call Library,SimDigiDumper,src/SimGeneral/Debugging/test,src_SimGeneral_Debugging_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimDigiDumper_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimDigiDumper,src/SimGeneral/Debugging/test))
endif
ALL_COMMONRULES += src_SimGeneral_Debugging_test
src_SimGeneral_Debugging_test_parent := SimGeneral/Debugging
src_SimGeneral_Debugging_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_Debugging_test,src/SimGeneral/Debugging/test,TEST))
