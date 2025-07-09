ifeq ($(strip $(SimG4CorePrintGeomInfoPlugins)),)
SimG4CorePrintGeomInfoPlugins := self/src/SimG4Core/PrintGeomInfo/plugins
PLUGINS:=yes
SimG4CorePrintGeomInfoPlugins_files := $(patsubst src/SimG4Core/PrintGeomInfo/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/PrintGeomInfo/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/PrintGeomInfo/plugins/$(file). Please fix src/SimG4Core/PrintGeomInfo/plugins/BuildFile.))))
SimG4CorePrintGeomInfoPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PrintGeomInfo/plugins/BuildFile
SimG4CorePrintGeomInfoPlugins_LOC_USE := self   DetectorDescription/Core DetectorDescription/DDCMS SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet Geometry/Records geant4core dd4hep boost 
SimG4CorePrintGeomInfoPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CorePrintGeomInfoPlugins,SimG4CorePrintGeomInfoPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/PrintGeomInfo/plugins))
SimG4CorePrintGeomInfoPlugins_PACKAGE := self/src/SimG4Core/PrintGeomInfo/plugins
ALL_PRODS += SimG4CorePrintGeomInfoPlugins
SimG4Core/PrintGeomInfo_forbigobj+=SimG4CorePrintGeomInfoPlugins
SimG4CorePrintGeomInfoPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePrintGeomInfoPlugins,src/SimG4Core/PrintGeomInfo/plugins,src_SimG4Core_PrintGeomInfo_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CorePrintGeomInfoPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CorePrintGeomInfoPlugins,src/SimG4Core/PrintGeomInfo/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_PrintGeomInfo_plugins
src_SimG4Core_PrintGeomInfo_plugins_parent := SimG4Core/PrintGeomInfo
src_SimG4Core_PrintGeomInfo_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_PrintGeomInfo_plugins,src/SimG4Core/PrintGeomInfo/plugins,PLUGINS))
