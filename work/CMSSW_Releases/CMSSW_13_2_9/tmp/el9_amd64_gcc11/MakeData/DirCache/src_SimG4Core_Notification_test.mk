ifeq ($(strip $(testSimG4CoreNotifications)),)
testSimG4CoreNotifications := self/src/SimG4Core/Notification/test
testSimG4CoreNotifications_files := $(patsubst src/SimG4Core/Notification/test/%,%,$(foreach file,simactivityregistry_t.cppunit.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Notification/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Notification/test/$(file). Please fix src/SimG4Core/Notification/test/BuildFile.))))
testSimG4CoreNotifications_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Notification/test/BuildFile
testSimG4CoreNotifications_LOC_USE := self   cppunit SimG4Core/Notification 
testSimG4CoreNotifications_PACKAGE := self/src/SimG4Core/Notification/test
ALL_PRODS += testSimG4CoreNotifications
testSimG4CoreNotifications_INIT_FUNC        += $$(eval $$(call Binary,testSimG4CoreNotifications,src/SimG4Core/Notification/test,src_SimG4Core_Notification_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testSimG4CoreNotifications_CLASS := TEST
testSimG4CoreNotifications_TEST_RUNNER_CMD :=  testSimG4CoreNotifications 
else
$(eval $(call MultipleWarningMsg,testSimG4CoreNotifications,src/SimG4Core/Notification/test))
endif
ALL_COMMONRULES += src_SimG4Core_Notification_test
src_SimG4Core_Notification_test_parent := SimG4Core/Notification
src_SimG4Core_Notification_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Notification_test,src/SimG4Core/Notification/test,TEST))
