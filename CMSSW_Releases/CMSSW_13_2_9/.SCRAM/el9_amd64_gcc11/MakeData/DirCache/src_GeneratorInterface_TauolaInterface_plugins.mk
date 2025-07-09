ifeq ($(strip $(TauSpinnerInterface)),)
TauSpinnerInterface := self/src/GeneratorInterface/TauolaInterface/plugins
PLUGINS:=yes
TauSpinnerInterface_files := $(patsubst src/GeneratorInterface/TauolaInterface/plugins/%,%,$(foreach file,TauSpinner/*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/TauolaInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/TauolaInterface/plugins/$(file). Please fix src/GeneratorInterface/TauolaInterface/plugins/BuildFile.))))
TauSpinnerInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/TauolaInterface/plugins/BuildFile
TauSpinnerInterface_LOC_USE := self   GeneratorInterface/TauolaInterface FWCore/Framework FWCore/ServiceRegistry SimDataFormats/GeneratorProducts tauolapp lhapdf root rootmath clhep 
TauSpinnerInterface_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,TauSpinnerInterface,TauSpinnerInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/TauolaInterface/plugins))
TauSpinnerInterface_PACKAGE := self/src/GeneratorInterface/TauolaInterface/plugins
ALL_PRODS += TauSpinnerInterface
GeneratorInterface/TauolaInterface_forbigobj+=TauSpinnerInterface
TauSpinnerInterface_INIT_FUNC        += $$(eval $$(call Library,TauSpinnerInterface,src/GeneratorInterface/TauolaInterface/plugins,src_GeneratorInterface_TauolaInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
TauSpinnerInterface_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,TauSpinnerInterface,src/GeneratorInterface/TauolaInterface/plugins))
endif
ifeq ($(strip $(TauolappInterface)),)
TauolappInterface := self/src/GeneratorInterface/TauolaInterface/plugins
PLUGINS:=yes
TauolappInterface_files := $(patsubst src/GeneratorInterface/TauolaInterface/plugins/%,%,$(foreach file,Tauolapp/*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/TauolaInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/TauolaInterface/plugins/$(file). Please fix src/GeneratorInterface/TauolaInterface/plugins/BuildFile.))))
TauolappInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/TauolaInterface/plugins/BuildFile
TauolappInterface_LOC_USE := self   FWCore/Framework FWCore/MessageLogger FWCore/PluginManager GeneratorInterface/TauolaInterface SimGeneral/HepPDTRecord heppdt clhep hepmc root rootmath tauolapp 
TauolappInterface_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,TauolappInterface,TauolappInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/TauolaInterface/plugins))
TauolappInterface_PACKAGE := self/src/GeneratorInterface/TauolaInterface/plugins
ALL_PRODS += TauolappInterface
GeneratorInterface/TauolaInterface_forbigobj+=TauolappInterface
TauolappInterface_INIT_FUNC        += $$(eval $$(call Library,TauolappInterface,src/GeneratorInterface/TauolaInterface/plugins,src_GeneratorInterface_TauolaInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
TauolappInterface_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,TauolappInterface,src/GeneratorInterface/TauolaInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_TauolaInterface_plugins
src_GeneratorInterface_TauolaInterface_plugins_parent := GeneratorInterface/TauolaInterface
src_GeneratorInterface_TauolaInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_TauolaInterface_plugins,src/GeneratorInterface/TauolaInterface/plugins,PLUGINS))
