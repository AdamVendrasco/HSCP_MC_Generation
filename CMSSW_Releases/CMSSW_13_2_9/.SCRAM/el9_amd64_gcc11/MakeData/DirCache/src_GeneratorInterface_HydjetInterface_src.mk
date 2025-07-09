ifeq ($(strip $(GeneratorInterface/HydjetInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_HydjetInterface_src
src_GeneratorInterface_HydjetInterface_src_parent := GeneratorInterface/HydjetInterface
src_GeneratorInterface_HydjetInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_HydjetInterface_src,src/GeneratorInterface/HydjetInterface/src,LIBRARY))
GeneratorInterfaceHydjetInterface := self/GeneratorInterface/HydjetInterface
GeneratorInterface/HydjetInterface := GeneratorInterfaceHydjetInterface
GeneratorInterfaceHydjetInterface_files := $(patsubst src/GeneratorInterface/HydjetInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HydjetInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHydjetInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HydjetInterface/BuildFile
GeneratorInterfaceHydjetInterface_LOC_USE := self   boost GeneratorInterface/Core FWCore/Concurrency FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/Pythia6Interface GeneratorInterface/ExternalDecays f77compiler hydjet hepmc 
GeneratorInterfaceHydjetInterface_EX_LIB   := GeneratorInterfaceHydjetInterface
GeneratorInterfaceHydjetInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceHydjetInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHydjetInterface_PACKAGE := self/src/GeneratorInterface/HydjetInterface/src
ALL_PRODS += GeneratorInterfaceHydjetInterface
GeneratorInterfaceHydjetInterface_CLASS := LIBRARY
GeneratorInterface/HydjetInterface_forbigobj+=GeneratorInterfaceHydjetInterface
GeneratorInterfaceHydjetInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHydjetInterface,src/GeneratorInterface/HydjetInterface/src,src_GeneratorInterface_HydjetInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
