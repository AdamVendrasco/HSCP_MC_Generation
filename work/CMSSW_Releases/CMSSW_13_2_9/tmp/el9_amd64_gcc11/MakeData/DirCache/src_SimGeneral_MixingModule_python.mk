ifeq ($(strip $(PySimGeneralMixingModule)),)
PySimGeneralMixingModule := self/src/SimGeneral/MixingModule/python
src_SimGeneral_MixingModule_python_parent := src/SimGeneral/MixingModule
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/MixingModule/python)
PySimGeneralMixingModule_files := $(patsubst src/SimGeneral/MixingModule/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/MixingModule/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralMixingModule_LOC_USE := self   
PySimGeneralMixingModule_PACKAGE := self/src/SimGeneral/MixingModule/python
ALL_PRODS += PySimGeneralMixingModule
PySimGeneralMixingModule_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralMixingModule,src/SimGeneral/MixingModule/python,src_SimGeneral_MixingModule_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralMixingModule,src/SimGeneral/MixingModule/python))
endif
ALL_COMMONRULES += src_SimGeneral_MixingModule_python
src_SimGeneral_MixingModule_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_python,src/SimGeneral/MixingModule/python,PYTHON))
