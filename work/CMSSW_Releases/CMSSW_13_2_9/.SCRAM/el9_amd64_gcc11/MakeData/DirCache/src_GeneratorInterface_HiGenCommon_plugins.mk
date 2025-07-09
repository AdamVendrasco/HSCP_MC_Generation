ifeq ($(strip $(GeneratorInterfaceHiGenCommonPlugins)),)
GeneratorInterfaceHiGenCommonPlugins := self/src/GeneratorInterface/HiGenCommon/plugins
PLUGINS:=yes
GeneratorInterfaceHiGenCommonPlugins_files := $(patsubst src/GeneratorInterface/HiGenCommon/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/HiGenCommon/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/HiGenCommon/plugins/$(file). Please fix src/GeneratorInterface/HiGenCommon/plugins/BuildFile.))))
GeneratorInterfaceHiGenCommonPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HiGenCommon/plugins/BuildFile
GeneratorInterfaceHiGenCommonPlugins_LOC_USE := self   FWCore/Framework FWCore/ServiceRegistry FWCore/Utilities SimDataFormats/GeneratorProducts SimGeneral/HepPDTRecord hepmc heppdt clhep root 
GeneratorInterfaceHiGenCommonPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHiGenCommonPlugins,GeneratorInterfaceHiGenCommonPlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/HiGenCommon/plugins))
GeneratorInterfaceHiGenCommonPlugins_PACKAGE := self/src/GeneratorInterface/HiGenCommon/plugins
ALL_PRODS += GeneratorInterfaceHiGenCommonPlugins
GeneratorInterface/HiGenCommon_forbigobj+=GeneratorInterfaceHiGenCommonPlugins
GeneratorInterfaceHiGenCommonPlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHiGenCommonPlugins,src/GeneratorInterface/HiGenCommon/plugins,src_GeneratorInterface_HiGenCommon_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHiGenCommonPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHiGenCommonPlugins,src/GeneratorInterface/HiGenCommon/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_HiGenCommon_plugins
src_GeneratorInterface_HiGenCommon_plugins_parent := GeneratorInterface/HiGenCommon
src_GeneratorInterface_HiGenCommon_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HiGenCommon_plugins,src/GeneratorInterface/HiGenCommon/plugins,PLUGINS))
