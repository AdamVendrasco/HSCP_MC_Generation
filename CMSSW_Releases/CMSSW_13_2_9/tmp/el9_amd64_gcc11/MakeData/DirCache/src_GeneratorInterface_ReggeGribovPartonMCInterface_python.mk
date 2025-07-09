ifeq ($(strip $(PyGeneratorInterfaceReggeGribovPartonMCInterface)),)
PyGeneratorInterfaceReggeGribovPartonMCInterface := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/python
src_GeneratorInterface_ReggeGribovPartonMCInterface_python_parent := src/GeneratorInterface/ReggeGribovPartonMCInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/ReggeGribovPartonMCInterface/python)
PyGeneratorInterfaceReggeGribovPartonMCInterface_files := $(patsubst src/GeneratorInterface/ReggeGribovPartonMCInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ReggeGribovPartonMCInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceReggeGribovPartonMCInterface_LOC_USE := self   
PyGeneratorInterfaceReggeGribovPartonMCInterface_PACKAGE := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/python
ALL_PRODS += PyGeneratorInterfaceReggeGribovPartonMCInterface
PyGeneratorInterfaceReggeGribovPartonMCInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceReggeGribovPartonMCInterface,src/GeneratorInterface/ReggeGribovPartonMCInterface/python,src_GeneratorInterface_ReggeGribovPartonMCInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceReggeGribovPartonMCInterface,src/GeneratorInterface/ReggeGribovPartonMCInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_ReggeGribovPartonMCInterface_python
src_GeneratorInterface_ReggeGribovPartonMCInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ReggeGribovPartonMCInterface_python,src/GeneratorInterface/ReggeGribovPartonMCInterface/python,PYTHON))
