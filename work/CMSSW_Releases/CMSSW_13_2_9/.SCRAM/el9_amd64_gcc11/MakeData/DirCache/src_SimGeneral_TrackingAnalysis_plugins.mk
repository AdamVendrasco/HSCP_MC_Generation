ifeq ($(strip $(SimGeneralTrackingAnalysisPlugins)),)
SimGeneralTrackingAnalysisPlugins := self/src/SimGeneral/TrackingAnalysis/plugins
PLUGINS:=yes
SimGeneralTrackingAnalysisPlugins_files := $(patsubst src/SimGeneral/TrackingAnalysis/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/TrackingAnalysis/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/TrackingAnalysis/plugins/$(file). Please fix src/SimGeneral/TrackingAnalysis/plugins/BuildFile.))))
SimGeneralTrackingAnalysisPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/TrackingAnalysis/plugins/BuildFile
SimGeneralTrackingAnalysisPlugins_LOC_USE := self   SimGeneral/TrackingAnalysis DataFormats/TrackerCommon DataFormats/HepMCCandidate Geometry/Records SimDataFormats/TrackerDigiSimLink SimGeneral/MixingModule SimGeneral/PreMixingModule 
SimGeneralTrackingAnalysisPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralTrackingAnalysisPlugins,SimGeneralTrackingAnalysisPlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/TrackingAnalysis/plugins))
SimGeneralTrackingAnalysisPlugins_PACKAGE := self/src/SimGeneral/TrackingAnalysis/plugins
ALL_PRODS += SimGeneralTrackingAnalysisPlugins
SimGeneral/TrackingAnalysis_forbigobj+=SimGeneralTrackingAnalysisPlugins
SimGeneralTrackingAnalysisPlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralTrackingAnalysisPlugins,src/SimGeneral/TrackingAnalysis/plugins,src_SimGeneral_TrackingAnalysis_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralTrackingAnalysisPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralTrackingAnalysisPlugins,src/SimGeneral/TrackingAnalysis/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_TrackingAnalysis_plugins
src_SimGeneral_TrackingAnalysis_plugins_parent := SimGeneral/TrackingAnalysis
src_SimGeneral_TrackingAnalysis_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_TrackingAnalysis_plugins,src/SimGeneral/TrackingAnalysis/plugins,PLUGINS))
