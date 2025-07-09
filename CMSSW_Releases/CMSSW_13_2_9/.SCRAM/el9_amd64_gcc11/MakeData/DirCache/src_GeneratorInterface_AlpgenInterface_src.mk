ifeq ($(strip $(GeneratorInterface/AlpgenInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_AlpgenInterface_src
src_GeneratorInterface_AlpgenInterface_src_parent := GeneratorInterface/AlpgenInterface
src_GeneratorInterface_AlpgenInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_AlpgenInterface_src,src/GeneratorInterface/AlpgenInterface/src,LIBRARY))
GeneratorInterfaceAlpgenInterface := self/GeneratorInterface/AlpgenInterface
GeneratorInterface/AlpgenInterface := GeneratorInterfaceAlpgenInterface
GeneratorInterfaceAlpgenInterface_files := $(patsubst src/GeneratorInterface/AlpgenInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/AlpgenInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceAlpgenInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AlpgenInterface/BuildFile
GeneratorInterfaceAlpgenInterface_LOC_USE := self   boost root DataFormats/Math SimDataFormats/GeneratorProducts f77compiler 
GeneratorInterfaceAlpgenInterface_EX_LIB   := GeneratorInterfaceAlpgenInterface
GeneratorInterfaceAlpgenInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceAlpgenInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceAlpgenInterface_PACKAGE := self/src/GeneratorInterface/AlpgenInterface/src
ALL_PRODS += GeneratorInterfaceAlpgenInterface
GeneratorInterfaceAlpgenInterface_CLASS := LIBRARY
GeneratorInterface/AlpgenInterface_forbigobj+=GeneratorInterfaceAlpgenInterface
GeneratorInterfaceAlpgenInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAlpgenInterface,src/GeneratorInterface/AlpgenInterface/src,src_GeneratorInterface_AlpgenInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
