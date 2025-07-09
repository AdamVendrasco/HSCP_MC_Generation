ifeq ($(strip $(PySimGeneralDataMixingModule)),)
PySimGeneralDataMixingModule := self/src/SimGeneral/DataMixingModule/python
src_SimGeneral_DataMixingModule_python_parent := src/SimGeneral/DataMixingModule
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/DataMixingModule/python)
PySimGeneralDataMixingModule_files := $(patsubst src/SimGeneral/DataMixingModule/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/DataMixingModule/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralDataMixingModule_LOC_USE := self   
PySimGeneralDataMixingModule_PACKAGE := self/src/SimGeneral/DataMixingModule/python
ALL_PRODS += PySimGeneralDataMixingModule
PySimGeneralDataMixingModule_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralDataMixingModule,src/SimGeneral/DataMixingModule/python,src_SimGeneral_DataMixingModule_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralDataMixingModule,src/SimGeneral/DataMixingModule/python))
endif
ALL_COMMONRULES += src_SimGeneral_DataMixingModule_python
src_SimGeneral_DataMixingModule_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_DataMixingModule_python,src/SimGeneral/DataMixingModule/python,PYTHON))
