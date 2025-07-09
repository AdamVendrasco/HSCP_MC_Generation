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
