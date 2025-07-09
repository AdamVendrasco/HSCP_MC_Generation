ifeq ($(strip $(SimG4CoreCustomPhysicsPlugins)),)
SimG4CoreCustomPhysicsPlugins := self/src/SimG4Core/CustomPhysics/plugins
PLUGINS:=yes
SimG4CoreCustomPhysicsPlugins_files := $(patsubst src/SimG4Core/CustomPhysics/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/CustomPhysics/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/CustomPhysics/plugins/$(file). Please fix src/SimG4Core/CustomPhysics/plugins/BuildFile.))))
SimG4CoreCustomPhysicsPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/CustomPhysics/plugins/BuildFile
SimG4CoreCustomPhysicsPlugins_LOC_FLAGS_USE_SOURCE_ONLY   := DataFormats/GeometryVector
SimG4CoreCustomPhysicsPlugins_LOC_USE := self   SimG4Core/Watcher SimG4Core/Notification FWCore/ParameterSet FWCore/PluginManager geant4core clhep boost SimG4Core/CustomPhysics 
SimG4CoreCustomPhysicsPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreCustomPhysicsPlugins,SimG4CoreCustomPhysicsPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/CustomPhysics/plugins))
SimG4CoreCustomPhysicsPlugins_PACKAGE := self/src/SimG4Core/CustomPhysics/plugins
ALL_PRODS += SimG4CoreCustomPhysicsPlugins
SimG4Core/CustomPhysics_forbigobj+=SimG4CoreCustomPhysicsPlugins
SimG4CoreCustomPhysicsPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreCustomPhysicsPlugins,src/SimG4Core/CustomPhysics/plugins,src_SimG4Core_CustomPhysics_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CoreCustomPhysicsPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CoreCustomPhysicsPlugins,src/SimG4Core/CustomPhysics/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_CustomPhysics_plugins
src_SimG4Core_CustomPhysics_plugins_parent := SimG4Core/CustomPhysics
src_SimG4Core_CustomPhysics_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_CustomPhysics_plugins,src/SimG4Core/CustomPhysics/plugins,PLUGINS))
