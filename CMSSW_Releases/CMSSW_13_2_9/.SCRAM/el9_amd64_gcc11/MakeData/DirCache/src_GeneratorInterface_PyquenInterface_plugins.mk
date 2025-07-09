ifeq ($(strip $(GeneratorInterfacePyquenInterfacePlugins)),)
GeneratorInterfacePyquenInterfacePlugins := self/src/GeneratorInterface/PyquenInterface/plugins
PLUGINS:=yes
GeneratorInterfacePyquenInterfacePlugins_files := $(patsubst src/GeneratorInterface/PyquenInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/PyquenInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/PyquenInterface/plugins/$(file). Please fix src/GeneratorInterface/PyquenInterface/plugins/BuildFile.))))
GeneratorInterfacePyquenInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PyquenInterface/plugins/BuildFile
GeneratorInterfacePyquenInterfacePlugins_LOC_USE := self   GeneratorInterface/PyquenInterface pydata 
GeneratorInterfacePyquenInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePyquenInterfacePlugins,GeneratorInterfacePyquenInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/PyquenInterface/plugins))
GeneratorInterfacePyquenInterfacePlugins_PACKAGE := self/src/GeneratorInterface/PyquenInterface/plugins
ALL_PRODS += GeneratorInterfacePyquenInterfacePlugins
GeneratorInterface/PyquenInterface_forbigobj+=GeneratorInterfacePyquenInterfacePlugins
GeneratorInterfacePyquenInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePyquenInterfacePlugins,src/GeneratorInterface/PyquenInterface/plugins,src_GeneratorInterface_PyquenInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePyquenInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePyquenInterfacePlugins,src/GeneratorInterface/PyquenInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_PyquenInterface_plugins
src_GeneratorInterface_PyquenInterface_plugins_parent := GeneratorInterface/PyquenInterface
src_GeneratorInterface_PyquenInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_PyquenInterface_plugins,src/GeneratorInterface/PyquenInterface/plugins,PLUGINS))
