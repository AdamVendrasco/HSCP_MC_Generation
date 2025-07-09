ifeq ($(strip $(PyGeneratorInterfaceHydjet2Interface)),)
PyGeneratorInterfaceHydjet2Interface := self/src/GeneratorInterface/Hydjet2Interface/python
src_GeneratorInterface_Hydjet2Interface_python_parent := src/GeneratorInterface/Hydjet2Interface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Hydjet2Interface/python)
PyGeneratorInterfaceHydjet2Interface_files := $(patsubst src/GeneratorInterface/Hydjet2Interface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Hydjet2Interface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceHydjet2Interface_LOC_USE := self   
PyGeneratorInterfaceHydjet2Interface_PACKAGE := self/src/GeneratorInterface/Hydjet2Interface/python
ALL_PRODS += PyGeneratorInterfaceHydjet2Interface
PyGeneratorInterfaceHydjet2Interface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceHydjet2Interface,src/GeneratorInterface/Hydjet2Interface/python,src_GeneratorInterface_Hydjet2Interface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceHydjet2Interface,src/GeneratorInterface/Hydjet2Interface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Hydjet2Interface_python
src_GeneratorInterface_Hydjet2Interface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Hydjet2Interface_python,src/GeneratorInterface/Hydjet2Interface/python,PYTHON))
