ifeq ($(strip $(cmsExternalGenerator)),)
cmsExternalGenerator := self/src/GeneratorInterface/Core/bin
cmsExternalGenerator_files := $(patsubst src/GeneratorInterface/Core/bin/%,%,$(foreach file,externalGenerator.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Core/bin/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Core/bin/$(file). Please fix src/GeneratorInterface/Core/bin/BuildFile.))))
cmsExternalGenerator_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/bin/BuildFile
cmsExternalGenerator_LOC_USE := self   boost boost_program_options FWCore/TestProcessor FWCore/SharedMemory FWCore/Services SimDataFormats/GeneratorProducts 
cmsExternalGenerator_PACKAGE := self/src/GeneratorInterface/Core/bin
ALL_PRODS += cmsExternalGenerator
cmsExternalGenerator_INIT_FUNC        += $$(eval $$(call Binary,cmsExternalGenerator,src/GeneratorInterface/Core/bin,src_GeneratorInterface_Core_bin,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_BIN),bin,$(SCRAMSTORENAME_LOGS)))
cmsExternalGenerator_CLASS := BINARY
else
$(eval $(call MultipleWarningMsg,cmsExternalGenerator,src/GeneratorInterface/Core/bin))
endif
ALL_COMMONRULES += src_GeneratorInterface_Core_bin
src_GeneratorInterface_Core_bin_parent := GeneratorInterface/Core
src_GeneratorInterface_Core_bin_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_bin,src/GeneratorInterface/Core/bin,BINARY))
