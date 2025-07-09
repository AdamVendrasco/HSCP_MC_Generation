ifeq ($(strip $(SimG4CorePhysicsListsPlugins)),)
SimG4CorePhysicsListsPlugins := self/src/SimG4Core/PhysicsLists/plugins
PLUGINS:=yes
SimG4CorePhysicsListsPlugins_files := $(patsubst src/SimG4Core/PhysicsLists/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/PhysicsLists/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/PhysicsLists/plugins/$(file). Please fix src/SimG4Core/PhysicsLists/plugins/BuildFile.))))
SimG4CorePhysicsListsPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PhysicsLists/plugins/BuildFile
SimG4CorePhysicsListsPlugins_LOC_USE := self   FWCore/ParameterSet FWCore/MessageLogger SimG4Core/Physics geant4core clhep heppdt boost SimG4Core/PhysicsLists 
SimG4CorePhysicsListsPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CorePhysicsListsPlugins,SimG4CorePhysicsListsPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/PhysicsLists/plugins))
SimG4CorePhysicsListsPlugins_PACKAGE := self/src/SimG4Core/PhysicsLists/plugins
ALL_PRODS += SimG4CorePhysicsListsPlugins
SimG4Core/PhysicsLists_forbigobj+=SimG4CorePhysicsListsPlugins
SimG4CorePhysicsListsPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePhysicsListsPlugins,src/SimG4Core/PhysicsLists/plugins,src_SimG4Core_PhysicsLists_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CorePhysicsListsPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CorePhysicsListsPlugins,src/SimG4Core/PhysicsLists/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_PhysicsLists_plugins
src_SimG4Core_PhysicsLists_plugins_parent := SimG4Core/PhysicsLists
src_SimG4Core_PhysicsLists_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_PhysicsLists_plugins,src/SimG4Core/PhysicsLists/plugins,PLUGINS))
