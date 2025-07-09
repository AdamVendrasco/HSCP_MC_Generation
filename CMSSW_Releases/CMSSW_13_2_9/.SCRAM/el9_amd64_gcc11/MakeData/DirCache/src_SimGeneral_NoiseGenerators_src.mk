ifeq ($(strip $(SimGeneral/NoiseGenerators)),)
ALL_COMMONRULES += src_SimGeneral_NoiseGenerators_src
src_SimGeneral_NoiseGenerators_src_parent := SimGeneral/NoiseGenerators
src_SimGeneral_NoiseGenerators_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_NoiseGenerators_src,src/SimGeneral/NoiseGenerators/src,LIBRARY))
SimGeneralNoiseGenerators := self/SimGeneral/NoiseGenerators
SimGeneral/NoiseGenerators := SimGeneralNoiseGenerators
SimGeneralNoiseGenerators_files := $(patsubst src/SimGeneral/NoiseGenerators/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/NoiseGenerators/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralNoiseGenerators_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/NoiseGenerators/BuildFile
SimGeneralNoiseGenerators_LOC_USE := self   clhep gsl DataFormats/Math 
SimGeneralNoiseGenerators_EX_LIB   := SimGeneralNoiseGenerators
SimGeneralNoiseGenerators_EX_USE   := $(foreach d,$(SimGeneralNoiseGenerators_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralNoiseGenerators_PACKAGE := self/src/SimGeneral/NoiseGenerators/src
ALL_PRODS += SimGeneralNoiseGenerators
SimGeneralNoiseGenerators_CLASS := LIBRARY
SimGeneral/NoiseGenerators_forbigobj+=SimGeneralNoiseGenerators
SimGeneralNoiseGenerators_INIT_FUNC        += $$(eval $$(call Library,SimGeneralNoiseGenerators,src/SimGeneral/NoiseGenerators/src,src_SimGeneral_NoiseGenerators_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
