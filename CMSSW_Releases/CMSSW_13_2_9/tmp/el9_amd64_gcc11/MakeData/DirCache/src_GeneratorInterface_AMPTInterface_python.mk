ifeq ($(strip $(PyGeneratorInterfaceAMPTInterface)),)
PyGeneratorInterfaceAMPTInterface := self/src/GeneratorInterface/AMPTInterface/python
src_GeneratorInterface_AMPTInterface_python_parent := src/GeneratorInterface/AMPTInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/AMPTInterface/python)
PyGeneratorInterfaceAMPTInterface_files := $(patsubst src/GeneratorInterface/AMPTInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/AMPTInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceAMPTInterface_LOC_USE := self   
PyGeneratorInterfaceAMPTInterface_PACKAGE := self/src/GeneratorInterface/AMPTInterface/python
ALL_PRODS += PyGeneratorInterfaceAMPTInterface
PyGeneratorInterfaceAMPTInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceAMPTInterface,src/GeneratorInterface/AMPTInterface/python,src_GeneratorInterface_AMPTInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceAMPTInterface,src/GeneratorInterface/AMPTInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_AMPTInterface_python
src_GeneratorInterface_AMPTInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AMPTInterface_python,src/GeneratorInterface/AMPTInterface/python,PYTHON))
