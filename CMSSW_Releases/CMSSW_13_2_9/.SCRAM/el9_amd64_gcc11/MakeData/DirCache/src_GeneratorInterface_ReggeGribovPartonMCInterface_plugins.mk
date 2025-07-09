ifeq ($(strip $(GeneratorInterfaceReggeGribovPartonMCInterfacePlugins)),)
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins
PLUGINS:=yes
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_files := $(patsubst src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/$(file). Please fix src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/BuildFile.))))
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/BuildFile
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_LOC_USE := self   GeneratorInterface/ReggeGribovPartonMCInterface 
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceReggeGribovPartonMCInterfacePlugins,GeneratorInterfaceReggeGribovPartonMCInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins))
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_PACKAGE := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins
ALL_PRODS += GeneratorInterfaceReggeGribovPartonMCInterfacePlugins
GeneratorInterface/ReggeGribovPartonMCInterface_forbigobj+=GeneratorInterfaceReggeGribovPartonMCInterfacePlugins
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceReggeGribovPartonMCInterfacePlugins,src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins,src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceReggeGribovPartonMCInterfacePlugins,src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins
src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins_parent := GeneratorInterface/ReggeGribovPartonMCInterface
src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins,src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins,PLUGINS))
