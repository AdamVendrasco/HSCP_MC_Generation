ifeq ($(strip $(SimG4CoreApplicationPlugins)),)
SimG4CoreApplicationPlugins := self/src/SimG4Core/Application/plugins
PLUGINS:=yes
SimG4CoreApplicationPlugins_files := $(patsubst src/SimG4Core/Application/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/Application/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Application/plugins/$(file). Please fix src/SimG4Core/Application/plugins/BuildFile.))))
SimG4CoreApplicationPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Application/plugins/BuildFile
SimG4CoreApplicationPlugins_LOC_USE := self   FWCore/Framework FWCore/ParameterSet SimDataFormats/CaloHit SimDataFormats/Track SimDataFormats/TrackingHit SimDataFormats/Vertex SimG4Core/Notification geant4core clhep hepmc SimG4Core/Application 
SimG4CoreApplicationPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreApplicationPlugins,SimG4CoreApplicationPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/Application/plugins))
SimG4CoreApplicationPlugins_PACKAGE := self/src/SimG4Core/Application/plugins
ALL_PRODS += SimG4CoreApplicationPlugins
SimG4Core/Application_forbigobj+=SimG4CoreApplicationPlugins
SimG4CoreApplicationPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreApplicationPlugins,src/SimG4Core/Application/plugins,src_SimG4Core_Application_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CoreApplicationPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CoreApplicationPlugins,src/SimG4Core/Application/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_Application_plugins
src_SimG4Core_Application_plugins_parent := SimG4Core/Application
src_SimG4Core_Application_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Application_plugins,src/SimG4Core/Application/plugins,PLUGINS))
