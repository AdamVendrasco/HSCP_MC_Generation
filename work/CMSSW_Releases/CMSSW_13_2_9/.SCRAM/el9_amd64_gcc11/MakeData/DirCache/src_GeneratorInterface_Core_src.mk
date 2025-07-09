ifeq ($(strip $(GeneratorInterface/Core)),)
ALL_COMMONRULES += src_GeneratorInterface_Core_src
src_GeneratorInterface_Core_src_parent := GeneratorInterface/Core
src_GeneratorInterface_Core_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_src,src/GeneratorInterface/Core/src,LIBRARY))
GeneratorInterfaceCore := self/GeneratorInterface/Core
GeneratorInterface/Core := GeneratorInterfaceCore
GeneratorInterfaceCore_files := $(patsubst src/GeneratorInterface/Core/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Core/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceCore_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/BuildFile
GeneratorInterfaceCore_LOC_USE := self   FWCore/Concurrency FWCore/ServiceRegistry FWCore/Utilities FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/LHEInterface heppdt boost hepmc hepmc3 clhep lhapdf f77compiler root 
GeneratorInterfaceCore_EX_LIB   := GeneratorInterfaceCore
GeneratorInterfaceCore_EX_USE   := $(foreach d,$(GeneratorInterfaceCore_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceCore_PACKAGE := self/src/GeneratorInterface/Core/src
ALL_PRODS += GeneratorInterfaceCore
GeneratorInterfaceCore_CLASS := LIBRARY
GeneratorInterface/Core_forbigobj+=GeneratorInterfaceCore
GeneratorInterfaceCore_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceCore,src/GeneratorInterface/Core/src,src_GeneratorInterface_Core_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
