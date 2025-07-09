ifeq ($(strip $(PyGeneratorInterfaceAlpgenInterface)),)
PyGeneratorInterfaceAlpgenInterface := self/src/GeneratorInterface/AlpgenInterface/python
src_GeneratorInterface_AlpgenInterface_python_parent := src/GeneratorInterface/AlpgenInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/AlpgenInterface/python)
PyGeneratorInterfaceAlpgenInterface_files := $(patsubst src/GeneratorInterface/AlpgenInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/AlpgenInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceAlpgenInterface_LOC_USE := self   
PyGeneratorInterfaceAlpgenInterface_PACKAGE := self/src/GeneratorInterface/AlpgenInterface/python
ALL_PRODS += PyGeneratorInterfaceAlpgenInterface
PyGeneratorInterfaceAlpgenInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceAlpgenInterface,src/GeneratorInterface/AlpgenInterface/python,src_GeneratorInterface_AlpgenInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceAlpgenInterface,src/GeneratorInterface/AlpgenInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_AlpgenInterface_python
src_GeneratorInterface_AlpgenInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AlpgenInterface_python,src/GeneratorInterface/AlpgenInterface/python,PYTHON))
