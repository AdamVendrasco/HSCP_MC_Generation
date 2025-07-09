ifeq ($(strip $(SimG4CoreWatcherTest)),)
SimG4CoreWatcherTest := self/src/SimG4Core/Watcher/test
SimG4CoreWatcherTest_files := $(patsubst src/SimG4Core/Watcher/test/%,%,$(foreach file,IntSimProducer.cc,$(eval xfile:=$(wildcard src/SimG4Core/Watcher/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Watcher/test/$(file). Please fix src/SimG4Core/Watcher/test/BuildFile.))))
SimG4CoreWatcherTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Watcher/test/BuildFile
SimG4CoreWatcherTest_LOC_USE := self   FWCore/Framework SimG4Core/Watcher boost 
SimG4CoreWatcherTest_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreWatcherTest,SimG4CoreWatcherTest,$(SCRAMSTORENAME_LIB),src/SimG4Core/Watcher/test))
SimG4CoreWatcherTest_PACKAGE := self/src/SimG4Core/Watcher/test
ALL_PRODS += SimG4CoreWatcherTest
SimG4CoreWatcherTest_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreWatcherTest,src/SimG4Core/Watcher/test,src_SimG4Core_Watcher_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CoreWatcherTest_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CoreWatcherTest,src/SimG4Core/Watcher/test))
endif
ALL_COMMONRULES += src_SimG4Core_Watcher_test
src_SimG4Core_Watcher_test_parent := SimG4Core/Watcher
src_SimG4Core_Watcher_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Watcher_test,src/SimG4Core/Watcher/test,TEST))
