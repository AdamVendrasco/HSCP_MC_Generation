ifeq ($(strip $(GeneratorInterfaceCore_plugins)),)
GeneratorInterfaceCore_plugins := self/src/GeneratorInterface/Core/plugins
PLUGINS:=yes
GeneratorInterfaceCore_plugins_files := $(patsubst src/GeneratorInterface/Core/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Core/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Core/plugins/$(file). Please fix src/GeneratorInterface/Core/plugins/BuildFile.))))
GeneratorInterfaceCore_plugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/plugins/BuildFile
GeneratorInterfaceCore_plugins_LOC_USE := self   FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger FWCore/Utilities SimDataFormats/GeneratorProducts FWCore/SharedMemory clhep 
GeneratorInterfaceCore_plugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceCore_plugins,GeneratorInterfaceCore_plugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Core/plugins))
GeneratorInterfaceCore_plugins_PACKAGE := self/src/GeneratorInterface/Core/plugins
ALL_PRODS += GeneratorInterfaceCore_plugins
GeneratorInterface/Core_forbigobj+=GeneratorInterfaceCore_plugins
GeneratorInterfaceCore_plugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceCore_plugins,src/GeneratorInterface/Core/plugins,src_GeneratorInterface_Core_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceCore_plugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceCore_plugins,src/GeneratorInterface/Core/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_Core_plugins
src_GeneratorInterface_Core_plugins_parent := GeneratorInterface/Core
src_GeneratorInterface_Core_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_plugins,src/GeneratorInterface/Core/plugins,PLUGINS))
