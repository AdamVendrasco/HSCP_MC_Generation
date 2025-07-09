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
