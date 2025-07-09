ifeq ($(strip $(PySimG4CoreGFlash)),)
PySimG4CoreGFlash := self/src/SimG4Core/GFlash/python
src_SimG4Core_GFlash_python_parent := src/SimG4Core/GFlash
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/GFlash/python)
PySimG4CoreGFlash_files := $(patsubst src/SimG4Core/GFlash/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/GFlash/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CoreGFlash_LOC_USE := self   
PySimG4CoreGFlash_PACKAGE := self/src/SimG4Core/GFlash/python
ALL_PRODS += PySimG4CoreGFlash
PySimG4CoreGFlash_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CoreGFlash,src/SimG4Core/GFlash/python,src_SimG4Core_GFlash_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CoreGFlash,src/SimG4Core/GFlash/python))
endif
ALL_COMMONRULES += src_SimG4Core_GFlash_python
src_SimG4Core_GFlash_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_GFlash_python,src/SimG4Core/GFlash/python,PYTHON))
