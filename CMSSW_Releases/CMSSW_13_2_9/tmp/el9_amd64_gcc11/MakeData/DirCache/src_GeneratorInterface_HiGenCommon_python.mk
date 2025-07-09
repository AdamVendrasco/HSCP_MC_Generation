ifeq ($(strip $(PyGeneratorInterfaceHiGenCommon)),)
PyGeneratorInterfaceHiGenCommon := self/src/GeneratorInterface/HiGenCommon/python
src_GeneratorInterface_HiGenCommon_python_parent := src/GeneratorInterface/HiGenCommon
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/HiGenCommon/python)
PyGeneratorInterfaceHiGenCommon_files := $(patsubst src/GeneratorInterface/HiGenCommon/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HiGenCommon/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceHiGenCommon_LOC_USE := self   
PyGeneratorInterfaceHiGenCommon_PACKAGE := self/src/GeneratorInterface/HiGenCommon/python
ALL_PRODS += PyGeneratorInterfaceHiGenCommon
PyGeneratorInterfaceHiGenCommon_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceHiGenCommon,src/GeneratorInterface/HiGenCommon/python,src_GeneratorInterface_HiGenCommon_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceHiGenCommon,src/GeneratorInterface/HiGenCommon/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_HiGenCommon_python
src_GeneratorInterface_HiGenCommon_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HiGenCommon_python,src/GeneratorInterface/HiGenCommon/python,PYTHON))
