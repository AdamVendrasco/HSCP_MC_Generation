ifeq ($(strip $(SimG4Core/PrintTrackNumber)),)
ALL_COMMONRULES += src_SimG4Core_PrintTrackNumber_src
src_SimG4Core_PrintTrackNumber_src_parent := SimG4Core/PrintTrackNumber
src_SimG4Core_PrintTrackNumber_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_PrintTrackNumber_src,src/SimG4Core/PrintTrackNumber/src,LIBRARY))
SimG4CorePrintTrackNumber := self/SimG4Core/PrintTrackNumber
SimG4Core/PrintTrackNumber := SimG4CorePrintTrackNumber
SimG4CorePrintTrackNumber_files := $(patsubst src/SimG4Core/PrintTrackNumber/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/PrintTrackNumber/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CorePrintTrackNumber_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PrintTrackNumber/BuildFile
SimG4CorePrintTrackNumber_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet geant4core boost 
SimG4CorePrintTrackNumber_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CorePrintTrackNumber,SimG4CorePrintTrackNumber,$(SCRAMSTORENAME_LIB),src/SimG4Core/PrintTrackNumber/src))
SimG4CorePrintTrackNumber_PACKAGE := self/src/SimG4Core/PrintTrackNumber/src
ALL_PRODS += SimG4CorePrintTrackNumber
SimG4CorePrintTrackNumber_CLASS := LIBRARY
SimG4Core/PrintTrackNumber_forbigobj+=SimG4CorePrintTrackNumber
SimG4CorePrintTrackNumber_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePrintTrackNumber,src/SimG4Core/PrintTrackNumber/src,src_SimG4Core_PrintTrackNumber_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
