ifeq ($(strip $(PyGeneratorInterfaceExternalDecays)),)
PyGeneratorInterfaceExternalDecays := self/src/GeneratorInterface/ExternalDecays/python
src_GeneratorInterface_ExternalDecays_python_parent := src/GeneratorInterface/ExternalDecays
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/ExternalDecays/python)
PyGeneratorInterfaceExternalDecays_files := $(patsubst src/GeneratorInterface/ExternalDecays/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ExternalDecays/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceExternalDecays_LOC_USE := self   
PyGeneratorInterfaceExternalDecays_PACKAGE := self/src/GeneratorInterface/ExternalDecays/python
ALL_PRODS += PyGeneratorInterfaceExternalDecays
PyGeneratorInterfaceExternalDecays_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceExternalDecays,src/GeneratorInterface/ExternalDecays/python,src_GeneratorInterface_ExternalDecays_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceExternalDecays,src/GeneratorInterface/ExternalDecays/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExternalDecays_python
src_GeneratorInterface_ExternalDecays_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExternalDecays_python,src/GeneratorInterface/ExternalDecays/python,PYTHON))
