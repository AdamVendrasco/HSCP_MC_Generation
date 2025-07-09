ifeq ($(strip $(SimGeneralDebuggingAuto)),)
SimGeneralDebuggingAuto := self/src/SimGeneral/Debugging/plugins
PLUGINS:=yes
SimGeneralDebuggingAuto_files := $(patsubst src/SimGeneral/Debugging/plugins/%,%,$(wildcard $(foreach dir,src/SimGeneral/Debugging/plugins ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralDebuggingAuto_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/Debugging/plugins/BuildFile
SimGeneralDebuggingAuto_LOC_USE := self   FWCore/Framework FWCore/ParameterSet SimDataFormats/Track SimDataFormats/Vertex SimDataFormats/TrackingAnalysis SimDataFormats/CaloAnalysis SimDataFormats/CaloHit SimDataFormats/CaloTest Geometry/HcalTowerAlgo Geometry/HGCalGeometry Geometry/Records 
SimGeneralDebuggingAuto_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralDebuggingAuto,SimGeneralDebuggingAuto,$(SCRAMSTORENAME_LIB),src/SimGeneral/Debugging/plugins))
SimGeneralDebuggingAuto_PACKAGE := self/src/SimGeneral/Debugging/plugins
ALL_PRODS += SimGeneralDebuggingAuto
SimGeneral/Debugging_forbigobj+=SimGeneralDebuggingAuto
SimGeneralDebuggingAuto_INIT_FUNC        += $$(eval $$(call Library,SimGeneralDebuggingAuto,src/SimGeneral/Debugging/plugins,src_SimGeneral_Debugging_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralDebuggingAuto_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralDebuggingAuto,src/SimGeneral/Debugging/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_Debugging_plugins
src_SimGeneral_Debugging_plugins_parent := SimGeneral/Debugging
src_SimGeneral_Debugging_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_Debugging_plugins,src/SimGeneral/Debugging/plugins,PLUGINS))
