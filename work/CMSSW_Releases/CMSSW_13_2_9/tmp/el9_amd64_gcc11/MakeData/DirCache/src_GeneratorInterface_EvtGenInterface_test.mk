ifeq ($(strip $(GeneratorInterfaceEvtGenInterfaceTest)),)
GeneratorInterfaceEvtGenInterfaceTest := self/src/GeneratorInterface/EvtGenInterface/test
GeneratorInterfaceEvtGenInterfaceTest_files := 1
GeneratorInterfaceEvtGenInterfaceTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/test/BuildFile
GeneratorInterfaceEvtGenInterfaceTest_LOC_USE := self   
GeneratorInterfaceEvtGenInterfaceTest_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/test
ALL_PRODS += GeneratorInterfaceEvtGenInterfaceTest
GeneratorInterfaceEvtGenInterfaceTest_INIT_FUNC        += $$(eval $$(call Binary,GeneratorInterfaceEvtGenInterfaceTest,src/GeneratorInterface/EvtGenInterface/test,src_GeneratorInterface_EvtGenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
GeneratorInterfaceEvtGenInterfaceTest_CLASS := TEST
GeneratorInterfaceEvtGenInterfaceTest_TEST_RUNNER_CMD :=  runevtgentests.sh
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceEvtGenInterfaceTest,src/GeneratorInterface/EvtGenInterface/test))
endif
ifeq ($(strip $(TestGeneratorInterfaceEvtGenInterface_bplus)),)
TestGeneratorInterfaceEvtGenInterface_bplus := self/src/GeneratorInterface/EvtGenInterface/test
TestGeneratorInterfaceEvtGenInterface_bplus_files := 1
TestGeneratorInterfaceEvtGenInterface_bplus_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/test/BuildFile
TestGeneratorInterfaceEvtGenInterface_bplus_LOC_USE := self   
TestGeneratorInterfaceEvtGenInterface_bplus_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/test
ALL_PRODS += TestGeneratorInterfaceEvtGenInterface_bplus
TestGeneratorInterfaceEvtGenInterface_bplus_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfaceEvtGenInterface_bplus,src/GeneratorInterface/EvtGenInterface/test,src_GeneratorInterface_EvtGenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfaceEvtGenInterface_bplus_CLASS := TEST
TestGeneratorInterfaceEvtGenInterface_bplus_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/EvtGenInterface/test/Py8_bplus_evtgen1_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfaceEvtGenInterface_bplus,src/GeneratorInterface/EvtGenInterface/test))
endif
ifeq ($(strip $(TestGeneratorInterfaceEvtGenInterface_external_bplus)),)
TestGeneratorInterfaceEvtGenInterface_external_bplus := self/src/GeneratorInterface/EvtGenInterface/test
TestGeneratorInterfaceEvtGenInterface_external_bplus_files := 1
TestGeneratorInterfaceEvtGenInterface_external_bplus_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/test/BuildFile
TestGeneratorInterfaceEvtGenInterface_external_bplus_LOC_USE := self   
TestGeneratorInterfaceEvtGenInterface_external_bplus_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/test
ALL_PRODS += TestGeneratorInterfaceEvtGenInterface_external_bplus
TestGeneratorInterfaceEvtGenInterface_external_bplus_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfaceEvtGenInterface_external_bplus,src/GeneratorInterface/EvtGenInterface/test,src_GeneratorInterface_EvtGenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfaceEvtGenInterface_external_bplus_CLASS := TEST
TestGeneratorInterfaceEvtGenInterface_external_bplus_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/EvtGenInterface/test/external_Py8_bplus_evtgen1_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfaceEvtGenInterface_external_bplus,src/GeneratorInterface/EvtGenInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_EvtGenInterface_test
src_GeneratorInterface_EvtGenInterface_test_parent := GeneratorInterface/EvtGenInterface
src_GeneratorInterface_EvtGenInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_EvtGenInterface_test,src/GeneratorInterface/EvtGenInterface/test,TEST))
