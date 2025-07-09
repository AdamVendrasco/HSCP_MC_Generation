ifeq ($(strip $(PySimGeneralTrackingAnalysis)),)
PySimGeneralTrackingAnalysis := self/src/SimGeneral/TrackingAnalysis/python
src_SimGeneral_TrackingAnalysis_python_parent := src/SimGeneral/TrackingAnalysis
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/TrackingAnalysis/python)
PySimGeneralTrackingAnalysis_files := $(patsubst src/SimGeneral/TrackingAnalysis/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/TrackingAnalysis/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralTrackingAnalysis_LOC_USE := self   
PySimGeneralTrackingAnalysis_PACKAGE := self/src/SimGeneral/TrackingAnalysis/python
ALL_PRODS += PySimGeneralTrackingAnalysis
PySimGeneralTrackingAnalysis_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralTrackingAnalysis,src/SimGeneral/TrackingAnalysis/python,src_SimGeneral_TrackingAnalysis_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralTrackingAnalysis,src/SimGeneral/TrackingAnalysis/python))
endif
ALL_COMMONRULES += src_SimGeneral_TrackingAnalysis_python
src_SimGeneral_TrackingAnalysis_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_TrackingAnalysis_python,src/SimGeneral/TrackingAnalysis/python,PYTHON))
