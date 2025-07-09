ifeq ($(strip $(GeneratorInterface/PyquenInterface)),)
ALL_COMMONRULES += src_GeneratorInterface_PyquenInterface_src
src_GeneratorInterface_PyquenInterface_src_parent := GeneratorInterface/PyquenInterface
src_GeneratorInterface_PyquenInterface_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_GeneratorInterface_PyquenInterface_src,src/GeneratorInterface/PyquenInterface/src,LIBRARY))
GeneratorInterfacePyquenInterface := self/GeneratorInterface/PyquenInterface
GeneratorInterface/PyquenInterface := GeneratorInterfacePyquenInterface
GeneratorInterfacePyquenInterface_files := $(patsubst src/GeneratorInterface/PyquenInterface/src/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/PyquenInterface/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
GeneratorInterfacePyquenInterface_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PyquenInterface/BuildFile
GeneratorInterfacePyquenInterface_LOC_USE := self   boost FWCore/Concurrency FWCore/Framework GeneratorInterface/Core GeneratorInterface/HiGenCommon SimDataFormats/GeneratorProducts clhep f77compiler GeneratorInterface/Pythia6Interface GeneratorInterface/ExternalDecays pyquen hepmc 
GeneratorInterfacePyquenInterface_EX_LIB   := GeneratorInterfacePyquenInterface
GeneratorInterfacePyquenInterface_EX_USE   := $(foreach d,$(GeneratorInterfacePyquenInterface_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePyquenInterface_PACKAGE := self/src/GeneratorInterface/PyquenInterface/src
ALL_PRODS += GeneratorInterfacePyquenInterface
GeneratorInterfacePyquenInterface_CLASS := LIBRARY
GeneratorInterface/PyquenInterface_forbigobj+=GeneratorInterfacePyquenInterface
GeneratorInterfacePyquenInterface_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfacePyquenInterface,src/GeneratorInterface/PyquenInterface/src,src_GeneratorInterface_PyquenInterface_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
