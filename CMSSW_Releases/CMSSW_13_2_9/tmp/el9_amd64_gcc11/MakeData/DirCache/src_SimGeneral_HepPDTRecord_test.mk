ifeq ($(strip $(testSimGeneralHepPDTRecord)),)
testSimGeneralHepPDTRecord := self/src/SimGeneral/HepPDTRecord/test
testSimGeneralHepPDTRecord_files := $(patsubst src/SimGeneral/HepPDTRecord/test/%,%,$(foreach file,testPdtEntry.cc testRunner.cpp,$(eval xfile:=$(wildcard src/SimGeneral/HepPDTRecord/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/HepPDTRecord/test/$(file). Please fix src/SimGeneral/HepPDTRecord/test/BuildFile.))))
testSimGeneralHepPDTRecord_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/HepPDTRecord/test/BuildFile
testSimGeneralHepPDTRecord_LOC_USE := self   SimGeneral/HepPDTRecord cppunit 
testSimGeneralHepPDTRecord_PACKAGE := self/src/SimGeneral/HepPDTRecord/test
ALL_PRODS += testSimGeneralHepPDTRecord
testSimGeneralHepPDTRecord_INIT_FUNC        += $$(eval $$(call Binary,testSimGeneralHepPDTRecord,src/SimGeneral/HepPDTRecord/test,src_SimGeneral_HepPDTRecord_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testSimGeneralHepPDTRecord_CLASS := TEST
testSimGeneralHepPDTRecord_TEST_RUNNER_CMD :=  testSimGeneralHepPDTRecord 
else
$(eval $(call MultipleWarningMsg,testSimGeneralHepPDTRecord,src/SimGeneral/HepPDTRecord/test))
endif
ALL_COMMONRULES += src_SimGeneral_HepPDTRecord_test
src_SimGeneral_HepPDTRecord_test_parent := SimGeneral/HepPDTRecord
src_SimGeneral_HepPDTRecord_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTRecord_test,src/SimGeneral/HepPDTRecord/test,TEST))
