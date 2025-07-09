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
