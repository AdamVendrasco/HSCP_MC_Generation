ifeq ($(strip $(DD4hepGeometryTestDriver)),)
DD4hepGeometryTestDriver := self/src/SimG4Core/DD4hepGeometry/test
DD4hepGeometryTestDriver_files := 1
DD4hepGeometryTestDriver_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/DD4hepGeometry/test/BuildFile
DD4hepGeometryTestDriver_LOC_USE := self   FWCore/Framework dd4hep-geant4 DetectorDescription/DDCMS 
DD4hepGeometryTestDriver_PACKAGE := self/src/SimG4Core/DD4hepGeometry/test
ALL_PRODS += DD4hepGeometryTestDriver
DD4hepGeometryTestDriver_INIT_FUNC        += $$(eval $$(call Binary,DD4hepGeometryTestDriver,src/SimG4Core/DD4hepGeometry/test,src_SimG4Core_DD4hepGeometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
DD4hepGeometryTestDriver_CLASS := TEST
DD4hepGeometryTestDriver_TEST_RUNNER_CMD :=  runTest.sh
else
$(eval $(call MultipleWarningMsg,DD4hepGeometryTestDriver,src/SimG4Core/DD4hepGeometry/test))
endif
ifeq ($(strip $(DD4hepGeometryTestPlugins)),)
DD4hepGeometryTestPlugins := self/src/SimG4Core/DD4hepGeometry/test
DD4hepGeometryTestPlugins_files := $(patsubst src/SimG4Core/DD4hepGeometry/test/%,%,$(foreach file,plugins/*.cc,$(eval xfile:=$(wildcard src/SimG4Core/DD4hepGeometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/DD4hepGeometry/test/$(file). Please fix src/SimG4Core/DD4hepGeometry/test/BuildFile.))))
DD4hepGeometryTestPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/DD4hepGeometry/test/BuildFile
DD4hepGeometryTestPlugins_LOC_LIB   := Geom
DD4hepGeometryTestPlugins_LOC_USE := self   FWCore/Framework dd4hep-geant4 DetectorDescription/DDCMS SimG4Core/DD4hepGeometry geant4core Geometry/Records 
DD4hepGeometryTestPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,DD4hepGeometryTestPlugins,DD4hepGeometryTestPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/DD4hepGeometry/test))
DD4hepGeometryTestPlugins_PACKAGE := self/src/SimG4Core/DD4hepGeometry/test
ALL_PRODS += DD4hepGeometryTestPlugins
DD4hepGeometryTestPlugins_INIT_FUNC        += $$(eval $$(call Library,DD4hepGeometryTestPlugins,src/SimG4Core/DD4hepGeometry/test,src_SimG4Core_DD4hepGeometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
DD4hepGeometryTestPlugins_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,DD4hepGeometryTestPlugins,src/SimG4Core/DD4hepGeometry/test))
endif
ALL_COMMONRULES += src_SimG4Core_DD4hepGeometry_test
src_SimG4Core_DD4hepGeometry_test_parent := SimG4Core/DD4hepGeometry
src_SimG4Core_DD4hepGeometry_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_DD4hepGeometry_test,src/SimG4Core/DD4hepGeometry/test,TEST))
