ifeq ($(strip $(PyGeneratorInterfaceLHEInterface)),)
PyGeneratorInterfaceLHEInterface := self/src/GeneratorInterface/LHEInterface/python
src_GeneratorInterface_LHEInterface_python_parent := src/GeneratorInterface/LHEInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/LHEInterface/python)
PyGeneratorInterfaceLHEInterface_files := $(patsubst src/GeneratorInterface/LHEInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/LHEInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceLHEInterface_LOC_USE := self   
PyGeneratorInterfaceLHEInterface_PACKAGE := self/src/GeneratorInterface/LHEInterface/python
ALL_PRODS += PyGeneratorInterfaceLHEInterface
PyGeneratorInterfaceLHEInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceLHEInterface,src/GeneratorInterface/LHEInterface/python,src_GeneratorInterface_LHEInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceLHEInterface,src/GeneratorInterface/LHEInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_LHEInterface_python
src_GeneratorInterface_LHEInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_LHEInterface_python,src/GeneratorInterface/LHEInterface/python,PYTHON))
