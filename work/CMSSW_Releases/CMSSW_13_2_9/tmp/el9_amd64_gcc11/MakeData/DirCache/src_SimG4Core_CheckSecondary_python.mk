ifeq ($(strip $(PySimG4CoreCheckSecondary)),)
PySimG4CoreCheckSecondary := self/src/SimG4Core/CheckSecondary/python
src_SimG4Core_CheckSecondary_python_parent := src/SimG4Core/CheckSecondary
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/CheckSecondary/python)
PySimG4CoreCheckSecondary_files := $(patsubst src/SimG4Core/CheckSecondary/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/CheckSecondary/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CoreCheckSecondary_LOC_USE := self   
PySimG4CoreCheckSecondary_PACKAGE := self/src/SimG4Core/CheckSecondary/python
ALL_PRODS += PySimG4CoreCheckSecondary
PySimG4CoreCheckSecondary_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CoreCheckSecondary,src/SimG4Core/CheckSecondary/python,src_SimG4Core_CheckSecondary_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CoreCheckSecondary,src/SimG4Core/CheckSecondary/python))
endif
ALL_COMMONRULES += src_SimG4Core_CheckSecondary_python
src_SimG4Core_CheckSecondary_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_CheckSecondary_python,src/SimG4Core/CheckSecondary/python,PYTHON))
