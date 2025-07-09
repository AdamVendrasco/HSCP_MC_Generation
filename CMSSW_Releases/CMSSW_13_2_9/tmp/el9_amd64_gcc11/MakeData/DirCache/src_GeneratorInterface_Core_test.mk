ifeq ($(strip $(FailingGeneratorFilterTest)),)
FailingGeneratorFilterTest := self/src/GeneratorInterface/Core/test
FailingGeneratorFilterTest_files := 1
FailingGeneratorFilterTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/test/BuildFile
FailingGeneratorFilterTest_LOC_USE := self   
FailingGeneratorFilterTest_PACKAGE := self/src/GeneratorInterface/Core/test
ALL_PRODS += FailingGeneratorFilterTest
FailingGeneratorFilterTest_INIT_FUNC        += $$(eval $$(call Binary,FailingGeneratorFilterTest,src/GeneratorInterface/Core/test,src_GeneratorInterface_Core_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
FailingGeneratorFilterTest_CLASS := TEST
FailingGeneratorFilterTest_TEST_RUNNER_CMD :=  ${LOCALTOP}/src/GeneratorInterface/Core/test/test_FailingGeneratorFilter.sh
else
$(eval $(call MultipleWarningMsg,FailingGeneratorFilterTest,src/GeneratorInterface/Core/test))
endif
ifeq ($(strip $(FailingGeneratorFilter)),)
FailingGeneratorFilter := self/src/GeneratorInterface/Core/test
FailingGeneratorFilter_files := $(patsubst src/GeneratorInterface/Core/test/%,%,$(foreach file,FailingGeneratorFilter.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Core/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Core/test/$(file). Please fix src/GeneratorInterface/Core/test/BuildFile.))))
FailingGeneratorFilter_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/test/BuildFile
FailingGeneratorFilter_LOC_USE := self   FWCore/Framework GeneratorInterface/Core 
FailingGeneratorFilter_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,FailingGeneratorFilter,FailingGeneratorFilter,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Core/test))
FailingGeneratorFilter_PACKAGE := self/src/GeneratorInterface/Core/test
ALL_PRODS += FailingGeneratorFilter
FailingGeneratorFilter_INIT_FUNC        += $$(eval $$(call Library,FailingGeneratorFilter,src/GeneratorInterface/Core/test,src_GeneratorInterface_Core_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
FailingGeneratorFilter_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,FailingGeneratorFilter,src/GeneratorInterface/Core/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_Core_test
src_GeneratorInterface_Core_test_parent := GeneratorInterface/Core
src_GeneratorInterface_Core_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_test,src/GeneratorInterface/Core/test,TEST))
