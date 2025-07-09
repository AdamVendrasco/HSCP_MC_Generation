ifeq ($(strip $(SimG4Core/Generators)),)
ALL_COMMONRULES += src_SimG4Core_Generators_src
src_SimG4Core_Generators_src_parent := SimG4Core/Generators
src_SimG4Core_Generators_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Generators_src,src/SimG4Core/Generators/src,LIBRARY))
SimG4CoreGenerators := self/SimG4Core/Generators
SimG4Core/Generators := SimG4CoreGenerators
SimG4CoreGenerators_files := $(patsubst src/SimG4Core/Generators/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Generators/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreGenerators_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Generators/BuildFile
SimG4CoreGenerators_LOC_USE := self   FWCore/ParameterSet FWCore/MessageLogger boost hepmc heppdt geant4core rootmath expat 
SimG4CoreGenerators_EX_LIB   := SimG4CoreGenerators
SimG4CoreGenerators_EX_USE   := $(foreach d,$(SimG4CoreGenerators_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreGenerators_PACKAGE := self/src/SimG4Core/Generators/src
ALL_PRODS += SimG4CoreGenerators
SimG4CoreGenerators_CLASS := LIBRARY
SimG4Core/Generators_forbigobj+=SimG4CoreGenerators
SimG4CoreGenerators_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreGenerators,src/SimG4Core/Generators/src,src_SimG4Core_Generators_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
