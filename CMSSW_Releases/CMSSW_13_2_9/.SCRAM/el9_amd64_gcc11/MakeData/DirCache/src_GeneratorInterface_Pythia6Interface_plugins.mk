ifeq ($(strip $(GeneratorInterfacePythia6Filters)),)
GeneratorInterfacePythia6Filters := self/src/GeneratorInterface/Pythia6Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia6Filters_files := $(patsubst src/GeneratorInterface/Pythia6Interface/plugins/%,%,$(foreach file,*Filter.cc Pythia6Hadronizer.cc *hadron.f,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia6Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia6Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia6Interface/plugins/BuildFile.))))
GeneratorInterfacePythia6Filters_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia6Interface/plugins/BuildFile
GeneratorInterfacePythia6Filters_LOC_USE := self   GeneratorInterface/Pythia6Interface GeneratorInterface/PartonShowerVeto GeneratorInterface/ExternalDecays heppdt 
GeneratorInterfacePythia6Filters_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePythia6Filters,GeneratorInterfacePythia6Filters,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia6Interface/plugins))
GeneratorInterfacePythia6Filters_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/plugins
ALL_PRODS += GeneratorInterfacePythia6Filters
GeneratorInterface/Pythia6Interface_forbigobj+=GeneratorInterfacePythia6Filters
GeneratorInterfacePythia6Filters_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia6Filters,src/GeneratorInterface/Pythia6Interface/plugins,src_GeneratorInterface_Pythia6Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePythia6Filters_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePythia6Filters,src/GeneratorInterface/Pythia6Interface/plugins))
endif
ifeq ($(strip $(GeneratorInterfacePythia6Guns)),)
GeneratorInterfacePythia6Guns := self/src/GeneratorInterface/Pythia6Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia6Guns_files := $(patsubst src/GeneratorInterface/Pythia6Interface/plugins/%,%,$(foreach file,Pythia6*Gun.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia6Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia6Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia6Interface/plugins/BuildFile.))))
GeneratorInterfacePythia6Guns_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia6Interface/plugins/BuildFile
GeneratorInterfacePythia6Guns_LOC_USE := self   GeneratorInterface/Pythia6Interface heppdt 
GeneratorInterfacePythia6Guns_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePythia6Guns,GeneratorInterfacePythia6Guns,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia6Interface/plugins))
GeneratorInterfacePythia6Guns_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/plugins
ALL_PRODS += GeneratorInterfacePythia6Guns
GeneratorInterface/Pythia6Interface_forbigobj+=GeneratorInterfacePythia6Guns
GeneratorInterfacePythia6Guns_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia6Guns,src/GeneratorInterface/Pythia6Interface/plugins,src_GeneratorInterface_Pythia6Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePythia6Guns_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePythia6Guns,src/GeneratorInterface/Pythia6Interface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia6Interface_plugins
src_GeneratorInterface_Pythia6Interface_plugins_parent := GeneratorInterface/Pythia6Interface
src_GeneratorInterface_Pythia6Interface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia6Interface_plugins,src/GeneratorInterface/Pythia6Interface/plugins,PLUGINS))
