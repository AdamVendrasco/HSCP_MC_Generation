ifeq ($(strip $(SimFileCompare)),)
SimFileCompare := self/src/SimG4Core/PrintGeomInfo/test
SimFileCompare_files := $(patsubst src/SimG4Core/PrintGeomInfo/test/%,%,$(foreach file,SimFileCompare.cpp,$(eval xfile:=$(wildcard src/SimG4Core/PrintGeomInfo/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/PrintGeomInfo/test/$(file). Please fix src/SimG4Core/PrintGeomInfo/test/BuildFile.))))
SimFileCompare_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PrintGeomInfo/test/BuildFile
SimFileCompare_LOC_USE := self   SimG4Core/Geometry 
SimFileCompare_PACKAGE := self/src/SimG4Core/PrintGeomInfo/test
ALL_PRODS += SimFileCompare
SimFileCompare_INIT_FUNC        += $$(eval $$(call Binary,SimFileCompare,src/SimG4Core/PrintGeomInfo/test,src_SimG4Core_PrintGeomInfo_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
SimFileCompare_CLASS := TEST
SimFileCompare_TEST_RUNNER_CMD :=  SimFileCompare 
else
$(eval $(call MultipleWarningMsg,SimFileCompare,src/SimG4Core/PrintGeomInfo/test))
endif
ALL_COMMONRULES += src_SimG4Core_PrintGeomInfo_test
src_SimG4Core_PrintGeomInfo_test_parent := SimG4Core/PrintGeomInfo
src_SimG4Core_PrintGeomInfo_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_PrintGeomInfo_test,src/SimG4Core/PrintGeomInfo/test,TEST))
