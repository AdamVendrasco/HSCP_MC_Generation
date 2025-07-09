ifeq ($(strip $(SimG4Core/Application)),)
ALL_COMMONRULES += src_SimG4Core_Application_src
src_SimG4Core_Application_src_parent := SimG4Core/Application
src_SimG4Core_Application_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Application_src,src/SimG4Core/Application/src,LIBRARY))
SimG4CoreApplication := self/SimG4Core/Application
SimG4Core/Application := SimG4CoreApplication
SimG4CoreApplication_files := $(patsubst src/SimG4Core/Application/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Application/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreApplication_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Application/BuildFile
SimG4CoreApplication_LOC_USE := self   SimDataFormats/GeneratorProducts SimDataFormats/Forward SimG4Core/Generators SimG4Core/Geometry DetectorDescription/DDCMS SimG4Core/MagneticField SimG4Core/Notification SimG4Core/PhysicsLists SimG4Core/CustomPhysics SimG4Core/Physics SimG4Core/SensitiveDetector SimG4Core/Watcher SimGeneral/HepPDTRecord SimGeneral/GFlash FWCore/ParameterSet FWCore/Framework FWCore/Utilities MagneticField/Engine MagneticField/Records clhep xerces-c geant4core hepmc heppdt 
SimG4CoreApplication_EX_LIB   := SimG4CoreApplication
SimG4CoreApplication_EX_USE   := $(foreach d,$(SimG4CoreApplication_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreApplication_PACKAGE := self/src/SimG4Core/Application/src
ALL_PRODS += SimG4CoreApplication
SimG4CoreApplication_CLASS := LIBRARY
SimG4Core/Application_forbigobj+=SimG4CoreApplication
SimG4CoreApplication_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreApplication,src/SimG4Core/Application/src,src_SimG4Core_Application_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4CoreApplicationPlugins)),)
SimG4CoreApplicationPlugins := self/src/SimG4Core/Application/plugins
PLUGINS:=yes
SimG4CoreApplicationPlugins_files := $(patsubst src/SimG4Core/Application/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/Application/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Application/plugins/$(file). Please fix src/SimG4Core/Application/plugins/BuildFile.))))
SimG4CoreApplicationPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Application/plugins/BuildFile
SimG4CoreApplicationPlugins_LOC_USE := self   FWCore/Framework FWCore/ParameterSet SimDataFormats/CaloHit SimDataFormats/Track SimDataFormats/TrackingHit SimDataFormats/Vertex SimG4Core/Notification geant4core clhep hepmc SimG4Core/Application 
SimG4CoreApplicationPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreApplicationPlugins,SimG4CoreApplicationPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/Application/plugins))
SimG4CoreApplicationPlugins_PACKAGE := self/src/SimG4Core/Application/plugins
ALL_PRODS += SimG4CoreApplicationPlugins
SimG4Core/Application_forbigobj+=SimG4CoreApplicationPlugins
SimG4CoreApplicationPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreApplicationPlugins,src/SimG4Core/Application/plugins,src_SimG4Core_Application_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CoreApplicationPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CoreApplicationPlugins,src/SimG4Core/Application/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_Application_plugins
src_SimG4Core_Application_plugins_parent := SimG4Core/Application
src_SimG4Core_Application_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Application_plugins,src/SimG4Core/Application/plugins,PLUGINS))
ifeq ($(strip $(SimG4Core/CheckSecondary)),)
ALL_COMMONRULES += src_SimG4Core_CheckSecondary_src
src_SimG4Core_CheckSecondary_src_parent := SimG4Core/CheckSecondary
src_SimG4Core_CheckSecondary_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_CheckSecondary_src,src/SimG4Core/CheckSecondary/src,LIBRARY))
SimG4CoreCheckSecondary := self/SimG4Core/CheckSecondary
SimG4Core/CheckSecondary := SimG4CoreCheckSecondary
SimG4CoreCheckSecondary_files := $(patsubst src/SimG4Core/CheckSecondary/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/CheckSecondary/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreCheckSecondary_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/CheckSecondary/BuildFile
SimG4CoreCheckSecondary_LOC_USE := self   FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger geant4core boost root SimG4Core/Notification SimG4Core/Watcher SimG4Core/Physics DataFormats/Math 
SimG4CoreCheckSecondary_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreCheckSecondary,SimG4CoreCheckSecondary,$(SCRAMSTORENAME_LIB),src/SimG4Core/CheckSecondary/src))
SimG4CoreCheckSecondary_PACKAGE := self/src/SimG4Core/CheckSecondary/src
ALL_PRODS += SimG4CoreCheckSecondary
SimG4CoreCheckSecondary_CLASS := LIBRARY
SimG4Core/CheckSecondary_forbigobj+=SimG4CoreCheckSecondary
SimG4CoreCheckSecondary_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreCheckSecondary,src/SimG4Core/CheckSecondary/src,src_SimG4Core_CheckSecondary_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimG4Core/CountProcesses)),)
ALL_COMMONRULES += src_SimG4Core_CountProcesses_src
src_SimG4Core_CountProcesses_src_parent := SimG4Core/CountProcesses
src_SimG4Core_CountProcesses_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_CountProcesses_src,src/SimG4Core/CountProcesses/src,LIBRARY))
SimG4CoreCountProcesses := self/SimG4Core/CountProcesses
SimG4Core/CountProcesses := SimG4CoreCountProcesses
SimG4CoreCountProcesses_files := $(patsubst src/SimG4Core/CountProcesses/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/CountProcesses/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreCountProcesses_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/CountProcesses/BuildFile
SimG4CoreCountProcesses_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet geant4core boost 
SimG4CoreCountProcesses_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreCountProcesses,SimG4CoreCountProcesses,$(SCRAMSTORENAME_LIB),src/SimG4Core/CountProcesses/src))
SimG4CoreCountProcesses_PACKAGE := self/src/SimG4Core/CountProcesses/src
ALL_PRODS += SimG4CoreCountProcesses
SimG4CoreCountProcesses_CLASS := LIBRARY
SimG4Core/CountProcesses_forbigobj+=SimG4CoreCountProcesses
SimG4CoreCountProcesses_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreCountProcesses,src/SimG4Core/CountProcesses/src,src_SimG4Core_CountProcesses_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimG4Core/CustomPhysics)),)
ALL_COMMONRULES += src_SimG4Core_CustomPhysics_src
src_SimG4Core_CustomPhysics_src_parent := SimG4Core/CustomPhysics
src_SimG4Core_CustomPhysics_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_CustomPhysics_src,src/SimG4Core/CustomPhysics/src,LIBRARY))
SimG4CoreCustomPhysics := self/SimG4Core/CustomPhysics
SimG4Core/CustomPhysics := SimG4CoreCustomPhysics
SimG4CoreCustomPhysics_files := $(patsubst src/SimG4Core/CustomPhysics/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/CustomPhysics/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreCustomPhysics_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/CustomPhysics/BuildFile
SimG4CoreCustomPhysics_LOC_USE := self   FWCore/Framework FWCore/MessageLogger SimG4Core/Notification SimG4Core/Physics SimG4Core/PhysicsLists SimG4Core/Watcher geant4core clhep boost rootmath root 
SimG4CoreCustomPhysics_EX_LIB   := SimG4CoreCustomPhysics
SimG4CoreCustomPhysics_EX_USE   := $(foreach d,$(SimG4CoreCustomPhysics_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreCustomPhysics_PACKAGE := self/src/SimG4Core/CustomPhysics/src
ALL_PRODS += SimG4CoreCustomPhysics
SimG4CoreCustomPhysics_CLASS := LIBRARY
SimG4Core/CustomPhysics_forbigobj+=SimG4CoreCustomPhysics
SimG4CoreCustomPhysics_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreCustomPhysics,src/SimG4Core/CustomPhysics/src,src_SimG4Core_CustomPhysics_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4CoreCustomPhysicsPlugins)),)
SimG4CoreCustomPhysicsPlugins := self/src/SimG4Core/CustomPhysics/plugins
PLUGINS:=yes
SimG4CoreCustomPhysicsPlugins_files := $(patsubst src/SimG4Core/CustomPhysics/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/CustomPhysics/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/CustomPhysics/plugins/$(file). Please fix src/SimG4Core/CustomPhysics/plugins/BuildFile.))))
SimG4CoreCustomPhysicsPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/CustomPhysics/plugins/BuildFile
SimG4CoreCustomPhysicsPlugins_LOC_FLAGS_USE_SOURCE_ONLY   := DataFormats/GeometryVector
SimG4CoreCustomPhysicsPlugins_LOC_USE := self   SimG4Core/Watcher SimG4Core/Notification FWCore/ParameterSet FWCore/PluginManager geant4core clhep boost SimG4Core/CustomPhysics 
SimG4CoreCustomPhysicsPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreCustomPhysicsPlugins,SimG4CoreCustomPhysicsPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/CustomPhysics/plugins))
SimG4CoreCustomPhysicsPlugins_PACKAGE := self/src/SimG4Core/CustomPhysics/plugins
ALL_PRODS += SimG4CoreCustomPhysicsPlugins
SimG4Core/CustomPhysics_forbigobj+=SimG4CoreCustomPhysicsPlugins
SimG4CoreCustomPhysicsPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreCustomPhysicsPlugins,src/SimG4Core/CustomPhysics/plugins,src_SimG4Core_CustomPhysics_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CoreCustomPhysicsPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CoreCustomPhysicsPlugins,src/SimG4Core/CustomPhysics/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_CustomPhysics_plugins
src_SimG4Core_CustomPhysics_plugins_parent := SimG4Core/CustomPhysics
src_SimG4Core_CustomPhysics_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_CustomPhysics_plugins,src/SimG4Core/CustomPhysics/plugins,PLUGINS))
ifeq ($(strip $(SimG4Core/DD4hepGeometry)),)
ALL_COMMONRULES += src_SimG4Core_DD4hepGeometry_src
src_SimG4Core_DD4hepGeometry_src_parent := SimG4Core/DD4hepGeometry
src_SimG4Core_DD4hepGeometry_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_DD4hepGeometry_src,src/SimG4Core/DD4hepGeometry/src,LIBRARY))
SimG4CoreDD4hepGeometry := self/SimG4Core/DD4hepGeometry
SimG4Core/DD4hepGeometry := SimG4CoreDD4hepGeometry
SimG4CoreDD4hepGeometry_files := $(patsubst src/SimG4Core/DD4hepGeometry/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/DD4hepGeometry/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreDD4hepGeometry_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/DD4hepGeometry/BuildFile
SimG4CoreDD4hepGeometry_LOC_USE := self   dd4hep-core dd4hep-geant4 geant4core FWCore/MessageLogger rootgeom rootmath 
SimG4CoreDD4hepGeometry_EX_LIB   := SimG4CoreDD4hepGeometry
SimG4CoreDD4hepGeometry_EX_USE   := $(foreach d,$(SimG4CoreDD4hepGeometry_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreDD4hepGeometry_PACKAGE := self/src/SimG4Core/DD4hepGeometry/src
ALL_PRODS += SimG4CoreDD4hepGeometry
SimG4CoreDD4hepGeometry_CLASS := LIBRARY
SimG4Core/DD4hepGeometry_forbigobj+=SimG4CoreDD4hepGeometry
SimG4CoreDD4hepGeometry_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreDD4hepGeometry,src/SimG4Core/DD4hepGeometry/src,src_SimG4Core_DD4hepGeometry_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4Core/GFlash)),)
ALL_COMMONRULES += src_SimG4Core_GFlash_src
src_SimG4Core_GFlash_src_parent := SimG4Core/GFlash
src_SimG4Core_GFlash_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_GFlash_src,src/SimG4Core/GFlash/src,LIBRARY))
SimG4CoreGFlash := self/SimG4Core/GFlash
SimG4Core/GFlash := SimG4CoreGFlash
SimG4CoreGFlash_files := $(patsubst src/SimG4Core/GFlash/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/GFlash/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreGFlash_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/GFlash/BuildFile
SimG4CoreGFlash_LOC_USE := self   FWCore/ParameterSet FWCore/MessageLogger SimG4Core/PhysicsLists SimGeneral/GFlash geant4core clhep root 
SimG4CoreGFlash_EX_LIB   := SimG4CoreGFlash
SimG4CoreGFlash_EX_USE   := $(foreach d,$(SimG4CoreGFlash_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreGFlash_PACKAGE := self/src/SimG4Core/GFlash/src
ALL_PRODS += SimG4CoreGFlash
SimG4CoreGFlash_CLASS := LIBRARY
SimG4Core/GFlash_forbigobj+=SimG4CoreGFlash
SimG4CoreGFlash_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreGFlash,src/SimG4Core/GFlash/src,src_SimG4Core_GFlash_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4CoreGFlashPlugins)),)
SimG4CoreGFlashPlugins := self/src/SimG4Core/GFlash/plugins
PLUGINS:=yes
SimG4CoreGFlashPlugins_files := $(patsubst src/SimG4Core/GFlash/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/GFlash/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/GFlash/plugins/$(file). Please fix src/SimG4Core/GFlash/plugins/BuildFile.))))
SimG4CoreGFlashPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/GFlash/plugins/BuildFile
SimG4CoreGFlashPlugins_LOC_USE := self   FWCore/Framework FWCore/MessageLogger FWCore/PluginManager SimG4Core/PhysicsLists SimG4Core/Notification SimG4Core/Watcher SimG4Core/GFlash geant4core clhep root 
SimG4CoreGFlashPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreGFlashPlugins,SimG4CoreGFlashPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/GFlash/plugins))
SimG4CoreGFlashPlugins_PACKAGE := self/src/SimG4Core/GFlash/plugins
ALL_PRODS += SimG4CoreGFlashPlugins
SimG4Core/GFlash_forbigobj+=SimG4CoreGFlashPlugins
SimG4CoreGFlashPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreGFlashPlugins,src/SimG4Core/GFlash/plugins,src_SimG4Core_GFlash_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CoreGFlashPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CoreGFlashPlugins,src/SimG4Core/GFlash/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_GFlash_plugins
src_SimG4Core_GFlash_plugins_parent := SimG4Core/GFlash
src_SimG4Core_GFlash_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_GFlash_plugins,src/SimG4Core/GFlash/plugins,PLUGINS))
ifeq ($(strip $(SimG4Core/Generators)),)
ALL_COMMONRULES += src_SimG4Core_Generators_src
src_SimG4Core_Generators_src_parent := SimG4Core/Generators
src_SimG4Core_Generators_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Generators_src,src/SimG4Core/Generators/src,LIBRARY))
SimG4CoreGenerators := self/SimG4Core/Generators
SimG4Core/Generators := SimG4CoreGenerators
SimG4CoreGenerators_files := $(patsubst src/SimG4Core/Generators/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Generators/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreGenerators_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Generators/BuildFile
SimG4CoreGenerators_LOC_USE := self   FWCore/ParameterSet FWCore/MessageLogger boost hepmc heppdt geant4core rootmath expat 
SimG4CoreGenerators_EX_LIB   := SimG4CoreGenerators
SimG4CoreGenerators_EX_USE   := $(foreach d,$(SimG4CoreGenerators_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreGenerators_PACKAGE := self/src/SimG4Core/Generators/src
ALL_PRODS += SimG4CoreGenerators
SimG4CoreGenerators_CLASS := LIBRARY
SimG4Core/Generators_forbigobj+=SimG4CoreGenerators
SimG4CoreGenerators_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreGenerators,src/SimG4Core/Generators/src,src_SimG4Core_Generators_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4Core/Geometry)),)
ALL_COMMONRULES += src_SimG4Core_Geometry_src
src_SimG4Core_Geometry_src_parent := SimG4Core/Geometry
src_SimG4Core_Geometry_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Geometry_src,src/SimG4Core/Geometry/src,LIBRARY))
SimG4CoreGeometry := self/SimG4Core/Geometry
SimG4Core/Geometry := SimG4CoreGeometry
SimG4CoreGeometry_files := $(patsubst src/SimG4Core/Geometry/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Geometry/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreGeometry_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/BuildFile
SimG4CoreGeometry_LOC_USE := self   DetectorDescription/Core geant4core DetectorDescription/DDCMS dd4hep-core dd4hep-geant4 FWCore/MessageLogger FWCore/Utilities xerces-c expat 
SimG4CoreGeometry_EX_LIB   := SimG4CoreGeometry
SimG4CoreGeometry_EX_USE   := $(foreach d,$(SimG4CoreGeometry_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreGeometry_PACKAGE := self/src/SimG4Core/Geometry/src
ALL_PRODS += SimG4CoreGeometry
SimG4CoreGeometry_CLASS := LIBRARY
SimG4Core/Geometry_forbigobj+=SimG4CoreGeometry
SimG4CoreGeometry_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreGeometry,src/SimG4Core/Geometry/src,src_SimG4Core_Geometry_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4Core/GeometryProducer)),)
ALL_COMMONRULES += src_SimG4Core_GeometryProducer_src
src_SimG4Core_GeometryProducer_src_parent := SimG4Core/GeometryProducer
src_SimG4Core_GeometryProducer_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_GeometryProducer_src,src/SimG4Core/GeometryProducer/src,LIBRARY))
SimG4CoreGeometryProducer := self/SimG4Core/GeometryProducer
SimG4Core/GeometryProducer := SimG4CoreGeometryProducer
SimG4CoreGeometryProducer_files := $(patsubst src/SimG4Core/GeometryProducer/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/GeometryProducer/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreGeometryProducer_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/GeometryProducer/BuildFile
SimG4CoreGeometryProducer_LOC_USE := self   DataFormats/Common SimG4Core/Notification SimG4Core/Watcher SimG4Core/Geometry SimG4Core/SensitiveDetector SimG4Core/MagneticField MagneticField/Engine MagneticField/Records FWCore/ParameterSet FWCore/Framework FWCore/PluginManager geant4core clhep 
SimG4CoreGeometryProducer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreGeometryProducer,SimG4CoreGeometryProducer,$(SCRAMSTORENAME_LIB),src/SimG4Core/GeometryProducer/src))
SimG4CoreGeometryProducer_PACKAGE := self/src/SimG4Core/GeometryProducer/src
ALL_PRODS += SimG4CoreGeometryProducer
SimG4CoreGeometryProducer_CLASS := LIBRARY
SimG4Core/GeometryProducer_forbigobj+=SimG4CoreGeometryProducer
SimG4CoreGeometryProducer_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreGeometryProducer,src/SimG4Core/GeometryProducer/src,src_SimG4Core_GeometryProducer_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimG4Core/HelpfulWatchers)),)
ALL_COMMONRULES += src_SimG4Core_HelpfulWatchers_src
src_SimG4Core_HelpfulWatchers_src_parent := SimG4Core/HelpfulWatchers
src_SimG4Core_HelpfulWatchers_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_HelpfulWatchers_src,src/SimG4Core/HelpfulWatchers/src,LIBRARY))
SimG4CoreHelpfulWatchers := self/SimG4Core/HelpfulWatchers
SimG4Core/HelpfulWatchers := SimG4CoreHelpfulWatchers
SimG4CoreHelpfulWatchers_files := $(patsubst src/SimG4Core/HelpfulWatchers/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/HelpfulWatchers/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreHelpfulWatchers_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/HelpfulWatchers/BuildFile
SimG4CoreHelpfulWatchers_LOC_USE := self   FWCore/Framework FWCore/ParameterSet SimG4Core/Watcher SimG4Core/Notification boost geant4core CommonTools/UtilAlgos MagneticField/Engine MagneticField/Records SimG4Core/Physics 
SimG4CoreHelpfulWatchers_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreHelpfulWatchers,SimG4CoreHelpfulWatchers,$(SCRAMSTORENAME_LIB),src/SimG4Core/HelpfulWatchers/src))
SimG4CoreHelpfulWatchers_PACKAGE := self/src/SimG4Core/HelpfulWatchers/src
ALL_PRODS += SimG4CoreHelpfulWatchers
SimG4CoreHelpfulWatchers_CLASS := LIBRARY
SimG4Core/HelpfulWatchers_forbigobj+=SimG4CoreHelpfulWatchers
SimG4CoreHelpfulWatchers_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreHelpfulWatchers,src/SimG4Core/HelpfulWatchers/src,src_SimG4Core_HelpfulWatchers_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimG4Core/KillSecondaries)),)
ALL_COMMONRULES += src_SimG4Core_KillSecondaries_src
src_SimG4Core_KillSecondaries_src_parent := SimG4Core/KillSecondaries
src_SimG4Core_KillSecondaries_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_KillSecondaries_src,src/SimG4Core/KillSecondaries/src,LIBRARY))
SimG4CoreKillSecondaries := self/SimG4Core/KillSecondaries
SimG4Core/KillSecondaries := SimG4CoreKillSecondaries
SimG4CoreKillSecondaries_files := $(patsubst src/SimG4Core/KillSecondaries/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/KillSecondaries/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreKillSecondaries_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/KillSecondaries/BuildFile
SimG4CoreKillSecondaries_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet geant4core boost 
SimG4CoreKillSecondaries_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreKillSecondaries,SimG4CoreKillSecondaries,$(SCRAMSTORENAME_LIB),src/SimG4Core/KillSecondaries/src))
SimG4CoreKillSecondaries_PACKAGE := self/src/SimG4Core/KillSecondaries/src
ALL_PRODS += SimG4CoreKillSecondaries
SimG4CoreKillSecondaries_CLASS := LIBRARY
SimG4Core/KillSecondaries_forbigobj+=SimG4CoreKillSecondaries
SimG4CoreKillSecondaries_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreKillSecondaries,src/SimG4Core/KillSecondaries/src,src_SimG4Core_KillSecondaries_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimG4Core/MagneticField)),)
ALL_COMMONRULES += src_SimG4Core_MagneticField_src
src_SimG4Core_MagneticField_src_parent := SimG4Core/MagneticField
src_SimG4Core_MagneticField_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_MagneticField_src,src/SimG4Core/MagneticField/src,LIBRARY))
SimG4CoreMagneticField := self/SimG4Core/MagneticField
SimG4Core/MagneticField := SimG4CoreMagneticField
SimG4CoreMagneticField_files := $(patsubst src/SimG4Core/MagneticField/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/MagneticField/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreMagneticField_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/MagneticField/BuildFile
SimG4CoreMagneticField_LOC_USE := self   FWCore/ParameterSet boost geant4core expat 
SimG4CoreMagneticField_EX_LIB   := SimG4CoreMagneticField
SimG4CoreMagneticField_EX_USE   := $(foreach d,$(SimG4CoreMagneticField_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreMagneticField_PACKAGE := self/src/SimG4Core/MagneticField/src
ALL_PRODS += SimG4CoreMagneticField
SimG4CoreMagneticField_CLASS := LIBRARY
SimG4Core/MagneticField_forbigobj+=SimG4CoreMagneticField
SimG4CoreMagneticField_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreMagneticField,src/SimG4Core/MagneticField/src,src_SimG4Core_MagneticField_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4Core/Notification)),)
ALL_COMMONRULES += src_SimG4Core_Notification_src
src_SimG4Core_Notification_src_parent := SimG4Core/Notification
src_SimG4Core_Notification_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Notification_src,src/SimG4Core/Notification/src,LIBRARY))
SimG4CoreNotification := self/SimG4Core/Notification
SimG4Core/Notification := SimG4CoreNotification
SimG4CoreNotification_files := $(patsubst src/SimG4Core/Notification/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Notification/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreNotification_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Notification/BuildFile
SimG4CoreNotification_LOC_USE := self   SimDataFormats/Forward SimDataFormats/Track SimDataFormats/Vertex DataFormats/Math geant4core FWCore/MessageLogger rootmath expat hepmc 
SimG4CoreNotification_EX_LIB   := SimG4CoreNotification
SimG4CoreNotification_EX_USE   := $(foreach d,$(SimG4CoreNotification_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreNotification_PACKAGE := self/src/SimG4Core/Notification/src
ALL_PRODS += SimG4CoreNotification
SimG4CoreNotification_CLASS := LIBRARY
SimG4Core/Notification_forbigobj+=SimG4CoreNotification
SimG4CoreNotification_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreNotification,src/SimG4Core/Notification/src,src_SimG4Core_Notification_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4Core/Physics)),)
ALL_COMMONRULES += src_SimG4Core_Physics_src
src_SimG4Core_Physics_src_parent := SimG4Core/Physics
src_SimG4Core_Physics_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Physics_src,src/SimG4Core/Physics/src,LIBRARY))
SimG4CorePhysics := self/SimG4Core/Physics
SimG4Core/Physics := SimG4CorePhysics
SimG4CorePhysics_files := $(patsubst src/SimG4Core/Physics/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Physics/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CorePhysics_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Physics/BuildFile
SimG4CorePhysics_LOC_USE := self   FWCore/ParameterSet geant4core heppdt boost expat 
SimG4CorePhysics_EX_LIB   := SimG4CorePhysics
SimG4CorePhysics_EX_USE   := $(foreach d,$(SimG4CorePhysics_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CorePhysics_PACKAGE := self/src/SimG4Core/Physics/src
ALL_PRODS += SimG4CorePhysics
SimG4CorePhysics_CLASS := LIBRARY
SimG4Core/Physics_forbigobj+=SimG4CorePhysics
SimG4CorePhysics_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePhysics,src/SimG4Core/Physics/src,src_SimG4Core_Physics_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4Core/PhysicsLists)),)
ALL_COMMONRULES += src_SimG4Core_PhysicsLists_src
src_SimG4Core_PhysicsLists_src_parent := SimG4Core/PhysicsLists
src_SimG4Core_PhysicsLists_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_PhysicsLists_src,src/SimG4Core/PhysicsLists/src,LIBRARY))
SimG4CorePhysicsLists := self/SimG4Core/PhysicsLists
SimG4Core/PhysicsLists := SimG4CorePhysicsLists
SimG4CorePhysicsLists_files := $(patsubst src/SimG4Core/PhysicsLists/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/PhysicsLists/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CorePhysicsLists_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PhysicsLists/BuildFile
SimG4CorePhysicsLists_LOC_USE := self   boost clhep geant4core g4hepemcore heppdt FWCore/MessageLogger SimG4Core/MagneticField SimG4Core/Physics 
SimG4CorePhysicsLists_EX_LIB   := SimG4CorePhysicsLists
SimG4CorePhysicsLists_EX_USE   := $(foreach d,$(SimG4CorePhysicsLists_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CorePhysicsLists_PACKAGE := self/src/SimG4Core/PhysicsLists/src
ALL_PRODS += SimG4CorePhysicsLists
SimG4CorePhysicsLists_CLASS := LIBRARY
SimG4Core/PhysicsLists_forbigobj+=SimG4CorePhysicsLists
SimG4CorePhysicsLists_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePhysicsLists,src/SimG4Core/PhysicsLists/src,src_SimG4Core_PhysicsLists_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4CorePhysicsListsPlugins)),)
SimG4CorePhysicsListsPlugins := self/src/SimG4Core/PhysicsLists/plugins
PLUGINS:=yes
SimG4CorePhysicsListsPlugins_files := $(patsubst src/SimG4Core/PhysicsLists/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimG4Core/PhysicsLists/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/PhysicsLists/plugins/$(file). Please fix src/SimG4Core/PhysicsLists/plugins/BuildFile.))))
SimG4CorePhysicsListsPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PhysicsLists/plugins/BuildFile
SimG4CorePhysicsListsPlugins_LOC_USE := self   FWCore/ParameterSet FWCore/MessageLogger SimG4Core/Physics geant4core clhep heppdt boost SimG4Core/PhysicsLists 
SimG4CorePhysicsListsPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CorePhysicsListsPlugins,SimG4CorePhysicsListsPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/PhysicsLists/plugins))
SimG4CorePhysicsListsPlugins_PACKAGE := self/src/SimG4Core/PhysicsLists/plugins
ALL_PRODS += SimG4CorePhysicsListsPlugins
SimG4Core/PhysicsLists_forbigobj+=SimG4CorePhysicsListsPlugins
SimG4CorePhysicsListsPlugins_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePhysicsListsPlugins,src/SimG4Core/PhysicsLists/plugins,src_SimG4Core_PhysicsLists_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CorePhysicsListsPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CorePhysicsListsPlugins,src/SimG4Core/PhysicsLists/plugins))
endif
ALL_COMMONRULES += src_SimG4Core_PhysicsLists_plugins
src_SimG4Core_PhysicsLists_plugins_parent := SimG4Core/PhysicsLists
src_SimG4Core_PhysicsLists_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_PhysicsLists_plugins,src/SimG4Core/PhysicsLists/plugins,PLUGINS))
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
ifeq ($(strip $(SimG4Core/PrintTrackNumber)),)
ALL_COMMONRULES += src_SimG4Core_PrintTrackNumber_src
src_SimG4Core_PrintTrackNumber_src_parent := SimG4Core/PrintTrackNumber
src_SimG4Core_PrintTrackNumber_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_PrintTrackNumber_src,src/SimG4Core/PrintTrackNumber/src,LIBRARY))
SimG4CorePrintTrackNumber := self/SimG4Core/PrintTrackNumber
SimG4Core/PrintTrackNumber := SimG4CorePrintTrackNumber
SimG4CorePrintTrackNumber_files := $(patsubst src/SimG4Core/PrintTrackNumber/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/PrintTrackNumber/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CorePrintTrackNumber_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PrintTrackNumber/BuildFile
SimG4CorePrintTrackNumber_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet geant4core boost 
SimG4CorePrintTrackNumber_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CorePrintTrackNumber,SimG4CorePrintTrackNumber,$(SCRAMSTORENAME_LIB),src/SimG4Core/PrintTrackNumber/src))
SimG4CorePrintTrackNumber_PACKAGE := self/src/SimG4Core/PrintTrackNumber/src
ALL_PRODS += SimG4CorePrintTrackNumber
SimG4CorePrintTrackNumber_CLASS := LIBRARY
SimG4Core/PrintTrackNumber_forbigobj+=SimG4CorePrintTrackNumber
SimG4CorePrintTrackNumber_INIT_FUNC        += $$(eval $$(call Library,SimG4CorePrintTrackNumber,src/SimG4Core/PrintTrackNumber/src,src_SimG4Core_PrintTrackNumber_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimG4Core/SaveSimTrackAction)),)
ALL_COMMONRULES += src_SimG4Core_SaveSimTrackAction_src
src_SimG4Core_SaveSimTrackAction_src_parent := SimG4Core/SaveSimTrackAction
src_SimG4Core_SaveSimTrackAction_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_SaveSimTrackAction_src,src/SimG4Core/SaveSimTrackAction/src,LIBRARY))
SimG4CoreSaveSimTrackAction := self/SimG4Core/SaveSimTrackAction
SimG4Core/SaveSimTrackAction := SimG4CoreSaveSimTrackAction
SimG4CoreSaveSimTrackAction_files := $(patsubst src/SimG4Core/SaveSimTrackAction/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/SaveSimTrackAction/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreSaveSimTrackAction_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/SaveSimTrackAction/BuildFile
SimG4CoreSaveSimTrackAction_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/PluginManager FWCore/ParameterSet geant4core boost 
SimG4CoreSaveSimTrackAction_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreSaveSimTrackAction,SimG4CoreSaveSimTrackAction,$(SCRAMSTORENAME_LIB),src/SimG4Core/SaveSimTrackAction/src))
SimG4CoreSaveSimTrackAction_PACKAGE := self/src/SimG4Core/SaveSimTrackAction/src
ALL_PRODS += SimG4CoreSaveSimTrackAction
SimG4CoreSaveSimTrackAction_CLASS := LIBRARY
SimG4Core/SaveSimTrackAction_forbigobj+=SimG4CoreSaveSimTrackAction
SimG4CoreSaveSimTrackAction_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreSaveSimTrackAction,src/SimG4Core/SaveSimTrackAction/src,src_SimG4Core_SaveSimTrackAction_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimG4Core/SensitiveDetector)),)
ALL_COMMONRULES += src_SimG4Core_SensitiveDetector_src
src_SimG4Core_SensitiveDetector_src_parent := SimG4Core/SensitiveDetector
src_SimG4Core_SensitiveDetector_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_SensitiveDetector_src,src/SimG4Core/SensitiveDetector/src,LIBRARY))
SimG4CoreSensitiveDetector := self/SimG4Core/SensitiveDetector
SimG4Core/SensitiveDetector := SimG4CoreSensitiveDetector
SimG4CoreSensitiveDetector_files := $(patsubst src/SimG4Core/SensitiveDetector/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/SensitiveDetector/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreSensitiveDetector_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/SensitiveDetector/BuildFile
SimG4CoreSensitiveDetector_LOC_USE := self   DataFormats/GeometryVector FWCore/MessageLogger FWCore/PluginManager SimG4Core/Geometry SimG4Core/Notification geant4core 
SimG4CoreSensitiveDetector_EX_LIB   := SimG4CoreSensitiveDetector
SimG4CoreSensitiveDetector_EX_USE   := $(foreach d,$(SimG4CoreSensitiveDetector_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreSensitiveDetector_PACKAGE := self/src/SimG4Core/SensitiveDetector/src
ALL_PRODS += SimG4CoreSensitiveDetector
SimG4CoreSensitiveDetector_CLASS := LIBRARY
SimG4Core/SensitiveDetector_forbigobj+=SimG4CoreSensitiveDetector
SimG4CoreSensitiveDetector_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreSensitiveDetector,src/SimG4Core/SensitiveDetector/src,src_SimG4Core_SensitiveDetector_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimG4Core/TrackingVerbose)),)
ALL_COMMONRULES += src_SimG4Core_TrackingVerbose_src
src_SimG4Core_TrackingVerbose_src_parent := SimG4Core/TrackingVerbose
src_SimG4Core_TrackingVerbose_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_TrackingVerbose_src,src/SimG4Core/TrackingVerbose/src,LIBRARY))
SimG4CoreTrackingVerbose := self/SimG4Core/TrackingVerbose
SimG4Core/TrackingVerbose := SimG4CoreTrackingVerbose
SimG4CoreTrackingVerbose_files := $(patsubst src/SimG4Core/TrackingVerbose/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/TrackingVerbose/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreTrackingVerbose_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/TrackingVerbose/BuildFile
SimG4CoreTrackingVerbose_LOC_USE := self   SimG4Core/Application geant4core boost 
SimG4CoreTrackingVerbose_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreTrackingVerbose,SimG4CoreTrackingVerbose,$(SCRAMSTORENAME_LIB),src/SimG4Core/TrackingVerbose/src))
SimG4CoreTrackingVerbose_PACKAGE := self/src/SimG4Core/TrackingVerbose/src
ALL_PRODS += SimG4CoreTrackingVerbose
SimG4CoreTrackingVerbose_CLASS := LIBRARY
SimG4Core/TrackingVerbose_forbigobj+=SimG4CoreTrackingVerbose
SimG4CoreTrackingVerbose_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreTrackingVerbose,src/SimG4Core/TrackingVerbose/src,src_SimG4Core_TrackingVerbose_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimG4Core/Watcher)),)
ALL_COMMONRULES += src_SimG4Core_Watcher_src
src_SimG4Core_Watcher_src_parent := SimG4Core/Watcher
src_SimG4Core_Watcher_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Watcher_src,src/SimG4Core/Watcher/src,LIBRARY))
SimG4CoreWatcher := self/SimG4Core/Watcher
SimG4Core/Watcher := SimG4CoreWatcher
SimG4CoreWatcher_files := $(patsubst src/SimG4Core/Watcher/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Watcher/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreWatcher_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Watcher/BuildFile
SimG4CoreWatcher_LOC_USE := self   FWCore/Framework boost 
SimG4CoreWatcher_EX_LIB   := SimG4CoreWatcher
SimG4CoreWatcher_EX_USE   := $(foreach d,$(SimG4CoreWatcher_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreWatcher_PACKAGE := self/src/SimG4Core/Watcher/src
ALL_PRODS += SimG4CoreWatcher
SimG4CoreWatcher_CLASS := LIBRARY
SimG4Core/Watcher_forbigobj+=SimG4CoreWatcher
SimG4CoreWatcher_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreWatcher,src/SimG4Core/Watcher/src,src_SimG4Core_Watcher_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterface/Core)),)
ALL_COMMONRULES += src_GeneratorInterface_Core_src
src_GeneratorInterface_Core_src_parent := GeneratorInterface/Core
src_GeneratorInterface_Core_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_src,src/GeneratorInterface/Core/src,LIBRARY))
GeneratorInterfaceCore := self/GeneratorInterface/Core
GeneratorInterface/Core := GeneratorInterfaceCore
GeneratorInterfaceCore_files := $(patsubst src/GeneratorInterface/Core/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Core/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceCore_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/BuildFile
GeneratorInterfaceCore_LOC_USE := self   FWCore/Concurrency FWCore/ServiceRegistry FWCore/Utilities FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/LHEInterface heppdt boost hepmc hepmc3 clhep lhapdf f77compiler root 
GeneratorInterfaceCore_EX_LIB   := GeneratorInterfaceCore
GeneratorInterfaceCore_EX_USE   := $(foreach d,$(GeneratorInterfaceCore_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceCore_PACKAGE := self/src/GeneratorInterface/Core/src
ALL_PRODS += GeneratorInterfaceCore
GeneratorInterfaceCore_CLASS := LIBRARY
GeneratorInterface/Core_forbigobj+=GeneratorInterfaceCore
GeneratorInterfaceCore_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceCore,src/GeneratorInterface/Core/src,src_GeneratorInterface_Core_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfaceCore_plugins)),)
GeneratorInterfaceCore_plugins := self/src/GeneratorInterface/Core/plugins
PLUGINS:=yes
GeneratorInterfaceCore_plugins_files := $(patsubst src/GeneratorInterface/Core/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Core/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Core/plugins/$(file). Please fix src/GeneratorInterface/Core/plugins/BuildFile.))))
GeneratorInterfaceCore_plugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/plugins/BuildFile
GeneratorInterfaceCore_plugins_LOC_USE := self   FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger FWCore/Utilities SimDataFormats/GeneratorProducts FWCore/SharedMemory clhep 
GeneratorInterfaceCore_plugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceCore_plugins,GeneratorInterfaceCore_plugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Core/plugins))
GeneratorInterfaceCore_plugins_PACKAGE := self/src/GeneratorInterface/Core/plugins
ALL_PRODS += GeneratorInterfaceCore_plugins
GeneratorInterface/Core_forbigobj+=GeneratorInterfaceCore_plugins
GeneratorInterfaceCore_plugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceCore_plugins,src/GeneratorInterface/Core/plugins,src_GeneratorInterface_Core_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceCore_plugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceCore_plugins,src/GeneratorInterface/Core/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_Core_plugins
src_GeneratorInterface_Core_plugins_parent := GeneratorInterface/Core
src_GeneratorInterface_Core_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_plugins,src/GeneratorInterface/Core/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/ExternalDecays)),)
ALL_COMMONRULES += src_GeneratorInterface_ExternalDecays_src
src_GeneratorInterface_ExternalDecays_src_parent := GeneratorInterface/ExternalDecays
src_GeneratorInterface_ExternalDecays_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExternalDecays_src,src/GeneratorInterface/ExternalDecays/src,LIBRARY))
GeneratorInterfaceExternalDecays := self/GeneratorInterface/ExternalDecays
GeneratorInterface/ExternalDecays := GeneratorInterfaceExternalDecays
GeneratorInterfaceExternalDecays_files := $(patsubst src/GeneratorInterface/ExternalDecays/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ExternalDecays/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceExternalDecays_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ExternalDecays/BuildFile
GeneratorInterfaceExternalDecays_LOC_USE := self   FWCore/Concurrency FWCore/ParameterSet FWCore/Framework heppdt clhep hepmc GeneratorInterface/Core GeneratorInterface/LHEInterface GeneratorInterface/EvtGenInterface GeneratorInterface/PhotosInterface GeneratorInterface/TauolaInterface SimDataFormats/GeneratorProducts 
GeneratorInterfaceExternalDecays_EX_LIB   := GeneratorInterfaceExternalDecays
GeneratorInterfaceExternalDecays_EX_USE   := $(foreach d,$(GeneratorInterfaceExternalDecays_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceExternalDecays_PACKAGE := self/src/GeneratorInterface/ExternalDecays/src
ALL_PRODS += GeneratorInterfaceExternalDecays
GeneratorInterfaceExternalDecays_CLASS := LIBRARY
GeneratorInterface/ExternalDecays_forbigobj+=GeneratorInterfaceExternalDecays
GeneratorInterfaceExternalDecays_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceExternalDecays,src/GeneratorInterface/ExternalDecays/src,src_GeneratorInterface_ExternalDecays_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterface/LHEInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_LHEInterface_src
src_GeneratorInterface_LHEInterface_src_parent := GeneratorInterface/LHEInterface
src_GeneratorInterface_LHEInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_LHEInterface_src,src/GeneratorInterface/LHEInterface/src,LIBRARY))
GeneratorInterfaceLHEInterface := self/GeneratorInterface/LHEInterface
GeneratorInterface/LHEInterface := GeneratorInterfaceLHEInterface
GeneratorInterfaceLHEInterface_files := $(patsubst src/GeneratorInterface/LHEInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/LHEInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceLHEInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/BuildFile
GeneratorInterfaceLHEInterface_LOC_USE := self   FWCore/MessageLogger FWCore/ParameterSet FWCore/Utilities Utilities/Xerces SimDataFormats/GeneratorProducts Utilities/StorageFactory hepmc boost xerces-c rootmath fastjet xz hdf5 highfive 
GeneratorInterfaceLHEInterface_EX_LIB   := GeneratorInterfaceLHEInterface
GeneratorInterfaceLHEInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceLHEInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceLHEInterface_PACKAGE := self/src/GeneratorInterface/LHEInterface/src
ALL_PRODS += GeneratorInterfaceLHEInterface
GeneratorInterfaceLHEInterface_CLASS := LIBRARY
GeneratorInterface/LHEInterface_forbigobj+=GeneratorInterfaceLHEInterface
GeneratorInterfaceLHEInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceLHEInterface,src/GeneratorInterface/LHEInterface/src,src_GeneratorInterface_LHEInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfaceLHECOMWeightProducer)),)
GeneratorInterfaceLHECOMWeightProducer := self/src/GeneratorInterface/LHEInterface/plugins
PLUGINS:=yes
GeneratorInterfaceLHECOMWeightProducer_files := $(patsubst src/GeneratorInterface/LHEInterface/plugins/%,%,$(foreach file,LHECOMWeightProducer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/LHEInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/LHEInterface/plugins/$(file). Please fix src/GeneratorInterface/LHEInterface/plugins/BuildFile.))))
GeneratorInterfaceLHECOMWeightProducer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/plugins/BuildFile
GeneratorInterfaceLHECOMWeightProducer_LOC_USE := self   stdcxx-fs FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities GeneratorInterface/LHEInterface lhapdf FWCore/Framework SimDataFormats/GeneratorProducts 
GeneratorInterfaceLHECOMWeightProducer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceLHECOMWeightProducer,GeneratorInterfaceLHECOMWeightProducer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/LHEInterface/plugins))
GeneratorInterfaceLHECOMWeightProducer_PACKAGE := self/src/GeneratorInterface/LHEInterface/plugins
ALL_PRODS += GeneratorInterfaceLHECOMWeightProducer
GeneratorInterface/LHEInterface_forbigobj+=GeneratorInterfaceLHECOMWeightProducer
GeneratorInterfaceLHECOMWeightProducer_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceLHECOMWeightProducer,src/GeneratorInterface/LHEInterface/plugins,src_GeneratorInterface_LHEInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceLHECOMWeightProducer_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceLHECOMWeightProducer,src/GeneratorInterface/LHEInterface/plugins))
endif
ifeq ($(strip $(GeneratorInterfaceLHEIO)),)
GeneratorInterfaceLHEIO := self/src/GeneratorInterface/LHEInterface/plugins
PLUGINS:=yes
GeneratorInterfaceLHEIO_files := $(patsubst src/GeneratorInterface/LHEInterface/plugins/%,%,$(foreach file,LH5Source.cc LHESource.cc LHEProvenanceHelper.cc LHEWriter.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/LHEInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/LHEInterface/plugins/$(file). Please fix src/GeneratorInterface/LHEInterface/plugins/BuildFile.))))
GeneratorInterfaceLHEIO_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/plugins/BuildFile
GeneratorInterfaceLHEIO_LOC_USE := self   stdcxx-fs FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities GeneratorInterface/LHEInterface FWCore/Framework FWCore/Sources SimDataFormats/GeneratorProducts 
GeneratorInterfaceLHEIO_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceLHEIO,GeneratorInterfaceLHEIO,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/LHEInterface/plugins))
GeneratorInterfaceLHEIO_PACKAGE := self/src/GeneratorInterface/LHEInterface/plugins
ALL_PRODS += GeneratorInterfaceLHEIO
GeneratorInterface/LHEInterface_forbigobj+=GeneratorInterfaceLHEIO
GeneratorInterfaceLHEIO_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceLHEIO,src/GeneratorInterface/LHEInterface/plugins,src_GeneratorInterface_LHEInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceLHEIO_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceLHEIO,src/GeneratorInterface/LHEInterface/plugins))
endif
ifeq ($(strip $(GeneratorInterfaceLHEProducer)),)
GeneratorInterfaceLHEProducer := self/src/GeneratorInterface/LHEInterface/plugins
PLUGINS:=yes
GeneratorInterfaceLHEProducer_files := $(patsubst src/GeneratorInterface/LHEInterface/plugins/%,%,$(foreach file,LHEFilter.cc LHE2HepMCConverter.cc ExternalLHEProducer.cc ExternalLHEAsciiDumper.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/LHEInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/LHEInterface/plugins/$(file). Please fix src/GeneratorInterface/LHEInterface/plugins/BuildFile.))))
GeneratorInterfaceLHEProducer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/plugins/BuildFile
GeneratorInterfaceLHEProducer_LOC_USE := self   stdcxx-fs FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities GeneratorInterface/LHEInterface tbb FWCore/Framework SimDataFormats/GeneratorProducts 
GeneratorInterfaceLHEProducer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceLHEProducer,GeneratorInterfaceLHEProducer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/LHEInterface/plugins))
GeneratorInterfaceLHEProducer_PACKAGE := self/src/GeneratorInterface/LHEInterface/plugins
ALL_PRODS += GeneratorInterfaceLHEProducer
GeneratorInterface/LHEInterface_forbigobj+=GeneratorInterfaceLHEProducer
GeneratorInterfaceLHEProducer_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceLHEProducer,src/GeneratorInterface/LHEInterface/plugins,src_GeneratorInterface_LHEInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceLHEProducer_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceLHEProducer,src/GeneratorInterface/LHEInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_LHEInterface_plugins
src_GeneratorInterface_LHEInterface_plugins_parent := GeneratorInterface/LHEInterface
src_GeneratorInterface_LHEInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_LHEInterface_plugins,src/GeneratorInterface/LHEInterface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/PartonShowerVeto)),)
ALL_COMMONRULES += src_GeneratorInterface_PartonShowerVeto_src
src_GeneratorInterface_PartonShowerVeto_src_parent := GeneratorInterface/PartonShowerVeto
src_GeneratorInterface_PartonShowerVeto_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_PartonShowerVeto_src,src/GeneratorInterface/PartonShowerVeto/src,LIBRARY))
GeneratorInterfacePartonShowerVeto := self/GeneratorInterface/PartonShowerVeto
GeneratorInterface/PartonShowerVeto := GeneratorInterfacePartonShowerVeto
GeneratorInterfacePartonShowerVeto_files := $(patsubst src/GeneratorInterface/PartonShowerVeto/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/PartonShowerVeto/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePartonShowerVeto_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PartonShowerVeto/BuildFile
GeneratorInterfacePartonShowerVeto_LOC_USE := self   FWCore/ParameterSet SimDataFormats/GeneratorProducts GeneratorInterface/AlpgenInterface GeneratorInterface/LHEInterface fastjet pythia8 pythia6 f77compiler hepmc 
GeneratorInterfacePartonShowerVeto_EX_LIB   := GeneratorInterfacePartonShowerVeto
GeneratorInterfacePartonShowerVeto_EX_USE   := $(foreach d,$(GeneratorInterfacePartonShowerVeto_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePartonShowerVeto_PACKAGE := self/src/GeneratorInterface/PartonShowerVeto/src
ALL_PRODS += GeneratorInterfacePartonShowerVeto
GeneratorInterfacePartonShowerVeto_CLASS := LIBRARY
GeneratorInterface/PartonShowerVeto_forbigobj+=GeneratorInterfacePartonShowerVeto
GeneratorInterfacePartonShowerVeto_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePartonShowerVeto,src/GeneratorInterface/PartonShowerVeto/src,src_GeneratorInterface_PartonShowerVeto_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterface/Pythia8Interface)),)
ALL_COMMONRULES += src_GeneratorInterface_Pythia8Interface_src
src_GeneratorInterface_Pythia8Interface_src_parent := GeneratorInterface/Pythia8Interface
src_GeneratorInterface_Pythia8Interface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia8Interface_src,src/GeneratorInterface/Pythia8Interface/src,LIBRARY))
GeneratorInterfacePythia8Interface := self/GeneratorInterface/Pythia8Interface
GeneratorInterface/Pythia8Interface := GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_files := $(patsubst src/GeneratorInterface/Pythia8Interface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Pythia8Interface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePythia8Interface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/BuildFile
GeneratorInterfacePythia8Interface_LOC_USE := self   FWCore/Concurrency FWCore/Framework FWCore/MessageLogger FWCore/Utilities SimDataFormats/GeneratorProducts GeneratorInterface/Core boost pythia8 evtgen hepmc hepmc3 clhep root 
GeneratorInterfacePythia8Interface_EX_LIB   := GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_EX_USE   := $(foreach d,$(GeneratorInterfacePythia8Interface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePythia8Interface_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/src
ALL_PRODS += GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_CLASS := LIBRARY
GeneratorInterface/Pythia8Interface_forbigobj+=GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia8Interface,src/GeneratorInterface/Pythia8Interface/src,src_GeneratorInterface_Pythia8Interface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfacePythia8Filters)),)
GeneratorInterfacePythia8Filters := self/src/GeneratorInterface/Pythia8Interface/plugins
PLUGINS:=yes
GeneratorInterfacePythia8Filters_files := $(patsubst src/GeneratorInterface/Pythia8Interface/plugins/%,%,$(foreach file,Pythia8Hadronizer.cc Py8toJetInput.cc *Hook*.cc LHA*.cc Pythia8DumpParticles.cc Pythia8_RhadronParticleDump_Full.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/plugins/$(file). Please fix src/GeneratorInterface/Pythia8Interface/plugins/BuildFile.))))
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
ifeq ($(strip $(GeneratorInterface/RivetInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_src
src_GeneratorInterface_RivetInterface_src_parent := GeneratorInterface/RivetInterface
src_GeneratorInterface_RivetInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_src,src/GeneratorInterface/RivetInterface/src,LIBRARY))
GeneratorInterfaceRivetInterface := self/GeneratorInterface/RivetInterface
GeneratorInterface/RivetInterface := GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_files := $(patsubst src/GeneratorInterface/RivetInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/RivetInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceRivetInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/BuildFile
GeneratorInterfaceRivetInterface_LOC_USE := self   rivet yoda fastjet clhep boost gsl root 
GeneratorInterfaceRivetInterface_PRE_INIT_FUNC += $$(eval $$(call rivetPlugin,GeneratorInterfaceRivetInterface,GeneratorInterfaceRivetInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/RivetInterface/src))
GeneratorInterfaceRivetInterface_PACKAGE := self/src/GeneratorInterface/RivetInterface/src
ALL_PRODS += GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_CLASS := LIBRARY
GeneratorInterface/RivetInterface_forbigobj+=GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/src,src_GeneratorInterface_RivetInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),rivet))
endif
ifeq ($(strip $(GeneratorInterfaceRivetInterface_plugins)),)
GeneratorInterfaceRivetInterface_plugins := self/src/GeneratorInterface/RivetInterface/plugins
PLUGINS:=yes
GeneratorInterfaceRivetInterface_plugins_files := $(patsubst src/GeneratorInterface/RivetInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/RivetInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/RivetInterface/plugins/$(file). Please fix src/GeneratorInterface/RivetInterface/plugins/BuildFile.))))
GeneratorInterfaceRivetInterface_plugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/plugins/BuildFile
GeneratorInterfaceRivetInterface_plugins_LOC_USE := self   FWCore/Framework FWCore/ServiceRegistry SimDataFormats/GeneratorProducts DataFormats/Common rivet yoda gsl tinyxml2 DQMServices/Core SimGeneral/HepPDTRecord DataFormats/HepMCCandidate DataFormats/METReco DataFormats/PatCandidates 
GeneratorInterfaceRivetInterface_plugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceRivetInterface_plugins,GeneratorInterfaceRivetInterface_plugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/RivetInterface/plugins))
GeneratorInterfaceRivetInterface_plugins_PACKAGE := self/src/GeneratorInterface/RivetInterface/plugins
ALL_PRODS += GeneratorInterfaceRivetInterface_plugins
GeneratorInterface/RivetInterface_forbigobj+=GeneratorInterfaceRivetInterface_plugins
GeneratorInterfaceRivetInterface_plugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceRivetInterface_plugins,src/GeneratorInterface/RivetInterface/plugins,src_GeneratorInterface_RivetInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceRivetInterface_plugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceRivetInterface_plugins,src/GeneratorInterface/RivetInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_plugins
src_GeneratorInterface_RivetInterface_plugins_parent := GeneratorInterface/RivetInterface
src_GeneratorInterface_RivetInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_plugins,src/GeneratorInterface/RivetInterface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/AMPTInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_AMPTInterface_src
src_GeneratorInterface_AMPTInterface_src_parent := GeneratorInterface/AMPTInterface
src_GeneratorInterface_AMPTInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_AMPTInterface_src,src/GeneratorInterface/AMPTInterface/src,LIBRARY))
GeneratorInterfaceAMPTInterface := self/GeneratorInterface/AMPTInterface
GeneratorInterface/AMPTInterface := GeneratorInterfaceAMPTInterface
GeneratorInterfaceAMPTInterface_files := $(patsubst src/GeneratorInterface/AMPTInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/AMPTInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceAMPTInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AMPTInterface/BuildFile
GeneratorInterfaceAMPTInterface_LOC_USE := self   boost hepmc GeneratorInterface/Core FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/ExternalDecays f77compiler 
GeneratorInterfaceAMPTInterface_EX_LIB   := GeneratorInterfaceAMPTInterface
GeneratorInterfaceAMPTInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceAMPTInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceAMPTInterface_PACKAGE := self/src/GeneratorInterface/AMPTInterface/src
ALL_PRODS += GeneratorInterfaceAMPTInterface
GeneratorInterfaceAMPTInterface_CLASS := LIBRARY
GeneratorInterface/AMPTInterface_forbigobj+=GeneratorInterfaceAMPTInterface
GeneratorInterfaceAMPTInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAMPTInterface,src/GeneratorInterface/AMPTInterface/src,src_GeneratorInterface_AMPTInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfaceAMPTInterfacePlugins)),)
GeneratorInterfaceAMPTInterfacePlugins := self/src/GeneratorInterface/AMPTInterface/plugins
PLUGINS:=yes
GeneratorInterfaceAMPTInterfacePlugins_files := $(patsubst src/GeneratorInterface/AMPTInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/AMPTInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/AMPTInterface/plugins/$(file). Please fix src/GeneratorInterface/AMPTInterface/plugins/BuildFile.))))
GeneratorInterfaceAMPTInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AMPTInterface/plugins/BuildFile
GeneratorInterfaceAMPTInterfacePlugins_LOC_USE := self   GeneratorInterface/AMPTInterface 
GeneratorInterfaceAMPTInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceAMPTInterfacePlugins,GeneratorInterfaceAMPTInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/AMPTInterface/plugins))
GeneratorInterfaceAMPTInterfacePlugins_PACKAGE := self/src/GeneratorInterface/AMPTInterface/plugins
ALL_PRODS += GeneratorInterfaceAMPTInterfacePlugins
GeneratorInterface/AMPTInterface_forbigobj+=GeneratorInterfaceAMPTInterfacePlugins
GeneratorInterfaceAMPTInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAMPTInterfacePlugins,src/GeneratorInterface/AMPTInterface/plugins,src_GeneratorInterface_AMPTInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceAMPTInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceAMPTInterfacePlugins,src/GeneratorInterface/AMPTInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_AMPTInterface_plugins
src_GeneratorInterface_AMPTInterface_plugins_parent := GeneratorInterface/AMPTInterface
src_GeneratorInterface_AMPTInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AMPTInterface_plugins,src/GeneratorInterface/AMPTInterface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/AlpgenInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_AlpgenInterface_src
src_GeneratorInterface_AlpgenInterface_src_parent := GeneratorInterface/AlpgenInterface
src_GeneratorInterface_AlpgenInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_AlpgenInterface_src,src/GeneratorInterface/AlpgenInterface/src,LIBRARY))
GeneratorInterfaceAlpgenInterface := self/GeneratorInterface/AlpgenInterface
GeneratorInterface/AlpgenInterface := GeneratorInterfaceAlpgenInterface
GeneratorInterfaceAlpgenInterface_files := $(patsubst src/GeneratorInterface/AlpgenInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/AlpgenInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceAlpgenInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AlpgenInterface/BuildFile
GeneratorInterfaceAlpgenInterface_LOC_USE := self   boost root DataFormats/Math SimDataFormats/GeneratorProducts f77compiler 
GeneratorInterfaceAlpgenInterface_EX_LIB   := GeneratorInterfaceAlpgenInterface
GeneratorInterfaceAlpgenInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceAlpgenInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceAlpgenInterface_PACKAGE := self/src/GeneratorInterface/AlpgenInterface/src
ALL_PRODS += GeneratorInterfaceAlpgenInterface
GeneratorInterfaceAlpgenInterface_CLASS := LIBRARY
GeneratorInterface/AlpgenInterface_forbigobj+=GeneratorInterfaceAlpgenInterface
GeneratorInterfaceAlpgenInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAlpgenInterface,src/GeneratorInterface/AlpgenInterface/src,src_GeneratorInterface_AlpgenInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
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
ifeq ($(strip $(GeneratorInterface/BeamHaloGenerator)),)
ALL_COMMONRULES += src_GeneratorInterface_BeamHaloGenerator_src
src_GeneratorInterface_BeamHaloGenerator_src_parent := GeneratorInterface/BeamHaloGenerator
src_GeneratorInterface_BeamHaloGenerator_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_BeamHaloGenerator_src,src/GeneratorInterface/BeamHaloGenerator/src,LIBRARY))
GeneratorInterfaceBeamHaloGenerator := self/GeneratorInterface/BeamHaloGenerator
GeneratorInterface/BeamHaloGenerator := GeneratorInterfaceBeamHaloGenerator
GeneratorInterfaceBeamHaloGenerator_files := $(patsubst src/GeneratorInterface/BeamHaloGenerator/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/BeamHaloGenerator/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceBeamHaloGenerator_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/BeamHaloGenerator/BuildFile
GeneratorInterfaceBeamHaloGenerator_LOC_USE := self   boost hepmc FWCore/Framework FWCore/ParameterSet SimDataFormats/GeneratorProducts clhep root f77compiler 
GeneratorInterfaceBeamHaloGenerator_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceBeamHaloGenerator,GeneratorInterfaceBeamHaloGenerator,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/BeamHaloGenerator/src))
GeneratorInterfaceBeamHaloGenerator_PACKAGE := self/src/GeneratorInterface/BeamHaloGenerator/src
ALL_PRODS += GeneratorInterfaceBeamHaloGenerator
GeneratorInterfaceBeamHaloGenerator_CLASS := LIBRARY
GeneratorInterface/BeamHaloGenerator_forbigobj+=GeneratorInterfaceBeamHaloGenerator
GeneratorInterfaceBeamHaloGenerator_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceBeamHaloGenerator,src/GeneratorInterface/BeamHaloGenerator/src,src_GeneratorInterface_BeamHaloGenerator_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(GeneratorInterface/CosmicMuonGenerator)),)
ALL_COMMONRULES += src_GeneratorInterface_CosmicMuonGenerator_src
src_GeneratorInterface_CosmicMuonGenerator_src_parent := GeneratorInterface/CosmicMuonGenerator
src_GeneratorInterface_CosmicMuonGenerator_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_CosmicMuonGenerator_src,src/GeneratorInterface/CosmicMuonGenerator/src,LIBRARY))
GeneratorInterfaceCosmicMuonGenerator := self/GeneratorInterface/CosmicMuonGenerator
GeneratorInterface/CosmicMuonGenerator := GeneratorInterfaceCosmicMuonGenerator
GeneratorInterfaceCosmicMuonGenerator_files := $(patsubst src/GeneratorInterface/CosmicMuonGenerator/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/CosmicMuonGenerator/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceCosmicMuonGenerator_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/CosmicMuonGenerator/BuildFile
GeneratorInterfaceCosmicMuonGenerator_LOC_USE := self   boost FWCore/Framework FWCore/ServiceRegistry SimDataFormats/GeneratorProducts clhep root hepmc 
GeneratorInterfaceCosmicMuonGenerator_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceCosmicMuonGenerator,GeneratorInterfaceCosmicMuonGenerator,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/CosmicMuonGenerator/src))
GeneratorInterfaceCosmicMuonGenerator_PACKAGE := self/src/GeneratorInterface/CosmicMuonGenerator/src
ALL_PRODS += GeneratorInterfaceCosmicMuonGenerator
GeneratorInterfaceCosmicMuonGenerator_CLASS := LIBRARY
GeneratorInterface/CosmicMuonGenerator_forbigobj+=GeneratorInterfaceCosmicMuonGenerator
GeneratorInterfaceCosmicMuonGenerator_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceCosmicMuonGenerator,src/GeneratorInterface/CosmicMuonGenerator/src,src_GeneratorInterface_CosmicMuonGenerator_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(GeneratorInterface/EvtGenInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_EvtGenInterface_src
src_GeneratorInterface_EvtGenInterface_src_parent := GeneratorInterface/EvtGenInterface
src_GeneratorInterface_EvtGenInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_EvtGenInterface_src,src/GeneratorInterface/EvtGenInterface/src,LIBRARY))
GeneratorInterfaceEvtGenInterface := self/GeneratorInterface/EvtGenInterface
GeneratorInterface/EvtGenInterface := GeneratorInterfaceEvtGenInterface
GeneratorInterfaceEvtGenInterface_files := $(patsubst src/GeneratorInterface/EvtGenInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/EvtGenInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceEvtGenInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/BuildFile
GeneratorInterfaceEvtGenInterface_LOC_USE := self   FWCore/ParameterSet FWCore/Framework FWCore/PluginManager hepmc clhep heppdt evtgen 
GeneratorInterfaceEvtGenInterface_EX_LIB   := GeneratorInterfaceEvtGenInterface
GeneratorInterfaceEvtGenInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceEvtGenInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceEvtGenInterface_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/src
ALL_PRODS += GeneratorInterfaceEvtGenInterface
GeneratorInterfaceEvtGenInterface_CLASS := LIBRARY
GeneratorInterface/EvtGenInterface_forbigobj+=GeneratorInterfaceEvtGenInterface
GeneratorInterfaceEvtGenInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceEvtGenInterface,src/GeneratorInterface/EvtGenInterface/src,src_GeneratorInterface_EvtGenInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
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
ifeq ($(strip $(GeneratorInterface/ExhumeInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_ExhumeInterface_src
src_GeneratorInterface_ExhumeInterface_src_parent := GeneratorInterface/ExhumeInterface
src_GeneratorInterface_ExhumeInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExhumeInterface_src,src/GeneratorInterface/ExhumeInterface/src,LIBRARY))
GeneratorInterfaceExhumeInterface := self/GeneratorInterface/ExhumeInterface
GeneratorInterface/ExhumeInterface := GeneratorInterfaceExhumeInterface
GeneratorInterfaceExhumeInterface_files := $(patsubst src/GeneratorInterface/ExhumeInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ExhumeInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceExhumeInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ExhumeInterface/BuildFile
GeneratorInterfaceExhumeInterface_LOC_USE := self   FWCore/Concurrency GeneratorInterface/Core GeneratorInterface/Pythia6Interface boost clhep f77compiler heppdt hepmc 
GeneratorInterfaceExhumeInterface_EX_LIB   := GeneratorInterfaceExhumeInterface
GeneratorInterfaceExhumeInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceExhumeInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceExhumeInterface_PACKAGE := self/src/GeneratorInterface/ExhumeInterface/src
ALL_PRODS += GeneratorInterfaceExhumeInterface
GeneratorInterfaceExhumeInterface_CLASS := LIBRARY
GeneratorInterface/ExhumeInterface_forbigobj+=GeneratorInterfaceExhumeInterface
GeneratorInterfaceExhumeInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceExhumeInterface,src/GeneratorInterface/ExhumeInterface/src,src_GeneratorInterface_ExhumeInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
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
ifeq ($(strip $(GeneratorInterfaceGenFiltersPlugins)),)
GeneratorInterfaceGenFiltersPlugins := self/src/GeneratorInterface/GenFilters/plugins
PLUGINS:=yes
GeneratorInterfaceGenFiltersPlugins_files := $(patsubst src/GeneratorInterface/GenFilters/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/GenFilters/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/GenFilters/plugins/$(file). Please fix src/GeneratorInterface/GenFilters/plugins/BuildFile.))))
GeneratorInterfaceGenFiltersPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/GenFilters/plugins/BuildFile
GeneratorInterfaceGenFiltersPlugins_LOC_USE := self   FWCore/ParameterSet FWCore/Framework FWCore/Utilities SimDataFormats/GeneratorProducts GeneratorInterface/Core SimGeneral/HepPDTRecord DataFormats/GeometryVector DataFormats/GeometrySurface TrackPropagation/SteppingHelixPropagator MagneticField/Records TrackingTools/TrajectoryState TrackingTools/TrajectoryParametrization TrackingTools/Records CommonTools/UtilAlgos FWCore/ServiceRegistry TrackingTools/GeomPropagators DataFormats/HepMCCandidate DataFormats/JetReco DataFormats/Math SimDataFormats/HTXS fastjet boost heppdt clhep rootcore pythia6 pythia8 
GeneratorInterfaceGenFiltersPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceGenFiltersPlugins,GeneratorInterfaceGenFiltersPlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/GenFilters/plugins))
GeneratorInterfaceGenFiltersPlugins_PACKAGE := self/src/GeneratorInterface/GenFilters/plugins
ALL_PRODS += GeneratorInterfaceGenFiltersPlugins
GeneratorInterface/GenFilters_forbigobj+=GeneratorInterfaceGenFiltersPlugins
GeneratorInterfaceGenFiltersPlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceGenFiltersPlugins,src/GeneratorInterface/GenFilters/plugins,src_GeneratorInterface_GenFilters_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceGenFiltersPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceGenFiltersPlugins,src/GeneratorInterface/GenFilters/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_GenFilters_plugins
src_GeneratorInterface_GenFilters_plugins_parent := GeneratorInterface/GenFilters
src_GeneratorInterface_GenFilters_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_GenFilters_plugins,src/GeneratorInterface/GenFilters/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/Herwig7Interface)),)
ALL_COMMONRULES += src_GeneratorInterface_Herwig7Interface_src
src_GeneratorInterface_Herwig7Interface_src_parent := GeneratorInterface/Herwig7Interface
src_GeneratorInterface_Herwig7Interface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Herwig7Interface_src,src/GeneratorInterface/Herwig7Interface/src,LIBRARY))
GeneratorInterfaceHerwig7Interface := self/GeneratorInterface/Herwig7Interface
GeneratorInterface/Herwig7Interface := GeneratorInterfaceHerwig7Interface
GeneratorInterfaceHerwig7Interface_files := $(patsubst src/GeneratorInterface/Herwig7Interface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Herwig7Interface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHerwig7Interface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Herwig7Interface/BuildFile
GeneratorInterfaceHerwig7Interface_LOC_USE := self   GeneratorInterface/Core boost hepmc thepeg herwig7 
GeneratorInterfaceHerwig7Interface_EX_LIB   := GeneratorInterfaceHerwig7Interface
GeneratorInterfaceHerwig7Interface_EX_USE   := $(foreach d,$(GeneratorInterfaceHerwig7Interface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHerwig7Interface_PACKAGE := self/src/GeneratorInterface/Herwig7Interface/src
ALL_PRODS += GeneratorInterfaceHerwig7Interface
GeneratorInterfaceHerwig7Interface_CLASS := LIBRARY
GeneratorInterface/Herwig7Interface_forbigobj+=GeneratorInterfaceHerwig7Interface
GeneratorInterfaceHerwig7Interface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHerwig7Interface,src/GeneratorInterface/Herwig7Interface/src,src_GeneratorInterface_Herwig7Interface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfaceHerwig7HadronizerPlugins)),)
GeneratorInterfaceHerwig7HadronizerPlugins := self/src/GeneratorInterface/Herwig7Interface/plugins
PLUGINS:=yes
GeneratorInterfaceHerwig7HadronizerPlugins_files := $(patsubst src/GeneratorInterface/Herwig7Interface/plugins/%,%,$(foreach file,Herwig7Hadronizer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Herwig7Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Herwig7Interface/plugins/$(file). Please fix src/GeneratorInterface/Herwig7Interface/plugins/BuildFile.))))
GeneratorInterfaceHerwig7HadronizerPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Herwig7Interface/plugins/BuildFile
GeneratorInterfaceHerwig7HadronizerPlugins_LOC_USE := self   SimDataFormats/GeneratorProducts herwig7 GeneratorInterface/Herwig7Interface GeneratorInterface/Core GeneratorInterface/ExternalDecays boost thepeg 
GeneratorInterfaceHerwig7HadronizerPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHerwig7HadronizerPlugins,GeneratorInterfaceHerwig7HadronizerPlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Herwig7Interface/plugins))
GeneratorInterfaceHerwig7HadronizerPlugins_PACKAGE := self/src/GeneratorInterface/Herwig7Interface/plugins
ALL_PRODS += GeneratorInterfaceHerwig7HadronizerPlugins
GeneratorInterface/Herwig7Interface_forbigobj+=GeneratorInterfaceHerwig7HadronizerPlugins
GeneratorInterfaceHerwig7HadronizerPlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHerwig7HadronizerPlugins,src/GeneratorInterface/Herwig7Interface/plugins,src_GeneratorInterface_Herwig7Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHerwig7HadronizerPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHerwig7HadronizerPlugins,src/GeneratorInterface/Herwig7Interface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_Herwig7Interface_plugins
src_GeneratorInterface_Herwig7Interface_plugins_parent := GeneratorInterface/Herwig7Interface
src_GeneratorInterface_Herwig7Interface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Herwig7Interface_plugins,src/GeneratorInterface/Herwig7Interface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/HiGenCommon)),)
ALL_COMMONRULES += src_GeneratorInterface_HiGenCommon_src
src_GeneratorInterface_HiGenCommon_src_parent := GeneratorInterface/HiGenCommon
src_GeneratorInterface_HiGenCommon_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_HiGenCommon_src,src/GeneratorInterface/HiGenCommon/src,LIBRARY))
GeneratorInterfaceHiGenCommon := self/GeneratorInterface/HiGenCommon
GeneratorInterface/HiGenCommon := GeneratorInterfaceHiGenCommon
GeneratorInterfaceHiGenCommon_files := $(patsubst src/GeneratorInterface/HiGenCommon/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HiGenCommon/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHiGenCommon_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HiGenCommon/BuildFile
GeneratorInterfaceHiGenCommon_LOC_USE := self   FWCore/ParameterSet hepmc 
GeneratorInterfaceHiGenCommon_EX_LIB   := GeneratorInterfaceHiGenCommon
GeneratorInterfaceHiGenCommon_EX_USE   := $(foreach d,$(GeneratorInterfaceHiGenCommon_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHiGenCommon_PACKAGE := self/src/GeneratorInterface/HiGenCommon/src
ALL_PRODS += GeneratorInterfaceHiGenCommon
GeneratorInterfaceHiGenCommon_CLASS := LIBRARY
GeneratorInterface/HiGenCommon_forbigobj+=GeneratorInterfaceHiGenCommon
GeneratorInterfaceHiGenCommon_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHiGenCommon,src/GeneratorInterface/HiGenCommon/src,src_GeneratorInterface_HiGenCommon_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
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
ifeq ($(strip $(GeneratorInterface/HijingInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_HijingInterface_src
src_GeneratorInterface_HijingInterface_src_parent := GeneratorInterface/HijingInterface
src_GeneratorInterface_HijingInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_HijingInterface_src,src/GeneratorInterface/HijingInterface/src,LIBRARY))
GeneratorInterfaceHijingInterface := self/GeneratorInterface/HijingInterface
GeneratorInterface/HijingInterface := GeneratorInterfaceHijingInterface
GeneratorInterfaceHijingInterface_files := $(patsubst src/GeneratorInterface/HijingInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HijingInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHijingInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HijingInterface/BuildFile
GeneratorInterfaceHijingInterface_LOC_USE := self   clhep boost GeneratorInterface/Core FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/ExternalDecays f77compiler hepmc 
GeneratorInterfaceHijingInterface_EX_LIB   := GeneratorInterfaceHijingInterface
GeneratorInterfaceHijingInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceHijingInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHijingInterface_PACKAGE := self/src/GeneratorInterface/HijingInterface/src
ALL_PRODS += GeneratorInterfaceHijingInterface
GeneratorInterfaceHijingInterface_CLASS := LIBRARY
GeneratorInterface/HijingInterface_forbigobj+=GeneratorInterfaceHijingInterface
GeneratorInterfaceHijingInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHijingInterface,src/GeneratorInterface/HijingInterface/src,src_GeneratorInterface_HijingInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterface/Hydjet2Interface)),)
ALL_COMMONRULES += src_GeneratorInterface_Hydjet2Interface_src
src_GeneratorInterface_Hydjet2Interface_src_parent := GeneratorInterface/Hydjet2Interface
src_GeneratorInterface_Hydjet2Interface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Hydjet2Interface_src,src/GeneratorInterface/Hydjet2Interface/src,LIBRARY))
GeneratorInterfaceHydjet2Interface := self/GeneratorInterface/Hydjet2Interface
GeneratorInterface/Hydjet2Interface := GeneratorInterfaceHydjet2Interface
GeneratorInterfaceHydjet2Interface_files := $(patsubst src/GeneratorInterface/Hydjet2Interface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Hydjet2Interface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHydjet2Interface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Hydjet2Interface/BuildFile
GeneratorInterfaceHydjet2Interface_LOC_USE := self   boost GeneratorInterface/Core FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/Pythia6Interface GeneratorInterface/ExternalDecays FWCore/Concurrency clhep f77compiler FWCore/ParameterSet FWCore/Utilities pyquen root hydjet2 rootmath rootcore hepmc 
GeneratorInterfaceHydjet2Interface_EX_LIB   := GeneratorInterfaceHydjet2Interface
GeneratorInterfaceHydjet2Interface_EX_USE   := $(foreach d,$(GeneratorInterfaceHydjet2Interface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHydjet2Interface_PACKAGE := self/src/GeneratorInterface/Hydjet2Interface/src
ALL_PRODS += GeneratorInterfaceHydjet2Interface
GeneratorInterfaceHydjet2Interface_CLASS := LIBRARY
GeneratorInterface/Hydjet2Interface_forbigobj+=GeneratorInterfaceHydjet2Interface
GeneratorInterfaceHydjet2Interface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHydjet2Interface,src/GeneratorInterface/Hydjet2Interface/src,src_GeneratorInterface_Hydjet2Interface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfaceHijingInterfacePlugins)),)
GeneratorInterfaceHijingInterfacePlugins := self/src/GeneratorInterface/HijingInterface/plugins
PLUGINS:=yes
GeneratorInterfaceHijingInterfacePlugins_files := $(patsubst src/GeneratorInterface/HijingInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/HijingInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/HijingInterface/plugins/$(file). Please fix src/GeneratorInterface/HijingInterface/plugins/BuildFile.))))
GeneratorInterfaceHijingInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HijingInterface/plugins/BuildFile
GeneratorInterfaceHijingInterfacePlugins_LOC_USE := self   GeneratorInterface/HijingInterface 
GeneratorInterfaceHijingInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHijingInterfacePlugins,GeneratorInterfaceHijingInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/HijingInterface/plugins))
GeneratorInterfaceHijingInterfacePlugins_PACKAGE := self/src/GeneratorInterface/HijingInterface/plugins
ALL_PRODS += GeneratorInterfaceHijingInterfacePlugins
GeneratorInterface/HijingInterface_forbigobj+=GeneratorInterfaceHijingInterfacePlugins
GeneratorInterfaceHijingInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHijingInterfacePlugins,src/GeneratorInterface/HijingInterface/plugins,src_GeneratorInterface_HijingInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHijingInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHijingInterfacePlugins,src/GeneratorInterface/HijingInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_HijingInterface_plugins
src_GeneratorInterface_HijingInterface_plugins_parent := GeneratorInterface/HijingInterface
src_GeneratorInterface_HijingInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HijingInterface_plugins,src/GeneratorInterface/HijingInterface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterfaceHydjet2InterfacePlugins)),)
GeneratorInterfaceHydjet2InterfacePlugins := self/src/GeneratorInterface/Hydjet2Interface/plugins
PLUGINS:=yes
GeneratorInterfaceHydjet2InterfacePlugins_files := $(patsubst src/GeneratorInterface/Hydjet2Interface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Hydjet2Interface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Hydjet2Interface/plugins/$(file). Please fix src/GeneratorInterface/Hydjet2Interface/plugins/BuildFile.))))
GeneratorInterfaceHydjet2InterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Hydjet2Interface/plugins/BuildFile
GeneratorInterfaceHydjet2InterfacePlugins_LOC_USE := self   GeneratorInterface/Hydjet2Interface pydata 
GeneratorInterfaceHydjet2InterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHydjet2InterfacePlugins,GeneratorInterfaceHydjet2InterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Hydjet2Interface/plugins))
GeneratorInterfaceHydjet2InterfacePlugins_PACKAGE := self/src/GeneratorInterface/Hydjet2Interface/plugins
ALL_PRODS += GeneratorInterfaceHydjet2InterfacePlugins
GeneratorInterface/Hydjet2Interface_forbigobj+=GeneratorInterfaceHydjet2InterfacePlugins
GeneratorInterfaceHydjet2InterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHydjet2InterfacePlugins,src/GeneratorInterface/Hydjet2Interface/plugins,src_GeneratorInterface_Hydjet2Interface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHydjet2InterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHydjet2InterfacePlugins,src/GeneratorInterface/Hydjet2Interface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_Hydjet2Interface_plugins
src_GeneratorInterface_Hydjet2Interface_plugins_parent := GeneratorInterface/Hydjet2Interface
src_GeneratorInterface_Hydjet2Interface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Hydjet2Interface_plugins,src/GeneratorInterface/Hydjet2Interface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/HydjetInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_HydjetInterface_src
src_GeneratorInterface_HydjetInterface_src_parent := GeneratorInterface/HydjetInterface
src_GeneratorInterface_HydjetInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_HydjetInterface_src,src/GeneratorInterface/HydjetInterface/src,LIBRARY))
GeneratorInterfaceHydjetInterface := self/GeneratorInterface/HydjetInterface
GeneratorInterface/HydjetInterface := GeneratorInterfaceHydjetInterface
GeneratorInterfaceHydjetInterface_files := $(patsubst src/GeneratorInterface/HydjetInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HydjetInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHydjetInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HydjetInterface/BuildFile
GeneratorInterfaceHydjetInterface_LOC_USE := self   boost GeneratorInterface/Core FWCore/Concurrency FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/Pythia6Interface GeneratorInterface/ExternalDecays f77compiler hydjet hepmc 
GeneratorInterfaceHydjetInterface_EX_LIB   := GeneratorInterfaceHydjetInterface
GeneratorInterfaceHydjetInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceHydjetInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHydjetInterface_PACKAGE := self/src/GeneratorInterface/HydjetInterface/src
ALL_PRODS += GeneratorInterfaceHydjetInterface
GeneratorInterfaceHydjetInterface_CLASS := LIBRARY
GeneratorInterface/HydjetInterface_forbigobj+=GeneratorInterfaceHydjetInterface
GeneratorInterfaceHydjetInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHydjetInterface,src/GeneratorInterface/HydjetInterface/src,src_GeneratorInterface_HydjetInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfaceHydjetInterfacePlugins)),)
GeneratorInterfaceHydjetInterfacePlugins := self/src/GeneratorInterface/HydjetInterface/plugins
PLUGINS:=yes
GeneratorInterfaceHydjetInterfacePlugins_files := $(patsubst src/GeneratorInterface/HydjetInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/HydjetInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/HydjetInterface/plugins/$(file). Please fix src/GeneratorInterface/HydjetInterface/plugins/BuildFile.))))
GeneratorInterfaceHydjetInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HydjetInterface/plugins/BuildFile
GeneratorInterfaceHydjetInterfacePlugins_LOC_USE := self   GeneratorInterface/HydjetInterface pydata 
GeneratorInterfaceHydjetInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceHydjetInterfacePlugins,GeneratorInterfaceHydjetInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/HydjetInterface/plugins))
GeneratorInterfaceHydjetInterfacePlugins_PACKAGE := self/src/GeneratorInterface/HydjetInterface/plugins
ALL_PRODS += GeneratorInterfaceHydjetInterfacePlugins
GeneratorInterface/HydjetInterface_forbigobj+=GeneratorInterfaceHydjetInterfacePlugins
GeneratorInterfaceHydjetInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHydjetInterfacePlugins,src/GeneratorInterface/HydjetInterface/plugins,src_GeneratorInterface_HydjetInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceHydjetInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceHydjetInterfacePlugins,src/GeneratorInterface/HydjetInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_HydjetInterface_plugins
src_GeneratorInterface_HydjetInterface_plugins_parent := GeneratorInterface/HydjetInterface
src_GeneratorInterface_HydjetInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HydjetInterface_plugins,src/GeneratorInterface/HydjetInterface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/PhotosInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_PhotosInterface_src
src_GeneratorInterface_PhotosInterface_src_parent := GeneratorInterface/PhotosInterface
src_GeneratorInterface_PhotosInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_PhotosInterface_src,src/GeneratorInterface/PhotosInterface/src,LIBRARY))
GeneratorInterfacePhotosInterface := self/GeneratorInterface/PhotosInterface
GeneratorInterface/PhotosInterface := GeneratorInterfacePhotosInterface
GeneratorInterfacePhotosInterface_files := $(patsubst src/GeneratorInterface/PhotosInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/PhotosInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePhotosInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PhotosInterface/BuildFile
GeneratorInterfacePhotosInterface_LOC_USE := self   FWCore/ParameterSet FWCore/Framework FWCore/PluginManager hepmc clhep 
GeneratorInterfacePhotosInterface_EX_LIB   := GeneratorInterfacePhotosInterface
GeneratorInterfacePhotosInterface_EX_USE   := $(foreach d,$(GeneratorInterfacePhotosInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePhotosInterface_PACKAGE := self/src/GeneratorInterface/PhotosInterface/src
ALL_PRODS += GeneratorInterfacePhotosInterface
GeneratorInterfacePhotosInterface_CLASS := LIBRARY
GeneratorInterface/PhotosInterface_forbigobj+=GeneratorInterfacePhotosInterface
GeneratorInterfacePhotosInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePhotosInterface,src/GeneratorInterface/PhotosInterface/src,src_GeneratorInterface_PhotosInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
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
ifeq ($(strip $(GeneratorInterface/PyquenInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_PyquenInterface_src
src_GeneratorInterface_PyquenInterface_src_parent := GeneratorInterface/PyquenInterface
src_GeneratorInterface_PyquenInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_PyquenInterface_src,src/GeneratorInterface/PyquenInterface/src,LIBRARY))
GeneratorInterfacePyquenInterface := self/GeneratorInterface/PyquenInterface
GeneratorInterface/PyquenInterface := GeneratorInterfacePyquenInterface
GeneratorInterfacePyquenInterface_files := $(patsubst src/GeneratorInterface/PyquenInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/PyquenInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePyquenInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PyquenInterface/BuildFile
GeneratorInterfacePyquenInterface_LOC_USE := self   boost FWCore/Concurrency FWCore/Framework GeneratorInterface/Core GeneratorInterface/HiGenCommon SimDataFormats/GeneratorProducts clhep f77compiler GeneratorInterface/Pythia6Interface GeneratorInterface/ExternalDecays pyquen hepmc 
GeneratorInterfacePyquenInterface_EX_LIB   := GeneratorInterfacePyquenInterface
GeneratorInterfacePyquenInterface_EX_USE   := $(foreach d,$(GeneratorInterfacePyquenInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePyquenInterface_PACKAGE := self/src/GeneratorInterface/PyquenInterface/src
ALL_PRODS += GeneratorInterfacePyquenInterface
GeneratorInterfacePyquenInterface_CLASS := LIBRARY
GeneratorInterface/PyquenInterface_forbigobj+=GeneratorInterfacePyquenInterface
GeneratorInterfacePyquenInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePyquenInterface,src/GeneratorInterface/PyquenInterface/src,src_GeneratorInterface_PyquenInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfacePyquenInterfacePlugins)),)
GeneratorInterfacePyquenInterfacePlugins := self/src/GeneratorInterface/PyquenInterface/plugins
PLUGINS:=yes
GeneratorInterfacePyquenInterfacePlugins_files := $(patsubst src/GeneratorInterface/PyquenInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/PyquenInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/PyquenInterface/plugins/$(file). Please fix src/GeneratorInterface/PyquenInterface/plugins/BuildFile.))))
GeneratorInterfacePyquenInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PyquenInterface/plugins/BuildFile
GeneratorInterfacePyquenInterfacePlugins_LOC_USE := self   GeneratorInterface/PyquenInterface pydata 
GeneratorInterfacePyquenInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfacePyquenInterfacePlugins,GeneratorInterfacePyquenInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/PyquenInterface/plugins))
GeneratorInterfacePyquenInterfacePlugins_PACKAGE := self/src/GeneratorInterface/PyquenInterface/plugins
ALL_PRODS += GeneratorInterfacePyquenInterfacePlugins
GeneratorInterface/PyquenInterface_forbigobj+=GeneratorInterfacePyquenInterfacePlugins
GeneratorInterfacePyquenInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePyquenInterfacePlugins,src/GeneratorInterface/PyquenInterface/plugins,src_GeneratorInterface_PyquenInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfacePyquenInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfacePyquenInterfacePlugins,src/GeneratorInterface/PyquenInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_PyquenInterface_plugins
src_GeneratorInterface_PyquenInterface_plugins_parent := GeneratorInterface/PyquenInterface
src_GeneratorInterface_PyquenInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_PyquenInterface_plugins,src/GeneratorInterface/PyquenInterface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/Pythia6Interface)),)
ALL_COMMONRULES += src_GeneratorInterface_Pythia6Interface_src
src_GeneratorInterface_Pythia6Interface_src_parent := GeneratorInterface/Pythia6Interface
src_GeneratorInterface_Pythia6Interface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia6Interface_src,src/GeneratorInterface/Pythia6Interface/src,LIBRARY))
GeneratorInterfacePythia6Interface := self/GeneratorInterface/Pythia6Interface
GeneratorInterface/Pythia6Interface := GeneratorInterfacePythia6Interface
GeneratorInterfacePythia6Interface_files := $(patsubst src/GeneratorInterface/Pythia6Interface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Pythia6Interface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePythia6Interface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia6Interface/BuildFile
GeneratorInterfacePythia6Interface_LOC_USE := self   boost GeneratorInterface/Core clhep pythia6 f77compiler hepmc 
GeneratorInterfacePythia6Interface_EX_LIB   := GeneratorInterfacePythia6Interface
GeneratorInterfacePythia6Interface_EX_USE   := $(foreach d,$(GeneratorInterfacePythia6Interface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePythia6Interface_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/src
ALL_PRODS += GeneratorInterfacePythia6Interface
GeneratorInterfacePythia6Interface_CLASS := LIBRARY
GeneratorInterface/Pythia6Interface_forbigobj+=GeneratorInterfacePythia6Interface
GeneratorInterfacePythia6Interface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia6Interface,src/GeneratorInterface/Pythia6Interface/src,src_GeneratorInterface_Pythia6Interface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
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
ifeq ($(strip $(GeneratorInterface/ReggeGribovPartonMCInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_ReggeGribovPartonMCInterface_src
src_GeneratorInterface_ReggeGribovPartonMCInterface_src_parent := GeneratorInterface/ReggeGribovPartonMCInterface
src_GeneratorInterface_ReggeGribovPartonMCInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_ReggeGribovPartonMCInterface_src,src/GeneratorInterface/ReggeGribovPartonMCInterface/src,LIBRARY))
GeneratorInterfaceReggeGribovPartonMCInterface := self/GeneratorInterface/ReggeGribovPartonMCInterface
GeneratorInterface/ReggeGribovPartonMCInterface := GeneratorInterfaceReggeGribovPartonMCInterface
GeneratorInterfaceReggeGribovPartonMCInterface_files := $(patsubst src/GeneratorInterface/ReggeGribovPartonMCInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ReggeGribovPartonMCInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceReggeGribovPartonMCInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ReggeGribovPartonMCInterface/BuildFile
GeneratorInterfaceReggeGribovPartonMCInterface_LOC_FLAGS_CPPDEFINES   := -D__SIBYLL__ -D__QGSJET01__ -D__QGSJETII04__
GeneratorInterfaceReggeGribovPartonMCInterface_LOC_USE := self   clhep boost GeneratorInterface/Core FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/ExternalDecays f77compiler hepmc 
GeneratorInterfaceReggeGribovPartonMCInterface_EX_LIB   := GeneratorInterfaceReggeGribovPartonMCInterface
GeneratorInterfaceReggeGribovPartonMCInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceReggeGribovPartonMCInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceReggeGribovPartonMCInterface_PACKAGE := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/src
ALL_PRODS += GeneratorInterfaceReggeGribovPartonMCInterface
GeneratorInterfaceReggeGribovPartonMCInterface_CLASS := LIBRARY
GeneratorInterface/ReggeGribovPartonMCInterface_forbigobj+=GeneratorInterfaceReggeGribovPartonMCInterface
GeneratorInterfaceReggeGribovPartonMCInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceReggeGribovPartonMCInterface,src/GeneratorInterface/ReggeGribovPartonMCInterface/src,src_GeneratorInterface_ReggeGribovPartonMCInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(GeneratorInterfaceReggeGribovPartonMCInterfacePlugins)),)
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins
PLUGINS:=yes
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_files := $(patsubst src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/$(file). Please fix src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/BuildFile.))))
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins/BuildFile
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_LOC_USE := self   GeneratorInterface/ReggeGribovPartonMCInterface 
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceReggeGribovPartonMCInterfacePlugins,GeneratorInterfaceReggeGribovPartonMCInterfacePlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins))
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_PACKAGE := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins
ALL_PRODS += GeneratorInterfaceReggeGribovPartonMCInterfacePlugins
GeneratorInterface/ReggeGribovPartonMCInterface_forbigobj+=GeneratorInterfaceReggeGribovPartonMCInterfacePlugins
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceReggeGribovPartonMCInterfacePlugins,src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins,src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceReggeGribovPartonMCInterfacePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceReggeGribovPartonMCInterfacePlugins,src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins
src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins_parent := GeneratorInterface/ReggeGribovPartonMCInterface
src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins,src/GeneratorInterface/ReggeGribovPartonMCInterface/plugins,PLUGINS))
ifeq ($(strip $(GeneratorInterface/SherpaInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_SherpaInterface_src
src_GeneratorInterface_SherpaInterface_src_parent := GeneratorInterface/SherpaInterface
src_GeneratorInterface_SherpaInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_SherpaInterface_src,src/GeneratorInterface/SherpaInterface/src,LIBRARY))
GeneratorInterfaceSherpaInterface := self/GeneratorInterface/SherpaInterface
GeneratorInterface/SherpaInterface := GeneratorInterfaceSherpaInterface
GeneratorInterfaceSherpaInterface_files := $(patsubst src/GeneratorInterface/SherpaInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/SherpaInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceSherpaInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/SherpaInterface/BuildFile
GeneratorInterfaceSherpaInterface_LOC_USE := self   FWCore/Framework FWCore/ParameterSet GeneratorInterface/Core GeneratorInterface/ExternalDecays Utilities/OpenSSL clhep sherpa zlib 
GeneratorInterfaceSherpaInterface_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceSherpaInterface,GeneratorInterfaceSherpaInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/SherpaInterface/src))
GeneratorInterfaceSherpaInterface_PACKAGE := self/src/GeneratorInterface/SherpaInterface/src
ALL_PRODS += GeneratorInterfaceSherpaInterface
GeneratorInterfaceSherpaInterface_CLASS := LIBRARY
GeneratorInterface/SherpaInterface_forbigobj+=GeneratorInterfaceSherpaInterface
GeneratorInterfaceSherpaInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceSherpaInterface,src/GeneratorInterface/SherpaInterface/src,src_GeneratorInterface_SherpaInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(GeneratorInterface/TauolaInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_TauolaInterface_src
src_GeneratorInterface_TauolaInterface_src_parent := GeneratorInterface/TauolaInterface
src_GeneratorInterface_TauolaInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_TauolaInterface_src,src/GeneratorInterface/TauolaInterface/src,LIBRARY))
GeneratorInterfaceTauolaInterface := self/GeneratorInterface/TauolaInterface
GeneratorInterface/TauolaInterface := GeneratorInterfaceTauolaInterface
GeneratorInterfaceTauolaInterface_files := $(patsubst src/GeneratorInterface/TauolaInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/TauolaInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceTauolaInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/TauolaInterface/BuildFile
GeneratorInterfaceTauolaInterface_LOC_USE := self   DataFormats/HepMCCandidate FWCore/ParameterSet FWCore/Framework FWCore/PluginManager GeneratorInterface/LHEInterface hepmc clhep heppdt tauolapp 
GeneratorInterfaceTauolaInterface_EX_LIB   := GeneratorInterfaceTauolaInterface
GeneratorInterfaceTauolaInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceTauolaInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceTauolaInterface_PACKAGE := self/src/GeneratorInterface/TauolaInterface/src
ALL_PRODS += GeneratorInterfaceTauolaInterface
GeneratorInterfaceTauolaInterface_CLASS := LIBRARY
GeneratorInterface/TauolaInterface_forbigobj+=GeneratorInterfaceTauolaInterface
GeneratorInterfaceTauolaInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceTauolaInterface,src/GeneratorInterface/TauolaInterface/src,src_GeneratorInterface_TauolaInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
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
ifeq ($(strip $(SimGeneralCaloAnalysisPlugins)),)
SimGeneralCaloAnalysisPlugins := self/src/SimGeneral/CaloAnalysis/plugins
PLUGINS:=yes
SimGeneralCaloAnalysisPlugins_files := $(patsubst src/SimGeneral/CaloAnalysis/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/CaloAnalysis/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/CaloAnalysis/plugins/$(file). Please fix src/SimGeneral/CaloAnalysis/plugins/BuildFile.))))
SimGeneralCaloAnalysisPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/CaloAnalysis/plugins/BuildFile
SimGeneralCaloAnalysisPlugins_LOC_USE := self   clhep DataFormats/Math DataFormats/SiStripDetId DataFormats/SiPixelDetId FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/Utilities SimDataFormats/GeneratorProducts SimDataFormats/CaloAnalysis SimDataFormats/Vertex SimDataFormats/TrackingHit DataFormats/HepMCCandidate SimGeneral/MixingModule SimGeneral/PreMixingModule SimDataFormats/CaloTest DataFormats/ForwardDetId DataFormats/HcalDetId Geometry/Records Geometry/MTDCommonData Geometry/HGCalGeometry Geometry/HcalTowerAlgo Geometry/HcalCommonData Geometry/MTDGeometryBuilder Geometry/MTDNumberingBuilder 
SimGeneralCaloAnalysisPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralCaloAnalysisPlugins,SimGeneralCaloAnalysisPlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/CaloAnalysis/plugins))
SimGeneralCaloAnalysisPlugins_PACKAGE := self/src/SimGeneral/CaloAnalysis/plugins
ALL_PRODS += SimGeneralCaloAnalysisPlugins
SimGeneral/CaloAnalysis_forbigobj+=SimGeneralCaloAnalysisPlugins
SimGeneralCaloAnalysisPlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralCaloAnalysisPlugins,src/SimGeneral/CaloAnalysis/plugins,src_SimGeneral_CaloAnalysis_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralCaloAnalysisPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralCaloAnalysisPlugins,src/SimGeneral/CaloAnalysis/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_CaloAnalysis_plugins
src_SimGeneral_CaloAnalysis_plugins_parent := SimGeneral/CaloAnalysis
src_SimGeneral_CaloAnalysis_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_CaloAnalysis_plugins,src/SimGeneral/CaloAnalysis/plugins,PLUGINS))
ifeq ($(strip $(SimGeneralDataMixingModulePlugins)),)
SimGeneralDataMixingModulePlugins := self/src/SimGeneral/DataMixingModule/plugins
PLUGINS:=yes
SimGeneralDataMixingModulePlugins_files := $(patsubst src/SimGeneral/DataMixingModule/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/DataMixingModule/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/DataMixingModule/plugins/$(file). Please fix src/SimGeneral/DataMixingModule/plugins/BuildFile.))))
SimGeneralDataMixingModulePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/DataMixingModule/plugins/BuildFile
SimGeneralDataMixingModulePlugins_LOC_USE := self   CalibFormats/HcalObjects CondFormats/EcalObjects DataFormats/CSCDigi DataFormats/Common DataFormats/DTDigi DataFormats/EcalDigi DataFormats/EcalRecHit DataFormats/HcalDigi DataFormats/HcalRecHit DataFormats/Provenance DataFormats/RPCDigi DataFormats/SiPixelDigi DataFormats/SiStripDigi DataFormats/TrackReco DataFormats/HepMCCandidate FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager FWCore/ServiceRegistry FWCore/Utilities Mixing/Base SimCalorimetry/CaloSimAlgos SimCalorimetry/HcalSimAlgos SimCalorimetry/HcalSimProducers SimDataFormats/PileupSummaryInfo SimDataFormats/CrossingFrame 
SimGeneralDataMixingModulePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralDataMixingModulePlugins,SimGeneralDataMixingModulePlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/DataMixingModule/plugins))
SimGeneralDataMixingModulePlugins_PACKAGE := self/src/SimGeneral/DataMixingModule/plugins
ALL_PRODS += SimGeneralDataMixingModulePlugins
SimGeneral/DataMixingModule_forbigobj+=SimGeneralDataMixingModulePlugins
SimGeneralDataMixingModulePlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralDataMixingModulePlugins,src/SimGeneral/DataMixingModule/plugins,src_SimGeneral_DataMixingModule_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralDataMixingModulePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralDataMixingModulePlugins,src/SimGeneral/DataMixingModule/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_DataMixingModule_plugins
src_SimGeneral_DataMixingModule_plugins_parent := SimGeneral/DataMixingModule
src_SimGeneral_DataMixingModule_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_DataMixingModule_plugins,src/SimGeneral/DataMixingModule/plugins,PLUGINS))
ifeq ($(strip $(SimGeneralDebuggingAuto)),)
SimGeneralDebuggingAuto := self/src/SimGeneral/Debugging/plugins
PLUGINS:=yes
SimGeneralDebuggingAuto_files := $(patsubst src/SimGeneral/Debugging/plugins/%,%,$(wildcard $(foreach dir,src/SimGeneral/Debugging/plugins ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralDebuggingAuto_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/Debugging/plugins/BuildFile
SimGeneralDebuggingAuto_LOC_USE := self   FWCore/Framework FWCore/ParameterSet SimDataFormats/Track SimDataFormats/Vertex SimDataFormats/TrackingAnalysis SimDataFormats/CaloAnalysis SimDataFormats/CaloHit SimDataFormats/CaloTest Geometry/HcalTowerAlgo Geometry/HGCalGeometry Geometry/Records 
SimGeneralDebuggingAuto_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralDebuggingAuto,SimGeneralDebuggingAuto,$(SCRAMSTORENAME_LIB),src/SimGeneral/Debugging/plugins))
SimGeneralDebuggingAuto_PACKAGE := self/src/SimGeneral/Debugging/plugins
ALL_PRODS += SimGeneralDebuggingAuto
SimGeneral/Debugging_forbigobj+=SimGeneralDebuggingAuto
SimGeneralDebuggingAuto_INIT_FUNC        += $$(eval $$(call Library,SimGeneralDebuggingAuto,src/SimGeneral/Debugging/plugins,src_SimGeneral_Debugging_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralDebuggingAuto_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralDebuggingAuto,src/SimGeneral/Debugging/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_Debugging_plugins
src_SimGeneral_Debugging_plugins_parent := SimGeneral/Debugging
src_SimGeneral_Debugging_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_Debugging_plugins,src/SimGeneral/Debugging/plugins,PLUGINS))
ifeq ($(strip $(SimGeneral/GFlash)),)
ALL_COMMONRULES += src_SimGeneral_GFlash_src
src_SimGeneral_GFlash_src_parent := SimGeneral/GFlash
src_SimGeneral_GFlash_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_GFlash_src,src/SimGeneral/GFlash/src,LIBRARY))
SimGeneralGFlash := self/SimGeneral/GFlash
SimGeneral/GFlash := SimGeneralGFlash
SimGeneralGFlash_files := $(patsubst src/SimGeneral/GFlash/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/GFlash/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralGFlash_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/GFlash/BuildFile
SimGeneralGFlash_LOC_USE := self   FWCore/ParameterSet FWCore/MessageLogger clhep root 
SimGeneralGFlash_EX_LIB   := SimGeneralGFlash
SimGeneralGFlash_EX_USE   := $(foreach d,$(SimGeneralGFlash_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralGFlash_PACKAGE := self/src/SimGeneral/GFlash/src
ALL_PRODS += SimGeneralGFlash
SimGeneralGFlash_CLASS := LIBRARY
SimGeneral/GFlash_forbigobj+=SimGeneralGFlash
SimGeneralGFlash_INIT_FUNC        += $$(eval $$(call Library,SimGeneralGFlash,src/SimGeneral/GFlash/src,src_SimGeneral_GFlash_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimGeneral/HepPDTESSource)),)
ALL_COMMONRULES += src_SimGeneral_HepPDTESSource_src
src_SimGeneral_HepPDTESSource_src_parent := SimGeneral/HepPDTESSource
src_SimGeneral_HepPDTESSource_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTESSource_src,src/SimGeneral/HepPDTESSource/src,LIBRARY))
SimGeneralHepPDTESSource := self/SimGeneral/HepPDTESSource
SimGeneral/HepPDTESSource := SimGeneralHepPDTESSource
SimGeneralHepPDTESSource_files := $(patsubst src/SimGeneral/HepPDTESSource/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/HepPDTESSource/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralHepPDTESSource_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/HepPDTESSource/BuildFile
SimGeneralHepPDTESSource_LOC_USE := self   SimGeneral/HepPDTRecord heppdt 
SimGeneralHepPDTESSource_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralHepPDTESSource,SimGeneralHepPDTESSource,$(SCRAMSTORENAME_LIB),src/SimGeneral/HepPDTESSource/src))
SimGeneralHepPDTESSource_PACKAGE := self/src/SimGeneral/HepPDTESSource/src
ALL_PRODS += SimGeneralHepPDTESSource
SimGeneralHepPDTESSource_CLASS := LIBRARY
SimGeneral/HepPDTESSource_forbigobj+=SimGeneralHepPDTESSource
SimGeneralHepPDTESSource_INIT_FUNC        += $$(eval $$(call Library,SimGeneralHepPDTESSource,src/SimGeneral/HepPDTESSource/src,src_SimGeneral_HepPDTESSource_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
ifeq ($(strip $(SimGeneral/HepPDTRecord)),)
ALL_COMMONRULES += src_SimGeneral_HepPDTRecord_src
src_SimGeneral_HepPDTRecord_src_parent := SimGeneral/HepPDTRecord
src_SimGeneral_HepPDTRecord_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTRecord_src,src/SimGeneral/HepPDTRecord/src,LIBRARY))
SimGeneralHepPDTRecord := self/SimGeneral/HepPDTRecord
SimGeneral/HepPDTRecord := SimGeneralHepPDTRecord
SimGeneralHepPDTRecord_files := $(patsubst src/SimGeneral/HepPDTRecord/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/HepPDTRecord/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralHepPDTRecord_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/HepPDTRecord/BuildFile
SimGeneralHepPDTRecord_LOC_USE := self   FWCore/Framework FWCore/ParameterSet heppdt 
SimGeneralHepPDTRecord_EX_LIB   := SimGeneralHepPDTRecord
SimGeneralHepPDTRecord_EX_USE   := $(foreach d,$(SimGeneralHepPDTRecord_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralHepPDTRecord_PACKAGE := self/src/SimGeneral/HepPDTRecord/src
ALL_PRODS += SimGeneralHepPDTRecord
SimGeneralHepPDTRecord_CLASS := LIBRARY
SimGeneral/HepPDTRecord_forbigobj+=SimGeneralHepPDTRecord
SimGeneralHepPDTRecord_INIT_FUNC        += $$(eval $$(call Library,SimGeneralHepPDTRecord,src/SimGeneral/HepPDTRecord/src,src_SimGeneral_HepPDTRecord_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimGeneral/MixingModule)),)
ALL_COMMONRULES += src_SimGeneral_MixingModule_src
src_SimGeneral_MixingModule_src_parent := SimGeneral/MixingModule
src_SimGeneral_MixingModule_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_src,src/SimGeneral/MixingModule/src,LIBRARY))
SimGeneralMixingModule := self/SimGeneral/MixingModule
SimGeneral/MixingModule := SimGeneralMixingModule
SimGeneralMixingModule_files := $(patsubst src/SimGeneral/MixingModule/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/MixingModule/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralMixingModule_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/MixingModule/BuildFile
SimGeneralMixingModule_LOC_USE := self   FWCore/Framework FWCore/PluginManager FWCore/ParameterSet 
SimGeneralMixingModule_EX_LIB   := SimGeneralMixingModule
SimGeneralMixingModule_EX_USE   := $(foreach d,$(SimGeneralMixingModule_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralMixingModule_PACKAGE := self/src/SimGeneral/MixingModule/src
ALL_PRODS += SimGeneralMixingModule
SimGeneralMixingModule_CLASS := LIBRARY
SimGeneral/MixingModule_forbigobj+=SimGeneralMixingModule
SimGeneralMixingModule_INIT_FUNC        += $$(eval $$(call Library,SimGeneralMixingModule,src/SimGeneral/MixingModule/src,src_SimGeneral_MixingModule_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimGeneralMixingModulePlugins)),)
SimGeneralMixingModulePlugins := self/src/SimGeneral/MixingModule/plugins
PLUGINS:=yes
SimGeneralMixingModulePlugins_files := $(patsubst src/SimGeneral/MixingModule/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/MixingModule/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/MixingModule/plugins/$(file). Please fix src/SimGeneral/MixingModule/plugins/BuildFile.))))
SimGeneralMixingModulePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/MixingModule/plugins/BuildFile
SimGeneralMixingModulePlugins_LOC_USE := self   DataFormats/Common DataFormats/Provenance FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities FWCore/PluginManager Mixing/Base SimDataFormats/CaloHit SimDataFormats/CrossingFrame SimDataFormats/Track SimDataFormats/TrackingHit SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimGeneral/MixingModule clhep CondFormats/RunInfo CondCore/DBOutputService DataFormats/TrackerRecHit2D 
SimGeneralMixingModulePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralMixingModulePlugins,SimGeneralMixingModulePlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/MixingModule/plugins))
SimGeneralMixingModulePlugins_PACKAGE := self/src/SimGeneral/MixingModule/plugins
ALL_PRODS += SimGeneralMixingModulePlugins
SimGeneral/MixingModule_forbigobj+=SimGeneralMixingModulePlugins
SimGeneralMixingModulePlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralMixingModulePlugins,src/SimGeneral/MixingModule/plugins,src_SimGeneral_MixingModule_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralMixingModulePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralMixingModulePlugins,src/SimGeneral/MixingModule/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_MixingModule_plugins
src_SimGeneral_MixingModule_plugins_parent := SimGeneral/MixingModule
src_SimGeneral_MixingModule_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_plugins,src/SimGeneral/MixingModule/plugins,PLUGINS))
ifeq ($(strip $(SimGeneral/NoiseGenerators)),)
ALL_COMMONRULES += src_SimGeneral_NoiseGenerators_src
src_SimGeneral_NoiseGenerators_src_parent := SimGeneral/NoiseGenerators
src_SimGeneral_NoiseGenerators_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_NoiseGenerators_src,src/SimGeneral/NoiseGenerators/src,LIBRARY))
SimGeneralNoiseGenerators := self/SimGeneral/NoiseGenerators
SimGeneral/NoiseGenerators := SimGeneralNoiseGenerators
SimGeneralNoiseGenerators_files := $(patsubst src/SimGeneral/NoiseGenerators/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/NoiseGenerators/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralNoiseGenerators_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/NoiseGenerators/BuildFile
SimGeneralNoiseGenerators_LOC_USE := self   clhep gsl DataFormats/Math 
SimGeneralNoiseGenerators_EX_LIB   := SimGeneralNoiseGenerators
SimGeneralNoiseGenerators_EX_USE   := $(foreach d,$(SimGeneralNoiseGenerators_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralNoiseGenerators_PACKAGE := self/src/SimGeneral/NoiseGenerators/src
ALL_PRODS += SimGeneralNoiseGenerators
SimGeneralNoiseGenerators_CLASS := LIBRARY
SimGeneral/NoiseGenerators_forbigobj+=SimGeneralNoiseGenerators
SimGeneralNoiseGenerators_INIT_FUNC        += $$(eval $$(call Library,SimGeneralNoiseGenerators,src/SimGeneral/NoiseGenerators/src,src_SimGeneral_NoiseGenerators_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimGeneralPileupInformationPlugins)),)
SimGeneralPileupInformationPlugins := self/src/SimGeneral/PileupInformation/plugins
PLUGINS:=yes
SimGeneralPileupInformationPlugins_files := $(patsubst src/SimGeneral/PileupInformation/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/PileupInformation/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/PileupInformation/plugins/$(file). Please fix src/SimGeneral/PileupInformation/plugins/BuildFile.))))
SimGeneralPileupInformationPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PileupInformation/plugins/BuildFile
SimGeneralPileupInformationPlugins_LOC_USE := self   FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet SimDataFormats/GeneratorProducts SimDataFormats/PileupSummaryInfo SimDataFormats/Track SimDataFormats/TrackingAnalysis SimGeneral/MixingModule SimGeneral/HepPDTRecord clhep 
SimGeneralPileupInformationPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralPileupInformationPlugins,SimGeneralPileupInformationPlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/PileupInformation/plugins))
SimGeneralPileupInformationPlugins_PACKAGE := self/src/SimGeneral/PileupInformation/plugins
ALL_PRODS += SimGeneralPileupInformationPlugins
SimGeneral/PileupInformation_forbigobj+=SimGeneralPileupInformationPlugins
SimGeneralPileupInformationPlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralPileupInformationPlugins,src/SimGeneral/PileupInformation/plugins,src_SimGeneral_PileupInformation_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralPileupInformationPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralPileupInformationPlugins,src/SimGeneral/PileupInformation/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_PileupInformation_plugins
src_SimGeneral_PileupInformation_plugins_parent := SimGeneral/PileupInformation
src_SimGeneral_PileupInformation_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PileupInformation_plugins,src/SimGeneral/PileupInformation/plugins,PLUGINS))
ifeq ($(strip $(SimGeneral/PreMixingModule)),)
ALL_COMMONRULES += src_SimGeneral_PreMixingModule_src
src_SimGeneral_PreMixingModule_src_parent := SimGeneral/PreMixingModule
src_SimGeneral_PreMixingModule_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_PreMixingModule_src,src/SimGeneral/PreMixingModule/src,LIBRARY))
SimGeneralPreMixingModule := self/SimGeneral/PreMixingModule
SimGeneral/PreMixingModule := SimGeneralPreMixingModule
SimGeneralPreMixingModule_files := $(patsubst src/SimGeneral/PreMixingModule/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/PreMixingModule/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralPreMixingModule_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PreMixingModule/BuildFile
SimGeneralPreMixingModule_LOC_USE := self   FWCore/Framework FWCore/ParameterSet FWCore/PluginManager 
SimGeneralPreMixingModule_EX_LIB   := SimGeneralPreMixingModule
SimGeneralPreMixingModule_EX_USE   := $(foreach d,$(SimGeneralPreMixingModule_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralPreMixingModule_PACKAGE := self/src/SimGeneral/PreMixingModule/src
ALL_PRODS += SimGeneralPreMixingModule
SimGeneralPreMixingModule_CLASS := LIBRARY
SimGeneral/PreMixingModule_forbigobj+=SimGeneralPreMixingModule
SimGeneralPreMixingModule_INIT_FUNC        += $$(eval $$(call Library,SimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/src,src_SimGeneral_PreMixingModule_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimGeneralPreMixingModulePlugins)),)
SimGeneralPreMixingModulePlugins := self/src/SimGeneral/PreMixingModule/plugins
PLUGINS:=yes
SimGeneralPreMixingModulePlugins_files := $(patsubst src/SimGeneral/PreMixingModule/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/PreMixingModule/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/PreMixingModule/plugins/$(file). Please fix src/SimGeneral/PreMixingModule/plugins/BuildFile.))))
SimGeneralPreMixingModulePlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PreMixingModule/plugins/BuildFile
SimGeneralPreMixingModulePlugins_LOC_USE := self   DataFormats/HepMCCandidate FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager FWCore/ServiceRegistry Mixing/Base SimDataFormats/CrossingFrame SimDataFormats/PileupSummaryInfo SimGeneral/MixingModule SimGeneral/PreMixingModule clhep 
SimGeneralPreMixingModulePlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralPreMixingModulePlugins,SimGeneralPreMixingModulePlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/PreMixingModule/plugins))
SimGeneralPreMixingModulePlugins_PACKAGE := self/src/SimGeneral/PreMixingModule/plugins
ALL_PRODS += SimGeneralPreMixingModulePlugins
SimGeneral/PreMixingModule_forbigobj+=SimGeneralPreMixingModulePlugins
SimGeneralPreMixingModulePlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralPreMixingModulePlugins,src/SimGeneral/PreMixingModule/plugins,src_SimGeneral_PreMixingModule_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralPreMixingModulePlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralPreMixingModulePlugins,src/SimGeneral/PreMixingModule/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_PreMixingModule_plugins
src_SimGeneral_PreMixingModule_plugins_parent := SimGeneral/PreMixingModule
src_SimGeneral_PreMixingModule_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PreMixingModule_plugins,src/SimGeneral/PreMixingModule/plugins,PLUGINS))
ifeq ($(strip $(SimGeneral/TrackingAnalysis)),)
ALL_COMMONRULES += src_SimGeneral_TrackingAnalysis_src
src_SimGeneral_TrackingAnalysis_src_parent := SimGeneral/TrackingAnalysis
src_SimGeneral_TrackingAnalysis_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_TrackingAnalysis_src,src/SimGeneral/TrackingAnalysis/src,LIBRARY))
SimGeneralTrackingAnalysis := self/SimGeneral/TrackingAnalysis
SimGeneral/TrackingAnalysis := SimGeneralTrackingAnalysis
SimGeneralTrackingAnalysis_files := $(patsubst src/SimGeneral/TrackingAnalysis/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/TrackingAnalysis/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralTrackingAnalysis_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/TrackingAnalysis/BuildFile
SimGeneralTrackingAnalysis_LOC_USE := self   clhep CalibFormats/SiStripObjects CalibTracker/Records CondFormats/CSCObjects CondFormats/SiPixelObjects DataFormats/SiStripDetId FWCore/Framework FWCore/ParameterSet SimDataFormats/Track SimDataFormats/TrackingAnalysis SimDataFormats/TrackingHit SimTracker/Common CondFormats/DataRecord DataFormats/Common DataFormats/L1TrackTrigger DataFormats/TrackerCommon FWCore/Utilities SimDataFormats/CrossingFrame SimDataFormats/EncodedEventId 
SimGeneralTrackingAnalysis_LCGDICTS  := x 
SimGeneralTrackingAnalysis_PRE_INIT_FUNC += $$(eval $$(call LCGDict,SimGeneralTrackingAnalysis,src/SimGeneral/TrackingAnalysis/src/classes.h,src/SimGeneral/TrackingAnalysis/src/classes_def.xml,$(SCRAMSTORENAME_LIB),$(GENREFLEX_ARGS) $(root_EX_FLAGS_GENREFLEX_FAILES_ON_WARNS)))
SimGeneralTrackingAnalysis_EX_LIB   := SimGeneralTrackingAnalysis
SimGeneralTrackingAnalysis_EX_USE   := $(foreach d,$(SimGeneralTrackingAnalysis_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralTrackingAnalysis_PACKAGE := self/src/SimGeneral/TrackingAnalysis/src
ALL_PRODS += SimGeneralTrackingAnalysis
SimGeneralTrackingAnalysis_CLASS := LIBRARY
SimGeneral/TrackingAnalysis_forbigobj+=SimGeneralTrackingAnalysis
SimGeneralTrackingAnalysis_INIT_FUNC        += $$(eval $$(call Library,SimGeneralTrackingAnalysis,src/SimGeneral/TrackingAnalysis/src,src_SimGeneral_TrackingAnalysis_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
ifeq ($(strip $(SimGeneralTrackingAnalysisPlugins)),)
SimGeneralTrackingAnalysisPlugins := self/src/SimGeneral/TrackingAnalysis/plugins
PLUGINS:=yes
SimGeneralTrackingAnalysisPlugins_files := $(patsubst src/SimGeneral/TrackingAnalysis/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/TrackingAnalysis/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/TrackingAnalysis/plugins/$(file). Please fix src/SimGeneral/TrackingAnalysis/plugins/BuildFile.))))
SimGeneralTrackingAnalysisPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/TrackingAnalysis/plugins/BuildFile
SimGeneralTrackingAnalysisPlugins_LOC_USE := self   SimGeneral/TrackingAnalysis DataFormats/TrackerCommon DataFormats/HepMCCandidate Geometry/Records SimDataFormats/TrackerDigiSimLink SimGeneral/MixingModule SimGeneral/PreMixingModule 
SimGeneralTrackingAnalysisPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralTrackingAnalysisPlugins,SimGeneralTrackingAnalysisPlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/TrackingAnalysis/plugins))
SimGeneralTrackingAnalysisPlugins_PACKAGE := self/src/SimGeneral/TrackingAnalysis/plugins
ALL_PRODS += SimGeneralTrackingAnalysisPlugins
SimGeneral/TrackingAnalysis_forbigobj+=SimGeneralTrackingAnalysisPlugins
SimGeneralTrackingAnalysisPlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralTrackingAnalysisPlugins,src/SimGeneral/TrackingAnalysis/plugins,src_SimGeneral_TrackingAnalysis_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralTrackingAnalysisPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralTrackingAnalysisPlugins,src/SimGeneral/TrackingAnalysis/plugins))
endif
ALL_COMMONRULES += src_SimGeneral_TrackingAnalysis_plugins
src_SimGeneral_TrackingAnalysis_plugins_parent := SimGeneral/TrackingAnalysis
src_SimGeneral_TrackingAnalysis_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_TrackingAnalysis_plugins,src/SimGeneral/TrackingAnalysis/plugins,PLUGINS))
