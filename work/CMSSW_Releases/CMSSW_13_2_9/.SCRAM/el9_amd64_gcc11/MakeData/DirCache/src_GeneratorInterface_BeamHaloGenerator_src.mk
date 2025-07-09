ifeq ($(strip $(GeneratorInterface/BeamHaloGenerator)),)
ALL_COMMONRULES += src_GeneratorInterface_BeamHaloGenerator_src
src_GeneratorInterface_BeamHaloGenerator_src_parent := GeneratorInterface/BeamHaloGenerator
src_GeneratorInterface_BeamHaloGenerator_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_BeamHaloGenerator_src,src/GeneratorInterface/BeamHaloGenerator/src,LIBRARY))
GeneratorInterfaceBeamHaloGenerator := self/GeneratorInterface/BeamHaloGenerator
GeneratorInterface/BeamHaloGenerator := GeneratorInterfaceBeamHaloGenerator
GeneratorInterfaceBeamHaloGenerator_files := $(patsubst src/GeneratorInterface/BeamHaloGenerator/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/BeamHaloGenerator/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceBeamHaloGenerator_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/BeamHaloGenerator/BuildFile
GeneratorInterfaceBeamHaloGenerator_LOC_USE := self   boost hepmc FWCore/Framework FWCore/ParameterSet SimDataFormats/GeneratorProducts clhep root f77compiler 
GeneratorInterfaceBeamHaloGenerator_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceBeamHaloGenerator,GeneratorInterfaceBeamHaloGenerator,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/BeamHaloGenerator/src))
GeneratorInterfaceBeamHaloGenerator_PACKAGE := self/src/GeneratorInterface/BeamHaloGenerator/src
ALL_PRODS += GeneratorInterfaceBeamHaloGenerator
GeneratorInterfaceBeamHaloGenerator_CLASS := LIBRARY
GeneratorInterface/BeamHaloGenerator_forbigobj+=GeneratorInterfaceBeamHaloGenerator
GeneratorInterfaceBeamHaloGenerator_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceBeamHaloGenerator,src/GeneratorInterface/BeamHaloGenerator/src,src_GeneratorInterface_BeamHaloGenerator_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
