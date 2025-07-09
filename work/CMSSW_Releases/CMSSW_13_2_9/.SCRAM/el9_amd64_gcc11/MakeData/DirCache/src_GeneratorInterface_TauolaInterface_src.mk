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
