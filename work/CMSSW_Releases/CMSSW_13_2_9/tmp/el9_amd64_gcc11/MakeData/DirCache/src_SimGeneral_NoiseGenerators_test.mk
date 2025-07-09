ifeq ($(strip $(CorrelatedNoisifierTest)),)
CorrelatedNoisifierTest := self/src/SimGeneral/NoiseGenerators/test
CorrelatedNoisifierTest_files := $(patsubst src/SimGeneral/NoiseGenerators/test/%,%,$(foreach file,CorrelatedNoisifierTest.cpp,$(eval xfile:=$(wildcard src/SimGeneral/NoiseGenerators/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/NoiseGenerators/test/$(file). Please fix src/SimGeneral/NoiseGenerators/test/BuildFile.))))
CorrelatedNoisifierTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/NoiseGenerators/test/BuildFile
CorrelatedNoisifierTest_LOC_USE := self   clhep root FWCore/Framework FWCore/ServiceRegistry FWCore/Utilities SimGeneral/NoiseGenerators CommonTools/Statistics 
CorrelatedNoisifierTest_PACKAGE := self/src/SimGeneral/NoiseGenerators/test
ALL_PRODS += CorrelatedNoisifierTest
CorrelatedNoisifierTest_INIT_FUNC        += $$(eval $$(call Binary,CorrelatedNoisifierTest,src/SimGeneral/NoiseGenerators/test,src_SimGeneral_NoiseGenerators_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
CorrelatedNoisifierTest_CLASS := TEST
CorrelatedNoisifierTest_TEST_RUNNER_CMD :=  CorrelatedNoisifierTest 
else
$(eval $(call MultipleWarningMsg,CorrelatedNoisifierTest,src/SimGeneral/NoiseGenerators/test))
endif
ifeq ($(strip $(GaussianTailNoiseGeneratorTest)),)
GaussianTailNoiseGeneratorTest := self/src/SimGeneral/NoiseGenerators/test
GaussianTailNoiseGeneratorTest_files := $(patsubst src/SimGeneral/NoiseGenerators/test/%,%,$(foreach file,GaussianTailNoiseGeneratorTest.cc,$(eval xfile:=$(wildcard src/SimGeneral/NoiseGenerators/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/NoiseGenerators/test/$(file). Please fix src/SimGeneral/NoiseGenerators/test/BuildFile.))))
GaussianTailNoiseGeneratorTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/NoiseGenerators/test/BuildFile
GaussianTailNoiseGeneratorTest_LOC_USE := self   clhep root FWCore/Framework FWCore/ServiceRegistry FWCore/Utilities SimGeneral/NoiseGenerators CommonTools/Statistics 
GaussianTailNoiseGeneratorTest_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GaussianTailNoiseGeneratorTest,GaussianTailNoiseGeneratorTest,$(SCRAMSTORENAME_LIB),src/SimGeneral/NoiseGenerators/test))
GaussianTailNoiseGeneratorTest_PACKAGE := self/src/SimGeneral/NoiseGenerators/test
ALL_PRODS += GaussianTailNoiseGeneratorTest
GaussianTailNoiseGeneratorTest_INIT_FUNC        += $$(eval $$(call Library,GaussianTailNoiseGeneratorTest,src/SimGeneral/NoiseGenerators/test,src_SimGeneral_NoiseGenerators_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GaussianTailNoiseGeneratorTest_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,GaussianTailNoiseGeneratorTest,src/SimGeneral/NoiseGenerators/test))
endif
ALL_COMMONRULES += src_SimGeneral_NoiseGenerators_test
src_SimGeneral_NoiseGenerators_test_parent := SimGeneral/NoiseGenerators
src_SimGeneral_NoiseGenerators_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_NoiseGenerators_test,src/SimGeneral/NoiseGenerators/test,TEST))
