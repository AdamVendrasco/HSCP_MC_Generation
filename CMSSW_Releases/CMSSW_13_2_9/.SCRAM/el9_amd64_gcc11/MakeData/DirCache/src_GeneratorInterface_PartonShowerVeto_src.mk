ifeq ($(strip $(GeneratorInterface/PartonShowerVeto)),)
ALL_COMMONRULES += src_GeneratorInterface_PartonShowerVeto_src
src_GeneratorInterface_PartonShowerVeto_src_parent := GeneratorInterface/PartonShowerVeto
src_GeneratorInterface_PartonShowerVeto_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_PartonShowerVeto_src,src/GeneratorInterface/PartonShowerVeto/src,LIBRARY))
GeneratorInterfacePartonShowerVeto := self/GeneratorInterface/PartonShowerVeto
GeneratorInterface/PartonShowerVeto := GeneratorInterfacePartonShowerVeto
GeneratorInterfacePartonShowerVeto_files := $(patsubst src/GeneratorInterface/PartonShowerVeto/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/PartonShowerVeto/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePartonShowerVeto_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PartonShowerVeto/BuildFile
GeneratorInterfacePartonShowerVeto_LOC_USE := self   FWCore/ParameterSet SimDataFormats/GeneratorProducts GeneratorInterface/AlpgenInterface GeneratorInterface/LHEInterface fastjet pythia8 pythia6 f77compiler hepmc 
GeneratorInterfacePartonShowerVeto_EX_LIB   := GeneratorInterfacePartonShowerVeto
GeneratorInterfacePartonShowerVeto_EX_USE   := $(foreach d,$(GeneratorInterfacePartonShowerVeto_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePartonShowerVeto_PACKAGE := self/src/GeneratorInterface/PartonShowerVeto/src
ALL_PRODS += GeneratorInterfacePartonShowerVeto
GeneratorInterfacePartonShowerVeto_CLASS := LIBRARY
GeneratorInterface/PartonShowerVeto_forbigobj+=GeneratorInterfacePartonShowerVeto
GeneratorInterfacePartonShowerVeto_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePartonShowerVeto,src/GeneratorInterface/PartonShowerVeto/src,src_GeneratorInterface_PartonShowerVeto_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
