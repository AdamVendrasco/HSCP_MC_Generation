ifeq ($(strip $(GeneratorInterface/HijingInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_HijingInterface_src
src_GeneratorInterface_HijingInterface_src_parent := GeneratorInterface/HijingInterface
src_GeneratorInterface_HijingInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_HijingInterface_src,src/GeneratorInterface/HijingInterface/src,LIBRARY))
GeneratorInterfaceHijingInterface := self/GeneratorInterface/HijingInterface
GeneratorInterface/HijingInterface := GeneratorInterfaceHijingInterface
GeneratorInterfaceHijingInterface_files := $(patsubst src/GeneratorInterface/HijingInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HijingInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHijingInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HijingInterface/BuildFile
GeneratorInterfaceHijingInterface_LOC_USE := self   clhep boost GeneratorInterface/Core FWCore/Framework SimDataFormats/GeneratorProducts GeneratorInterface/ExternalDecays f77compiler hepmc 
GeneratorInterfaceHijingInterface_EX_LIB   := GeneratorInterfaceHijingInterface
GeneratorInterfaceHijingInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceHijingInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHijingInterface_PACKAGE := self/src/GeneratorInterface/HijingInterface/src
ALL_PRODS += GeneratorInterfaceHijingInterface
GeneratorInterfaceHijingInterface_CLASS := LIBRARY
GeneratorInterface/HijingInterface_forbigobj+=GeneratorInterfaceHijingInterface
GeneratorInterfaceHijingInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHijingInterface,src/GeneratorInterface/HijingInterface/src,src_GeneratorInterface_HijingInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
