ifeq ($(strip $(PyGeneratorInterfaceTauolaInterface)),)
PyGeneratorInterfaceTauolaInterface := self/src/GeneratorInterface/TauolaInterface/python
src_GeneratorInterface_TauolaInterface_python_parent := src/GeneratorInterface/TauolaInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/TauolaInterface/python)
PyGeneratorInterfaceTauolaInterface_files := $(patsubst src/GeneratorInterface/TauolaInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/TauolaInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceTauolaInterface_LOC_USE := self   
PyGeneratorInterfaceTauolaInterface_PACKAGE := self/src/GeneratorInterface/TauolaInterface/python
ALL_PRODS += PyGeneratorInterfaceTauolaInterface
PyGeneratorInterfaceTauolaInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceTauolaInterface,src/GeneratorInterface/TauolaInterface/python,src_GeneratorInterface_TauolaInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceTauolaInterface,src/GeneratorInterface/TauolaInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_TauolaInterface_python
src_GeneratorInterface_TauolaInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_TauolaInterface_python,src/GeneratorInterface/TauolaInterface/python,PYTHON))
