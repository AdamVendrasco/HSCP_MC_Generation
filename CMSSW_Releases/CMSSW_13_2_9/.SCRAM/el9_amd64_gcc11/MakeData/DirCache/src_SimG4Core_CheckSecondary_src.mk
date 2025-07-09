ifeq ($(strip $(SimG4Core/CheckSecondary)),)
ALL_COMMONRULES += src_SimG4Core_CheckSecondary_src
src_SimG4Core_CheckSecondary_src_parent := SimG4Core/CheckSecondary
src_SimG4Core_CheckSecondary_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_CheckSecondary_src,src/SimG4Core/CheckSecondary/src,LIBRARY))
SimG4CoreCheckSecondary := self/SimG4Core/CheckSecondary
SimG4Core/CheckSecondary := SimG4CoreCheckSecondary
SimG4CoreCheckSecondary_files := $(patsubst src/SimG4Core/CheckSecondary/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/CheckSecondary/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreCheckSecondary_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/CheckSecondary/BuildFile
SimG4CoreCheckSecondary_LOC_USE := self   FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger geant4core boost root SimG4Core/Notification SimG4Core/Watcher SimG4Core/Physics DataFormats/Math 
SimG4CoreCheckSecondary_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreCheckSecondary,SimG4CoreCheckSecondary,$(SCRAMSTORENAME_LIB),src/SimG4Core/CheckSecondary/src))
SimG4CoreCheckSecondary_PACKAGE := self/src/SimG4Core/CheckSecondary/src
ALL_PRODS += SimG4CoreCheckSecondary
SimG4CoreCheckSecondary_CLASS := LIBRARY
SimG4Core/CheckSecondary_forbigobj+=SimG4CoreCheckSecondary
SimG4CoreCheckSecondary_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreCheckSecondary,src/SimG4Core/CheckSecondary/src,src_SimG4Core_CheckSecondary_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
