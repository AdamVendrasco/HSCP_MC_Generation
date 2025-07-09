ifeq ($(strip $(BcGenerator)),)
BcGenerator := self/src/GeneratorInterface/GenExtensions/bin
BcGenerator_files := $(patsubst src/GeneratorInterface/GenExtensions/bin/%,%,$(foreach file,BCVEGPY/main.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/GenExtensions/bin/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/GenExtensions/bin/$(file). Please fix src/GeneratorInterface/GenExtensions/bin/BuildFile.))))
BcGenerator_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/GenExtensions/bin/BuildFile
BcGenerator_LOC_LIB   := GeneratorInterfaceBCVEGPY
BcGenerator_LOC_USE := self   pythia6 f77compiler 
BcGenerator_PACKAGE := self/src/GeneratorInterface/GenExtensions/bin
ALL_PRODS += BcGenerator
BcGenerator_INIT_FUNC        += $$(eval $$(call Binary,BcGenerator,src/GeneratorInterface/GenExtensions/bin,src_GeneratorInterface_GenExtensions_bin,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_BIN),bin,$(SCRAMSTORENAME_LOGS)))
BcGenerator_CLASS := BINARY
else
$(eval $(call MultipleWarningMsg,BcGenerator,src/GeneratorInterface/GenExtensions/bin))
endif
ifeq ($(strip $(GeneratorInterfaceBCVEGPY)),)
GeneratorInterfaceBCVEGPY := self/src/GeneratorInterface/GenExtensions/bin
GeneratorInterfaceBCVEGPY_files := $(patsubst src/GeneratorInterface/GenExtensions/bin/%,%,$(foreach file,BCVEGPY/*.F BCVEGPY/*.f,$(eval xfile:=$(wildcard src/GeneratorInterface/GenExtensions/bin/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/GenExtensions/bin/$(file). Please fix src/GeneratorInterface/GenExtensions/bin/BuildFile.))))
GeneratorInterfaceBCVEGPY_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/GenExtensions/bin/BuildFile
GeneratorInterfaceBCVEGPY_LOC_USE := self   pythia6 f77compiler 
GeneratorInterfaceBCVEGPY_PACKAGE := self/src/GeneratorInterface/GenExtensions/bin
ALL_PRODS += GeneratorInterfaceBCVEGPY
GeneratorInterfaceBCVEGPY_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceBCVEGPY,src/GeneratorInterface/GenExtensions/bin,src_GeneratorInterface_GenExtensions_bin,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
GeneratorInterfaceBCVEGPY_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceBCVEGPY,src/GeneratorInterface/GenExtensions/bin))
endif
ALL_COMMONRULES += src_GeneratorInterface_GenExtensions_bin
src_GeneratorInterface_GenExtensions_bin_parent := GeneratorInterface/GenExtensions
src_GeneratorInterface_GenExtensions_bin_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_GenExtensions_bin,src/GeneratorInterface/GenExtensions/bin,BINARY))
