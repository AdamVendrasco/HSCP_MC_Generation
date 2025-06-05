ifeq ($(strip $(GeneratorInterface/Pythia8Interface)),)
ALL_COMMONRULES += src_GeneratorInterface_Pythia8Interface_src
src_GeneratorInterface_Pythia8Interface_src_parent := GeneratorInterface/Pythia8Interface
src_GeneratorInterface_Pythia8Interface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia8Interface_src,src/GeneratorInterface/Pythia8Interface/src,LIBRARY))
GeneratorInterfacePythia8Interface := self/GeneratorInterface/Pythia8Interface
GeneratorInterface/Pythia8Interface := GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_files := $(patsubst src/GeneratorInterface/Pythia8Interface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Pythia8Interface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePythia8Interface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/BuildFile
GeneratorInterfacePythia8Interface_LOC_USE := self   FWCore/Concurrency FWCore/Framework FWCore/MessageLogger FWCore/Utilities SimDataFormats/GeneratorProducts GeneratorInterface/Core boost pythia8 evtgen hepmc hepmc3 clhep root 
GeneratorInterfacePythia8Interface_EX_LIB   := GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_EX_USE   := $(foreach d,$(GeneratorInterfacePythia8Interface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePythia8Interface_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/src
ALL_PRODS += GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_CLASS := LIBRARY
GeneratorInterface/Pythia8Interface_forbigobj+=GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia8Interface,src/GeneratorInterface/Pythia8Interface/src,src_GeneratorInterface_Pythia8Interface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
