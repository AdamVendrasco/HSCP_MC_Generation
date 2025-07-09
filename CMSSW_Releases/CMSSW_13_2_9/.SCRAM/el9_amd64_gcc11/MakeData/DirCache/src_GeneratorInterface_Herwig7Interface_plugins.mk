ifeq ($(strip $(GeneratorInterfaceHerwig7HadronizerPlugins)),)
GeneratorInterfaceHerwig7HadronizerPlugins := self/src/GeneratorInterface/Herwig7Interface/plugins
PLUGINS:=yes
GeneratorInterfaceHerwig7HadronizerPlugins_files := $(patsubst src/GeneratorInterface/Herwig7Interface/plugins/%,%,$(foreach file,Herwig7Hadronizer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Herwig7Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Herwig7Interface/plugins/$(file). Please fix src/GeneratorInterface/Herwig7Interface/plugins/BuildFile.))))
GeneratorInterfaceHerwig7HadronizerPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Herwig7Interface/plugins/BuildFile
GeneratorInterfaceHerwig7HadronizerPlugins_LOC_USE := self   SimDataFormats/GeneratorProducts herwig7 GeneratorInterface/Herwig7Interface GeneratorInterface/Core GeneratorInterface/ExternalDecays boost thepeg 
GeneratorInterfaceHerwig7HadronizerPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHerwig7HadronizerPlugins,GeneratorInterfaceHerwig7HadronizerPlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Herwig7Interface/plugins))
GeneratorInterfaceHerwig7HadronizerPlugins_PACKAGE := self/src/GeneratorInterface/Herwig7Interface/plugins
ALL_PRODS += GeneratorInterfaceHerwig7HadronizerPlugins
GeneratorInterface/Herwig7Interface_forbigobj+=GeneratorInterfaceHerwig7HadronizerPlugins
GeneratorInterfaceHerwig7HadronizerPlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHerwig7HadronizerPlugins,src/GeneratorInterface/Herwig7Interface/plugins,src_GeneratorInterface_Herwig7Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHerwig7HadronizerPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHerwig7HadronizerPlugins,src/GeneratorInterface/Herwig7Interface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_Herwig7Interface_plugins
src_GeneratorInterface_Herwig7Interface_plugins_parent := GeneratorInterface/Herwig7Interface
src_GeneratorInterface_Herwig7Interface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Herwig7Interface_plugins,src/GeneratorInterface/Herwig7Interface/plugins,PLUGINS))
