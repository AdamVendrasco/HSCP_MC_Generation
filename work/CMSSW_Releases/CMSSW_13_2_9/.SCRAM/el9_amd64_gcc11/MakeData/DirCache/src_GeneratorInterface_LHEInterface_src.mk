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
