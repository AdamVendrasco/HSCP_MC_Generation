ifeq ($(strip $(EvtGenInterface)),)
EvtGenInterface := self/src/GeneratorInterface/EvtGenInterface/plugins
PLUGINS:=yes
EvtGenInterface_files := $(patsubst src/GeneratorInterface/EvtGenInterface/plugins/%,%,$(foreach file,EvtGenUserModels/*.cpp EvtGen/*.cc myEvtRandomEngine.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/EvtGenInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/EvtGenInterface/plugins/$(file). Please fix src/GeneratorInterface/EvtGenInterface/plugins/BuildFile.))))
EvtGenInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/plugins/BuildFile
EvtGenInterface_LOC_USE := self   FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager GeneratorInterface/EvtGenInterface heppdt clhep hepmc evtgen pythia8 tauolapp photospp root 
EvtGenInterface_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,EvtGenInterface,EvtGenInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/EvtGenInterface/plugins))
EvtGenInterface_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/plugins
ALL_PRODS += EvtGenInterface
GeneratorInterface/EvtGenInterface_forbigobj+=EvtGenInterface
EvtGenInterface_INIT_FUNC        += $$(eval $$(call Library,EvtGenInterface,src/GeneratorInterface/EvtGenInterface/plugins,src_GeneratorInterface_EvtGenInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
EvtGenInterface_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,EvtGenInterface,src/GeneratorInterface/EvtGenInterface/plugins))
endif
ifeq ($(strip $(GenDataCardFileWriter)),)
GenDataCardFileWriter := self/src/GeneratorInterface/EvtGenInterface/plugins
PLUGINS:=yes
GenDataCardFileWriter_files := $(patsubst src/GeneratorInterface/EvtGenInterface/plugins/%,%,$(foreach file,DataCardFileWriter.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/EvtGenInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/EvtGenInterface/plugins/$(file). Please fix src/GeneratorInterface/EvtGenInterface/plugins/BuildFile.))))
GenDataCardFileWriter_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/plugins/BuildFile
GenDataCardFileWriter_LOC_USE := self   FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager 
GenDataCardFileWriter_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GenDataCardFileWriter,GenDataCardFileWriter,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/EvtGenInterface/plugins))
GenDataCardFileWriter_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/plugins
ALL_PRODS += GenDataCardFileWriter
GeneratorInterface/EvtGenInterface_forbigobj+=GenDataCardFileWriter
GenDataCardFileWriter_INIT_FUNC        += $$(eval $$(call Library,GenDataCardFileWriter,src/GeneratorInterface/EvtGenInterface/plugins,src_GeneratorInterface_EvtGenInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GenDataCardFileWriter_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GenDataCardFileWriter,src/GeneratorInterface/EvtGenInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_EvtGenInterface_plugins
src_GeneratorInterface_EvtGenInterface_plugins_parent := GeneratorInterface/EvtGenInterface
src_GeneratorInterface_EvtGenInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_EvtGenInterface_plugins,src/GeneratorInterface/EvtGenInterface/plugins,PLUGINS))
