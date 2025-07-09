ifeq ($(strip $(PySimG4CoreApplication)),)
PySimG4CoreApplication := self/src/SimG4Core/Application/python
src_SimG4Core_Application_python_parent := src/SimG4Core/Application
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/Application/python)
PySimG4CoreApplication_files := $(patsubst src/SimG4Core/Application/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/Application/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CoreApplication_LOC_USE := self   
PySimG4CoreApplication_PACKAGE := self/src/SimG4Core/Application/python
ALL_PRODS += PySimG4CoreApplication
PySimG4CoreApplication_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CoreApplication,src/SimG4Core/Application/python,src_SimG4Core_Application_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CoreApplication,src/SimG4Core/Application/python))
endif
ALL_COMMONRULES += src_SimG4Core_Application_python
src_SimG4Core_Application_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Application_python,src/SimG4Core/Application/python,PYTHON))
