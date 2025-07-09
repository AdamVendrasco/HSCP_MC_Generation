ifeq ($(strip $(PySimG4CoreHelpfulWatchers)),)
PySimG4CoreHelpfulWatchers := self/src/SimG4Core/HelpfulWatchers/python
src_SimG4Core_HelpfulWatchers_python_parent := src/SimG4Core/HelpfulWatchers
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/HelpfulWatchers/python)
PySimG4CoreHelpfulWatchers_files := $(patsubst src/SimG4Core/HelpfulWatchers/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/HelpfulWatchers/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CoreHelpfulWatchers_LOC_USE := self   
PySimG4CoreHelpfulWatchers_PACKAGE := self/src/SimG4Core/HelpfulWatchers/python
ALL_PRODS += PySimG4CoreHelpfulWatchers
PySimG4CoreHelpfulWatchers_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CoreHelpfulWatchers,src/SimG4Core/HelpfulWatchers/python,src_SimG4Core_HelpfulWatchers_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CoreHelpfulWatchers,src/SimG4Core/HelpfulWatchers/python))
endif
ALL_COMMONRULES += src_SimG4Core_HelpfulWatchers_python
src_SimG4Core_HelpfulWatchers_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_HelpfulWatchers_python,src/SimG4Core/HelpfulWatchers/python,PYTHON))
