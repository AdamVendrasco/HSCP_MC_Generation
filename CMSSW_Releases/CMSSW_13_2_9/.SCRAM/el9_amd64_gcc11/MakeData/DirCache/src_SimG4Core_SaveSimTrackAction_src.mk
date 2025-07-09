ifeq ($(strip $(SimG4Core/SaveSimTrackAction)),)
ALL_COMMONRULES += src_SimG4Core_SaveSimTrackAction_src
src_SimG4Core_SaveSimTrackAction_src_parent := SimG4Core/SaveSimTrackAction
src_SimG4Core_SaveSimTrackAction_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_SaveSimTrackAction_src,src/SimG4Core/SaveSimTrackAction/src,LIBRARY))
SimG4CoreSaveSimTrackAction := self/SimG4Core/SaveSimTrackAction
SimG4Core/SaveSimTrackAction := SimG4CoreSaveSimTrackAction
SimG4CoreSaveSimTrackAction_files := $(patsubst src/SimG4Core/SaveSimTrackAction/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/SaveSimTrackAction/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreSaveSimTrackAction_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/SaveSimTrackAction/BuildFile
SimG4CoreSaveSimTrackAction_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/PluginManager FWCore/ParameterSet geant4core boost 
SimG4CoreSaveSimTrackAction_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreSaveSimTrackAction,SimG4CoreSaveSimTrackAction,$(SCRAMSTORENAME_LIB),src/SimG4Core/SaveSimTrackAction/src))
SimG4CoreSaveSimTrackAction_PACKAGE := self/src/SimG4Core/SaveSimTrackAction/src
ALL_PRODS += SimG4CoreSaveSimTrackAction
SimG4CoreSaveSimTrackAction_CLASS := LIBRARY
SimG4Core/SaveSimTrackAction_forbigobj+=SimG4CoreSaveSimTrackAction
SimG4CoreSaveSimTrackAction_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreSaveSimTrackAction,src/SimG4Core/SaveSimTrackAction/src,src_SimG4Core_SaveSimTrackAction_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
