ifeq ($(strip $(GeneratorInterface/AMPTInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_AMPTInterface_src
src_GeneratorInterface_AMPTInterface_src_parent := GeneratorInterface/AMPTInterface
src_GeneratorInterface_AMPTInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_AMPTInterface_src,src/GeneratorInterface/AMPTInterface/src,LIBRARY))
GeneratorInterfaceAMPTInterface := self/GeneratorInterface/AMPTInterface
GeneratorInterface/AMPTInterface := GeneratorInterfaceAMPTInterface
GeneratorInterfaceAMPTInterface_files := $(patsubst src/GeneratorInterface/AMPTInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/AMPTInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceAMPTInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AMPTInterface/BuildFile
GeneratorInterfaceAMPTInterface_LOC_USE := self   boost hepmc GeneratorInterface/Core FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/ExternalDecays f77compiler 
GeneratorInterfaceAMPTInterface_EX_LIB   := GeneratorInterfaceAMPTInterface
GeneratorInterfaceAMPTInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceAMPTInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceAMPTInterface_PACKAGE := self/src/GeneratorInterface/AMPTInterface/src
ALL_PRODS += GeneratorInterfaceAMPTInterface
GeneratorInterfaceAMPTInterface_CLASS := LIBRARY
GeneratorInterface/AMPTInterface_forbigobj+=GeneratorInterfaceAMPTInterface
GeneratorInterfaceAMPTInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAMPTInterface,src/GeneratorInterface/AMPTInterface/src,src_GeneratorInterface_AMPTInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
