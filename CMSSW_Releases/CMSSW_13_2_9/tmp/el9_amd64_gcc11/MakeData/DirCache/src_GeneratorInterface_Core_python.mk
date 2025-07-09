ifeq ($(strip $(PyGeneratorInterfaceCore)),)
PyGeneratorInterfaceCore := self/src/GeneratorInterface/Core/python
src_GeneratorInterface_Core_python_parent := src/GeneratorInterface/Core
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Core/python)
PyGeneratorInterfaceCore_files := $(patsubst src/GeneratorInterface/Core/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Core/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceCore_LOC_USE := self   
PyGeneratorInterfaceCore_PACKAGE := self/src/GeneratorInterface/Core/python
ALL_PRODS += PyGeneratorInterfaceCore
PyGeneratorInterfaceCore_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceCore,src/GeneratorInterface/Core/python,src_GeneratorInterface_Core_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceCore,src/GeneratorInterface/Core/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Core_python
src_GeneratorInterface_Core_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_python,src/GeneratorInterface/Core/python,PYTHON))
