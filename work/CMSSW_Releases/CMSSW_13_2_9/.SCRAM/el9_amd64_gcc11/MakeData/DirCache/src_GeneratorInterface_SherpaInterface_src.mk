ifeq ($(strip $(GeneratorInterface/SherpaInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_SherpaInterface_src
src_GeneratorInterface_SherpaInterface_src_parent := GeneratorInterface/SherpaInterface
src_GeneratorInterface_SherpaInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_SherpaInterface_src,src/GeneratorInterface/SherpaInterface/src,LIBRARY))
GeneratorInterfaceSherpaInterface := self/GeneratorInterface/SherpaInterface
GeneratorInterface/SherpaInterface := GeneratorInterfaceSherpaInterface
GeneratorInterfaceSherpaInterface_files := $(patsubst src/GeneratorInterface/SherpaInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/SherpaInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceSherpaInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/SherpaInterface/BuildFile
GeneratorInterfaceSherpaInterface_LOC_USE := self   FWCore/Framework FWCore/ParameterSet GeneratorInterface/Core GeneratorInterface/ExternalDecays Utilities/OpenSSL clhep sherpa zlib 
GeneratorInterfaceSherpaInterface_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceSherpaInterface,GeneratorInterfaceSherpaInterface,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/SherpaInterface/src))
GeneratorInterfaceSherpaInterface_PACKAGE := self/src/GeneratorInterface/SherpaInterface/src
ALL_PRODS += GeneratorInterfaceSherpaInterface
GeneratorInterfaceSherpaInterface_CLASS := LIBRARY
GeneratorInterface/SherpaInterface_forbigobj+=GeneratorInterfaceSherpaInterface
GeneratorInterfaceSherpaInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceSherpaInterface,src/GeneratorInterface/SherpaInterface/src,src_GeneratorInterface_SherpaInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
