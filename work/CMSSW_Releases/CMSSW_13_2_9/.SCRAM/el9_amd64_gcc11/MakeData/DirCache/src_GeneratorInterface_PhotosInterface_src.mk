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
