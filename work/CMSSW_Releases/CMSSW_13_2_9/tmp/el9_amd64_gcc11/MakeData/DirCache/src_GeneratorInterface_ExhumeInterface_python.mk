ifeq ($(strip $(PyGeneratorInterfaceExhumeInterface)),)
PyGeneratorInterfaceExhumeInterface := self/src/GeneratorInterface/ExhumeInterface/python
src_GeneratorInterface_ExhumeInterface_python_parent := src/GeneratorInterface/ExhumeInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/ExhumeInterface/python)
PyGeneratorInterfaceExhumeInterface_files := $(patsubst src/GeneratorInterface/ExhumeInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ExhumeInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceExhumeInterface_LOC_USE := self   
PyGeneratorInterfaceExhumeInterface_PACKAGE := self/src/GeneratorInterface/ExhumeInterface/python
ALL_PRODS += PyGeneratorInterfaceExhumeInterface
PyGeneratorInterfaceExhumeInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceExhumeInterface,src/GeneratorInterface/ExhumeInterface/python,src_GeneratorInterface_ExhumeInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceExhumeInterface,src/GeneratorInterface/ExhumeInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExhumeInterface_python
src_GeneratorInterface_ExhumeInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExhumeInterface_python,src/GeneratorInterface/ExhumeInterface/python,PYTHON))
