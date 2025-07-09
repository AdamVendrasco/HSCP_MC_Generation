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
