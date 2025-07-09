ifeq ($(strip $(PyGeneratorInterfaceEvtGenInterface)),)
PyGeneratorInterfaceEvtGenInterface := self/src/GeneratorInterface/EvtGenInterface/python
src_GeneratorInterface_EvtGenInterface_python_parent := src/GeneratorInterface/EvtGenInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/EvtGenInterface/python)
PyGeneratorInterfaceEvtGenInterface_files := $(patsubst src/GeneratorInterface/EvtGenInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/EvtGenInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceEvtGenInterface_LOC_USE := self   
PyGeneratorInterfaceEvtGenInterface_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/python
ALL_PRODS += PyGeneratorInterfaceEvtGenInterface
PyGeneratorInterfaceEvtGenInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceEvtGenInterface,src/GeneratorInterface/EvtGenInterface/python,src_GeneratorInterface_EvtGenInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceEvtGenInterface,src/GeneratorInterface/EvtGenInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_EvtGenInterface_python
src_GeneratorInterface_EvtGenInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_EvtGenInterface_python,src/GeneratorInterface/EvtGenInterface/python,PYTHON))
