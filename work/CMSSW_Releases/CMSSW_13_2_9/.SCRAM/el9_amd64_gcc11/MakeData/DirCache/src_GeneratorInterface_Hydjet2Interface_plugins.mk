ifeq ($(strip $(GeneratorInterfaceHydjet2InterfacePlugins)),)
GeneratorInterfaceHydjet2InterfacePlugins := self/src/GeneratorInterface/Hydjet2Interface/plugins
PLUGINS:=yes
GeneratorInterfaceHydjet2InterfacePlugins_files := $(patsubst src/GeneratorInterface/Hydjet2Interface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Hydjet2Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Hydjet2Interface/plugins/$(file). Please fix src/GeneratorInterface/Hydjet2Interface/plugins/BuildFile.))))
GeneratorInterfaceHydjet2InterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Hydjet2Interface/plugins/BuildFile
GeneratorInterfaceHydjet2InterfacePlugins_LOC_USE := self   GeneratorInterface/Hydjet2Interface pydata 
GeneratorInterfaceHydjet2InterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHydjet2InterfacePlugins,GeneratorInterfaceHydjet2InterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Hydjet2Interface/plugins))
GeneratorInterfaceHydjet2InterfacePlugins_PACKAGE := self/src/GeneratorInterface/Hydjet2Interface/plugins
ALL_PRODS += GeneratorInterfaceHydjet2InterfacePlugins
GeneratorInterface/Hydjet2Interface_forbigobj+=GeneratorInterfaceHydjet2InterfacePlugins
GeneratorInterfaceHydjet2InterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHydjet2InterfacePlugins,src/GeneratorInterface/Hydjet2Interface/plugins,src_GeneratorInterface_Hydjet2Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHydjet2InterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHydjet2InterfacePlugins,src/GeneratorInterface/Hydjet2Interface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_Hydjet2Interface_plugins
src_GeneratorInterface_Hydjet2Interface_plugins_parent := GeneratorInterface/Hydjet2Interface
src_GeneratorInterface_Hydjet2Interface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Hydjet2Interface_plugins,src/GeneratorInterface/Hydjet2Interface/plugins,PLUGINS))
