ifeq ($(strip $(GeneratorInterfaceHijingInterfacePlugins)),)
GeneratorInterfaceHijingInterfacePlugins := self/src/GeneratorInterface/HijingInterface/plugins
PLUGINS:=yes
GeneratorInterfaceHijingInterfacePlugins_files := $(patsubst src/GeneratorInterface/HijingInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/HijingInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/HijingInterface/plugins/$(file). Please fix src/GeneratorInterface/HijingInterface/plugins/BuildFile.))))
GeneratorInterfaceHijingInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HijingInterface/plugins/BuildFile
GeneratorInterfaceHijingInterfacePlugins_LOC_USE := self   GeneratorInterface/HijingInterface 
GeneratorInterfaceHijingInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHijingInterfacePlugins,GeneratorInterfaceHijingInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/HijingInterface/plugins))
GeneratorInterfaceHijingInterfacePlugins_PACKAGE := self/src/GeneratorInterface/HijingInterface/plugins
ALL_PRODS += GeneratorInterfaceHijingInterfacePlugins
GeneratorInterface/HijingInterface_forbigobj+=GeneratorInterfaceHijingInterfacePlugins
GeneratorInterfaceHijingInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHijingInterfacePlugins,src/GeneratorInterface/HijingInterface/plugins,src_GeneratorInterface_HijingInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHijingInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHijingInterfacePlugins,src/GeneratorInterface/HijingInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_HijingInterface_plugins
src_GeneratorInterface_HijingInterface_plugins_parent := GeneratorInterface/HijingInterface
src_GeneratorInterface_HijingInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HijingInterface_plugins,src/GeneratorInterface/HijingInterface/plugins,PLUGINS))
