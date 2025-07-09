ifeq ($(strip $(PyGeneratorInterfaceConfiguration)),)
PyGeneratorInterfaceConfiguration := self/src/GeneratorInterface/Configuration/python
src_GeneratorInterface_Configuration_python_parent := src/GeneratorInterface/Configuration
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Configuration/python)
PyGeneratorInterfaceConfiguration_files := $(patsubst src/GeneratorInterface/Configuration/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Configuration/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceConfiguration_LOC_USE := self   
PyGeneratorInterfaceConfiguration_PACKAGE := self/src/GeneratorInterface/Configuration/python
ALL_PRODS += PyGeneratorInterfaceConfiguration
PyGeneratorInterfaceConfiguration_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceConfiguration,src/GeneratorInterface/Configuration/python,src_GeneratorInterface_Configuration_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceConfiguration,src/GeneratorInterface/Configuration/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Configuration_python
src_GeneratorInterface_Configuration_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Configuration_python,src/GeneratorInterface/Configuration/python,PYTHON))
