ifeq ($(strip $(GeneratorInterface/HiGenCommon)),)
ALL_COMMONRULES += src_GeneratorInterface_HiGenCommon_src
src_GeneratorInterface_HiGenCommon_src_parent := GeneratorInterface/HiGenCommon
src_GeneratorInterface_HiGenCommon_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_HiGenCommon_src,src/GeneratorInterface/HiGenCommon/src,LIBRARY))
GeneratorInterfaceHiGenCommon := self/GeneratorInterface/HiGenCommon
GeneratorInterface/HiGenCommon := GeneratorInterfaceHiGenCommon
GeneratorInterfaceHiGenCommon_files := $(patsubst src/GeneratorInterface/HiGenCommon/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HiGenCommon/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHiGenCommon_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HiGenCommon/BuildFile
GeneratorInterfaceHiGenCommon_LOC_USE := self   FWCore/ParameterSet hepmc 
GeneratorInterfaceHiGenCommon_EX_LIB   := GeneratorInterfaceHiGenCommon
GeneratorInterfaceHiGenCommon_EX_USE   := $(foreach d,$(GeneratorInterfaceHiGenCommon_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHiGenCommon_PACKAGE := self/src/GeneratorInterface/HiGenCommon/src
ALL_PRODS += GeneratorInterfaceHiGenCommon
GeneratorInterfaceHiGenCommon_CLASS := LIBRARY
GeneratorInterface/HiGenCommon_forbigobj+=GeneratorInterfaceHiGenCommon
GeneratorInterfaceHiGenCommon_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHiGenCommon,src/GeneratorInterface/HiGenCommon/src,src_GeneratorInterface_HiGenCommon_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
