ifeq ($(strip $(PySimG4CoreConfiguration)),)
PySimG4CoreConfiguration := self/src/SimG4Core/Configuration/python
src_SimG4Core_Configuration_python_parent := src/SimG4Core/Configuration
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/Configuration/python)
PySimG4CoreConfiguration_files := $(patsubst src/SimG4Core/Configuration/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/Configuration/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CoreConfiguration_LOC_USE := self   
PySimG4CoreConfiguration_PACKAGE := self/src/SimG4Core/Configuration/python
ALL_PRODS += PySimG4CoreConfiguration
PySimG4CoreConfiguration_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CoreConfiguration,src/SimG4Core/Configuration/python,src_SimG4Core_Configuration_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CoreConfiguration,src/SimG4Core/Configuration/python))
endif
ALL_COMMONRULES += src_SimG4Core_Configuration_python
src_SimG4Core_Configuration_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Configuration_python,src/SimG4Core/Configuration/python,PYTHON))
