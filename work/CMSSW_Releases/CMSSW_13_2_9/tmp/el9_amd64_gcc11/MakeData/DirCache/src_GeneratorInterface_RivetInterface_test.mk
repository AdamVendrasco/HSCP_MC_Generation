ifeq ($(strip $(test-rivet-list)),)
test-rivet-list := self/src/GeneratorInterface/RivetInterface/test
test-rivet-list_files := 1
test-rivet-list_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-rivet-list_LOC_USE := self   
test-rivet-list_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-rivet-list
test-rivet-list_INIT_FUNC        += $$(eval $$(call Binary,test-rivet-list,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-rivet-list_CLASS := TEST
test-rivet-list_TEST_RUNNER_CMD :=  test-rivet-list.sh
else
$(eval $(call MultipleWarningMsg,test-rivet-list,src/GeneratorInterface/RivetInterface/test))
endif
ifeq ($(strip $(test-rivet-nan)),)
test-rivet-nan := self/src/GeneratorInterface/RivetInterface/test
test-rivet-nan_files := 1
test-rivet-nan_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-rivet-nan_LOC_USE := self   
test-rivet-nan_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-rivet-nan
test-rivet-nan_INIT_FUNC        += $$(eval $$(call Binary,test-rivet-nan,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-rivet-nan_CLASS := TEST
test-rivet-nan_TEST_RUNNER_CMD :=  test-rivet-nan.sh
test-rivet-nan_PRE_TEST := test-rivet-run
else
$(eval $(call MultipleWarningMsg,test-rivet-nan,src/GeneratorInterface/RivetInterface/test))
endif
ifeq ($(strip $(test-rivet-run)),)
test-rivet-run := self/src/GeneratorInterface/RivetInterface/test
test-rivet-run_files := 1
test-rivet-run_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-rivet-run_LOC_USE := self   
test-rivet-run_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-rivet-run
test-rivet-run_INIT_FUNC        += $$(eval $$(call Binary,test-rivet-run,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-rivet-run_CLASS := TEST
test-rivet-run_TEST_RUNNER_CMD :=  test-rivet-run.sh
else
$(eval $(call MultipleWarningMsg,test-rivet-run,src/GeneratorInterface/RivetInterface/test))
endif
ifeq ($(strip $(test-yoda-merge)),)
test-yoda-merge := self/src/GeneratorInterface/RivetInterface/test
test-yoda-merge_files := 1
test-yoda-merge_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-yoda-merge_LOC_USE := self   
test-yoda-merge_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-yoda-merge
test-yoda-merge_INIT_FUNC        += $$(eval $$(call Binary,test-yoda-merge,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-yoda-merge_CLASS := TEST
test-yoda-merge_TEST_RUNNER_CMD :=  test-yoda-merge.sh
test-yoda-merge_PRE_TEST := test-rivet-run
else
$(eval $(call MultipleWarningMsg,test-yoda-merge,src/GeneratorInterface/RivetInterface/test))
endif
ifeq ($(strip $(test-yoda-root)),)
test-yoda-root := self/src/GeneratorInterface/RivetInterface/test
test-yoda-root_files := 1
test-yoda-root_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-yoda-root_LOC_USE := self   
test-yoda-root_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-yoda-root
test-yoda-root_INIT_FUNC        += $$(eval $$(call Binary,test-yoda-root,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-yoda-root_CLASS := TEST
test-yoda-root_TEST_RUNNER_CMD :=  test-yoda-root.sh
test-yoda-root_PRE_TEST := test-rivet-run
else
$(eval $(call MultipleWarningMsg,test-yoda-root,src/GeneratorInterface/RivetInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_test
src_GeneratorInterface_RivetInterface_test_parent := GeneratorInterface/RivetInterface
src_GeneratorInterface_RivetInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_test,src/GeneratorInterface/RivetInterface/test,TEST))
