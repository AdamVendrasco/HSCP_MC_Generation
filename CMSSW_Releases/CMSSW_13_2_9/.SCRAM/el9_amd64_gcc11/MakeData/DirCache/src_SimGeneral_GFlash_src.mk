ifeq ($(strip $(SimGeneral/GFlash)),)
ALL_COMMONRULES += src_SimGeneral_GFlash_src
src_SimGeneral_GFlash_src_parent := SimGeneral/GFlash
src_SimGeneral_GFlash_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_GFlash_src,src/SimGeneral/GFlash/src,LIBRARY))
SimGeneralGFlash := self/SimGeneral/GFlash
SimGeneral/GFlash := SimGeneralGFlash
SimGeneralGFlash_files := $(patsubst src/SimGeneral/GFlash/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/GFlash/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralGFlash_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/GFlash/BuildFile
SimGeneralGFlash_LOC_USE := self   FWCore/ParameterSet FWCore/MessageLogger clhep root 
SimGeneralGFlash_EX_LIB   := SimGeneralGFlash
SimGeneralGFlash_EX_USE   := $(foreach d,$(SimGeneralGFlash_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralGFlash_PACKAGE := self/src/SimGeneral/GFlash/src
ALL_PRODS += SimGeneralGFlash
SimGeneralGFlash_CLASS := LIBRARY
SimGeneral/GFlash_forbigobj+=SimGeneralGFlash
SimGeneralGFlash_INIT_FUNC        += $$(eval $$(call Library,SimGeneralGFlash,src/SimGeneral/GFlash/src,src_SimGeneral_GFlash_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
