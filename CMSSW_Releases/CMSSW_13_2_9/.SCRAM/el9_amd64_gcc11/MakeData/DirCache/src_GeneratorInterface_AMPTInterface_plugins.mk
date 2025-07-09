ifeq ($(strip $(GeneratorInterfaceAMPTInterfacePlugins)),)
GeneratorInterfaceAMPTInterfacePlugins := self/src/GeneratorInterface/AMPTInterface/plugins
PLUGINS:=yes
GeneratorInterfaceAMPTInterfacePlugins_files := $(patsubst src/GeneratorInterface/AMPTInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/AMPTInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/AMPTInterface/plugins/$(file). Please fix src/GeneratorInterface/AMPTInterface/plugins/BuildFile.))))
GeneratorInterfaceAMPTInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AMPTInterface/plugins/BuildFile
GeneratorInterfaceAMPTInterfacePlugins_LOC_USE := self   GeneratorInterface/AMPTInterface 
GeneratorInterfaceAMPTInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceAMPTInterfacePlugins,GeneratorInterfaceAMPTInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/AMPTInterface/plugins))
GeneratorInterfaceAMPTInterfacePlugins_PACKAGE := self/src/GeneratorInterface/AMPTInterface/plugins
ALL_PRODS += GeneratorInterfaceAMPTInterfacePlugins
GeneratorInterface/AMPTInterface_forbigobj+=GeneratorInterfaceAMPTInterfacePlugins
GeneratorInterfaceAMPTInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAMPTInterfacePlugins,src/GeneratorInterface/AMPTInterface/plugins,src_GeneratorInterface_AMPTInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceAMPTInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceAMPTInterfacePlugins,src/GeneratorInterface/AMPTInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_AMPTInterface_plugins
src_GeneratorInterface_AMPTInterface_plugins_parent := GeneratorInterface/AMPTInterface
src_GeneratorInterface_AMPTInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AMPTInterface_plugins,src/GeneratorInterface/AMPTInterface/plugins,PLUGINS))
