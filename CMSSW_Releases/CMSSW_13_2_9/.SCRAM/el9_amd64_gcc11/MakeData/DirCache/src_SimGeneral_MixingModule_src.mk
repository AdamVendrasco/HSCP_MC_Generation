ifeq ($(strip $(SimGeneral/MixingModule)),)
ALL_COMMONRULES += src_SimGeneral_MixingModule_src
src_SimGeneral_MixingModule_src_parent := SimGeneral/MixingModule
src_SimGeneral_MixingModule_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_src,src/SimGeneral/MixingModule/src,LIBRARY))
SimGeneralMixingModule := self/SimGeneral/MixingModule
SimGeneral/MixingModule := SimGeneralMixingModule
SimGeneralMixingModule_files := $(patsubst src/SimGeneral/MixingModule/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/MixingModule/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralMixingModule_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/MixingModule/BuildFile
SimGeneralMixingModule_LOC_USE := self   FWCore/Framework FWCore/PluginManager FWCore/ParameterSet 
SimGeneralMixingModule_EX_LIB   := SimGeneralMixingModule
SimGeneralMixingModule_EX_USE   := $(foreach d,$(SimGeneralMixingModule_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralMixingModule_PACKAGE := self/src/SimGeneral/MixingModule/src
ALL_PRODS += SimGeneralMixingModule
SimGeneralMixingModule_CLASS := LIBRARY
SimGeneral/MixingModule_forbigobj+=SimGeneralMixingModule
SimGeneralMixingModule_INIT_FUNC        += $$(eval $$(call Library,SimGeneralMixingModule,src/SimGeneral/MixingModule/src,src_SimGeneral_MixingModule_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
