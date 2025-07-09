ifeq ($(strip $(testSimG4CoreFieldStepWatcher)),)
testSimG4CoreFieldStepWatcher := self/src/SimG4Core/MagneticField/test
testSimG4CoreFieldStepWatcher_files := $(patsubst src/SimG4Core/MagneticField/test/%,%,$(foreach file,FieldStepWatcher.cc,$(eval xfile:=$(wildcard src/SimG4Core/MagneticField/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/MagneticField/test/$(file). Please fix src/SimG4Core/MagneticField/test/BuildFile.))))
testSimG4CoreFieldStepWatcher_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/MagneticField/test/BuildFile
testSimG4CoreFieldStepWatcher_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet FWCore/MessageLogger DQMServices/Core geant4core boost root expat 
testSimG4CoreFieldStepWatcher_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,testSimG4CoreFieldStepWatcher,testSimG4CoreFieldStepWatcher,$(SCRAMSTORENAME_LIB),src/SimG4Core/MagneticField/test))
testSimG4CoreFieldStepWatcher_PACKAGE := self/src/SimG4Core/MagneticField/test
ALL_PRODS += testSimG4CoreFieldStepWatcher
testSimG4CoreFieldStepWatcher_INIT_FUNC        += $$(eval $$(call Library,testSimG4CoreFieldStepWatcher,src/SimG4Core/MagneticField/test,src_SimG4Core_MagneticField_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
testSimG4CoreFieldStepWatcher_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,testSimG4CoreFieldStepWatcher,src/SimG4Core/MagneticField/test))
endif
ALL_COMMONRULES += src_SimG4Core_MagneticField_test
src_SimG4Core_MagneticField_test_parent := SimG4Core/MagneticField
src_SimG4Core_MagneticField_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_MagneticField_test,src/SimG4Core/MagneticField/test,TEST))
