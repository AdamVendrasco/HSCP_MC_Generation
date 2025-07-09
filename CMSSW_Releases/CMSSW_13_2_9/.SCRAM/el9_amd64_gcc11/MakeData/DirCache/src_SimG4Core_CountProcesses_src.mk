ifeq ($(strip $(SimG4Core/CountProcesses)),)
ALL_COMMONRULES += src_SimG4Core_CountProcesses_src
src_SimG4Core_CountProcesses_src_parent := SimG4Core/CountProcesses
src_SimG4Core_CountProcesses_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_CountProcesses_src,src/SimG4Core/CountProcesses/src,LIBRARY))
SimG4CoreCountProcesses := self/SimG4Core/CountProcesses
SimG4Core/CountProcesses := SimG4CoreCountProcesses
SimG4CoreCountProcesses_files := $(patsubst src/SimG4Core/CountProcesses/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/CountProcesses/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreCountProcesses_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/CountProcesses/BuildFile
SimG4CoreCountProcesses_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet geant4core boost 
SimG4CoreCountProcesses_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreCountProcesses,SimG4CoreCountProcesses,$(SCRAMSTORENAME_LIB),src/SimG4Core/CountProcesses/src))
SimG4CoreCountProcesses_PACKAGE := self/src/SimG4Core/CountProcesses/src
ALL_PRODS += SimG4CoreCountProcesses
SimG4CoreCountProcesses_CLASS := LIBRARY
SimG4Core/CountProcesses_forbigobj+=SimG4CoreCountProcesses
SimG4CoreCountProcesses_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreCountProcesses,src/SimG4Core/CountProcesses/src,src_SimG4Core_CountProcesses_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
