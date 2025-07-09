ifeq ($(strip $(SimG4Core/KillSecondaries)),)
ALL_COMMONRULES += src_SimG4Core_KillSecondaries_src
src_SimG4Core_KillSecondaries_src_parent := SimG4Core/KillSecondaries
src_SimG4Core_KillSecondaries_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_KillSecondaries_src,src/SimG4Core/KillSecondaries/src,LIBRARY))
SimG4CoreKillSecondaries := self/SimG4Core/KillSecondaries
SimG4Core/KillSecondaries := SimG4CoreKillSecondaries
SimG4CoreKillSecondaries_files := $(patsubst src/SimG4Core/KillSecondaries/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/KillSecondaries/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreKillSecondaries_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/KillSecondaries/BuildFile
SimG4CoreKillSecondaries_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet geant4core boost 
SimG4CoreKillSecondaries_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreKillSecondaries,SimG4CoreKillSecondaries,$(SCRAMSTORENAME_LIB),src/SimG4Core/KillSecondaries/src))
SimG4CoreKillSecondaries_PACKAGE := self/src/SimG4Core/KillSecondaries/src
ALL_PRODS += SimG4CoreKillSecondaries
SimG4CoreKillSecondaries_CLASS := LIBRARY
SimG4Core/KillSecondaries_forbigobj+=SimG4CoreKillSecondaries
SimG4CoreKillSecondaries_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreKillSecondaries,src/SimG4Core/KillSecondaries/src,src_SimG4Core_KillSecondaries_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
