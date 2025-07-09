ifeq ($(strip $(SimG4CoreGFlashPlugins)),)
SimG4CoreGFlashPlugins := self/src/SimG4Core/GFlash/plugins
PLUGINS:=yes
SimG4CoreGFlashPlugins_files := $(patsubst src/SimG4Core/GFlash/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/GFlash/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/GFlash/plugins/$(file). Please fix src/SimG4Core/GFlash/plugins/BuildFile.))))
SimG4CoreGFlashPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/GFlash/plugins/BuildFile
SimG4CoreGFlashPlugins_LOC_USE := self   FWCore/Framework FWCore/MessageLogger FWCore/PluginManager SimG4Core/PhysicsLists SimG4Core/Notification SimG4Core/Watcher SimG4Core/GFlash geant4core clhep root 
SimG4CoreGFlashPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreGFlashPlugins,SimG4CoreGFlashPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/GFlash/plugins))
SimG4CoreGFlashPlugins_PACKAGE := self/src/SimG4Core/GFlash/plugins
ALL_PRODS += SimG4CoreGFlashPlugins
SimG4Core/GFlash_forbigobj+=SimG4CoreGFlashPlugins
SimG4CoreGFlashPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreGFlashPlugins,src/SimG4Core/GFlash/plugins,src_SimG4Core_GFlash_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CoreGFlashPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CoreGFlashPlugins,src/SimG4Core/GFlash/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_GFlash_plugins
src_SimG4Core_GFlash_plugins_parent := SimG4Core/GFlash
src_SimG4Core_GFlash_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_GFlash_plugins,src/SimG4Core/GFlash/plugins,PLUGINS))
