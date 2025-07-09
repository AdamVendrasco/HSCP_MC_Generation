ifeq ($(strip $(PySimG4CorePrintGeomInfo)),)
PySimG4CorePrintGeomInfo := self/src/SimG4Core/PrintGeomInfo/python
src_SimG4Core_PrintGeomInfo_python_parent := src/SimG4Core/PrintGeomInfo
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/PrintGeomInfo/python)
PySimG4CorePrintGeomInfo_files := $(patsubst src/SimG4Core/PrintGeomInfo/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/PrintGeomInfo/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CorePrintGeomInfo_LOC_USE := self   
PySimG4CorePrintGeomInfo_PACKAGE := self/src/SimG4Core/PrintGeomInfo/python
ALL_PRODS += PySimG4CorePrintGeomInfo
PySimG4CorePrintGeomInfo_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CorePrintGeomInfo,src/SimG4Core/PrintGeomInfo/python,src_SimG4Core_PrintGeomInfo_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CorePrintGeomInfo,src/SimG4Core/PrintGeomInfo/python))
endif
ALL_COMMONRULES += src_SimG4Core_PrintGeomInfo_python
src_SimG4Core_PrintGeomInfo_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_PrintGeomInfo_python,src/SimG4Core/PrintGeomInfo/python,PYTHON))
