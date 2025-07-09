ifeq ($(strip $(GeneratorInterface/Pythia6Interface)),)
ALL_COMMONRULES += src_GeneratorInterface_Pythia6Interface_src
src_GeneratorInterface_Pythia6Interface_src_parent := GeneratorInterface/Pythia6Interface
src_GeneratorInterface_Pythia6Interface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia6Interface_src,src/GeneratorInterface/Pythia6Interface/src,LIBRARY))
GeneratorInterfacePythia6Interface := self/GeneratorInterface/Pythia6Interface
GeneratorInterface/Pythia6Interface := GeneratorInterfacePythia6Interface
GeneratorInterfacePythia6Interface_files := $(patsubst src/GeneratorInterface/Pythia6Interface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Pythia6Interface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePythia6Interface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia6Interface/BuildFile
GeneratorInterfacePythia6Interface_LOC_USE := self   boost GeneratorInterface/Core clhep pythia6 f77compiler hepmc 
GeneratorInterfacePythia6Interface_EX_LIB   := GeneratorInterfacePythia6Interface
GeneratorInterfacePythia6Interface_EX_USE   := $(foreach d,$(GeneratorInterfacePythia6Interface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePythia6Interface_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/src
ALL_PRODS += GeneratorInterfacePythia6Interface
GeneratorInterfacePythia6Interface_CLASS := LIBRARY
GeneratorInterface/Pythia6Interface_forbigobj+=GeneratorInterfacePythia6Interface
GeneratorInterfacePythia6Interface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePythia6Interface,src/GeneratorInterface/Pythia6Interface/src,src_GeneratorInterface_Pythia6Interface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
