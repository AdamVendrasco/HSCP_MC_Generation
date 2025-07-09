ifeq ($(strip $(GeneratorInterface/EvtGenInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_EvtGenInterface_src
src_GeneratorInterface_EvtGenInterface_src_parent := GeneratorInterface/EvtGenInterface
src_GeneratorInterface_EvtGenInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_EvtGenInterface_src,src/GeneratorInterface/EvtGenInterface/src,LIBRARY))
GeneratorInterfaceEvtGenInterface := self/GeneratorInterface/EvtGenInterface
GeneratorInterface/EvtGenInterface := GeneratorInterfaceEvtGenInterface
GeneratorInterfaceEvtGenInterface_files := $(patsubst src/GeneratorInterface/EvtGenInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/EvtGenInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceEvtGenInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/BuildFile
GeneratorInterfaceEvtGenInterface_LOC_USE := self   FWCore/ParameterSet FWCore/Framework FWCore/PluginManager hepmc clhep heppdt evtgen 
GeneratorInterfaceEvtGenInterface_EX_LIB   := GeneratorInterfaceEvtGenInterface
GeneratorInterfaceEvtGenInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceEvtGenInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceEvtGenInterface_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/src
ALL_PRODS += GeneratorInterfaceEvtGenInterface
GeneratorInterfaceEvtGenInterface_CLASS := LIBRARY
GeneratorInterface/EvtGenInterface_forbigobj+=GeneratorInterfaceEvtGenInterface
GeneratorInterfaceEvtGenInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceEvtGenInterface,src/GeneratorInterface/EvtGenInterface/src,src_GeneratorInterface_EvtGenInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
