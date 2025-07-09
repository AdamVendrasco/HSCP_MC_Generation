ifeq ($(strip $(SimG4Core/Physics)),)
ALL_COMMONRULES += src_SimG4Core_Physics_src
src_SimG4Core_Physics_src_parent := SimG4Core/Physics
src_SimG4Core_Physics_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Physics_src,src/SimG4Core/Physics/src,LIBRARY))
SimG4CorePhysics := self/SimG4Core/Physics
SimG4Core/Physics := SimG4CorePhysics
SimG4CorePhysics_files := $(patsubst src/SimG4Core/Physics/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Physics/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CorePhysics_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Physics/BuildFile
SimG4CorePhysics_LOC_USE := self   FWCore/ParameterSet geant4core heppdt boost expat 
SimG4CorePhysics_EX_LIB   := SimG4CorePhysics
SimG4CorePhysics_EX_USE   := $(foreach d,$(SimG4CorePhysics_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CorePhysics_PACKAGE := self/src/SimG4Core/Physics/src
ALL_PRODS += SimG4CorePhysics
SimG4CorePhysics_CLASS := LIBRARY
SimG4Core/Physics_forbigobj+=SimG4CorePhysics
SimG4CorePhysics_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePhysics,src/SimG4Core/Physics/src,src_SimG4Core_Physics_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
