ifeq ($(strip $(SimGeneralCaloAnalysisPlugins)),)
SimGeneralCaloAnalysisPlugins := self/src/SimGeneral/CaloAnalysis/plugins
PLUGINS:=yes
SimGeneralCaloAnalysisPlugins_files := $(patsubst src/SimGeneral/CaloAnalysis/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/CaloAnalysis/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/CaloAnalysis/plugins/$(file). Please fix src/SimGeneral/CaloAnalysis/plugins/BuildFile.))))
SimGeneralCaloAnalysisPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/CaloAnalysis/plugins/BuildFile
SimGeneralCaloAnalysisPlugins_LOC_USE := self   clhep DataFormats/Math DataFormats/SiStripDetId DataFormats/SiPixelDetId FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/Utilities SimDataFormats/GeneratorProducts SimDataFormats/CaloAnalysis SimDataFormats/Vertex SimDataFormats/TrackingHit DataFormats/HepMCCandidate SimGeneral/MixingModule SimGeneral/PreMixingModule SimDataFormats/CaloTest DataFormats/ForwardDetId DataFormats/HcalDetId Geometry/Records Geometry/MTDCommonData Geometry/HGCalGeometry Geometry/HcalTowerAlgo Geometry/HcalCommonData Geometry/MTDGeometryBuilder Geometry/MTDNumberingBuilder 
SimGeneralCaloAnalysisPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralCaloAnalysisPlugins,SimGeneralCaloAnalysisPlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/CaloAnalysis/plugins))
SimGeneralCaloAnalysisPlugins_PACKAGE := self/src/SimGeneral/CaloAnalysis/plugins
ALL_PRODS += SimGeneralCaloAnalysisPlugins
SimGeneral/CaloAnalysis_forbigobj+=SimGeneralCaloAnalysisPlugins
SimGeneralCaloAnalysisPlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralCaloAnalysisPlugins,src/SimGeneral/CaloAnalysis/plugins,src_SimGeneral_CaloAnalysis_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralCaloAnalysisPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralCaloAnalysisPlugins,src/SimGeneral/CaloAnalysis/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_CaloAnalysis_plugins
src_SimGeneral_CaloAnalysis_plugins_parent := SimGeneral/CaloAnalysis
src_SimGeneral_CaloAnalysis_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_CaloAnalysis_plugins,src/SimGeneral/CaloAnalysis/plugins,PLUGINS))
