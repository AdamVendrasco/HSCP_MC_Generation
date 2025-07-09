ifeq ($(strip $(SimG4Core/GFlash)),)
ALL_COMMONRULES += src_SimG4Core_GFlash_src
src_SimG4Core_GFlash_src_parent := SimG4Core/GFlash
src_SimG4Core_GFlash_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_GFlash_src,src/SimG4Core/GFlash/src,LIBRARY))
SimG4CoreGFlash := self/SimG4Core/GFlash
SimG4Core/GFlash := SimG4CoreGFlash
SimG4CoreGFlash_files := $(patsubst src/SimG4Core/GFlash/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/GFlash/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreGFlash_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/GFlash/BuildFile
SimG4CoreGFlash_LOC_USE := self   FWCore/ParameterSet FWCore/MessageLogger SimG4Core/PhysicsLists SimGeneral/GFlash geant4core clhep root 
SimG4CoreGFlash_EX_LIB   := SimG4CoreGFlash
SimG4CoreGFlash_EX_USE   := $(foreach d,$(SimG4CoreGFlash_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreGFlash_PACKAGE := self/src/SimG4Core/GFlash/src
ALL_PRODS += SimG4CoreGFlash
SimG4CoreGFlash_CLASS := LIBRARY
SimG4Core/GFlash_forbigobj+=SimG4CoreGFlash
SimG4CoreGFlash_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreGFlash,src/SimG4Core/GFlash/src,src_SimG4Core_GFlash_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
