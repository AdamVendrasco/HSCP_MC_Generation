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
