ifeq ($(strip $(GeneratorInterface/ExhumeInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_ExhumeInterface_src
src_GeneratorInterface_ExhumeInterface_src_parent := GeneratorInterface/ExhumeInterface
src_GeneratorInterface_ExhumeInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExhumeInterface_src,src/GeneratorInterface/ExhumeInterface/src,LIBRARY))
GeneratorInterfaceExhumeInterface := self/GeneratorInterface/ExhumeInterface
GeneratorInterface/ExhumeInterface := GeneratorInterfaceExhumeInterface
GeneratorInterfaceExhumeInterface_files := $(patsubst src/GeneratorInterface/ExhumeInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ExhumeInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfaceExhumeInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ExhumeInterface/BuildFile
GeneratorInterfaceExhumeInterface_LOC_USE := self   FWCore/Concurrency GeneratorInterface/Core GeneratorInterface/Pythia6Interface boost clhep f77compiler heppdt hepmc 
GeneratorInterfaceExhumeInterface_EX_LIB   := GeneratorInterfaceExhumeInterface
GeneratorInterfaceExhumeInterface_EX_USE   := $(foreach d,$(GeneratorInterfaceExhumeInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfaceExhumeInterface_PACKAGE := self/src/GeneratorInterface/ExhumeInterface/src
ALL_PRODS += GeneratorInterfaceExhumeInterface
GeneratorInterfaceExhumeInterface_CLASS := LIBRARY
GeneratorInterface/ExhumeInterface_forbigobj+=GeneratorInterfaceExhumeInterface
GeneratorInterfaceExhumeInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceExhumeInterface,src/GeneratorInterface/ExhumeInterface/src,src_GeneratorInterface_ExhumeInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
