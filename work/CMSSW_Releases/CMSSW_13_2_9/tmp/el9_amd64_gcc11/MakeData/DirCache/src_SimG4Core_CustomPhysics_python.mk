ifeq ($(strip $(PySimG4CoreCustomPhysics)),)
PySimG4CoreCustomPhysics := self/src/SimG4Core/CustomPhysics/python
src_SimG4Core_CustomPhysics_python_parent := src/SimG4Core/CustomPhysics
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/CustomPhysics/python)
PySimG4CoreCustomPhysics_files := $(patsubst src/SimG4Core/CustomPhysics/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/CustomPhysics/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CoreCustomPhysics_LOC_USE := self   
PySimG4CoreCustomPhysics_PACKAGE := self/src/SimG4Core/CustomPhysics/python
ALL_PRODS += PySimG4CoreCustomPhysics
PySimG4CoreCustomPhysics_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CoreCustomPhysics,src/SimG4Core/CustomPhysics/python,src_SimG4Core_CustomPhysics_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CoreCustomPhysics,src/SimG4Core/CustomPhysics/python))
endif
ALL_COMMONRULES += src_SimG4Core_CustomPhysics_python
src_SimG4Core_CustomPhysics_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_CustomPhysics_python,src/SimG4Core/CustomPhysics/python,PYTHON))
