ifeq ($(strip $(SimGeneral/PreMixingModule)),)
ALL_COMMONRULES += src_SimGeneral_PreMixingModule_src
src_SimGeneral_PreMixingModule_src_parent := SimGeneral/PreMixingModule
src_SimGeneral_PreMixingModule_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_PreMixingModule_src,src/SimGeneral/PreMixingModule/src,LIBRARY))
SimGeneralPreMixingModule := self/SimGeneral/PreMixingModule
SimGeneral/PreMixingModule := SimGeneralPreMixingModule
SimGeneralPreMixingModule_files := $(patsubst src/SimGeneral/PreMixingModule/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/PreMixingModule/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralPreMixingModule_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PreMixingModule/BuildFile
SimGeneralPreMixingModule_LOC_USE := self   FWCore/Framework FWCore/ParameterSet FWCore/PluginManager 
SimGeneralPreMixingModule_EX_LIB   := SimGeneralPreMixingModule
SimGeneralPreMixingModule_EX_USE   := $(foreach d,$(SimGeneralPreMixingModule_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralPreMixingModule_PACKAGE := self/src/SimGeneral/PreMixingModule/src
ALL_PRODS += SimGeneralPreMixingModule
SimGeneralPreMixingModule_CLASS := LIBRARY
SimGeneral/PreMixingModule_forbigobj+=SimGeneralPreMixingModule
SimGeneralPreMixingModule_INIT_FUNC        += $$(eval $$(call Library,SimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/src,src_SimGeneral_PreMixingModule_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
