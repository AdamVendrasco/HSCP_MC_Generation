ifeq ($(strip $(PySimG4CorePhysicsLists)),)
PySimG4CorePhysicsLists := self/src/SimG4Core/PhysicsLists/python
src_SimG4Core_PhysicsLists_python_parent := src/SimG4Core/PhysicsLists
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/PhysicsLists/python)
PySimG4CorePhysicsLists_files := $(patsubst src/SimG4Core/PhysicsLists/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/PhysicsLists/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CorePhysicsLists_LOC_USE := self   
PySimG4CorePhysicsLists_PACKAGE := self/src/SimG4Core/PhysicsLists/python
ALL_PRODS += PySimG4CorePhysicsLists
PySimG4CorePhysicsLists_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CorePhysicsLists,src/SimG4Core/PhysicsLists/python,src_SimG4Core_PhysicsLists_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CorePhysicsLists,src/SimG4Core/PhysicsLists/python))
endif
ALL_COMMONRULES += src_SimG4Core_PhysicsLists_python
src_SimG4Core_PhysicsLists_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_PhysicsLists_python,src/SimG4Core/PhysicsLists/python,PYTHON))
