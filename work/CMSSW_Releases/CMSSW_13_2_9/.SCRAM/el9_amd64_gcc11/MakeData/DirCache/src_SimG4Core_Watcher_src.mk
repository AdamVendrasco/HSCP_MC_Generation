ifeq ($(strip $(SimG4Core/Watcher)),)
ALL_COMMONRULES += src_SimG4Core_Watcher_src
src_SimG4Core_Watcher_src_parent := SimG4Core/Watcher
src_SimG4Core_Watcher_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Watcher_src,src/SimG4Core/Watcher/src,LIBRARY))
SimG4CoreWatcher := self/SimG4Core/Watcher
SimG4Core/Watcher := SimG4CoreWatcher
SimG4CoreWatcher_files := $(patsubst src/SimG4Core/Watcher/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Watcher/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreWatcher_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Watcher/BuildFile
SimG4CoreWatcher_LOC_USE := self   FWCore/Framework boost 
SimG4CoreWatcher_EX_LIB   := SimG4CoreWatcher
SimG4CoreWatcher_EX_USE   := $(foreach d,$(SimG4CoreWatcher_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreWatcher_PACKAGE := self/src/SimG4Core/Watcher/src
ALL_PRODS += SimG4CoreWatcher
SimG4CoreWatcher_CLASS := LIBRARY
SimG4Core/Watcher_forbigobj+=SimG4CoreWatcher
SimG4CoreWatcher_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreWatcher,src/SimG4Core/Watcher/src,src_SimG4Core_Watcher_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
