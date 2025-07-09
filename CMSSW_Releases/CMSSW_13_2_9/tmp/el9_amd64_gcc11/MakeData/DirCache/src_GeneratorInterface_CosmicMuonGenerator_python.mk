ifeq ($(strip $(PyGeneratorInterfaceCosmicMuonGenerator)),)
PyGeneratorInterfaceCosmicMuonGenerator := self/src/GeneratorInterface/CosmicMuonGenerator/python
src_GeneratorInterface_CosmicMuonGenerator_python_parent := src/GeneratorInterface/CosmicMuonGenerator
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/CosmicMuonGenerator/python)
PyGeneratorInterfaceCosmicMuonGenerator_files := $(patsubst src/GeneratorInterface/CosmicMuonGenerator/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/CosmicMuonGenerator/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceCosmicMuonGenerator_LOC_USE := self   
PyGeneratorInterfaceCosmicMuonGenerator_PACKAGE := self/src/GeneratorInterface/CosmicMuonGenerator/python
ALL_PRODS += PyGeneratorInterfaceCosmicMuonGenerator
PyGeneratorInterfaceCosmicMuonGenerator_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceCosmicMuonGenerator,src/GeneratorInterface/CosmicMuonGenerator/python,src_GeneratorInterface_CosmicMuonGenerator_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceCosmicMuonGenerator,src/GeneratorInterface/CosmicMuonGenerator/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_CosmicMuonGenerator_python
src_GeneratorInterface_CosmicMuonGenerator_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_CosmicMuonGenerator_python,src/GeneratorInterface/CosmicMuonGenerator/python,PYTHON))
