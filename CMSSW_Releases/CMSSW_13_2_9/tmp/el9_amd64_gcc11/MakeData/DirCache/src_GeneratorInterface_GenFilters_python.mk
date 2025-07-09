ifeq ($(strip $(PyGeneratorInterfaceGenFilters)),)
PyGeneratorInterfaceGenFilters := self/src/GeneratorInterface/GenFilters/python
src_GeneratorInterface_GenFilters_python_parent := src/GeneratorInterface/GenFilters
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/GenFilters/python)
PyGeneratorInterfaceGenFilters_files := $(patsubst src/GeneratorInterface/GenFilters/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/GenFilters/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceGenFilters_LOC_USE := self   
PyGeneratorInterfaceGenFilters_PACKAGE := self/src/GeneratorInterface/GenFilters/python
ALL_PRODS += PyGeneratorInterfaceGenFilters
PyGeneratorInterfaceGenFilters_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceGenFilters,src/GeneratorInterface/GenFilters/python,src_GeneratorInterface_GenFilters_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceGenFilters,src/GeneratorInterface/GenFilters/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_GenFilters_python
src_GeneratorInterface_GenFilters_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_GenFilters_python,src/GeneratorInterface/GenFilters/python,PYTHON))
