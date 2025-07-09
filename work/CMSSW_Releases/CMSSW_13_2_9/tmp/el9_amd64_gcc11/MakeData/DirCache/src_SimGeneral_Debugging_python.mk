ifeq ($(strip $(PySimGeneralDebugging)),)
PySimGeneralDebugging := self/src/SimGeneral/Debugging/python
src_SimGeneral_Debugging_python_parent := src/SimGeneral/Debugging
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/Debugging/python)
PySimGeneralDebugging_files := $(patsubst src/SimGeneral/Debugging/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/Debugging/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralDebugging_LOC_USE := self   
PySimGeneralDebugging_PACKAGE := self/src/SimGeneral/Debugging/python
ALL_PRODS += PySimGeneralDebugging
PySimGeneralDebugging_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralDebugging,src/SimGeneral/Debugging/python,src_SimGeneral_Debugging_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralDebugging,src/SimGeneral/Debugging/python))
endif
ALL_COMMONRULES += src_SimGeneral_Debugging_python
src_SimGeneral_Debugging_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_Debugging_python,src/SimGeneral/Debugging/python,PYTHON))
