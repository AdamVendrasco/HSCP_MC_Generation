ifeq ($(strip $(SimG4Core/TrackingVerbose)),)
ALL_COMMONRULES += src_SimG4Core_TrackingVerbose_src
src_SimG4Core_TrackingVerbose_src_parent := SimG4Core/TrackingVerbose
src_SimG4Core_TrackingVerbose_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_TrackingVerbose_src,src/SimG4Core/TrackingVerbose/src,LIBRARY))
SimG4CoreTrackingVerbose := self/SimG4Core/TrackingVerbose
SimG4Core/TrackingVerbose := SimG4CoreTrackingVerbose
SimG4CoreTrackingVerbose_files := $(patsubst src/SimG4Core/TrackingVerbose/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/TrackingVerbose/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreTrackingVerbose_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/TrackingVerbose/BuildFile
SimG4CoreTrackingVerbose_LOC_USE := self   SimG4Core/Application geant4core boost 
SimG4CoreTrackingVerbose_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreTrackingVerbose,SimG4CoreTrackingVerbose,$(SCRAMSTORENAME_LIB),src/SimG4Core/TrackingVerbose/src))
SimG4CoreTrackingVerbose_PACKAGE := self/src/SimG4Core/TrackingVerbose/src
ALL_PRODS += SimG4CoreTrackingVerbose
SimG4CoreTrackingVerbose_CLASS := LIBRARY
SimG4Core/TrackingVerbose_forbigobj+=SimG4CoreTrackingVerbose
SimG4CoreTrackingVerbose_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreTrackingVerbose,src/SimG4Core/TrackingVerbose/src,src_SimG4Core_TrackingVerbose_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
