ifeq ($(strip $(PyGeneratorInterfaceHerwig7Interface)),)
PyGeneratorInterfaceHerwig7Interface := self/src/GeneratorInterface/Herwig7Interface/python
src_GeneratorInterface_Herwig7Interface_python_parent := src/GeneratorInterface/Herwig7Interface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Herwig7Interface/python)
PyGeneratorInterfaceHerwig7Interface_files := $(patsubst src/GeneratorInterface/Herwig7Interface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Herwig7Interface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceHerwig7Interface_LOC_USE := self   
PyGeneratorInterfaceHerwig7Interface_PACKAGE := self/src/GeneratorInterface/Herwig7Interface/python
ALL_PRODS += PyGeneratorInterfaceHerwig7Interface
PyGeneratorInterfaceHerwig7Interface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceHerwig7Interface,src/GeneratorInterface/Herwig7Interface/python,src_GeneratorInterface_Herwig7Interface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceHerwig7Interface,src/GeneratorInterface/Herwig7Interface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Herwig7Interface_python
src_GeneratorInterface_Herwig7Interface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Herwig7Interface_python,src/GeneratorInterface/Herwig7Interface/python,PYTHON))
