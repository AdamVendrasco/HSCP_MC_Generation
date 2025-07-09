ifeq ($(strip $(PyGeneratorInterfacePyquenInterface)),)
PyGeneratorInterfacePyquenInterface := self/src/GeneratorInterface/PyquenInterface/python
src_GeneratorInterface_PyquenInterface_python_parent := src/GeneratorInterface/PyquenInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/PyquenInterface/python)
PyGeneratorInterfacePyquenInterface_files := $(patsubst src/GeneratorInterface/PyquenInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/PyquenInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfacePyquenInterface_LOC_USE := self   
PyGeneratorInterfacePyquenInterface_PACKAGE := self/src/GeneratorInterface/PyquenInterface/python
ALL_PRODS += PyGeneratorInterfacePyquenInterface
PyGeneratorInterfacePyquenInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfacePyquenInterface,src/GeneratorInterface/PyquenInterface/python,src_GeneratorInterface_PyquenInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfacePyquenInterface,src/GeneratorInterface/PyquenInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_PyquenInterface_python
src_GeneratorInterface_PyquenInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_PyquenInterface_python,src/GeneratorInterface/PyquenInterface/python,PYTHON))
