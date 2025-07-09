ifeq ($(strip $(SimG4Core/CustomPhysics)),)
ALL_COMMONRULES += src_SimG4Core_CustomPhysics_src
src_SimG4Core_CustomPhysics_src_parent := SimG4Core/CustomPhysics
src_SimG4Core_CustomPhysics_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_CustomPhysics_src,src/SimG4Core/CustomPhysics/src,LIBRARY))
SimG4CoreCustomPhysics := self/SimG4Core/CustomPhysics
SimG4Core/CustomPhysics := SimG4CoreCustomPhysics
SimG4CoreCustomPhysics_files := $(patsubst src/SimG4Core/CustomPhysics/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/CustomPhysics/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreCustomPhysics_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/CustomPhysics/BuildFile
SimG4CoreCustomPhysics_LOC_USE := self   FWCore/Framework FWCore/MessageLogger SimG4Core/Notification SimG4Core/Physics SimG4Core/PhysicsLists SimG4Core/Watcher geant4core clhep boost rootmath root 
SimG4CoreCustomPhysics_EX_LIB   := SimG4CoreCustomPhysics
SimG4CoreCustomPhysics_EX_USE   := $(foreach d,$(SimG4CoreCustomPhysics_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreCustomPhysics_PACKAGE := self/src/SimG4Core/CustomPhysics/src
ALL_PRODS += SimG4CoreCustomPhysics
SimG4CoreCustomPhysics_CLASS := LIBRARY
SimG4Core/CustomPhysics_forbigobj+=SimG4CoreCustomPhysics
SimG4CoreCustomPhysics_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreCustomPhysics,src/SimG4Core/CustomPhysics/src,src_SimG4Core_CustomPhysics_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
