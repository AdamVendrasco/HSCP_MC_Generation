ifeq ($(strip $(GeneratorInterfaceExhumeFilter)),)
GeneratorInterfaceExhumeFilter := self/src/GeneratorInterface/ExhumeInterface/plugins
PLUGINS:=yes
GeneratorInterfaceExhumeFilter_files := $(patsubst src/GeneratorInterface/ExhumeInterface/plugins/%,%,$(foreach file,ExhumeGeneratorFilter.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/ExhumeInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/ExhumeInterface/plugins/$(file). Please fix src/GeneratorInterface/ExhumeInterface/plugins/BuildFile.))))
GeneratorInterfaceExhumeFilter_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ExhumeInterface/plugins/BuildFile
GeneratorInterfaceExhumeFilter_LOC_USE := self   GeneratorInterface/ExhumeInterface pydata GeneratorInterface/Core GeneratorInterface/ExternalDecays 
GeneratorInterfaceExhumeFilter_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceExhumeFilter,GeneratorInterfaceExhumeFilter,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/ExhumeInterface/plugins))
GeneratorInterfaceExhumeFilter_PACKAGE := self/src/GeneratorInterface/ExhumeInterface/plugins
ALL_PRODS += GeneratorInterfaceExhumeFilter
GeneratorInterface/ExhumeInterface_forbigobj+=GeneratorInterfaceExhumeFilter
GeneratorInterfaceExhumeFilter_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceExhumeFilter,src/GeneratorInterface/ExhumeInterface/plugins,src_GeneratorInterface_ExhumeInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceExhumeFilter_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceExhumeFilter,src/GeneratorInterface/ExhumeInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExhumeInterface_plugins
src_GeneratorInterface_ExhumeInterface_plugins_parent := GeneratorInterface/ExhumeInterface
src_GeneratorInterface_ExhumeInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExhumeInterface_plugins,src/GeneratorInterface/ExhumeInterface/plugins,PLUGINS))
