ifeq ($(strip $(GeneratorInterface/Herwig7Interface)),)
ALL_COMMONRULES += src_GeneratorInterface_Herwig7Interface_src
src_GeneratorInterface_Herwig7Interface_src_parent := GeneratorInterface/Herwig7Interface
src_GeneratorInterface_Herwig7Interface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_Herwig7Interface_src,src/GeneratorInterface/Herwig7Interface/src,LIBRARY))
GeneratorInterfaceHerwig7Interface := self/GeneratorInterface/Herwig7Interface
GeneratorInterface/Herwig7Interface := GeneratorInterfaceHerwig7Interface
GeneratorInterfaceHerwig7Interface_files := $(patsubst src/GeneratorInterface/Herwig7Interface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Herwig7Interface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceHerwig7Interface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Herwig7Interface/BuildFile
GeneratorInterfaceHerwig7Interface_LOC_USE := self   GeneratorInterface/Core boost hepmc thepeg herwig7 
GeneratorInterfaceHerwig7Interface_EX_LIB   := GeneratorInterfaceHerwig7Interface
GeneratorInterfaceHerwig7Interface_EX_USE   := $(foreach d,$(GeneratorInterfaceHerwig7Interface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceHerwig7Interface_PACKAGE := self/src/GeneratorInterface/Herwig7Interface/src
ALL_PRODS += GeneratorInterfaceHerwig7Interface
GeneratorInterfaceHerwig7Interface_CLASS := LIBRARY
GeneratorInterface/Herwig7Interface_forbigobj+=GeneratorInterfaceHerwig7Interface
GeneratorInterfaceHerwig7Interface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceHerwig7Interface,src/GeneratorInterface/Herwig7Interface/src,src_GeneratorInterface_Herwig7Interface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
