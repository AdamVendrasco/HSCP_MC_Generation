ifeq ($(strip $(GeneratorInterfaceAlpgenSource)),)
GeneratorInterfaceAlpgenSource := self/src/GeneratorInterface/AlpgenInterface/plugins
PLUGINS:=yes
GeneratorInterfaceAlpgenSource_files := $(patsubst src/GeneratorInterface/AlpgenInterface/plugins/%,%,$(foreach file,AlpgenSource.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/AlpgenInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/AlpgenInterface/plugins/$(file). Please fix src/GeneratorInterface/AlpgenInterface/plugins/BuildFile.))))
GeneratorInterfaceAlpgenSource_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AlpgenInterface/plugins/BuildFile
GeneratorInterfaceAlpgenSource_LOC_USE := self   FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/Sources FWCore/Utilities GeneratorInterface/AlpgenInterface SimDataFormats/GeneratorProducts boost 
GeneratorInterfaceAlpgenSource_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceAlpgenSource,GeneratorInterfaceAlpgenSource,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/AlpgenInterface/plugins))
GeneratorInterfaceAlpgenSource_PACKAGE := self/src/GeneratorInterface/AlpgenInterface/plugins
ALL_PRODS += GeneratorInterfaceAlpgenSource
GeneratorInterface/AlpgenInterface_forbigobj+=GeneratorInterfaceAlpgenSource
GeneratorInterfaceAlpgenSource_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAlpgenSource,src/GeneratorInterface/AlpgenInterface/plugins,src_GeneratorInterface_AlpgenInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceAlpgenSource_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceAlpgenSource,src/GeneratorInterface/AlpgenInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_AlpgenInterface_plugins
src_GeneratorInterface_AlpgenInterface_plugins_parent := GeneratorInterface/AlpgenInterface
src_GeneratorInterface_AlpgenInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AlpgenInterface_plugins,src/GeneratorInterface/AlpgenInterface/plugins,PLUGINS))
