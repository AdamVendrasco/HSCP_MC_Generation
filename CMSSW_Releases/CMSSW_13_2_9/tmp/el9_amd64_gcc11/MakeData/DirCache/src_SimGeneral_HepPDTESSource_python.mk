ifeq ($(strip $(PySimGeneralHepPDTESSource)),)
PySimGeneralHepPDTESSource := self/src/SimGeneral/HepPDTESSource/python
src_SimGeneral_HepPDTESSource_python_parent := src/SimGeneral/HepPDTESSource
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/HepPDTESSource/python)
PySimGeneralHepPDTESSource_files := $(patsubst src/SimGeneral/HepPDTESSource/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/HepPDTESSource/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralHepPDTESSource_LOC_USE := self   
PySimGeneralHepPDTESSource_PACKAGE := self/src/SimGeneral/HepPDTESSource/python
ALL_PRODS += PySimGeneralHepPDTESSource
PySimGeneralHepPDTESSource_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralHepPDTESSource,src/SimGeneral/HepPDTESSource/python,src_SimGeneral_HepPDTESSource_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralHepPDTESSource,src/SimGeneral/HepPDTESSource/python))
endif
ALL_COMMONRULES += src_SimGeneral_HepPDTESSource_python
src_SimGeneral_HepPDTESSource_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTESSource_python,src/SimGeneral/HepPDTESSource/python,PYTHON))
