ifeq ($(strip $(PyGeneratorInterfaceHydjetInterface)),)
PyGeneratorInterfaceHydjetInterface := self/src/GeneratorInterface/HydjetInterface/python
src_GeneratorInterface_HydjetInterface_python_parent := src/GeneratorInterface/HydjetInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/HydjetInterface/python)
PyGeneratorInterfaceHydjetInterface_files := $(patsubst src/GeneratorInterface/HydjetInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HydjetInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceHydjetInterface_LOC_USE := self   
PyGeneratorInterfaceHydjetInterface_PACKAGE := self/src/GeneratorInterface/HydjetInterface/python
ALL_PRODS += PyGeneratorInterfaceHydjetInterface
PyGeneratorInterfaceHydjetInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceHydjetInterface,src/GeneratorInterface/HydjetInterface/python,src_GeneratorInterface_HydjetInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceHydjetInterface,src/GeneratorInterface/HydjetInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_HydjetInterface_python
src_GeneratorInterface_HydjetInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HydjetInterface_python,src/GeneratorInterface/HydjetInterface/python,PYTHON))
