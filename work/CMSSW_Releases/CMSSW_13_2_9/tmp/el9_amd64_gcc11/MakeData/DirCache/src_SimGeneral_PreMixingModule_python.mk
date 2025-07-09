ifeq ($(strip $(PySimGeneralPreMixingModule)),)
PySimGeneralPreMixingModule := self/src/SimGeneral/PreMixingModule/python
src_SimGeneral_PreMixingModule_python_parent := src/SimGeneral/PreMixingModule
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/PreMixingModule/python)
PySimGeneralPreMixingModule_files := $(patsubst src/SimGeneral/PreMixingModule/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/PreMixingModule/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralPreMixingModule_LOC_USE := self   
PySimGeneralPreMixingModule_PACKAGE := self/src/SimGeneral/PreMixingModule/python
ALL_PRODS += PySimGeneralPreMixingModule
PySimGeneralPreMixingModule_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/python,src_SimGeneral_PreMixingModule_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/python))
endif
ALL_COMMONRULES += src_SimGeneral_PreMixingModule_python
src_SimGeneral_PreMixingModule_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PreMixingModule_python,src/SimGeneral/PreMixingModule/python,PYTHON))
