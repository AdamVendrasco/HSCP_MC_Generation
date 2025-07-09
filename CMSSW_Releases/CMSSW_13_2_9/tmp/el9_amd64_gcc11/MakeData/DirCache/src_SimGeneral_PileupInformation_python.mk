ifeq ($(strip $(PySimGeneralPileupInformation)),)
PySimGeneralPileupInformation := self/src/SimGeneral/PileupInformation/python
src_SimGeneral_PileupInformation_python_parent := src/SimGeneral/PileupInformation
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/PileupInformation/python)
PySimGeneralPileupInformation_files := $(patsubst src/SimGeneral/PileupInformation/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/PileupInformation/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralPileupInformation_LOC_USE := self   
PySimGeneralPileupInformation_PACKAGE := self/src/SimGeneral/PileupInformation/python
ALL_PRODS += PySimGeneralPileupInformation
PySimGeneralPileupInformation_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralPileupInformation,src/SimGeneral/PileupInformation/python,src_SimGeneral_PileupInformation_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralPileupInformation,src/SimGeneral/PileupInformation/python))
endif
ALL_COMMONRULES += src_SimGeneral_PileupInformation_python
src_SimGeneral_PileupInformation_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PileupInformation_python,src/SimGeneral/PileupInformation/python,PYTHON))
