ifeq ($(strip $(PhotosppInterface)),)
PhotosppInterface := self/src/GeneratorInterface/PhotosInterface/plugins
PLUGINS:=yes
PhotosppInterface_files := $(patsubst src/GeneratorInterface/PhotosInterface/plugins/%,%,$(foreach file,PhotosppInterface.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/PhotosInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/PhotosInterface/plugins/$(file). Please fix src/GeneratorInterface/PhotosInterface/plugins/BuildFile.))))
PhotosppInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PhotosInterface/plugins/BuildFile
PhotosppInterface_LOC_USE := self   FWCore/Framework FWCore/PluginManager GeneratorInterface/PhotosInterface photospp hepmc clhep 
PhotosppInterface_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,PhotosppInterface,PhotosppInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/PhotosInterface/plugins))
PhotosppInterface_PACKAGE := self/src/GeneratorInterface/PhotosInterface/plugins
ALL_PRODS += PhotosppInterface
GeneratorInterface/PhotosInterface_forbigobj+=PhotosppInterface
PhotosppInterface_INIT_FUNC        += $$(eval $$(call Library,PhotosppInterface,src/GeneratorInterface/PhotosInterface/plugins,src_GeneratorInterface_PhotosInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
PhotosppInterface_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,PhotosppInterface,src/GeneratorInterface/PhotosInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_PhotosInterface_plugins
src_GeneratorInterface_PhotosInterface_plugins_parent := GeneratorInterface/PhotosInterface
src_GeneratorInterface_PhotosInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_PhotosInterface_plugins,src/GeneratorInterface/PhotosInterface/plugins,PLUGINS))
