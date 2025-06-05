ifeq ($(strip $(GeneratorInterfacePythia8Filters)),)
GeneratorInterfacePythia8Filters := self/src/GeneratorInterface/Pythia8Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia8Filters_files := $(patsubst src/GeneratorInterface/Pythia8Interface/plugins/%,%,$(foreach file,Pythia8Hadronizer.cc Py8toJetInput.cc *Hook*.cc LHA*.cc PythiaDumpParticles.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia8Interface/plugins/BuildFile.))))
GeneratorInterfacePythia8Filters_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/plugins/BuildFile
GeneratorInterfacePythia8Filters_LOC_USE := self   GeneratorInterface/Pythia8Interface GeneratorInterface/PartonShowerVeto GeneratorInterface/ExternalDecays FWCore/Concurrency FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities GeneratorInterface/Core hepmc pythia8 SimDataFormats/GeneratorProducts 
GeneratorInterfacePythia8Filters_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePythia8Filters,GeneratorInterfacePythia8Filters,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia8Interface/plugins))
GeneratorInterfacePythia8Filters_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/plugins
ALL_PRODS += GeneratorInterfacePythia8Filters
GeneratorInterface/Pythia8Interface_forbigobj+=GeneratorInterfacePythia8Filters
GeneratorInterfacePythia8Filters_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia8Filters,src/GeneratorInterface/Pythia8Interface/plugins,src_GeneratorInterface_Pythia8Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePythia8Filters_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePythia8Filters,src/GeneratorInterface/Pythia8Interface/plugins))
endif
ifeq ($(strip $(GeneratorInterfacePythia8Guns)),)
GeneratorInterfacePythia8Guns := self/src/GeneratorInterface/Pythia8Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia8Guns_files := $(patsubst src/GeneratorInterface/Pythia8Interface/plugins/%,%,$(foreach file,Py*Gun.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia8Interface/plugins/BuildFile.))))
GeneratorInterfacePythia8Guns_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/plugins/BuildFile
GeneratorInterfacePythia8Guns_LOC_USE := self   GeneratorInterface/Pythia8Interface GeneratorInterface/ExternalDecays 
GeneratorInterfacePythia8Guns_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePythia8Guns,GeneratorInterfacePythia8Guns,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia8Interface/plugins))
GeneratorInterfacePythia8Guns_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/plugins
ALL_PRODS += GeneratorInterfacePythia8Guns
GeneratorInterface/Pythia8Interface_forbigobj+=GeneratorInterfacePythia8Guns
GeneratorInterfacePythia8Guns_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia8Guns,src/GeneratorInterface/Pythia8Interface/plugins,src_GeneratorInterface_Pythia8Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePythia8Guns_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePythia8Guns,src/GeneratorInterface/Pythia8Interface/plugins))
endif
ifeq ($(strip $(GeneratorInterfacePythia8HepMC3Filters)),)
GeneratorInterfacePythia8HepMC3Filters := self/src/GeneratorInterface/Pythia8Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia8HepMC3Filters_files := $(patsubst src/GeneratorInterface/Pythia8Interface/plugins/%,%,$(foreach file,Pythia8HepMC3Hadronizer.cc Py8toJetInput.cc *Hook*.cc LHA*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia8Interface/plugins/BuildFile.))))
GeneratorInterfacePythia8HepMC3Filters_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/plugins/BuildFile
GeneratorInterfacePythia8HepMC3Filters_LOC_USE := self   GeneratorInterface/Pythia8Interface GeneratorInterface/PartonShowerVeto GeneratorInterface/ExternalDecays FWCore/Concurrency FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities GeneratorInterface/Core hepmc3 pythia8 SimDataFormats/GeneratorProducts 
GeneratorInterfacePythia8HepMC3Filters_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePythia8HepMC3Filters,GeneratorInterfacePythia8HepMC3Filters,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia8Interface/plugins))
GeneratorInterfacePythia8HepMC3Filters_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/plugins
ALL_PRODS += GeneratorInterfacePythia8HepMC3Filters
GeneratorInterface/Pythia8Interface_forbigobj+=GeneratorInterfacePythia8HepMC3Filters
GeneratorInterfacePythia8HepMC3Filters_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia8HepMC3Filters,src/GeneratorInterface/Pythia8Interface/plugins,src_GeneratorInterface_Pythia8Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePythia8HepMC3Filters_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePythia8HepMC3Filters,src/GeneratorInterface/Pythia8Interface/plugins))
endif
ifeq ($(strip $(GeneratorInterfacePythia8JetMatchingFxFxHook)),)
GeneratorInterfacePythia8JetMatchingFxFxHook := self/src/GeneratorInterface/Pythia8Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia8JetMatchingFxFxHook_files := $(patsubst src/GeneratorInterface/Pythia8Interface/plugins/%,%,$(foreach file,JetMatchingEWK*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia8Interface/plugins/BuildFile.))))
GeneratorInterfacePythia8JetMatchingFxFxHook_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/plugins/BuildFile
GeneratorInterfacePythia8JetMatchingFxFxHook_LOC_USE := self   GeneratorInterface/Pythia8Interface 
GeneratorInterfacePythia8JetMatchingFxFxHook_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePythia8JetMatchingFxFxHook,GeneratorInterfacePythia8JetMatchingFxFxHook,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia8Interface/plugins))
GeneratorInterfacePythia8JetMatchingFxFxHook_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/plugins
ALL_PRODS += GeneratorInterfacePythia8JetMatchingFxFxHook
GeneratorInterface/Pythia8Interface_forbigobj+=GeneratorInterfacePythia8JetMatchingFxFxHook
GeneratorInterfacePythia8JetMatchingFxFxHook_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia8JetMatchingFxFxHook,src/GeneratorInterface/Pythia8Interface/plugins,src_GeneratorInterface_Pythia8Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePythia8JetMatchingFxFxHook_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePythia8JetMatchingFxFxHook,src/GeneratorInterface/Pythia8Interface/plugins))
endif
ifeq ($(strip $(GeneratorInterfacePythia8SLHAReader)),)
GeneratorInterfacePythia8SLHAReader := self/src/GeneratorInterface/Pythia8Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia8SLHAReader_files := $(patsubst src/GeneratorInterface/Pythia8Interface/plugins/%,%,$(foreach file,SLHA*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia8Interface/plugins/BuildFile.))))
GeneratorInterfacePythia8SLHAReader_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/plugins/BuildFile
GeneratorInterfacePythia8SLHAReader_LOC_USE := self   GeneratorInterface/Pythia8Interface root 
GeneratorInterfacePythia8SLHAReader_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePythia8SLHAReader,GeneratorInterfacePythia8SLHAReader,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia8Interface/plugins))
GeneratorInterfacePythia8SLHAReader_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/plugins
ALL_PRODS += GeneratorInterfacePythia8SLHAReader
GeneratorInterface/Pythia8Interface_forbigobj+=GeneratorInterfacePythia8SLHAReader
GeneratorInterfacePythia8SLHAReader_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia8SLHAReader,src/GeneratorInterface/Pythia8Interface/plugins,src_GeneratorInterface_Pythia8Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePythia8SLHAReader_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePythia8SLHAReader,src/GeneratorInterface/Pythia8Interface/plugins))
endif
ifeq ($(strip $(GeneratorInterfacePythia8SUEPHook)),)
GeneratorInterfacePythia8SUEPHook := self/src/GeneratorInterface/Pythia8Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia8SUEPHook_files := $(patsubst src/GeneratorInterface/Pythia8Interface/plugins/%,%,$(foreach file,Suep*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia8Interface/plugins/BuildFile.))))
GeneratorInterfacePythia8SUEPHook_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/plugins/BuildFile
GeneratorInterfacePythia8SUEPHook_LOC_USE := self   GeneratorInterface/Pythia8Interface 
GeneratorInterfacePythia8SUEPHook_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePythia8SUEPHook,GeneratorInterfacePythia8SUEPHook,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia8Interface/plugins))
GeneratorInterfacePythia8SUEPHook_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/plugins
ALL_PRODS += GeneratorInterfacePythia8SUEPHook
GeneratorInterface/Pythia8Interface_forbigobj+=GeneratorInterfacePythia8SUEPHook
GeneratorInterfacePythia8SUEPHook_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia8SUEPHook,src/GeneratorInterface/Pythia8Interface/plugins,src_GeneratorInterface_Pythia8Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePythia8SUEPHook_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePythia8SUEPHook,src/GeneratorInterface/Pythia8Interface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia8Interface_plugins
src_GeneratorInterface_Pythia8Interface_plugins_parent := GeneratorInterface/Pythia8Interface
src_GeneratorInterface_Pythia8Interface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia8Interface_plugins,src/GeneratorInterface/Pythia8Interface/plugins,PLUGINS))
