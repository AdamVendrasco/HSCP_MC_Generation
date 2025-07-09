ifeq ($(strip $(SimGeneral/TrackingAnalysis)),)
ALL_COMMONRULES += src_SimGeneral_TrackingAnalysis_src
src_SimGeneral_TrackingAnalysis_src_parent := SimGeneral/TrackingAnalysis
src_SimGeneral_TrackingAnalysis_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_TrackingAnalysis_src,src/SimGeneral/TrackingAnalysis/src,LIBRARY))
SimGeneralTrackingAnalysis := self/SimGeneral/TrackingAnalysis
SimGeneral/TrackingAnalysis := SimGeneralTrackingAnalysis
SimGeneralTrackingAnalysis_files := $(patsubst src/SimGeneral/TrackingAnalysis/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/TrackingAnalysis/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralTrackingAnalysis_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/TrackingAnalysis/BuildFile
SimGeneralTrackingAnalysis_LOC_USE := self   clhep CalibFormats/SiStripObjects CalibTracker/Records CondFormats/CSCObjects CondFormats/SiPixelObjects DataFormats/SiStripDetId FWCore/Framework FWCore/ParameterSet SimDataFormats/Track SimDataFormats/TrackingAnalysis SimDataFormats/TrackingHit SimTracker/Common CondFormats/DataRecord DataFormats/Common DataFormats/L1TrackTrigger DataFormats/TrackerCommon FWCore/Utilities SimDataFormats/CrossingFrame SimDataFormats/EncodedEventId 
SimGeneralTrackingAnalysis_LCGDICTS  := x 
SimGeneralTrackingAnalysis_PRE_INIT_FUNC += $$(eval $$(call LCGDict,SimGeneralTrackingAnalysis,src/SimGeneral/TrackingAnalysis/src/classes.h,src/SimGeneral/TrackingAnalysis/src/classes_def.xml,$(SCRAMSTORENAME_LIB),$(GENREFLEX_ARGS) $(root_EX_FLAGS_GENREFLEX_FAILES_ON_WARNS)))
SimGeneralTrackingAnalysis_EX_LIB   := SimGeneralTrackingAnalysis
SimGeneralTrackingAnalysis_EX_USE   := $(foreach d,$(SimGeneralTrackingAnalysis_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralTrackingAnalysis_PACKAGE := self/src/SimGeneral/TrackingAnalysis/src
ALL_PRODS += SimGeneralTrackingAnalysis
SimGeneralTrackingAnalysis_CLASS := LIBRARY
SimGeneral/TrackingAnalysis_forbigobj+=SimGeneralTrackingAnalysis
SimGeneralTrackingAnalysis_INIT_FUNC        += $$(eval $$(call Library,SimGeneralTrackingAnalysis,src/SimGeneral/TrackingAnalysis/src,src_SimGeneral_TrackingAnalysis_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
