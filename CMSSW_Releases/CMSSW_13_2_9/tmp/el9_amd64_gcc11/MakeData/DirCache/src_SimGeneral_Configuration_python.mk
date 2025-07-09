ifeq ($(strip $(PySimGeneralConfiguration)),)
PySimGeneralConfiguration := self/src/SimGeneral/Configuration/python
src_SimGeneral_Configuration_python_parent := src/SimGeneral/Configuration
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/Configuration/python)
PySimGeneralConfiguration_files := $(patsubst src/SimGeneral/Configuration/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/Configuration/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralConfiguration_LOC_USE := self   
PySimGeneralConfiguration_PACKAGE := self/src/SimGeneral/Configuration/python
ALL_PRODS += PySimGeneralConfiguration
PySimGeneralConfiguration_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralConfiguration,src/SimGeneral/Configuration/python,src_SimGeneral_Configuration_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralConfiguration,src/SimGeneral/Configuration/python))
endif
ALL_COMMONRULES += src_SimGeneral_Configuration_python
src_SimGeneral_Configuration_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_Configuration_python,src/SimGeneral/Configuration/python,PYTHON))
