ifeq ($(strip $(PyGeneratorInterfaceSherpaInterface)),)
PyGeneratorInterfaceSherpaInterface := self/src/GeneratorInterface/SherpaInterface/python
src_GeneratorInterface_SherpaInterface_python_parent := src/GeneratorInterface/SherpaInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/SherpaInterface/python)
PyGeneratorInterfaceSherpaInterface_files := $(patsubst src/GeneratorInterface/SherpaInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/SherpaInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceSherpaInterface_LOC_USE := self   
PyGeneratorInterfaceSherpaInterface_PACKAGE := self/src/GeneratorInterface/SherpaInterface/python
ALL_PRODS += PyGeneratorInterfaceSherpaInterface
PyGeneratorInterfaceSherpaInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceSherpaInterface,src/GeneratorInterface/SherpaInterface/python,src_GeneratorInterface_SherpaInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceSherpaInterface,src/GeneratorInterface/SherpaInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_SherpaInterface_python
src_GeneratorInterface_SherpaInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_SherpaInterface_python,src/GeneratorInterface/SherpaInterface/python,PYTHON))
