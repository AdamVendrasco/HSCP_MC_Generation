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
