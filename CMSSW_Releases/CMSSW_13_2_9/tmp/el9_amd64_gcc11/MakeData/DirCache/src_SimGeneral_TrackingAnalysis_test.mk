ifeq ($(strip $(SimGeneralTrackingAnalysis_test)),)
SimGeneralTrackingAnalysis_test := self/src/SimGeneral/TrackingAnalysis/test
SimGeneralTrackingAnalysis_test_files := $(patsubst src/SimGeneral/TrackingAnalysis/test/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/TrackingAnalysis/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/TrackingAnalysis/test/$(file). Please fix src/SimGeneral/TrackingAnalysis/test/BuildFile.))))
SimGeneralTrackingAnalysis_test_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/TrackingAnalysis/test/BuildFile
SimGeneralTrackingAnalysis_test_LOC_USE := self   clhep FWCore/Framework SimDataFormats/TrackingAnalysis SimDataFormats/Track SimDataFormats/GeneratorProducts 
SimGeneralTrackingAnalysis_test_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralTrackingAnalysis_test,SimGeneralTrackingAnalysis_test,$(SCRAMSTORENAME_LIB),src/SimGeneral/TrackingAnalysis/test))
SimGeneralTrackingAnalysis_test_PACKAGE := self/src/SimGeneral/TrackingAnalysis/test
ALL_PRODS += SimGeneralTrackingAnalysis_test
SimGeneralTrackingAnalysis_test_INIT_FUNC        += $$(eval $$(call Library,SimGeneralTrackingAnalysis_test,src/SimGeneral/TrackingAnalysis/test,src_SimGeneral_TrackingAnalysis_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralTrackingAnalysis_test_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralTrackingAnalysis_test,src/SimGeneral/TrackingAnalysis/test))
endif
ALL_COMMONRULES += src_SimGeneral_TrackingAnalysis_test
src_SimGeneral_TrackingAnalysis_test_parent := SimGeneral/TrackingAnalysis
src_SimGeneral_TrackingAnalysis_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_TrackingAnalysis_test,src/SimGeneral/TrackingAnalysis/test,TEST))
