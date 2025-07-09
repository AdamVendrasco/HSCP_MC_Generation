ifeq ($(strip $(GeneratorInterfaceHydjetInterfacePlugins)),)
GeneratorInterfaceHydjetInterfacePlugins := self/src/GeneratorInterface/HydjetInterface/plugins
PLUGINS:=yes
GeneratorInterfaceHydjetInterfacePlugins_files := $(patsubst src/GeneratorInterface/HydjetInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/HydjetInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/HydjetInterface/plugins/$(file). Please fix src/GeneratorInterface/HydjetInterface/plugins/BuildFile.))))
GeneratorInterfaceHydjetInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HydjetInterface/plugins/BuildFile
GeneratorInterfaceHydjetInterfacePlugins_LOC_USE := self   GeneratorInterface/HydjetInterface pydata 
GeneratorInterfaceHydjetInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHydjetInterfacePlugins,GeneratorInterfaceHydjetInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/HydjetInterface/plugins))
GeneratorInterfaceHydjetInterfacePlugins_PACKAGE := self/src/GeneratorInterface/HydjetInterface/plugins
ALL_PRODS += GeneratorInterfaceHydjetInterfacePlugins
GeneratorInterface/HydjetInterface_forbigobj+=GeneratorInterfaceHydjetInterfacePlugins
GeneratorInterfaceHydjetInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHydjetInterfacePlugins,src/GeneratorInterface/HydjetInterface/plugins,src_GeneratorInterface_HydjetInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHydjetInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHydjetInterfacePlugins,src/GeneratorInterface/HydjetInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_HydjetInterface_plugins
src_GeneratorInterface_HydjetInterface_plugins_parent := GeneratorInterface/HydjetInterface
src_GeneratorInterface_HydjetInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HydjetInterface_plugins,src/GeneratorInterface/HydjetInterface/plugins,PLUGINS))
