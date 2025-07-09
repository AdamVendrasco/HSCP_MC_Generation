ifeq ($(strip $(SimG4Core/PhysicsLists)),)
ALL_COMMONRULES += src_SimG4Core_PhysicsLists_src
src_SimG4Core_PhysicsLists_src_parent := SimG4Core/PhysicsLists
src_SimG4Core_PhysicsLists_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_PhysicsLists_src,src/SimG4Core/PhysicsLists/src,LIBRARY))
SimG4CorePhysicsLists := self/SimG4Core/PhysicsLists
SimG4Core/PhysicsLists := SimG4CorePhysicsLists
SimG4CorePhysicsLists_files := $(patsubst src/SimG4Core/PhysicsLists/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/PhysicsLists/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CorePhysicsLists_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PhysicsLists/BuildFile
SimG4CorePhysicsLists_LOC_USE := self   boost clhep geant4core g4hepemcore heppdt FWCore/MessageLogger SimG4Core/MagneticField SimG4Core/Physics 
SimG4CorePhysicsLists_EX_LIB   := SimG4CorePhysicsLists
SimG4CorePhysicsLists_EX_USE   := $(foreach d,$(SimG4CorePhysicsLists_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CorePhysicsLists_PACKAGE := self/src/SimG4Core/PhysicsLists/src
ALL_PRODS += SimG4CorePhysicsLists
SimG4CorePhysicsLists_CLASS := LIBRARY
SimG4Core/PhysicsLists_forbigobj+=SimG4CorePhysicsLists
SimG4CorePhysicsLists_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePhysicsLists,src/SimG4Core/PhysicsLists/src,src_SimG4Core_PhysicsLists_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
