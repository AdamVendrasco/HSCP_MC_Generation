ifeq ($(strip $(GeneratorInterface/Hydjet2Interface)),)
ALL_COMMONRULES += src_GeneratorInterface_Hydjet2Interface_src
src_GeneratorInterface_Hydjet2Interface_src_parent := GeneratorInterface/Hydjet2Interface
src_GeneratorInterface_Hydjet2Interface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Hydjet2Interface_src,src/GeneratorInterface/Hydjet2Interface/src,LIBRARY))
GeneratorInterfaceHydjet2Interface := self/GeneratorInterface/Hydjet2Interface
GeneratorInterface/Hydjet2Interface := GeneratorInterfaceHydjet2Interface
GeneratorInterfaceHydjet2Interface_files := $(patsubst src/GeneratorInterface/Hydjet2Interface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Hydjet2Interface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHydjet2Interface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Hydjet2Interface/BuildFile
GeneratorInterfaceHydjet2Interface_LOC_USE := self   boost GeneratorInterface/Core FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/Pythia6Interface GeneratorInterface/ExternalDecays FWCore/Concurrency clhep f77compiler FWCore/ParameterSet FWCore/Utilities pyquen root hydjet2 rootmath rootcore hepmc 
GeneratorInterfaceHydjet2Interface_EX_LIB   := GeneratorInterfaceHydjet2Interface
GeneratorInterfaceHydjet2Interface_EX_USE   := $(foreach d,$(GeneratorInterfaceHydjet2Interface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHydjet2Interface_PACKAGE := self/src/GeneratorInterface/Hydjet2Interface/src
ALL_PRODS += GeneratorInterfaceHydjet2Interface
GeneratorInterfaceHydjet2Interface_CLASS := LIBRARY
GeneratorInterface/Hydjet2Interface_forbigobj+=GeneratorInterfaceHydjet2Interface
GeneratorInterfaceHydjet2Interface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHydjet2Interface,src/GeneratorInterface/Hydjet2Interface/src,src_GeneratorInterface_Hydjet2Interface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
