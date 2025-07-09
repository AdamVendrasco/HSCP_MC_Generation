ifeq ($(strip $(PyGeneratorInterfacePythia6Interface)),)
PyGeneratorInterfacePythia6Interface := self/src/GeneratorInterface/Pythia6Interface/python
src_GeneratorInterface_Pythia6Interface_python_parent := src/GeneratorInterface/Pythia6Interface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Pythia6Interface/python)
PyGeneratorInterfacePythia6Interface_files := $(patsubst src/GeneratorInterface/Pythia6Interface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Pythia6Interface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfacePythia6Interface_LOC_USE := self   
PyGeneratorInterfacePythia6Interface_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/python
ALL_PRODS += PyGeneratorInterfacePythia6Interface
PyGeneratorInterfacePythia6Interface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfacePythia6Interface,src/GeneratorInterface/Pythia6Interface/python,src_GeneratorInterface_Pythia6Interface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfacePythia6Interface,src/GeneratorInterface/Pythia6Interface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia6Interface_python
src_GeneratorInterface_Pythia6Interface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia6Interface_python,src/GeneratorInterface/Pythia6Interface/python,PYTHON))
