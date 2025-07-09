ifeq ($(strip $(GeneratorInterface/RivetInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_src
src_GeneratorInterface_RivetInterface_src_parent := GeneratorInterface/RivetInterface
src_GeneratorInterface_RivetInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_src,src/GeneratorInterface/RivetInterface/src,LIBRARY))
GeneratorInterfaceRivetInterface := self/GeneratorInterface/RivetInterface
GeneratorInterface/RivetInterface := GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_files := $(patsubst src/GeneratorInterface/RivetInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/RivetInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceRivetInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/BuildFile
GeneratorInterfaceRivetInterface_LOC_USE := self   rivet yoda fastjet clhep boost gsl root 
GeneratorInterfaceRivetInterface_PRE_INIT_FUNC += $$(eval $$(call rivetPlugin,GeneratorInterfaceRivetInterface,GeneratorInterfaceRivetInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/RivetInterface/src))
GeneratorInterfaceRivetInterface_PACKAGE := self/src/GeneratorInterface/RivetInterface/src
ALL_PRODS += GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_CLASS := LIBRARY
GeneratorInterface/RivetInterface_forbigobj+=GeneratorInterfaceRivetInterface
GeneratorInterfaceRivetInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/src,src_GeneratorInterface_RivetInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),rivet))
endif
