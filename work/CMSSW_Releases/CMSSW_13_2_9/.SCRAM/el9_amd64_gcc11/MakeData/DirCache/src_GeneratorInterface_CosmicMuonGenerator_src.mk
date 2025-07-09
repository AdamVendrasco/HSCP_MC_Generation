ifeq ($(strip $(GeneratorInterface/CosmicMuonGenerator)),)
ALL_COMMONRULES += src_GeneratorInterface_CosmicMuonGenerator_src
src_GeneratorInterface_CosmicMuonGenerator_src_parent := GeneratorInterface/CosmicMuonGenerator
src_GeneratorInterface_CosmicMuonGenerator_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_CosmicMuonGenerator_src,src/GeneratorInterface/CosmicMuonGenerator/src,LIBRARY))
GeneratorInterfaceCosmicMuonGenerator := self/GeneratorInterface/CosmicMuonGenerator
GeneratorInterface/CosmicMuonGenerator := GeneratorInterfaceCosmicMuonGenerator
GeneratorInterfaceCosmicMuonGenerator_files := $(patsubst src/GeneratorInterface/CosmicMuonGenerator/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/CosmicMuonGenerator/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceCosmicMuonGenerator_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/CosmicMuonGenerator/BuildFile
GeneratorInterfaceCosmicMuonGenerator_LOC_USE := self   boost FWCore/Framework FWCore/ServiceRegistry SimDataFormats/GeneratorProducts clhep root hepmc 
GeneratorInterfaceCosmicMuonGenerator_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceCosmicMuonGenerator,GeneratorInterfaceCosmicMuonGenerator,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/CosmicMuonGenerator/src))
GeneratorInterfaceCosmicMuonGenerator_PACKAGE := self/src/GeneratorInterface/CosmicMuonGenerator/src
ALL_PRODS += GeneratorInterfaceCosmicMuonGenerator
GeneratorInterfaceCosmicMuonGenerator_CLASS := LIBRARY
GeneratorInterface/CosmicMuonGenerator_forbigobj+=GeneratorInterfaceCosmicMuonGenerator
GeneratorInterfaceCosmicMuonGenerator_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceCosmicMuonGenerator,src/GeneratorInterface/CosmicMuonGenerator/src,src_GeneratorInterface_CosmicMuonGenerator_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
