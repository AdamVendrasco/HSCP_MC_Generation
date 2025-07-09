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
