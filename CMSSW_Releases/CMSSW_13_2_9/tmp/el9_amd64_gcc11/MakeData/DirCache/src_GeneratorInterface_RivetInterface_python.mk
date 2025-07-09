ifeq ($(strip $(PyGeneratorInterfaceRivetInterface)),)
PyGeneratorInterfaceRivetInterface := self/src/GeneratorInterface/RivetInterface/python
src_GeneratorInterface_RivetInterface_python_parent := src/GeneratorInterface/RivetInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/RivetInterface/python)
PyGeneratorInterfaceRivetInterface_files := $(patsubst src/GeneratorInterface/RivetInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/RivetInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceRivetInterface_LOC_USE := self   
PyGeneratorInterfaceRivetInterface_PACKAGE := self/src/GeneratorInterface/RivetInterface/python
ALL_PRODS += PyGeneratorInterfaceRivetInterface
PyGeneratorInterfaceRivetInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/python,src_GeneratorInterface_RivetInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_python
src_GeneratorInterface_RivetInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_python,src/GeneratorInterface/RivetInterface/python,PYTHON))
