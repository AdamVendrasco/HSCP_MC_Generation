ALL_SUBSYSTEMS+=SimG4Core
subdirs_src_SimG4Core = src_SimG4Core_Application src_SimG4Core_CheckSecondary src_SimG4Core_Configuration src_SimG4Core_CountProcesses src_SimG4Core_CustomPhysics src_SimG4Core_DD4hepGeometry src_SimG4Core_GFlash src_SimG4Core_Generators src_SimG4Core_Geometry src_SimG4Core_GeometryProducer src_SimG4Core_HelpfulWatchers src_SimG4Core_KillSecondaries src_SimG4Core_MagneticField src_SimG4Core_Notification src_SimG4Core_Physics src_SimG4Core_PhysicsLists src_SimG4Core_PrintGeomInfo src_SimG4Core_PrintTrackNumber src_SimG4Core_SaveSimTrackAction src_SimG4Core_SensitiveDetector src_SimG4Core_TrackingVerbose src_SimG4Core_Watcher src_SimG4Core_SimG4Core
subdirs_src += src_SimG4Core
ALL_PACKAGES += SimG4Core/Application
subdirs_src_SimG4Core_Application := src_SimG4Core_Application_plugins src_SimG4Core_Application_python src_SimG4Core_Application_src src_SimG4Core_Application_test
ifeq ($(strip $(PySimG4CoreApplication)),)
PySimG4CoreApplication := self/src/SimG4Core/Application/python
src_SimG4Core_Application_python_parent := src/SimG4Core/Application
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/Application/python)
PySimG4CoreApplication_files := $(patsubst src/SimG4Core/Application/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/Application/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CoreApplication_LOC_USE := self   
PySimG4CoreApplication_PACKAGE := self/src/SimG4Core/Application/python
ALL_PRODS += PySimG4CoreApplication
PySimG4CoreApplication_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CoreApplication,src/SimG4Core/Application/python,src_SimG4Core_Application_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CoreApplication,src/SimG4Core/Application/python))
endif
ALL_COMMONRULES += src_SimG4Core_Application_python
src_SimG4Core_Application_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Application_python,src/SimG4Core/Application/python,PYTHON))
ALL_PACKAGES += SimG4Core/CheckSecondary
subdirs_src_SimG4Core_CheckSecondary := src_SimG4Core_CheckSecondary_python src_SimG4Core_CheckSecondary_src src_SimG4Core_CheckSecondary_test
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
ALL_PACKAGES += SimG4Core/Configuration
subdirs_src_SimG4Core_Configuration := src_SimG4Core_Configuration_python src_SimG4Core_Configuration_test
ifeq ($(strip $(PySimG4CoreConfiguration)),)
PySimG4CoreConfiguration := self/src/SimG4Core/Configuration/python
src_SimG4Core_Configuration_python_parent := src/SimG4Core/Configuration
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimG4Core/Configuration/python)
PySimG4CoreConfiguration_files := $(patsubst src/SimG4Core/Configuration/python/%,%,$(wildcard $(foreach dir,src/SimG4Core/Configuration/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimG4CoreConfiguration_LOC_USE := self   
PySimG4CoreConfiguration_PACKAGE := self/src/SimG4Core/Configuration/python
ALL_PRODS += PySimG4CoreConfiguration
PySimG4CoreConfiguration_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimG4CoreConfiguration,src/SimG4Core/Configuration/python,src_SimG4Core_Configuration_python))
else
$(eval $(call MultipleWarningMsg,PySimG4CoreConfiguration,src/SimG4Core/Configuration/python))
endif
ALL_COMMONRULES += src_SimG4Core_Configuration_python
src_SimG4Core_Configuration_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Configuration_python,src/SimG4Core/Configuration/python,PYTHON))
ALL_PACKAGES += SimG4Core/CountProcesses
subdirs_src_SimG4Core_CountProcesses := src_SimG4Core_CountProcesses_src
ALL_PACKAGES += SimG4Core/CustomPhysics
subdirs_src_SimG4Core_CustomPhysics := src_SimG4Core_CustomPhysics_plugins src_SimG4Core_CustomPhysics_python src_SimG4Core_CustomPhysics_src src_SimG4Core_CustomPhysics_test
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
ALL_PACKAGES += SimG4Core/DD4hepGeometry
subdirs_src_SimG4Core_DD4hepGeometry := src_SimG4Core_DD4hepGeometry_src src_SimG4Core_DD4hepGeometry_test
ALL_PACKAGES += SimG4Core/GFlash
subdirs_src_SimG4Core_GFlash := src_SimG4Core_GFlash_plugins src_SimG4Core_GFlash_python src_SimG4Core_GFlash_src src_SimG4Core_GFlash_test
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
ALL_PACKAGES += SimG4Core/Generators
subdirs_src_SimG4Core_Generators := src_SimG4Core_Generators_src
ALL_PACKAGES += SimG4Core/Geometry
subdirs_src_SimG4Core_Geometry := src_SimG4Core_Geometry_src src_SimG4Core_Geometry_test
ALL_PACKAGES += SimG4Core/GeometryProducer
subdirs_src_SimG4Core_GeometryProducer := src_SimG4Core_GeometryProducer_src
ALL_PACKAGES += SimG4Core/HelpfulWatchers
subdirs_src_SimG4Core_HelpfulWatchers := src_SimG4Core_HelpfulWatchers_python src_SimG4Core_HelpfulWatchers_src
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
ALL_PACKAGES += SimG4Core/KillSecondaries
subdirs_src_SimG4Core_KillSecondaries := src_SimG4Core_KillSecondaries_src
ALL_PACKAGES += SimG4Core/MagneticField
subdirs_src_SimG4Core_MagneticField := src_SimG4Core_MagneticField_src src_SimG4Core_MagneticField_test
ALL_PACKAGES += SimG4Core/Notification
subdirs_src_SimG4Core_Notification := src_SimG4Core_Notification_src src_SimG4Core_Notification_test
ALL_PACKAGES += SimG4Core/Physics
subdirs_src_SimG4Core_Physics := src_SimG4Core_Physics_src
ALL_PACKAGES += SimG4Core/PhysicsLists
subdirs_src_SimG4Core_PhysicsLists := src_SimG4Core_PhysicsLists_plugins src_SimG4Core_PhysicsLists_python src_SimG4Core_PhysicsLists_src src_SimG4Core_PhysicsLists_test
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
ALL_PACKAGES += SimG4Core/PrintGeomInfo
subdirs_src_SimG4Core_PrintGeomInfo := src_SimG4Core_PrintGeomInfo_plugins src_SimG4Core_PrintGeomInfo_python src_SimG4Core_PrintGeomInfo_test
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
ALL_PACKAGES += SimG4Core/PrintTrackNumber
subdirs_src_SimG4Core_PrintTrackNumber := src_SimG4Core_PrintTrackNumber_src
ALL_PACKAGES += SimG4Core/SaveSimTrackAction
subdirs_src_SimG4Core_SaveSimTrackAction := src_SimG4Core_SaveSimTrackAction_src
ALL_PACKAGES += SimG4Core/SensitiveDetector
subdirs_src_SimG4Core_SensitiveDetector := src_SimG4Core_SensitiveDetector_src
ALL_PACKAGES += SimG4Core/TrackingVerbose
subdirs_src_SimG4Core_TrackingVerbose := src_SimG4Core_TrackingVerbose_src
ALL_PACKAGES += SimG4Core/Watcher
subdirs_src_SimG4Core_Watcher := src_SimG4Core_Watcher_src src_SimG4Core_Watcher_test
ALL_PACKAGES += SimG4Core/SimG4Core
subdirs_src_SimG4Core_SimG4Core := 
ALL_SUBSYSTEMS+=GeneratorInterface
subdirs_src_GeneratorInterface = src_GeneratorInterface_Core src_GeneratorInterface_ExternalDecays src_GeneratorInterface_LHEInterface src_GeneratorInterface_PartonShowerVeto src_GeneratorInterface_Pythia8Interface src_GeneratorInterface_RivetInterface src_GeneratorInterface_AMPTInterface src_GeneratorInterface_AlpgenInterface src_GeneratorInterface_BeamHaloGenerator src_GeneratorInterface_Configuration src_GeneratorInterface_CosmicMuonGenerator src_GeneratorInterface_EvtGenInterface src_GeneratorInterface_ExhumeInterface src_GeneratorInterface_GenExtensions src_GeneratorInterface_GenFilters src_GeneratorInterface_Herwig7Interface src_GeneratorInterface_HiGenCommon src_GeneratorInterface_HijingInterface src_GeneratorInterface_Hydjet2Interface src_GeneratorInterface_HydjetInterface src_GeneratorInterface_PhotosInterface src_GeneratorInterface_PyquenInterface src_GeneratorInterface_Pythia6Interface src_GeneratorInterface_ReggeGribovPartonMCInterface src_GeneratorInterface_SherpaInterface src_GeneratorInterface_TauolaInterface
subdirs_src += src_GeneratorInterface
ALL_PACKAGES += GeneratorInterface/Core
subdirs_src_GeneratorInterface_Core := src_GeneratorInterface_Core_bin src_GeneratorInterface_Core_plugins src_GeneratorInterface_Core_python src_GeneratorInterface_Core_src src_GeneratorInterface_Core_test
ifeq ($(strip $(PyGeneratorInterfaceCore)),)
PyGeneratorInterfaceCore := self/src/GeneratorInterface/Core/python
src_GeneratorInterface_Core_python_parent := src/GeneratorInterface/Core
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Core/python)
PyGeneratorInterfaceCore_files := $(patsubst src/GeneratorInterface/Core/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Core/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceCore_LOC_USE := self   
PyGeneratorInterfaceCore_PACKAGE := self/src/GeneratorInterface/Core/python
ALL_PRODS += PyGeneratorInterfaceCore
PyGeneratorInterfaceCore_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceCore,src/GeneratorInterface/Core/python,src_GeneratorInterface_Core_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceCore,src/GeneratorInterface/Core/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Core_python
src_GeneratorInterface_Core_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_python,src/GeneratorInterface/Core/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/ExternalDecays
subdirs_src_GeneratorInterface_ExternalDecays := src_GeneratorInterface_ExternalDecays_python src_GeneratorInterface_ExternalDecays_src src_GeneratorInterface_ExternalDecays_test
ifeq ($(strip $(PyGeneratorInterfaceExternalDecays)),)
PyGeneratorInterfaceExternalDecays := self/src/GeneratorInterface/ExternalDecays/python
src_GeneratorInterface_ExternalDecays_python_parent := src/GeneratorInterface/ExternalDecays
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/ExternalDecays/python)
PyGeneratorInterfaceExternalDecays_files := $(patsubst src/GeneratorInterface/ExternalDecays/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ExternalDecays/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceExternalDecays_LOC_USE := self   
PyGeneratorInterfaceExternalDecays_PACKAGE := self/src/GeneratorInterface/ExternalDecays/python
ALL_PRODS += PyGeneratorInterfaceExternalDecays
PyGeneratorInterfaceExternalDecays_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceExternalDecays,src/GeneratorInterface/ExternalDecays/python,src_GeneratorInterface_ExternalDecays_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceExternalDecays,src/GeneratorInterface/ExternalDecays/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExternalDecays_python
src_GeneratorInterface_ExternalDecays_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExternalDecays_python,src/GeneratorInterface/ExternalDecays/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/LHEInterface
subdirs_src_GeneratorInterface_LHEInterface := src_GeneratorInterface_LHEInterface_plugins src_GeneratorInterface_LHEInterface_python src_GeneratorInterface_LHEInterface_scripts src_GeneratorInterface_LHEInterface_src src_GeneratorInterface_LHEInterface_test
ifeq ($(strip $(PyGeneratorInterfaceLHEInterface)),)
PyGeneratorInterfaceLHEInterface := self/src/GeneratorInterface/LHEInterface/python
src_GeneratorInterface_LHEInterface_python_parent := src/GeneratorInterface/LHEInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/LHEInterface/python)
PyGeneratorInterfaceLHEInterface_files := $(patsubst src/GeneratorInterface/LHEInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/LHEInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceLHEInterface_LOC_USE := self   
PyGeneratorInterfaceLHEInterface_PACKAGE := self/src/GeneratorInterface/LHEInterface/python
ALL_PRODS += PyGeneratorInterfaceLHEInterface
PyGeneratorInterfaceLHEInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceLHEInterface,src/GeneratorInterface/LHEInterface/python,src_GeneratorInterface_LHEInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceLHEInterface,src/GeneratorInterface/LHEInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_LHEInterface_python
src_GeneratorInterface_LHEInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_LHEInterface_python,src/GeneratorInterface/LHEInterface/python,PYTHON))
src_GeneratorInterface_LHEInterface_scripts_files := $(filter-out \#% %\#,$(notdir $(wildcard $(foreach dir,$(LOCALTOP)/src/GeneratorInterface/LHEInterface/scripts,$(dir)/*))))
$(eval $(call Src2StoreCopy,src_GeneratorInterface_LHEInterface_scripts,src/GeneratorInterface/LHEInterface/scripts,$(SCRAMSTORENAME_BIN),*))
ALL_PACKAGES += GeneratorInterface/PartonShowerVeto
subdirs_src_GeneratorInterface_PartonShowerVeto := src_GeneratorInterface_PartonShowerVeto_src src_GeneratorInterface_PartonShowerVeto_test
ALL_PACKAGES += GeneratorInterface/Pythia8Interface
subdirs_src_GeneratorInterface_Pythia8Interface := src_GeneratorInterface_Pythia8Interface_plugins src_GeneratorInterface_Pythia8Interface_python src_GeneratorInterface_Pythia8Interface_src src_GeneratorInterface_Pythia8Interface_test
ifeq ($(strip $(PyGeneratorInterfacePythia8Interface)),)
PyGeneratorInterfacePythia8Interface := self/src/GeneratorInterface/Pythia8Interface/python
src_GeneratorInterface_Pythia8Interface_python_parent := src/GeneratorInterface/Pythia8Interface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Pythia8Interface/python)
PyGeneratorInterfacePythia8Interface_files := $(patsubst src/GeneratorInterface/Pythia8Interface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Pythia8Interface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfacePythia8Interface_LOC_USE := self   
PyGeneratorInterfacePythia8Interface_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/python
ALL_PRODS += PyGeneratorInterfacePythia8Interface
PyGeneratorInterfacePythia8Interface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfacePythia8Interface,src/GeneratorInterface/Pythia8Interface/python,src_GeneratorInterface_Pythia8Interface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfacePythia8Interface,src/GeneratorInterface/Pythia8Interface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia8Interface_python
src_GeneratorInterface_Pythia8Interface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia8Interface_python,src/GeneratorInterface/Pythia8Interface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/RivetInterface
subdirs_src_GeneratorInterface_RivetInterface := src_GeneratorInterface_RivetInterface_plugins src_GeneratorInterface_RivetInterface_python src_GeneratorInterface_RivetInterface_src src_GeneratorInterface_RivetInterface_test
ifeq ($(strip $(PyGeneratorInterfaceRivetInterface)),)
PyGeneratorInterfaceRivetInterface := self/src/GeneratorInterface/RivetInterface/python
src_GeneratorInterface_RivetInterface_python_parent := src/GeneratorInterface/RivetInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/RivetInterface/python)
PyGeneratorInterfaceRivetInterface_files := $(patsubst src/GeneratorInterface/RivetInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/RivetInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceRivetInterface_LOC_USE := self   
PyGeneratorInterfaceRivetInterface_PACKAGE := self/src/GeneratorInterface/RivetInterface/python
ALL_PRODS += PyGeneratorInterfaceRivetInterface
PyGeneratorInterfaceRivetInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/python,src_GeneratorInterface_RivetInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceRivetInterface,src/GeneratorInterface/RivetInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_python
src_GeneratorInterface_RivetInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_python,src/GeneratorInterface/RivetInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/AMPTInterface
subdirs_src_GeneratorInterface_AMPTInterface := src_GeneratorInterface_AMPTInterface_plugins src_GeneratorInterface_AMPTInterface_python src_GeneratorInterface_AMPTInterface_src src_GeneratorInterface_AMPTInterface_test
ifeq ($(strip $(PyGeneratorInterfaceAMPTInterface)),)
PyGeneratorInterfaceAMPTInterface := self/src/GeneratorInterface/AMPTInterface/python
src_GeneratorInterface_AMPTInterface_python_parent := src/GeneratorInterface/AMPTInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/AMPTInterface/python)
PyGeneratorInterfaceAMPTInterface_files := $(patsubst src/GeneratorInterface/AMPTInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/AMPTInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceAMPTInterface_LOC_USE := self   
PyGeneratorInterfaceAMPTInterface_PACKAGE := self/src/GeneratorInterface/AMPTInterface/python
ALL_PRODS += PyGeneratorInterfaceAMPTInterface
PyGeneratorInterfaceAMPTInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceAMPTInterface,src/GeneratorInterface/AMPTInterface/python,src_GeneratorInterface_AMPTInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceAMPTInterface,src/GeneratorInterface/AMPTInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_AMPTInterface_python
src_GeneratorInterface_AMPTInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AMPTInterface_python,src/GeneratorInterface/AMPTInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/AlpgenInterface
subdirs_src_GeneratorInterface_AlpgenInterface := src_GeneratorInterface_AlpgenInterface_plugins src_GeneratorInterface_AlpgenInterface_python src_GeneratorInterface_AlpgenInterface_src src_GeneratorInterface_AlpgenInterface_test
ifeq ($(strip $(PyGeneratorInterfaceAlpgenInterface)),)
PyGeneratorInterfaceAlpgenInterface := self/src/GeneratorInterface/AlpgenInterface/python
src_GeneratorInterface_AlpgenInterface_python_parent := src/GeneratorInterface/AlpgenInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/AlpgenInterface/python)
PyGeneratorInterfaceAlpgenInterface_files := $(patsubst src/GeneratorInterface/AlpgenInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/AlpgenInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceAlpgenInterface_LOC_USE := self   
PyGeneratorInterfaceAlpgenInterface_PACKAGE := self/src/GeneratorInterface/AlpgenInterface/python
ALL_PRODS += PyGeneratorInterfaceAlpgenInterface
PyGeneratorInterfaceAlpgenInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceAlpgenInterface,src/GeneratorInterface/AlpgenInterface/python,src_GeneratorInterface_AlpgenInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceAlpgenInterface,src/GeneratorInterface/AlpgenInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_AlpgenInterface_python
src_GeneratorInterface_AlpgenInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AlpgenInterface_python,src/GeneratorInterface/AlpgenInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/BeamHaloGenerator
subdirs_src_GeneratorInterface_BeamHaloGenerator := src_GeneratorInterface_BeamHaloGenerator_src src_GeneratorInterface_BeamHaloGenerator_test
ALL_PACKAGES += GeneratorInterface/Configuration
subdirs_src_GeneratorInterface_Configuration := src_GeneratorInterface_Configuration_python
ifeq ($(strip $(PyGeneratorInterfaceConfiguration)),)
PyGeneratorInterfaceConfiguration := self/src/GeneratorInterface/Configuration/python
src_GeneratorInterface_Configuration_python_parent := src/GeneratorInterface/Configuration
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Configuration/python)
PyGeneratorInterfaceConfiguration_files := $(patsubst src/GeneratorInterface/Configuration/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Configuration/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceConfiguration_LOC_USE := self   
PyGeneratorInterfaceConfiguration_PACKAGE := self/src/GeneratorInterface/Configuration/python
ALL_PRODS += PyGeneratorInterfaceConfiguration
PyGeneratorInterfaceConfiguration_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceConfiguration,src/GeneratorInterface/Configuration/python,src_GeneratorInterface_Configuration_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceConfiguration,src/GeneratorInterface/Configuration/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Configuration_python
src_GeneratorInterface_Configuration_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Configuration_python,src/GeneratorInterface/Configuration/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/CosmicMuonGenerator
subdirs_src_GeneratorInterface_CosmicMuonGenerator := src_GeneratorInterface_CosmicMuonGenerator_python src_GeneratorInterface_CosmicMuonGenerator_src src_GeneratorInterface_CosmicMuonGenerator_test
ifeq ($(strip $(PyGeneratorInterfaceCosmicMuonGenerator)),)
PyGeneratorInterfaceCosmicMuonGenerator := self/src/GeneratorInterface/CosmicMuonGenerator/python
src_GeneratorInterface_CosmicMuonGenerator_python_parent := src/GeneratorInterface/CosmicMuonGenerator
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/CosmicMuonGenerator/python)
PyGeneratorInterfaceCosmicMuonGenerator_files := $(patsubst src/GeneratorInterface/CosmicMuonGenerator/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/CosmicMuonGenerator/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceCosmicMuonGenerator_LOC_USE := self   
PyGeneratorInterfaceCosmicMuonGenerator_PACKAGE := self/src/GeneratorInterface/CosmicMuonGenerator/python
ALL_PRODS += PyGeneratorInterfaceCosmicMuonGenerator
PyGeneratorInterfaceCosmicMuonGenerator_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceCosmicMuonGenerator,src/GeneratorInterface/CosmicMuonGenerator/python,src_GeneratorInterface_CosmicMuonGenerator_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceCosmicMuonGenerator,src/GeneratorInterface/CosmicMuonGenerator/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_CosmicMuonGenerator_python
src_GeneratorInterface_CosmicMuonGenerator_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_CosmicMuonGenerator_python,src/GeneratorInterface/CosmicMuonGenerator/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/EvtGenInterface
subdirs_src_GeneratorInterface_EvtGenInterface := src_GeneratorInterface_EvtGenInterface_plugins src_GeneratorInterface_EvtGenInterface_python src_GeneratorInterface_EvtGenInterface_src src_GeneratorInterface_EvtGenInterface_test
ifeq ($(strip $(PyGeneratorInterfaceEvtGenInterface)),)
PyGeneratorInterfaceEvtGenInterface := self/src/GeneratorInterface/EvtGenInterface/python
src_GeneratorInterface_EvtGenInterface_python_parent := src/GeneratorInterface/EvtGenInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/EvtGenInterface/python)
PyGeneratorInterfaceEvtGenInterface_files := $(patsubst src/GeneratorInterface/EvtGenInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/EvtGenInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceEvtGenInterface_LOC_USE := self   
PyGeneratorInterfaceEvtGenInterface_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/python
ALL_PRODS += PyGeneratorInterfaceEvtGenInterface
PyGeneratorInterfaceEvtGenInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceEvtGenInterface,src/GeneratorInterface/EvtGenInterface/python,src_GeneratorInterface_EvtGenInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceEvtGenInterface,src/GeneratorInterface/EvtGenInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_EvtGenInterface_python
src_GeneratorInterface_EvtGenInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_EvtGenInterface_python,src/GeneratorInterface/EvtGenInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/ExhumeInterface
subdirs_src_GeneratorInterface_ExhumeInterface := src_GeneratorInterface_ExhumeInterface_plugins src_GeneratorInterface_ExhumeInterface_python src_GeneratorInterface_ExhumeInterface_src src_GeneratorInterface_ExhumeInterface_test
ifeq ($(strip $(PyGeneratorInterfaceExhumeInterface)),)
PyGeneratorInterfaceExhumeInterface := self/src/GeneratorInterface/ExhumeInterface/python
src_GeneratorInterface_ExhumeInterface_python_parent := src/GeneratorInterface/ExhumeInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/ExhumeInterface/python)
PyGeneratorInterfaceExhumeInterface_files := $(patsubst src/GeneratorInterface/ExhumeInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ExhumeInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceExhumeInterface_LOC_USE := self   
PyGeneratorInterfaceExhumeInterface_PACKAGE := self/src/GeneratorInterface/ExhumeInterface/python
ALL_PRODS += PyGeneratorInterfaceExhumeInterface
PyGeneratorInterfaceExhumeInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceExhumeInterface,src/GeneratorInterface/ExhumeInterface/python,src_GeneratorInterface_ExhumeInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceExhumeInterface,src/GeneratorInterface/ExhumeInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExhumeInterface_python
src_GeneratorInterface_ExhumeInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExhumeInterface_python,src/GeneratorInterface/ExhumeInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/GenExtensions
subdirs_src_GeneratorInterface_GenExtensions := src_GeneratorInterface_GenExtensions_bin src_GeneratorInterface_GenExtensions_test
ALL_PACKAGES += GeneratorInterface/GenFilters
subdirs_src_GeneratorInterface_GenFilters := src_GeneratorInterface_GenFilters_plugins src_GeneratorInterface_GenFilters_python src_GeneratorInterface_GenFilters_test
ifeq ($(strip $(PyGeneratorInterfaceGenFilters)),)
PyGeneratorInterfaceGenFilters := self/src/GeneratorInterface/GenFilters/python
src_GeneratorInterface_GenFilters_python_parent := src/GeneratorInterface/GenFilters
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/GenFilters/python)
PyGeneratorInterfaceGenFilters_files := $(patsubst src/GeneratorInterface/GenFilters/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/GenFilters/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceGenFilters_LOC_USE := self   
PyGeneratorInterfaceGenFilters_PACKAGE := self/src/GeneratorInterface/GenFilters/python
ALL_PRODS += PyGeneratorInterfaceGenFilters
PyGeneratorInterfaceGenFilters_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceGenFilters,src/GeneratorInterface/GenFilters/python,src_GeneratorInterface_GenFilters_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceGenFilters,src/GeneratorInterface/GenFilters/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_GenFilters_python
src_GeneratorInterface_GenFilters_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_GenFilters_python,src/GeneratorInterface/GenFilters/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/Herwig7Interface
subdirs_src_GeneratorInterface_Herwig7Interface := src_GeneratorInterface_Herwig7Interface_plugins src_GeneratorInterface_Herwig7Interface_python src_GeneratorInterface_Herwig7Interface_scripts src_GeneratorInterface_Herwig7Interface_src src_GeneratorInterface_Herwig7Interface_test
ifeq ($(strip $(PyGeneratorInterfaceHerwig7Interface)),)
PyGeneratorInterfaceHerwig7Interface := self/src/GeneratorInterface/Herwig7Interface/python
src_GeneratorInterface_Herwig7Interface_python_parent := src/GeneratorInterface/Herwig7Interface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Herwig7Interface/python)
PyGeneratorInterfaceHerwig7Interface_files := $(patsubst src/GeneratorInterface/Herwig7Interface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Herwig7Interface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceHerwig7Interface_LOC_USE := self   
PyGeneratorInterfaceHerwig7Interface_PACKAGE := self/src/GeneratorInterface/Herwig7Interface/python
ALL_PRODS += PyGeneratorInterfaceHerwig7Interface
PyGeneratorInterfaceHerwig7Interface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceHerwig7Interface,src/GeneratorInterface/Herwig7Interface/python,src_GeneratorInterface_Herwig7Interface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceHerwig7Interface,src/GeneratorInterface/Herwig7Interface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Herwig7Interface_python
src_GeneratorInterface_Herwig7Interface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Herwig7Interface_python,src/GeneratorInterface/Herwig7Interface/python,PYTHON))
src_GeneratorInterface_Herwig7Interface_scripts_files := $(filter-out \#% %\#,$(notdir $(wildcard $(foreach dir,$(LOCALTOP)/src/GeneratorInterface/Herwig7Interface/scripts,$(dir)/*))))
$(eval $(call Src2StoreCopy,src_GeneratorInterface_Herwig7Interface_scripts,src/GeneratorInterface/Herwig7Interface/scripts,$(SCRAMSTORENAME_BIN),*))
ALL_PACKAGES += GeneratorInterface/HiGenCommon
subdirs_src_GeneratorInterface_HiGenCommon := src_GeneratorInterface_HiGenCommon_plugins src_GeneratorInterface_HiGenCommon_python src_GeneratorInterface_HiGenCommon_src
ifeq ($(strip $(PyGeneratorInterfaceHiGenCommon)),)
PyGeneratorInterfaceHiGenCommon := self/src/GeneratorInterface/HiGenCommon/python
src_GeneratorInterface_HiGenCommon_python_parent := src/GeneratorInterface/HiGenCommon
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/HiGenCommon/python)
PyGeneratorInterfaceHiGenCommon_files := $(patsubst src/GeneratorInterface/HiGenCommon/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HiGenCommon/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceHiGenCommon_LOC_USE := self   
PyGeneratorInterfaceHiGenCommon_PACKAGE := self/src/GeneratorInterface/HiGenCommon/python
ALL_PRODS += PyGeneratorInterfaceHiGenCommon
PyGeneratorInterfaceHiGenCommon_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceHiGenCommon,src/GeneratorInterface/HiGenCommon/python,src_GeneratorInterface_HiGenCommon_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceHiGenCommon,src/GeneratorInterface/HiGenCommon/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_HiGenCommon_python
src_GeneratorInterface_HiGenCommon_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HiGenCommon_python,src/GeneratorInterface/HiGenCommon/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/HijingInterface
subdirs_src_GeneratorInterface_HijingInterface := src_GeneratorInterface_HijingInterface_plugins src_GeneratorInterface_HijingInterface_src src_GeneratorInterface_HijingInterface_test
ALL_PACKAGES += GeneratorInterface/Hydjet2Interface
subdirs_src_GeneratorInterface_Hydjet2Interface := src_GeneratorInterface_Hydjet2Interface_plugins src_GeneratorInterface_Hydjet2Interface_python src_GeneratorInterface_Hydjet2Interface_src src_GeneratorInterface_Hydjet2Interface_test
ifeq ($(strip $(PyGeneratorInterfaceHydjet2Interface)),)
PyGeneratorInterfaceHydjet2Interface := self/src/GeneratorInterface/Hydjet2Interface/python
src_GeneratorInterface_Hydjet2Interface_python_parent := src/GeneratorInterface/Hydjet2Interface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Hydjet2Interface/python)
PyGeneratorInterfaceHydjet2Interface_files := $(patsubst src/GeneratorInterface/Hydjet2Interface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Hydjet2Interface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceHydjet2Interface_LOC_USE := self   
PyGeneratorInterfaceHydjet2Interface_PACKAGE := self/src/GeneratorInterface/Hydjet2Interface/python
ALL_PRODS += PyGeneratorInterfaceHydjet2Interface
PyGeneratorInterfaceHydjet2Interface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceHydjet2Interface,src/GeneratorInterface/Hydjet2Interface/python,src_GeneratorInterface_Hydjet2Interface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceHydjet2Interface,src/GeneratorInterface/Hydjet2Interface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Hydjet2Interface_python
src_GeneratorInterface_Hydjet2Interface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Hydjet2Interface_python,src/GeneratorInterface/Hydjet2Interface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/HydjetInterface
subdirs_src_GeneratorInterface_HydjetInterface := src_GeneratorInterface_HydjetInterface_plugins src_GeneratorInterface_HydjetInterface_python src_GeneratorInterface_HydjetInterface_src src_GeneratorInterface_HydjetInterface_test
ifeq ($(strip $(PyGeneratorInterfaceHydjetInterface)),)
PyGeneratorInterfaceHydjetInterface := self/src/GeneratorInterface/HydjetInterface/python
src_GeneratorInterface_HydjetInterface_python_parent := src/GeneratorInterface/HydjetInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/HydjetInterface/python)
PyGeneratorInterfaceHydjetInterface_files := $(patsubst src/GeneratorInterface/HydjetInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/HydjetInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceHydjetInterface_LOC_USE := self   
PyGeneratorInterfaceHydjetInterface_PACKAGE := self/src/GeneratorInterface/HydjetInterface/python
ALL_PRODS += PyGeneratorInterfaceHydjetInterface
PyGeneratorInterfaceHydjetInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceHydjetInterface,src/GeneratorInterface/HydjetInterface/python,src_GeneratorInterface_HydjetInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceHydjetInterface,src/GeneratorInterface/HydjetInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_HydjetInterface_python
src_GeneratorInterface_HydjetInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HydjetInterface_python,src/GeneratorInterface/HydjetInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/PhotosInterface
subdirs_src_GeneratorInterface_PhotosInterface := src_GeneratorInterface_PhotosInterface_plugins src_GeneratorInterface_PhotosInterface_python src_GeneratorInterface_PhotosInterface_src src_GeneratorInterface_PhotosInterface_test
ifeq ($(strip $(PyGeneratorInterfacePhotosInterface)),)
PyGeneratorInterfacePhotosInterface := self/src/GeneratorInterface/PhotosInterface/python
src_GeneratorInterface_PhotosInterface_python_parent := src/GeneratorInterface/PhotosInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/PhotosInterface/python)
PyGeneratorInterfacePhotosInterface_files := $(patsubst src/GeneratorInterface/PhotosInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/PhotosInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfacePhotosInterface_LOC_USE := self   
PyGeneratorInterfacePhotosInterface_PACKAGE := self/src/GeneratorInterface/PhotosInterface/python
ALL_PRODS += PyGeneratorInterfacePhotosInterface
PyGeneratorInterfacePhotosInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfacePhotosInterface,src/GeneratorInterface/PhotosInterface/python,src_GeneratorInterface_PhotosInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfacePhotosInterface,src/GeneratorInterface/PhotosInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_PhotosInterface_python
src_GeneratorInterface_PhotosInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_PhotosInterface_python,src/GeneratorInterface/PhotosInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/PyquenInterface
subdirs_src_GeneratorInterface_PyquenInterface := src_GeneratorInterface_PyquenInterface_plugins src_GeneratorInterface_PyquenInterface_python src_GeneratorInterface_PyquenInterface_src src_GeneratorInterface_PyquenInterface_test
ifeq ($(strip $(PyGeneratorInterfacePyquenInterface)),)
PyGeneratorInterfacePyquenInterface := self/src/GeneratorInterface/PyquenInterface/python
src_GeneratorInterface_PyquenInterface_python_parent := src/GeneratorInterface/PyquenInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/PyquenInterface/python)
PyGeneratorInterfacePyquenInterface_files := $(patsubst src/GeneratorInterface/PyquenInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/PyquenInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfacePyquenInterface_LOC_USE := self   
PyGeneratorInterfacePyquenInterface_PACKAGE := self/src/GeneratorInterface/PyquenInterface/python
ALL_PRODS += PyGeneratorInterfacePyquenInterface
PyGeneratorInterfacePyquenInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfacePyquenInterface,src/GeneratorInterface/PyquenInterface/python,src_GeneratorInterface_PyquenInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfacePyquenInterface,src/GeneratorInterface/PyquenInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_PyquenInterface_python
src_GeneratorInterface_PyquenInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_PyquenInterface_python,src/GeneratorInterface/PyquenInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/Pythia6Interface
subdirs_src_GeneratorInterface_Pythia6Interface := src_GeneratorInterface_Pythia6Interface_plugins src_GeneratorInterface_Pythia6Interface_python src_GeneratorInterface_Pythia6Interface_src src_GeneratorInterface_Pythia6Interface_test
ifeq ($(strip $(PyGeneratorInterfacePythia6Interface)),)
PyGeneratorInterfacePythia6Interface := self/src/GeneratorInterface/Pythia6Interface/python
src_GeneratorInterface_Pythia6Interface_python_parent := src/GeneratorInterface/Pythia6Interface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/Pythia6Interface/python)
PyGeneratorInterfacePythia6Interface_files := $(patsubst src/GeneratorInterface/Pythia6Interface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/Pythia6Interface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfacePythia6Interface_LOC_USE := self   
PyGeneratorInterfacePythia6Interface_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/python
ALL_PRODS += PyGeneratorInterfacePythia6Interface
PyGeneratorInterfacePythia6Interface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfacePythia6Interface,src/GeneratorInterface/Pythia6Interface/python,src_GeneratorInterface_Pythia6Interface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfacePythia6Interface,src/GeneratorInterface/Pythia6Interface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia6Interface_python
src_GeneratorInterface_Pythia6Interface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia6Interface_python,src/GeneratorInterface/Pythia6Interface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/ReggeGribovPartonMCInterface
subdirs_src_GeneratorInterface_ReggeGribovPartonMCInterface := src_GeneratorInterface_ReggeGribovPartonMCInterface_plugins src_GeneratorInterface_ReggeGribovPartonMCInterface_python src_GeneratorInterface_ReggeGribovPartonMCInterface_src src_GeneratorInterface_ReggeGribovPartonMCInterface_test
ifeq ($(strip $(PyGeneratorInterfaceReggeGribovPartonMCInterface)),)
PyGeneratorInterfaceReggeGribovPartonMCInterface := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/python
src_GeneratorInterface_ReggeGribovPartonMCInterface_python_parent := src/GeneratorInterface/ReggeGribovPartonMCInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/ReggeGribovPartonMCInterface/python)
PyGeneratorInterfaceReggeGribovPartonMCInterface_files := $(patsubst src/GeneratorInterface/ReggeGribovPartonMCInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/ReggeGribovPartonMCInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceReggeGribovPartonMCInterface_LOC_USE := self   
PyGeneratorInterfaceReggeGribovPartonMCInterface_PACKAGE := self/src/GeneratorInterface/ReggeGribovPartonMCInterface/python
ALL_PRODS += PyGeneratorInterfaceReggeGribovPartonMCInterface
PyGeneratorInterfaceReggeGribovPartonMCInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceReggeGribovPartonMCInterface,src/GeneratorInterface/ReggeGribovPartonMCInterface/python,src_GeneratorInterface_ReggeGribovPartonMCInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceReggeGribovPartonMCInterface,src/GeneratorInterface/ReggeGribovPartonMCInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_ReggeGribovPartonMCInterface_python
src_GeneratorInterface_ReggeGribovPartonMCInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ReggeGribovPartonMCInterface_python,src/GeneratorInterface/ReggeGribovPartonMCInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/SherpaInterface
subdirs_src_GeneratorInterface_SherpaInterface := src_GeneratorInterface_SherpaInterface_python src_GeneratorInterface_SherpaInterface_src
ifeq ($(strip $(PyGeneratorInterfaceSherpaInterface)),)
PyGeneratorInterfaceSherpaInterface := self/src/GeneratorInterface/SherpaInterface/python
src_GeneratorInterface_SherpaInterface_python_parent := src/GeneratorInterface/SherpaInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/SherpaInterface/python)
PyGeneratorInterfaceSherpaInterface_files := $(patsubst src/GeneratorInterface/SherpaInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/SherpaInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceSherpaInterface_LOC_USE := self   
PyGeneratorInterfaceSherpaInterface_PACKAGE := self/src/GeneratorInterface/SherpaInterface/python
ALL_PRODS += PyGeneratorInterfaceSherpaInterface
PyGeneratorInterfaceSherpaInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceSherpaInterface,src/GeneratorInterface/SherpaInterface/python,src_GeneratorInterface_SherpaInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceSherpaInterface,src/GeneratorInterface/SherpaInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_SherpaInterface_python
src_GeneratorInterface_SherpaInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_SherpaInterface_python,src/GeneratorInterface/SherpaInterface/python,PYTHON))
ALL_PACKAGES += GeneratorInterface/TauolaInterface
subdirs_src_GeneratorInterface_TauolaInterface := src_GeneratorInterface_TauolaInterface_plugins src_GeneratorInterface_TauolaInterface_python src_GeneratorInterface_TauolaInterface_src src_GeneratorInterface_TauolaInterface_test
ifeq ($(strip $(PyGeneratorInterfaceTauolaInterface)),)
PyGeneratorInterfaceTauolaInterface := self/src/GeneratorInterface/TauolaInterface/python
src_GeneratorInterface_TauolaInterface_python_parent := src/GeneratorInterface/TauolaInterface
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/GeneratorInterface/TauolaInterface/python)
PyGeneratorInterfaceTauolaInterface_files := $(patsubst src/GeneratorInterface/TauolaInterface/python/%,%,$(wildcard $(foreach dir,src/GeneratorInterface/TauolaInterface/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyGeneratorInterfaceTauolaInterface_LOC_USE := self   
PyGeneratorInterfaceTauolaInterface_PACKAGE := self/src/GeneratorInterface/TauolaInterface/python
ALL_PRODS += PyGeneratorInterfaceTauolaInterface
PyGeneratorInterfaceTauolaInterface_INIT_FUNC        += $$(eval $$(call PythonProduct,PyGeneratorInterfaceTauolaInterface,src/GeneratorInterface/TauolaInterface/python,src_GeneratorInterface_TauolaInterface_python))
else
$(eval $(call MultipleWarningMsg,PyGeneratorInterfaceTauolaInterface,src/GeneratorInterface/TauolaInterface/python))
endif
ALL_COMMONRULES += src_GeneratorInterface_TauolaInterface_python
src_GeneratorInterface_TauolaInterface_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_TauolaInterface_python,src/GeneratorInterface/TauolaInterface/python,PYTHON))
ALL_SUBSYSTEMS+=SimGeneral
subdirs_src_SimGeneral = src_SimGeneral_CaloAnalysis src_SimGeneral_Configuration src_SimGeneral_DataMixingModule src_SimGeneral_Debugging src_SimGeneral_GFlash src_SimGeneral_HepPDTESSource src_SimGeneral_HepPDTRecord src_SimGeneral_MixingModule src_SimGeneral_NoiseGenerators src_SimGeneral_PileupInformation src_SimGeneral_PreMixingModule src_SimGeneral_TrackingAnalysis
subdirs_src += src_SimGeneral
ALL_PACKAGES += SimGeneral/CaloAnalysis
subdirs_src_SimGeneral_CaloAnalysis := src_SimGeneral_CaloAnalysis_plugins
ALL_PACKAGES += SimGeneral/Configuration
subdirs_src_SimGeneral_Configuration := src_SimGeneral_Configuration_python
ifeq ($(strip $(PySimGeneralConfiguration)),)
PySimGeneralConfiguration := self/src/SimGeneral/Configuration/python
src_SimGeneral_Configuration_python_parent := src/SimGeneral/Configuration
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/Configuration/python)
PySimGeneralConfiguration_files := $(patsubst src/SimGeneral/Configuration/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/Configuration/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralConfiguration_LOC_USE := self   
PySimGeneralConfiguration_PACKAGE := self/src/SimGeneral/Configuration/python
ALL_PRODS += PySimGeneralConfiguration
PySimGeneralConfiguration_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralConfiguration,src/SimGeneral/Configuration/python,src_SimGeneral_Configuration_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralConfiguration,src/SimGeneral/Configuration/python))
endif
ALL_COMMONRULES += src_SimGeneral_Configuration_python
src_SimGeneral_Configuration_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_Configuration_python,src/SimGeneral/Configuration/python,PYTHON))
ALL_PACKAGES += SimGeneral/DataMixingModule
subdirs_src_SimGeneral_DataMixingModule := src_SimGeneral_DataMixingModule_plugins src_SimGeneral_DataMixingModule_python src_SimGeneral_DataMixingModule_test
ifeq ($(strip $(PySimGeneralDataMixingModule)),)
PySimGeneralDataMixingModule := self/src/SimGeneral/DataMixingModule/python
src_SimGeneral_DataMixingModule_python_parent := src/SimGeneral/DataMixingModule
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/DataMixingModule/python)
PySimGeneralDataMixingModule_files := $(patsubst src/SimGeneral/DataMixingModule/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/DataMixingModule/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralDataMixingModule_LOC_USE := self   
PySimGeneralDataMixingModule_PACKAGE := self/src/SimGeneral/DataMixingModule/python
ALL_PRODS += PySimGeneralDataMixingModule
PySimGeneralDataMixingModule_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralDataMixingModule,src/SimGeneral/DataMixingModule/python,src_SimGeneral_DataMixingModule_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralDataMixingModule,src/SimGeneral/DataMixingModule/python))
endif
ALL_COMMONRULES += src_SimGeneral_DataMixingModule_python
src_SimGeneral_DataMixingModule_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_DataMixingModule_python,src/SimGeneral/DataMixingModule/python,PYTHON))
ALL_PACKAGES += SimGeneral/Debugging
subdirs_src_SimGeneral_Debugging := src_SimGeneral_Debugging_plugins src_SimGeneral_Debugging_python src_SimGeneral_Debugging_test
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
ALL_PACKAGES += SimGeneral/GFlash
subdirs_src_SimGeneral_GFlash := src_SimGeneral_GFlash_src
ALL_PACKAGES += SimGeneral/HepPDTESSource
subdirs_src_SimGeneral_HepPDTESSource := src_SimGeneral_HepPDTESSource_python src_SimGeneral_HepPDTESSource_src src_SimGeneral_HepPDTESSource_test
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
ALL_PACKAGES += SimGeneral/HepPDTRecord
subdirs_src_SimGeneral_HepPDTRecord := src_SimGeneral_HepPDTRecord_src src_SimGeneral_HepPDTRecord_test
ALL_PACKAGES += SimGeneral/MixingModule
subdirs_src_SimGeneral_MixingModule := src_SimGeneral_MixingModule_plugins src_SimGeneral_MixingModule_python src_SimGeneral_MixingModule_src src_SimGeneral_MixingModule_test
ifeq ($(strip $(PySimGeneralMixingModule)),)
PySimGeneralMixingModule := self/src/SimGeneral/MixingModule/python
src_SimGeneral_MixingModule_python_parent := src/SimGeneral/MixingModule
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/MixingModule/python)
PySimGeneralMixingModule_files := $(patsubst src/SimGeneral/MixingModule/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/MixingModule/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralMixingModule_LOC_USE := self   
PySimGeneralMixingModule_PACKAGE := self/src/SimGeneral/MixingModule/python
ALL_PRODS += PySimGeneralMixingModule
PySimGeneralMixingModule_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralMixingModule,src/SimGeneral/MixingModule/python,src_SimGeneral_MixingModule_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralMixingModule,src/SimGeneral/MixingModule/python))
endif
ALL_COMMONRULES += src_SimGeneral_MixingModule_python
src_SimGeneral_MixingModule_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_MixingModule_python,src/SimGeneral/MixingModule/python,PYTHON))
ALL_PACKAGES += SimGeneral/NoiseGenerators
subdirs_src_SimGeneral_NoiseGenerators := src_SimGeneral_NoiseGenerators_src src_SimGeneral_NoiseGenerators_test
ALL_PACKAGES += SimGeneral/PileupInformation
subdirs_src_SimGeneral_PileupInformation := src_SimGeneral_PileupInformation_plugins src_SimGeneral_PileupInformation_python
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
ALL_PACKAGES += SimGeneral/PreMixingModule
subdirs_src_SimGeneral_PreMixingModule := src_SimGeneral_PreMixingModule_plugins src_SimGeneral_PreMixingModule_python src_SimGeneral_PreMixingModule_src src_SimGeneral_PreMixingModule_test
ifeq ($(strip $(PySimGeneralPreMixingModule)),)
PySimGeneralPreMixingModule := self/src/SimGeneral/PreMixingModule/python
src_SimGeneral_PreMixingModule_python_parent := src/SimGeneral/PreMixingModule
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/SimGeneral/PreMixingModule/python)
PySimGeneralPreMixingModule_files := $(patsubst src/SimGeneral/PreMixingModule/python/%,%,$(wildcard $(foreach dir,src/SimGeneral/PreMixingModule/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PySimGeneralPreMixingModule_LOC_USE := self   
PySimGeneralPreMixingModule_PACKAGE := self/src/SimGeneral/PreMixingModule/python
ALL_PRODS += PySimGeneralPreMixingModule
PySimGeneralPreMixingModule_INIT_FUNC        += $$(eval $$(call PythonProduct,PySimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/python,src_SimGeneral_PreMixingModule_python))
else
$(eval $(call MultipleWarningMsg,PySimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/python))
endif
ALL_COMMONRULES += src_SimGeneral_PreMixingModule_python
src_SimGeneral_PreMixingModule_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PreMixingModule_python,src/SimGeneral/PreMixingModule/python,PYTHON))
ALL_PACKAGES += SimGeneral/TrackingAnalysis
subdirs_src_SimGeneral_TrackingAnalysis := src_SimGeneral_TrackingAnalysis_plugins src_SimGeneral_TrackingAnalysis_python src_SimGeneral_TrackingAnalysis_src src_SimGeneral_TrackingAnalysis_test
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
ifeq ($(strip $(SimHitCaloHitDumper)),)
SimHitCaloHitDumper := self/src/SimG4Core/Application/test
SimHitCaloHitDumper_files := $(patsubst src/SimG4Core/Application/test/%,%,$(foreach file,SimHitCaloHitDumper.cc,$(eval xfile:=$(wildcard src/SimG4Core/Application/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Application/test/$(file). Please fix src/SimG4Core/Application/test/BuildFile.))))
SimHitCaloHitDumper_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Application/test/BuildFile
SimHitCaloHitDumper_LOC_USE := self   FWCore/Framework SimDataFormats/TrackingHit SimDataFormats/CaloHit 
SimHitCaloHitDumper_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimHitCaloHitDumper,SimHitCaloHitDumper,$(SCRAMSTORENAME_LIB),src/SimG4Core/Application/test))
SimHitCaloHitDumper_PACKAGE := self/src/SimG4Core/Application/test
ALL_PRODS += SimHitCaloHitDumper
SimHitCaloHitDumper_INIT_FUNC        += $$(eval $$(call Library,SimHitCaloHitDumper,src/SimG4Core/Application/test,src_SimG4Core_Application_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimHitCaloHitDumper_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimHitCaloHitDumper,src/SimG4Core/Application/test))
endif
ifeq ($(strip $(SimTrackSimVertexDumper)),)
SimTrackSimVertexDumper := self/src/SimG4Core/Application/test
SimTrackSimVertexDumper_files := $(patsubst src/SimG4Core/Application/test/%,%,$(foreach file,SimTrackSimVertexDumper.cc,$(eval xfile:=$(wildcard src/SimG4Core/Application/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Application/test/$(file). Please fix src/SimG4Core/Application/test/BuildFile.))))
SimTrackSimVertexDumper_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Application/test/BuildFile
SimTrackSimVertexDumper_LOC_USE := self   FWCore/Framework SimDataFormats/GeneratorProducts SimDataFormats/Track SimDataFormats/Vertex 
SimTrackSimVertexDumper_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimTrackSimVertexDumper,SimTrackSimVertexDumper,$(SCRAMSTORENAME_LIB),src/SimG4Core/Application/test))
SimTrackSimVertexDumper_PACKAGE := self/src/SimG4Core/Application/test
ALL_PRODS += SimTrackSimVertexDumper
SimTrackSimVertexDumper_INIT_FUNC        += $$(eval $$(call Library,SimTrackSimVertexDumper,src/SimG4Core/Application/test,src_SimG4Core_Application_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimTrackSimVertexDumper_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimTrackSimVertexDumper,src/SimG4Core/Application/test))
endif
ALL_COMMONRULES += src_SimG4Core_Application_test
src_SimG4Core_Application_test_parent := SimG4Core/Application
src_SimG4Core_Application_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Application_test,src/SimG4Core/Application/test,TEST))
ifeq ($(strip $(DD4hepGeometryTestDriver)),)
DD4hepGeometryTestDriver := self/src/SimG4Core/DD4hepGeometry/test
DD4hepGeometryTestDriver_files := 1
DD4hepGeometryTestDriver_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/DD4hepGeometry/test/BuildFile
DD4hepGeometryTestDriver_LOC_USE := self   FWCore/Framework dd4hep-geant4 DetectorDescription/DDCMS 
DD4hepGeometryTestDriver_PACKAGE := self/src/SimG4Core/DD4hepGeometry/test
ALL_PRODS += DD4hepGeometryTestDriver
DD4hepGeometryTestDriver_INIT_FUNC        += $$(eval $$(call Binary,DD4hepGeometryTestDriver,src/SimG4Core/DD4hepGeometry/test,src_SimG4Core_DD4hepGeometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
DD4hepGeometryTestDriver_CLASS := TEST
DD4hepGeometryTestDriver_TEST_RUNNER_CMD :=  runTest.sh
else
$(eval $(call MultipleWarningMsg,DD4hepGeometryTestDriver,src/SimG4Core/DD4hepGeometry/test))
endif
ifeq ($(strip $(DD4hepGeometryTestPlugins)),)
DD4hepGeometryTestPlugins := self/src/SimG4Core/DD4hepGeometry/test
DD4hepGeometryTestPlugins_files := $(patsubst src/SimG4Core/DD4hepGeometry/test/%,%,$(foreach file,plugins/*.cc,$(eval xfile:=$(wildcard src/SimG4Core/DD4hepGeometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/DD4hepGeometry/test/$(file). Please fix src/SimG4Core/DD4hepGeometry/test/BuildFile.))))
DD4hepGeometryTestPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/DD4hepGeometry/test/BuildFile
DD4hepGeometryTestPlugins_LOC_LIB   := Geom
DD4hepGeometryTestPlugins_LOC_USE := self   FWCore/Framework dd4hep-geant4 DetectorDescription/DDCMS SimG4Core/DD4hepGeometry geant4core Geometry/Records 
DD4hepGeometryTestPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,DD4hepGeometryTestPlugins,DD4hepGeometryTestPlugins,$(SCRAMSTORENAME_LIB),src/SimG4Core/DD4hepGeometry/test))
DD4hepGeometryTestPlugins_PACKAGE := self/src/SimG4Core/DD4hepGeometry/test
ALL_PRODS += DD4hepGeometryTestPlugins
DD4hepGeometryTestPlugins_INIT_FUNC        += $$(eval $$(call Library,DD4hepGeometryTestPlugins,src/SimG4Core/DD4hepGeometry/test,src_SimG4Core_DD4hepGeometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
DD4hepGeometryTestPlugins_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,DD4hepGeometryTestPlugins,src/SimG4Core/DD4hepGeometry/test))
endif
ALL_COMMONRULES += src_SimG4Core_DD4hepGeometry_test
src_SimG4Core_DD4hepGeometry_test_parent := SimG4Core/DD4hepGeometry
src_SimG4Core_DD4hepGeometry_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_DD4hepGeometry_test,src/SimG4Core/DD4hepGeometry/test,TEST))
ifeq ($(strip $(Box_)),)
Box_ := self/src/SimG4Core/Geometry/test
Box__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,Box_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
Box__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
Box__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
Box__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += Box_
Box__INIT_FUNC        += $$(eval $$(call Binary,Box_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
Box__CLASS := TEST
Box__TEST_RUNNER_CMD :=  Box_ 
else
$(eval $(call MultipleWarningMsg,Box_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(Cons_)),)
Cons_ := self/src/SimG4Core/Geometry/test
Cons__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,Cons_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
Cons__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
Cons__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
Cons__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += Cons_
Cons__INIT_FUNC        += $$(eval $$(call Binary,Cons_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
Cons__CLASS := TEST
Cons__TEST_RUNNER_CMD :=  Cons_ 
else
$(eval $(call MultipleWarningMsg,Cons_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(CutTubs_)),)
CutTubs_ := self/src/SimG4Core/Geometry/test
CutTubs__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,CutTubs_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
CutTubs__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
CutTubs__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
CutTubs__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += CutTubs_
CutTubs__INIT_FUNC        += $$(eval $$(call Binary,CutTubs_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
CutTubs__CLASS := TEST
CutTubs__TEST_RUNNER_CMD :=  CutTubs_ 
else
$(eval $(call MultipleWarningMsg,CutTubs_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(EllipticalTube_)),)
EllipticalTube_ := self/src/SimG4Core/Geometry/test
EllipticalTube__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,EllipticalTube_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
EllipticalTube__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
EllipticalTube__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
EllipticalTube__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += EllipticalTube_
EllipticalTube__INIT_FUNC        += $$(eval $$(call Binary,EllipticalTube_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
EllipticalTube__CLASS := TEST
EllipticalTube__TEST_RUNNER_CMD :=  EllipticalTube_ 
else
$(eval $(call MultipleWarningMsg,EllipticalTube_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(ExtrudedPolygon_)),)
ExtrudedPolygon_ := self/src/SimG4Core/Geometry/test
ExtrudedPolygon__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,ExtrudedPolygon_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
ExtrudedPolygon__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
ExtrudedPolygon__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
ExtrudedPolygon__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += ExtrudedPolygon_
ExtrudedPolygon__INIT_FUNC        += $$(eval $$(call Binary,ExtrudedPolygon_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
ExtrudedPolygon__CLASS := TEST
ExtrudedPolygon__TEST_RUNNER_CMD :=  ExtrudedPolygon_ 
else
$(eval $(call MultipleWarningMsg,ExtrudedPolygon_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(Polycone_)),)
Polycone_ := self/src/SimG4Core/Geometry/test
Polycone__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,Polycone_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
Polycone__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
Polycone__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
Polycone__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += Polycone_
Polycone__INIT_FUNC        += $$(eval $$(call Binary,Polycone_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
Polycone__CLASS := TEST
Polycone__TEST_RUNNER_CMD :=  Polycone_ 
else
$(eval $(call MultipleWarningMsg,Polycone_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(Polyhedra_)),)
Polyhedra_ := self/src/SimG4Core/Geometry/test
Polyhedra__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,Polyhedra_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
Polyhedra__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
Polyhedra__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
Polyhedra__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += Polyhedra_
Polyhedra__INIT_FUNC        += $$(eval $$(call Binary,Polyhedra_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
Polyhedra__CLASS := TEST
Polyhedra__TEST_RUNNER_CMD :=  Polyhedra_ 
else
$(eval $(call MultipleWarningMsg,Polyhedra_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(PseudoTrap_)),)
PseudoTrap_ := self/src/SimG4Core/Geometry/test
PseudoTrap__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,PseudoTrap_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
PseudoTrap__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
PseudoTrap__LOC_USE := self   DetectorDescription/Core geant4core expat SimG4Core/Geometry cppunit 
PseudoTrap__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += PseudoTrap_
PseudoTrap__INIT_FUNC        += $$(eval $$(call Binary,PseudoTrap_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
PseudoTrap__CLASS := TEST
PseudoTrap__TEST_RUNNER_CMD :=  PseudoTrap_ 
else
$(eval $(call MultipleWarningMsg,PseudoTrap_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(Sphere_)),)
Sphere_ := self/src/SimG4Core/Geometry/test
Sphere__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,Sphere_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
Sphere__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
Sphere__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
Sphere__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += Sphere_
Sphere__INIT_FUNC        += $$(eval $$(call Binary,Sphere_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
Sphere__CLASS := TEST
Sphere__TEST_RUNNER_CMD :=  Sphere_ 
else
$(eval $(call MultipleWarningMsg,Sphere_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(Torus_)),)
Torus_ := self/src/SimG4Core/Geometry/test
Torus__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,Torus_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
Torus__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
Torus__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
Torus__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += Torus_
Torus__INIT_FUNC        += $$(eval $$(call Binary,Torus_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
Torus__CLASS := TEST
Torus__TEST_RUNNER_CMD :=  Torus_ 
else
$(eval $(call MultipleWarningMsg,Torus_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(Trap_)),)
Trap_ := self/src/SimG4Core/Geometry/test
Trap__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,Trap_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
Trap__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
Trap__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
Trap__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += Trap_
Trap__INIT_FUNC        += $$(eval $$(call Binary,Trap_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
Trap__CLASS := TEST
Trap__TEST_RUNNER_CMD :=  Trap_ 
else
$(eval $(call MultipleWarningMsg,Trap_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(TruncTubs_)),)
TruncTubs_ := self/src/SimG4Core/Geometry/test
TruncTubs__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,TruncTubs_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
TruncTubs__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
TruncTubs__LOC_USE := self   DetectorDescription/Core geant4core expat SimG4Core/Geometry cppunit 
TruncTubs__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += TruncTubs_
TruncTubs__INIT_FUNC        += $$(eval $$(call Binary,TruncTubs_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TruncTubs__CLASS := TEST
TruncTubs__TEST_RUNNER_CMD :=  TruncTubs_ 
else
$(eval $(call MultipleWarningMsg,TruncTubs_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(Tubs_)),)
Tubs_ := self/src/SimG4Core/Geometry/test
Tubs__files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,Tubs_.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
Tubs__BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
Tubs__LOC_USE := self   DetectorDescription/Core geant4core expat cppunit 
Tubs__PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += Tubs_
Tubs__INIT_FUNC        += $$(eval $$(call Binary,Tubs_,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
Tubs__CLASS := TEST
Tubs__TEST_RUNNER_CMD :=  Tubs_ 
else
$(eval $(call MultipleWarningMsg,Tubs_,src/SimG4Core/Geometry/test))
endif
ifeq ($(strip $(testVolumes)),)
testVolumes := self/src/SimG4Core/Geometry/test
testVolumes_files := $(patsubst src/SimG4Core/Geometry/test/%,%,$(foreach file,testVolumes.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Geometry/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Geometry/test/$(file). Please fix src/SimG4Core/Geometry/test/BuildFile.))))
testVolumes_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Geometry/test/BuildFile
testVolumes_LOC_USE := self   DetectorDescription/Core geant4core expat 
testVolumes_PACKAGE := self/src/SimG4Core/Geometry/test
ALL_PRODS += testVolumes
testVolumes_INIT_FUNC        += $$(eval $$(call Binary,testVolumes,src/SimG4Core/Geometry/test,src_SimG4Core_Geometry_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testVolumes_CLASS := TEST
testVolumes_TEST_RUNNER_CMD :=  testVolumes 
else
$(eval $(call MultipleWarningMsg,testVolumes,src/SimG4Core/Geometry/test))
endif
ALL_COMMONRULES += src_SimG4Core_Geometry_test
src_SimG4Core_Geometry_test_parent := SimG4Core/Geometry
src_SimG4Core_Geometry_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Geometry_test,src/SimG4Core/Geometry/test,TEST))
ifeq ($(strip $(testSimG4CoreFieldStepWatcher)),)
testSimG4CoreFieldStepWatcher := self/src/SimG4Core/MagneticField/test
testSimG4CoreFieldStepWatcher_files := $(patsubst src/SimG4Core/MagneticField/test/%,%,$(foreach file,FieldStepWatcher.cc,$(eval xfile:=$(wildcard src/SimG4Core/MagneticField/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/MagneticField/test/$(file). Please fix src/SimG4Core/MagneticField/test/BuildFile.))))
testSimG4CoreFieldStepWatcher_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/MagneticField/test/BuildFile
testSimG4CoreFieldStepWatcher_LOC_USE := self   SimG4Core/Notification SimG4Core/Watcher FWCore/ParameterSet FWCore/MessageLogger DQMServices/Core geant4core boost root expat 
testSimG4CoreFieldStepWatcher_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,testSimG4CoreFieldStepWatcher,testSimG4CoreFieldStepWatcher,$(SCRAMSTORENAME_LIB),src/SimG4Core/MagneticField/test))
testSimG4CoreFieldStepWatcher_PACKAGE := self/src/SimG4Core/MagneticField/test
ALL_PRODS += testSimG4CoreFieldStepWatcher
testSimG4CoreFieldStepWatcher_INIT_FUNC        += $$(eval $$(call Library,testSimG4CoreFieldStepWatcher,src/SimG4Core/MagneticField/test,src_SimG4Core_MagneticField_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
testSimG4CoreFieldStepWatcher_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,testSimG4CoreFieldStepWatcher,src/SimG4Core/MagneticField/test))
endif
ALL_COMMONRULES += src_SimG4Core_MagneticField_test
src_SimG4Core_MagneticField_test_parent := SimG4Core/MagneticField
src_SimG4Core_MagneticField_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_MagneticField_test,src/SimG4Core/MagneticField/test,TEST))
ifeq ($(strip $(testSimG4CoreNotifications)),)
testSimG4CoreNotifications := self/src/SimG4Core/Notification/test
testSimG4CoreNotifications_files := $(patsubst src/SimG4Core/Notification/test/%,%,$(foreach file,simactivityregistry_t.cppunit.cpp,$(eval xfile:=$(wildcard src/SimG4Core/Notification/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Notification/test/$(file). Please fix src/SimG4Core/Notification/test/BuildFile.))))
testSimG4CoreNotifications_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Notification/test/BuildFile
testSimG4CoreNotifications_LOC_USE := self   cppunit SimG4Core/Notification 
testSimG4CoreNotifications_PACKAGE := self/src/SimG4Core/Notification/test
ALL_PRODS += testSimG4CoreNotifications
testSimG4CoreNotifications_INIT_FUNC        += $$(eval $$(call Binary,testSimG4CoreNotifications,src/SimG4Core/Notification/test,src_SimG4Core_Notification_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testSimG4CoreNotifications_CLASS := TEST
testSimG4CoreNotifications_TEST_RUNNER_CMD :=  testSimG4CoreNotifications 
else
$(eval $(call MultipleWarningMsg,testSimG4CoreNotifications,src/SimG4Core/Notification/test))
endif
ALL_COMMONRULES += src_SimG4Core_Notification_test
src_SimG4Core_Notification_test_parent := SimG4Core/Notification
src_SimG4Core_Notification_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Notification_test,src/SimG4Core/Notification/test,TEST))
ifeq ($(strip $(SimFileCompare)),)
SimFileCompare := self/src/SimG4Core/PrintGeomInfo/test
SimFileCompare_files := $(patsubst src/SimG4Core/PrintGeomInfo/test/%,%,$(foreach file,SimFileCompare.cpp,$(eval xfile:=$(wildcard src/SimG4Core/PrintGeomInfo/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/PrintGeomInfo/test/$(file). Please fix src/SimG4Core/PrintGeomInfo/test/BuildFile.))))
SimFileCompare_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/PrintGeomInfo/test/BuildFile
SimFileCompare_LOC_USE := self   SimG4Core/Geometry 
SimFileCompare_PACKAGE := self/src/SimG4Core/PrintGeomInfo/test
ALL_PRODS += SimFileCompare
SimFileCompare_INIT_FUNC        += $$(eval $$(call Binary,SimFileCompare,src/SimG4Core/PrintGeomInfo/test,src_SimG4Core_PrintGeomInfo_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
SimFileCompare_CLASS := TEST
SimFileCompare_TEST_RUNNER_CMD :=  SimFileCompare 
else
$(eval $(call MultipleWarningMsg,SimFileCompare,src/SimG4Core/PrintGeomInfo/test))
endif
ALL_COMMONRULES += src_SimG4Core_PrintGeomInfo_test
src_SimG4Core_PrintGeomInfo_test_parent := SimG4Core/PrintGeomInfo
src_SimG4Core_PrintGeomInfo_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_PrintGeomInfo_test,src/SimG4Core/PrintGeomInfo/test,TEST))
ifeq ($(strip $(SimG4CoreWatcherTest)),)
SimG4CoreWatcherTest := self/src/SimG4Core/Watcher/test
SimG4CoreWatcherTest_files := $(patsubst src/SimG4Core/Watcher/test/%,%,$(foreach file,IntSimProducer.cc,$(eval xfile:=$(wildcard src/SimG4Core/Watcher/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimG4Core/Watcher/test/$(file). Please fix src/SimG4Core/Watcher/test/BuildFile.))))
SimG4CoreWatcherTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Watcher/test/BuildFile
SimG4CoreWatcherTest_LOC_USE := self   FWCore/Framework SimG4Core/Watcher boost 
SimG4CoreWatcherTest_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreWatcherTest,SimG4CoreWatcherTest,$(SCRAMSTORENAME_LIB),src/SimG4Core/Watcher/test))
SimG4CoreWatcherTest_PACKAGE := self/src/SimG4Core/Watcher/test
ALL_PRODS += SimG4CoreWatcherTest
SimG4CoreWatcherTest_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreWatcherTest,src/SimG4Core/Watcher/test,src_SimG4Core_Watcher_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimG4CoreWatcherTest_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimG4CoreWatcherTest,src/SimG4Core/Watcher/test))
endif
ALL_COMMONRULES += src_SimG4Core_Watcher_test
src_SimG4Core_Watcher_test_parent := SimG4Core/Watcher
src_SimG4Core_Watcher_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimG4Core_Watcher_test,src/SimG4Core/Watcher/test,TEST))
ifeq ($(strip $(cmsExternalGenerator)),)
cmsExternalGenerator := self/src/GeneratorInterface/Core/bin
cmsExternalGenerator_files := $(patsubst src/GeneratorInterface/Core/bin/%,%,$(foreach file,externalGenerator.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Core/bin/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Core/bin/$(file). Please fix src/GeneratorInterface/Core/bin/BuildFile.))))
cmsExternalGenerator_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/bin/BuildFile
cmsExternalGenerator_LOC_USE := self   boost boost_program_options FWCore/TestProcessor FWCore/SharedMemory FWCore/Services SimDataFormats/GeneratorProducts 
cmsExternalGenerator_PACKAGE := self/src/GeneratorInterface/Core/bin
ALL_PRODS += cmsExternalGenerator
cmsExternalGenerator_INIT_FUNC        += $$(eval $$(call Binary,cmsExternalGenerator,src/GeneratorInterface/Core/bin,src_GeneratorInterface_Core_bin,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_BIN),bin,$(SCRAMSTORENAME_LOGS)))
cmsExternalGenerator_CLASS := BINARY
else
$(eval $(call MultipleWarningMsg,cmsExternalGenerator,src/GeneratorInterface/Core/bin))
endif
ALL_COMMONRULES += src_GeneratorInterface_Core_bin
src_GeneratorInterface_Core_bin_parent := GeneratorInterface/Core
src_GeneratorInterface_Core_bin_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_bin,src/GeneratorInterface/Core/bin,BINARY))
ifeq ($(strip $(FailingGeneratorFilterTest)),)
FailingGeneratorFilterTest := self/src/GeneratorInterface/Core/test
FailingGeneratorFilterTest_files := 1
FailingGeneratorFilterTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/test/BuildFile
FailingGeneratorFilterTest_LOC_USE := self   
FailingGeneratorFilterTest_PACKAGE := self/src/GeneratorInterface/Core/test
ALL_PRODS += FailingGeneratorFilterTest
FailingGeneratorFilterTest_INIT_FUNC        += $$(eval $$(call Binary,FailingGeneratorFilterTest,src/GeneratorInterface/Core/test,src_GeneratorInterface_Core_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
FailingGeneratorFilterTest_CLASS := TEST
FailingGeneratorFilterTest_TEST_RUNNER_CMD :=  ${LOCALTOP}/src/GeneratorInterface/Core/test/test_FailingGeneratorFilter.sh
else
$(eval $(call MultipleWarningMsg,FailingGeneratorFilterTest,src/GeneratorInterface/Core/test))
endif
ifeq ($(strip $(FailingGeneratorFilter)),)
FailingGeneratorFilter := self/src/GeneratorInterface/Core/test
FailingGeneratorFilter_files := $(patsubst src/GeneratorInterface/Core/test/%,%,$(foreach file,FailingGeneratorFilter.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Core/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Core/test/$(file). Please fix src/GeneratorInterface/Core/test/BuildFile.))))
FailingGeneratorFilter_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Core/test/BuildFile
FailingGeneratorFilter_LOC_USE := self   FWCore/Framework GeneratorInterface/Core 
FailingGeneratorFilter_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,FailingGeneratorFilter,FailingGeneratorFilter,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Core/test))
FailingGeneratorFilter_PACKAGE := self/src/GeneratorInterface/Core/test
ALL_PRODS += FailingGeneratorFilter
FailingGeneratorFilter_INIT_FUNC        += $$(eval $$(call Library,FailingGeneratorFilter,src/GeneratorInterface/Core/test,src_GeneratorInterface_Core_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
FailingGeneratorFilter_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,FailingGeneratorFilter,src/GeneratorInterface/Core/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_Core_test
src_GeneratorInterface_Core_test_parent := GeneratorInterface/Core
src_GeneratorInterface_Core_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Core_test,src/GeneratorInterface/Core/test,TEST))
ifeq ($(strip $(EvtGenTestAnalyzer)),)
EvtGenTestAnalyzer := self/src/GeneratorInterface/ExternalDecays/test
EvtGenTestAnalyzer_files := $(patsubst src/GeneratorInterface/ExternalDecays/test/%,%,$(foreach file,EvtGenTestAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/ExternalDecays/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/ExternalDecays/test/$(file). Please fix src/GeneratorInterface/ExternalDecays/test/BuildFile.))))
EvtGenTestAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ExternalDecays/test/BuildFile
EvtGenTestAnalyzer_LOC_USE := self   boost hepmc root FWCore/Framework CommonTools/UtilAlgos FWCore/ServiceRegistry SimDataFormats/GeneratorProducts 
EvtGenTestAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,EvtGenTestAnalyzer,EvtGenTestAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/ExternalDecays/test))
EvtGenTestAnalyzer_PACKAGE := self/src/GeneratorInterface/ExternalDecays/test
ALL_PRODS += EvtGenTestAnalyzer
EvtGenTestAnalyzer_INIT_FUNC        += $$(eval $$(call Library,EvtGenTestAnalyzer,src/GeneratorInterface/ExternalDecays/test,src_GeneratorInterface_ExternalDecays_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
EvtGenTestAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,EvtGenTestAnalyzer,src/GeneratorInterface/ExternalDecays/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExternalDecays_test
src_GeneratorInterface_ExternalDecays_test_parent := GeneratorInterface/ExternalDecays
src_GeneratorInterface_ExternalDecays_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExternalDecays_test,src/GeneratorInterface/ExternalDecays/test,TEST))
ifeq ($(strip $(TestGeneratorInterfaceLHEInterfaceFileReading)),)
TestGeneratorInterfaceLHEInterfaceFileReading := self/src/GeneratorInterface/LHEInterface/test
TestGeneratorInterfaceLHEInterfaceFileReading_files := 1
TestGeneratorInterfaceLHEInterfaceFileReading_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/test/BuildFile
TestGeneratorInterfaceLHEInterfaceFileReading_LOC_USE := self   
TestGeneratorInterfaceLHEInterfaceFileReading_PACKAGE := self/src/GeneratorInterface/LHEInterface/test
ALL_PRODS += TestGeneratorInterfaceLHEInterfaceFileReading
TestGeneratorInterfaceLHEInterfaceFileReading_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfaceLHEInterfaceFileReading,src/GeneratorInterface/LHEInterface/test,src_GeneratorInterface_LHEInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfaceLHEInterfaceFileReading_CLASS := TEST
TestGeneratorInterfaceLHEInterfaceFileReading_TEST_RUNNER_CMD :=  testMerging.sh
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfaceLHEInterfaceFileReading,src/GeneratorInterface/LHEInterface/test))
endif
ifeq ($(strip $(testGeneratorInterfaceLHEInterface_TP)),)
testGeneratorInterfaceLHEInterface_TP := self/src/GeneratorInterface/LHEInterface/test
testGeneratorInterfaceLHEInterface_TP_files := $(patsubst src/GeneratorInterface/LHEInterface/test/%,%,$(foreach file,test_catch2_*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/LHEInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/LHEInterface/test/$(file). Please fix src/GeneratorInterface/LHEInterface/test/BuildFile.))))
testGeneratorInterfaceLHEInterface_TP_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/test/BuildFile
testGeneratorInterfaceLHEInterface_TP_LOC_USE := self   FWCore/TestProcessor SimDataFormats/GeneratorProducts catch2 
testGeneratorInterfaceLHEInterface_TP_PACKAGE := self/src/GeneratorInterface/LHEInterface/test
ALL_PRODS += testGeneratorInterfaceLHEInterface_TP
testGeneratorInterfaceLHEInterface_TP_INIT_FUNC        += $$(eval $$(call Binary,testGeneratorInterfaceLHEInterface_TP,src/GeneratorInterface/LHEInterface/test,src_GeneratorInterface_LHEInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testGeneratorInterfaceLHEInterface_TP_CLASS := TEST
testGeneratorInterfaceLHEInterface_TP_TEST_RUNNER_CMD :=  testGeneratorInterfaceLHEInterface_TP 
else
$(eval $(call MultipleWarningMsg,testGeneratorInterfaceLHEInterface_TP,src/GeneratorInterface/LHEInterface/test))
endif
ifeq ($(strip $(test_cmsLHEtoEOSManager)),)
test_cmsLHEtoEOSManager := self/src/GeneratorInterface/LHEInterface/test
test_cmsLHEtoEOSManager_files := 1
test_cmsLHEtoEOSManager_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/test/BuildFile
test_cmsLHEtoEOSManager_LOC_USE := self   
test_cmsLHEtoEOSManager_PACKAGE := self/src/GeneratorInterface/LHEInterface/test
ALL_PRODS += test_cmsLHEtoEOSManager
test_cmsLHEtoEOSManager_INIT_FUNC        += $$(eval $$(call Binary,test_cmsLHEtoEOSManager,src/GeneratorInterface/LHEInterface/test,src_GeneratorInterface_LHEInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test_cmsLHEtoEOSManager_CLASS := TEST
test_cmsLHEtoEOSManager_TEST_RUNNER_CMD :=  test_cmsLHEtoEOSManager.sh
else
$(eval $(call MultipleWarningMsg,test_cmsLHEtoEOSManager,src/GeneratorInterface/LHEInterface/test))
endif
ifeq ($(strip $(DummyLHEAnalyzer)),)
DummyLHEAnalyzer := self/src/GeneratorInterface/LHEInterface/test
DummyLHEAnalyzer_files := $(patsubst src/GeneratorInterface/LHEInterface/test/%,%,$(foreach file,DummyLHEAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/LHEInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/LHEInterface/test/$(file). Please fix src/GeneratorInterface/LHEInterface/test/BuildFile.))))
DummyLHEAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/LHEInterface/test/BuildFile
DummyLHEAnalyzer_LOC_USE := self   SimDataFormats/GeneratorProducts FWCore/Framework 
DummyLHEAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,DummyLHEAnalyzer,DummyLHEAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/LHEInterface/test))
DummyLHEAnalyzer_PACKAGE := self/src/GeneratorInterface/LHEInterface/test
ALL_PRODS += DummyLHEAnalyzer
DummyLHEAnalyzer_INIT_FUNC        += $$(eval $$(call Library,DummyLHEAnalyzer,src/GeneratorInterface/LHEInterface/test,src_GeneratorInterface_LHEInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
DummyLHEAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,DummyLHEAnalyzer,src/GeneratorInterface/LHEInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_LHEInterface_test
src_GeneratorInterface_LHEInterface_test_parent := GeneratorInterface/LHEInterface
src_GeneratorInterface_LHEInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_LHEInterface_test,src/GeneratorInterface/LHEInterface/test,TEST))
ifeq ($(strip $(TestGeneratorInterfacePythia8ConcurrentGeneratorFilter)),)
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter := self/src/GeneratorInterface/Pythia8Interface/test
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_files := 1
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += TestGeneratorInterfacePythia8ConcurrentGeneratorFilter
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfacePythia8ConcurrentGeneratorFilter,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_CLASS := TEST
TestGeneratorInterfacePythia8ConcurrentGeneratorFilter_TEST_RUNNER_CMD :=  ${LOCALTOP}/src/GeneratorInterface/Pythia8Interface/test/test_Pythia8ConcurrentGeneratorFilter_WZ_TuneCP5_13TeV-pythia8.sh
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfacePythia8ConcurrentGeneratorFilter,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(TestGeneratorInterfacePythia8InterfaceCompareExternal)),)
TestGeneratorInterfacePythia8InterfaceCompareExternal := self/src/GeneratorInterface/Pythia8Interface/test
TestGeneratorInterfacePythia8InterfaceCompareExternal_files := 1
TestGeneratorInterfacePythia8InterfaceCompareExternal_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
TestGeneratorInterfacePythia8InterfaceCompareExternal_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
TestGeneratorInterfacePythia8InterfaceCompareExternal_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += TestGeneratorInterfacePythia8InterfaceCompareExternal
TestGeneratorInterfacePythia8InterfaceCompareExternal_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfacePythia8InterfaceCompareExternal,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfacePythia8InterfaceCompareExternal_CLASS := TEST
TestGeneratorInterfacePythia8InterfaceCompareExternal_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/Pythia8Interface/test/compare_external_generators_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfacePythia8InterfaceCompareExternal,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(TestGeneratorInterfacePythia8InterfaceCompareExternalStreams)),)
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams := self/src/GeneratorInterface/Pythia8Interface/test
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_files := 1
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += TestGeneratorInterfacePythia8InterfaceCompareExternalStreams
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfacePythia8InterfaceCompareExternalStreams,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_CLASS := TEST
TestGeneratorInterfacePythia8InterfaceCompareExternalStreams_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/Pythia8Interface/test/compare_external_generators_streams_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfacePythia8InterfaceCompareExternalStreams,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(TestGeneratorInterfacePythia8InterfaceCompareIdentical)),)
TestGeneratorInterfacePythia8InterfaceCompareIdentical := self/src/GeneratorInterface/Pythia8Interface/test
TestGeneratorInterfacePythia8InterfaceCompareIdentical_files := 1
TestGeneratorInterfacePythia8InterfaceCompareIdentical_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
TestGeneratorInterfacePythia8InterfaceCompareIdentical_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
TestGeneratorInterfacePythia8InterfaceCompareIdentical_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += TestGeneratorInterfacePythia8InterfaceCompareIdentical
TestGeneratorInterfacePythia8InterfaceCompareIdentical_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfacePythia8InterfaceCompareIdentical,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfacePythia8InterfaceCompareIdentical_CLASS := TEST
TestGeneratorInterfacePythia8InterfaceCompareIdentical_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/Pythia8Interface/test/compare_identical_generators_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfacePythia8InterfaceCompareIdentical,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(testGeneratorInterfacePythia8InterfaceTP)),)
testGeneratorInterfacePythia8InterfaceTP := self/src/GeneratorInterface/Pythia8Interface/test
testGeneratorInterfacePythia8InterfaceTP_files := $(patsubst src/GeneratorInterface/Pythia8Interface/test/%,%,$(foreach file,test_catch2_*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/test/$(file). Please fix src/GeneratorInterface/Pythia8Interface/test/BuildFile.))))
testGeneratorInterfacePythia8InterfaceTP_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
testGeneratorInterfacePythia8InterfaceTP_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos FWCore/TestProcessor catch2 
testGeneratorInterfacePythia8InterfaceTP_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += testGeneratorInterfacePythia8InterfaceTP
testGeneratorInterfacePythia8InterfaceTP_INIT_FUNC        += $$(eval $$(call Binary,testGeneratorInterfacePythia8InterfaceTP,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testGeneratorInterfacePythia8InterfaceTP_CLASS := TEST
testGeneratorInterfacePythia8InterfaceTP_TEST_RUNNER_CMD :=  testGeneratorInterfacePythia8InterfaceTP 
else
$(eval $(call MultipleWarningMsg,testGeneratorInterfacePythia8InterfaceTP,src/GeneratorInterface/Pythia8Interface/test))
endif
ifeq ($(strip $(ZJetsTestAnalyzer)),)
ZJetsTestAnalyzer := self/src/GeneratorInterface/Pythia8Interface/test
ZJetsTestAnalyzer_files := $(patsubst src/GeneratorInterface/Pythia8Interface/test/%,%,$(foreach file,ZJetsAnalyzer.cc analyserhepmc/LeptonAnalyserHepMC.cc analyserhepmc/JetInputHepMC.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia8Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia8Interface/test/$(file). Please fix src/GeneratorInterface/Pythia8Interface/test/BuildFile.))))
ZJetsTestAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia8Interface/test/BuildFile
ZJetsTestAnalyzer_LOC_USE := self   FWCore/Framework fastjet root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
ZJetsTestAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,ZJetsTestAnalyzer,ZJetsTestAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia8Interface/test))
ZJetsTestAnalyzer_PACKAGE := self/src/GeneratorInterface/Pythia8Interface/test
ALL_PRODS += ZJetsTestAnalyzer
ZJetsTestAnalyzer_INIT_FUNC        += $$(eval $$(call Library,ZJetsTestAnalyzer,src/GeneratorInterface/Pythia8Interface/test,src_GeneratorInterface_Pythia8Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
ZJetsTestAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,ZJetsTestAnalyzer,src/GeneratorInterface/Pythia8Interface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia8Interface_test
src_GeneratorInterface_Pythia8Interface_test_parent := GeneratorInterface/Pythia8Interface
src_GeneratorInterface_Pythia8Interface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia8Interface_test,src/GeneratorInterface/Pythia8Interface/test,TEST))
ifeq ($(strip $(test-rivet-list)),)
test-rivet-list := self/src/GeneratorInterface/RivetInterface/test
test-rivet-list_files := 1
test-rivet-list_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-rivet-list_LOC_USE := self   
test-rivet-list_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-rivet-list
test-rivet-list_INIT_FUNC        += $$(eval $$(call Binary,test-rivet-list,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-rivet-list_CLASS := TEST
test-rivet-list_TEST_RUNNER_CMD :=  test-rivet-list.sh
else
$(eval $(call MultipleWarningMsg,test-rivet-list,src/GeneratorInterface/RivetInterface/test))
endif
ifeq ($(strip $(test-rivet-nan)),)
test-rivet-nan := self/src/GeneratorInterface/RivetInterface/test
test-rivet-nan_files := 1
test-rivet-nan_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-rivet-nan_LOC_USE := self   
test-rivet-nan_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-rivet-nan
test-rivet-nan_INIT_FUNC        += $$(eval $$(call Binary,test-rivet-nan,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-rivet-nan_CLASS := TEST
test-rivet-nan_TEST_RUNNER_CMD :=  test-rivet-nan.sh
test-rivet-nan_PRE_TEST := test-rivet-run
else
$(eval $(call MultipleWarningMsg,test-rivet-nan,src/GeneratorInterface/RivetInterface/test))
endif
ifeq ($(strip $(test-rivet-run)),)
test-rivet-run := self/src/GeneratorInterface/RivetInterface/test
test-rivet-run_files := 1
test-rivet-run_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-rivet-run_LOC_USE := self   
test-rivet-run_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-rivet-run
test-rivet-run_INIT_FUNC        += $$(eval $$(call Binary,test-rivet-run,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-rivet-run_CLASS := TEST
test-rivet-run_TEST_RUNNER_CMD :=  test-rivet-run.sh
else
$(eval $(call MultipleWarningMsg,test-rivet-run,src/GeneratorInterface/RivetInterface/test))
endif
ifeq ($(strip $(test-yoda-merge)),)
test-yoda-merge := self/src/GeneratorInterface/RivetInterface/test
test-yoda-merge_files := 1
test-yoda-merge_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-yoda-merge_LOC_USE := self   
test-yoda-merge_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-yoda-merge
test-yoda-merge_INIT_FUNC        += $$(eval $$(call Binary,test-yoda-merge,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-yoda-merge_CLASS := TEST
test-yoda-merge_TEST_RUNNER_CMD :=  test-yoda-merge.sh
test-yoda-merge_PRE_TEST := test-rivet-run
else
$(eval $(call MultipleWarningMsg,test-yoda-merge,src/GeneratorInterface/RivetInterface/test))
endif
ifeq ($(strip $(test-yoda-root)),)
test-yoda-root := self/src/GeneratorInterface/RivetInterface/test
test-yoda-root_files := 1
test-yoda-root_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/RivetInterface/test/BuildFile
test-yoda-root_LOC_USE := self   
test-yoda-root_PACKAGE := self/src/GeneratorInterface/RivetInterface/test
ALL_PRODS += test-yoda-root
test-yoda-root_INIT_FUNC        += $$(eval $$(call Binary,test-yoda-root,src/GeneratorInterface/RivetInterface/test,src_GeneratorInterface_RivetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
test-yoda-root_CLASS := TEST
test-yoda-root_TEST_RUNNER_CMD :=  test-yoda-root.sh
test-yoda-root_PRE_TEST := test-rivet-run
else
$(eval $(call MultipleWarningMsg,test-yoda-root,src/GeneratorInterface/RivetInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_RivetInterface_test
src_GeneratorInterface_RivetInterface_test_parent := GeneratorInterface/RivetInterface
src_GeneratorInterface_RivetInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_RivetInterface_test,src/GeneratorInterface/RivetInterface/test,TEST))
ifeq ($(strip $(AMPTAnalyzer)),)
AMPTAnalyzer := self/src/GeneratorInterface/AMPTInterface/test
AMPTAnalyzer_files := $(patsubst src/GeneratorInterface/AMPTInterface/test/%,%,$(foreach file,AMPTAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/AMPTInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/AMPTInterface/test/$(file). Please fix src/GeneratorInterface/AMPTInterface/test/BuildFile.))))
AMPTAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AMPTInterface/test/BuildFile
AMPTAnalyzer_LOC_USE := self   boost root heppdt GeneratorInterface/AMPTInterface FWCore/Framework SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimGeneral/HepPDTRecord CommonTools/UtilAlgos FWCore/ServiceRegistry FWCore/Utilities 
AMPTAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,AMPTAnalyzer,AMPTAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/AMPTInterface/test))
AMPTAnalyzer_PACKAGE := self/src/GeneratorInterface/AMPTInterface/test
ALL_PRODS += AMPTAnalyzer
AMPTAnalyzer_INIT_FUNC        += $$(eval $$(call Library,AMPTAnalyzer,src/GeneratorInterface/AMPTInterface/test,src_GeneratorInterface_AMPTInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
AMPTAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,AMPTAnalyzer,src/GeneratorInterface/AMPTInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_AMPTInterface_test
src_GeneratorInterface_AMPTInterface_test_parent := GeneratorInterface/AMPTInterface
src_GeneratorInterface_AMPTInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AMPTInterface_test,src/GeneratorInterface/AMPTInterface/test,TEST))
ifeq ($(strip $(GeneratorInterfaceAlpgenExtractor)),)
GeneratorInterfaceAlpgenExtractor := self/src/GeneratorInterface/AlpgenInterface/test
GeneratorInterfaceAlpgenExtractor_files := $(patsubst src/GeneratorInterface/AlpgenInterface/test/%,%,$(foreach file,AlpgenExtractor.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/AlpgenInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/AlpgenInterface/test/$(file). Please fix src/GeneratorInterface/AlpgenInterface/test/BuildFile.))))
GeneratorInterfaceAlpgenExtractor_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/AlpgenInterface/test/BuildFile
GeneratorInterfaceAlpgenExtractor_LOC_USE := self   FWCore/Framework FWCore/ParameterSet SimDataFormats/GeneratorProducts 
GeneratorInterfaceAlpgenExtractor_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceAlpgenExtractor,GeneratorInterfaceAlpgenExtractor,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/AlpgenInterface/test))
GeneratorInterfaceAlpgenExtractor_PACKAGE := self/src/GeneratorInterface/AlpgenInterface/test
ALL_PRODS += GeneratorInterfaceAlpgenExtractor
GeneratorInterfaceAlpgenExtractor_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceAlpgenExtractor,src/GeneratorInterface/AlpgenInterface/test,src_GeneratorInterface_AlpgenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceAlpgenExtractor_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceAlpgenExtractor,src/GeneratorInterface/AlpgenInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_AlpgenInterface_test
src_GeneratorInterface_AlpgenInterface_test_parent := GeneratorInterface/AlpgenInterface
src_GeneratorInterface_AlpgenInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_AlpgenInterface_test,src/GeneratorInterface/AlpgenInterface/test,TEST))
ifeq ($(strip $(GeneratorInterfaceEvtGenInterfaceTest)),)
GeneratorInterfaceEvtGenInterfaceTest := self/src/GeneratorInterface/EvtGenInterface/test
GeneratorInterfaceEvtGenInterfaceTest_files := 1
GeneratorInterfaceEvtGenInterfaceTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/test/BuildFile
GeneratorInterfaceEvtGenInterfaceTest_LOC_USE := self   
GeneratorInterfaceEvtGenInterfaceTest_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/test
ALL_PRODS += GeneratorInterfaceEvtGenInterfaceTest
GeneratorInterfaceEvtGenInterfaceTest_INIT_FUNC        += $$(eval $$(call Binary,GeneratorInterfaceEvtGenInterfaceTest,src/GeneratorInterface/EvtGenInterface/test,src_GeneratorInterface_EvtGenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
GeneratorInterfaceEvtGenInterfaceTest_CLASS := TEST
GeneratorInterfaceEvtGenInterfaceTest_TEST_RUNNER_CMD :=  runevtgentests.sh
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceEvtGenInterfaceTest,src/GeneratorInterface/EvtGenInterface/test))
endif
ifeq ($(strip $(TestGeneratorInterfaceEvtGenInterface_bplus)),)
TestGeneratorInterfaceEvtGenInterface_bplus := self/src/GeneratorInterface/EvtGenInterface/test
TestGeneratorInterfaceEvtGenInterface_bplus_files := 1
TestGeneratorInterfaceEvtGenInterface_bplus_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/test/BuildFile
TestGeneratorInterfaceEvtGenInterface_bplus_LOC_USE := self   
TestGeneratorInterfaceEvtGenInterface_bplus_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/test
ALL_PRODS += TestGeneratorInterfaceEvtGenInterface_bplus
TestGeneratorInterfaceEvtGenInterface_bplus_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfaceEvtGenInterface_bplus,src/GeneratorInterface/EvtGenInterface/test,src_GeneratorInterface_EvtGenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfaceEvtGenInterface_bplus_CLASS := TEST
TestGeneratorInterfaceEvtGenInterface_bplus_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/EvtGenInterface/test/Py8_bplus_evtgen1_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfaceEvtGenInterface_bplus,src/GeneratorInterface/EvtGenInterface/test))
endif
ifeq ($(strip $(TestGeneratorInterfaceEvtGenInterface_external_bplus)),)
TestGeneratorInterfaceEvtGenInterface_external_bplus := self/src/GeneratorInterface/EvtGenInterface/test
TestGeneratorInterfaceEvtGenInterface_external_bplus_files := 1
TestGeneratorInterfaceEvtGenInterface_external_bplus_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/EvtGenInterface/test/BuildFile
TestGeneratorInterfaceEvtGenInterface_external_bplus_LOC_USE := self   
TestGeneratorInterfaceEvtGenInterface_external_bplus_PACKAGE := self/src/GeneratorInterface/EvtGenInterface/test
ALL_PRODS += TestGeneratorInterfaceEvtGenInterface_external_bplus
TestGeneratorInterfaceEvtGenInterface_external_bplus_INIT_FUNC        += $$(eval $$(call Binary,TestGeneratorInterfaceEvtGenInterface_external_bplus,src/GeneratorInterface/EvtGenInterface/test,src_GeneratorInterface_EvtGenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
TestGeneratorInterfaceEvtGenInterface_external_bplus_CLASS := TEST
TestGeneratorInterfaceEvtGenInterface_external_bplus_TEST_RUNNER_CMD :=  cmsRun ${LOCALTOP}/src/GeneratorInterface/EvtGenInterface/test/external_Py8_bplus_evtgen1_cfg.py
else
$(eval $(call MultipleWarningMsg,TestGeneratorInterfaceEvtGenInterface_external_bplus,src/GeneratorInterface/EvtGenInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_EvtGenInterface_test
src_GeneratorInterface_EvtGenInterface_test_parent := GeneratorInterface/EvtGenInterface
src_GeneratorInterface_EvtGenInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_EvtGenInterface_test,src/GeneratorInterface/EvtGenInterface/test,TEST))
ifeq ($(strip $(ExhumeAnalyzer)),)
ExhumeAnalyzer := self/src/GeneratorInterface/ExhumeInterface/test
ExhumeAnalyzer_files := $(patsubst src/GeneratorInterface/ExhumeInterface/test/%,%,$(foreach file,ExhumeAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/ExhumeInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/ExhumeInterface/test/$(file). Please fix src/GeneratorInterface/ExhumeInterface/test/BuildFile.))))
ExhumeAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/ExhumeInterface/test/BuildFile
ExhumeAnalyzer_LOC_USE := self   FWCore/Framework FWCore/ParameterSet DataFormats/HepMCCandidate CommonTools/UtilAlgos roothistmatrix 
ExhumeAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,ExhumeAnalyzer,ExhumeAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/ExhumeInterface/test))
ExhumeAnalyzer_PACKAGE := self/src/GeneratorInterface/ExhumeInterface/test
ALL_PRODS += ExhumeAnalyzer
ExhumeAnalyzer_INIT_FUNC        += $$(eval $$(call Library,ExhumeAnalyzer,src/GeneratorInterface/ExhumeInterface/test,src_GeneratorInterface_ExhumeInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
ExhumeAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,ExhumeAnalyzer,src/GeneratorInterface/ExhumeInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_ExhumeInterface_test
src_GeneratorInterface_ExhumeInterface_test_parent := GeneratorInterface/ExhumeInterface
src_GeneratorInterface_ExhumeInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_ExhumeInterface_test,src/GeneratorInterface/ExhumeInterface/test,TEST))
ifeq ($(strip $(BcGenerator)),)
BcGenerator := self/src/GeneratorInterface/GenExtensions/bin
BcGenerator_files := $(patsubst src/GeneratorInterface/GenExtensions/bin/%,%,$(foreach file,BCVEGPY/main.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/GenExtensions/bin/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/GenExtensions/bin/$(file). Please fix src/GeneratorInterface/GenExtensions/bin/BuildFile.))))
BcGenerator_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/GenExtensions/bin/BuildFile
BcGenerator_LOC_LIB   := GeneratorInterfaceBCVEGPY
BcGenerator_LOC_USE := self   pythia6 f77compiler 
BcGenerator_PACKAGE := self/src/GeneratorInterface/GenExtensions/bin
ALL_PRODS += BcGenerator
BcGenerator_INIT_FUNC        += $$(eval $$(call Binary,BcGenerator,src/GeneratorInterface/GenExtensions/bin,src_GeneratorInterface_GenExtensions_bin,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_BIN),bin,$(SCRAMSTORENAME_LOGS)))
BcGenerator_CLASS := BINARY
else
$(eval $(call MultipleWarningMsg,BcGenerator,src/GeneratorInterface/GenExtensions/bin))
endif
ifeq ($(strip $(GeneratorInterfaceBCVEGPY)),)
GeneratorInterfaceBCVEGPY := self/src/GeneratorInterface/GenExtensions/bin
GeneratorInterfaceBCVEGPY_files := $(patsubst src/GeneratorInterface/GenExtensions/bin/%,%,$(foreach file,BCVEGPY/*.F BCVEGPY/*.f,$(eval xfile:=$(wildcard src/GeneratorInterface/GenExtensions/bin/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/GenExtensions/bin/$(file). Please fix src/GeneratorInterface/GenExtensions/bin/BuildFile.))))
GeneratorInterfaceBCVEGPY_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/GenExtensions/bin/BuildFile
GeneratorInterfaceBCVEGPY_LOC_USE := self   pythia6 f77compiler 
GeneratorInterfaceBCVEGPY_PACKAGE := self/src/GeneratorInterface/GenExtensions/bin
ALL_PRODS += GeneratorInterfaceBCVEGPY
GeneratorInterfaceBCVEGPY_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceBCVEGPY,src/GeneratorInterface/GenExtensions/bin,src_GeneratorInterface_GenExtensions_bin,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
GeneratorInterfaceBCVEGPY_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceBCVEGPY,src/GeneratorInterface/GenExtensions/bin))
endif
ALL_COMMONRULES += src_GeneratorInterface_GenExtensions_bin
src_GeneratorInterface_GenExtensions_bin_parent := GeneratorInterface/GenExtensions
src_GeneratorInterface_GenExtensions_bin_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_GenExtensions_bin,src/GeneratorInterface/GenExtensions/bin,BINARY))
ifeq ($(strip $(Hydjet2Analyzer)),)
Hydjet2Analyzer := self/src/GeneratorInterface/Hydjet2Interface/test
Hydjet2Analyzer_files := $(patsubst src/GeneratorInterface/Hydjet2Interface/test/%,%,$(foreach file,Hydjet2Analyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Hydjet2Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Hydjet2Interface/test/$(file). Please fix src/GeneratorInterface/Hydjet2Interface/test/BuildFile.))))
Hydjet2Analyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Hydjet2Interface/test/BuildFile
Hydjet2Analyzer_LOC_USE := self   boost root heppdt FWCore/Framework SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimDataFormats/HiGenData SimGeneral/HepPDTRecord CommonTools/UtilAlgos FWCore/ServiceRegistry FWCore/Utilities 
Hydjet2Analyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,Hydjet2Analyzer,Hydjet2Analyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Hydjet2Interface/test))
Hydjet2Analyzer_PACKAGE := self/src/GeneratorInterface/Hydjet2Interface/test
ALL_PRODS += Hydjet2Analyzer
Hydjet2Analyzer_INIT_FUNC        += $$(eval $$(call Library,Hydjet2Analyzer,src/GeneratorInterface/Hydjet2Interface/test,src_GeneratorInterface_Hydjet2Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
Hydjet2Analyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,Hydjet2Analyzer,src/GeneratorInterface/Hydjet2Interface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_Hydjet2Interface_test
src_GeneratorInterface_Hydjet2Interface_test_parent := GeneratorInterface/Hydjet2Interface
src_GeneratorInterface_Hydjet2Interface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Hydjet2Interface_test,src/GeneratorInterface/Hydjet2Interface/test,TEST))
ifeq ($(strip $(HydjetAnalyzer)),)
HydjetAnalyzer := self/src/GeneratorInterface/HydjetInterface/test
HydjetAnalyzer_files := $(patsubst src/GeneratorInterface/HydjetInterface/test/%,%,$(foreach file,HydjetAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/HydjetInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/HydjetInterface/test/$(file). Please fix src/GeneratorInterface/HydjetInterface/test/BuildFile.))))
HydjetAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/HydjetInterface/test/BuildFile
HydjetAnalyzer_LOC_USE := self   boost root heppdt FWCore/Framework SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimDataFormats/HiGenData SimGeneral/HepPDTRecord CommonTools/UtilAlgos FWCore/ServiceRegistry FWCore/Utilities 
HydjetAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,HydjetAnalyzer,HydjetAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/HydjetInterface/test))
HydjetAnalyzer_PACKAGE := self/src/GeneratorInterface/HydjetInterface/test
ALL_PRODS += HydjetAnalyzer
HydjetAnalyzer_INIT_FUNC        += $$(eval $$(call Library,HydjetAnalyzer,src/GeneratorInterface/HydjetInterface/test,src_GeneratorInterface_HydjetInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
HydjetAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,HydjetAnalyzer,src/GeneratorInterface/HydjetInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_HydjetInterface_test
src_GeneratorInterface_HydjetInterface_test_parent := GeneratorInterface/HydjetInterface
src_GeneratorInterface_HydjetInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_HydjetInterface_test,src/GeneratorInterface/HydjetInterface/test,TEST))
ifeq ($(strip $(PyquenAnalyzer)),)
PyquenAnalyzer := self/src/GeneratorInterface/PyquenInterface/test
PyquenAnalyzer_files := $(patsubst src/GeneratorInterface/PyquenInterface/test/%,%,$(foreach file,PyquenAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/PyquenInterface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/PyquenInterface/test/$(file). Please fix src/GeneratorInterface/PyquenInterface/test/BuildFile.))))
PyquenAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/PyquenInterface/test/BuildFile
PyquenAnalyzer_LOC_USE := self   boost root SimDataFormats/GeneratorProducts SimDataFormats/HiGenData CommonTools/UtilAlgos FWCore/Framework 
PyquenAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,PyquenAnalyzer,PyquenAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/PyquenInterface/test))
PyquenAnalyzer_PACKAGE := self/src/GeneratorInterface/PyquenInterface/test
ALL_PRODS += PyquenAnalyzer
PyquenAnalyzer_INIT_FUNC        += $$(eval $$(call Library,PyquenAnalyzer,src/GeneratorInterface/PyquenInterface/test,src_GeneratorInterface_PyquenInterface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
PyquenAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,PyquenAnalyzer,src/GeneratorInterface/PyquenInterface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_PyquenInterface_test
src_GeneratorInterface_PyquenInterface_test_parent := GeneratorInterface/PyquenInterface
src_GeneratorInterface_PyquenInterface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_PyquenInterface_test,src/GeneratorInterface/PyquenInterface/test,TEST))
ifeq ($(strip $(HZZ4muExampleAnalyzer)),)
HZZ4muExampleAnalyzer := self/src/GeneratorInterface/Pythia6Interface/test
HZZ4muExampleAnalyzer_files := $(patsubst src/GeneratorInterface/Pythia6Interface/test/%,%,$(foreach file,HZZ4muAnalyzer.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia6Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia6Interface/test/$(file). Please fix src/GeneratorInterface/Pythia6Interface/test/BuildFile.))))
HZZ4muExampleAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia6Interface/test/BuildFile
HZZ4muExampleAnalyzer_LOC_USE := self   FWCore/Framework root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos 
HZZ4muExampleAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,HZZ4muExampleAnalyzer,HZZ4muExampleAnalyzer,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia6Interface/test))
HZZ4muExampleAnalyzer_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/test
ALL_PRODS += HZZ4muExampleAnalyzer
HZZ4muExampleAnalyzer_INIT_FUNC        += $$(eval $$(call Library,HZZ4muExampleAnalyzer,src/GeneratorInterface/Pythia6Interface/test,src_GeneratorInterface_Pythia6Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
HZZ4muExampleAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,HZZ4muExampleAnalyzer,src/GeneratorInterface/Pythia6Interface/test))
endif
ifeq ($(strip $(SimpleGenTesters)),)
SimpleGenTesters := self/src/GeneratorInterface/Pythia6Interface/test
SimpleGenTesters_files := $(patsubst src/GeneratorInterface/Pythia6Interface/test/%,%,$(foreach file,BasicGenTester.cc TauPhotonTester.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/Pythia6Interface/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/Pythia6Interface/test/$(file). Please fix src/GeneratorInterface/Pythia6Interface/test/BuildFile.))))
SimpleGenTesters_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/Pythia6Interface/test/BuildFile
SimpleGenTesters_LOC_USE := self   FWCore/Framework root SimDataFormats/GeneratorProducts CommonTools/UtilAlgos heppdt SimGeneral/HepPDTRecord 
SimpleGenTesters_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimpleGenTesters,SimpleGenTesters,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/Pythia6Interface/test))
SimpleGenTesters_PACKAGE := self/src/GeneratorInterface/Pythia6Interface/test
ALL_PRODS += SimpleGenTesters
SimpleGenTesters_INIT_FUNC        += $$(eval $$(call Library,SimpleGenTesters,src/GeneratorInterface/Pythia6Interface/test,src_GeneratorInterface_Pythia6Interface_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimpleGenTesters_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimpleGenTesters,src/GeneratorInterface/Pythia6Interface/test))
endif
ALL_COMMONRULES += src_GeneratorInterface_Pythia6Interface_test
src_GeneratorInterface_Pythia6Interface_test_parent := GeneratorInterface/Pythia6Interface
src_GeneratorInterface_Pythia6Interface_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_Pythia6Interface_test,src/GeneratorInterface/Pythia6Interface/test,TEST))
ifeq ($(strip $(SimDigiDumper)),)
SimDigiDumper := self/src/SimGeneral/Debugging/test
SimDigiDumper_files := $(patsubst src/SimGeneral/Debugging/test/%,%,$(foreach file,SimDigiDumper.cc,$(eval xfile:=$(wildcard src/SimGeneral/Debugging/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/Debugging/test/$(file). Please fix src/SimGeneral/Debugging/test/BuildFile.))))
SimDigiDumper_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/Debugging/test/BuildFile
SimDigiDumper_LOC_USE := self   DataFormats/Common DataFormats/EcalDigi DataFormats/HcalDigi DataFormats/SiStripDigi DataFormats/SiPixelDigi DataFormats/DTDigi DataFormats/CSCDigi DataFormats/RPCDigi DataFormats/FTLDigi FWCore/Framework FWCore/MessageLogger 
SimDigiDumper_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimDigiDumper,SimDigiDumper,$(SCRAMSTORENAME_LIB),src/SimGeneral/Debugging/test))
SimDigiDumper_PACKAGE := self/src/SimGeneral/Debugging/test
ALL_PRODS += SimDigiDumper
SimDigiDumper_INIT_FUNC        += $$(eval $$(call Library,SimDigiDumper,src/SimGeneral/Debugging/test,src_SimGeneral_Debugging_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimDigiDumper_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimDigiDumper,src/SimGeneral/Debugging/test))
endif
ALL_COMMONRULES += src_SimGeneral_Debugging_test
src_SimGeneral_Debugging_test_parent := SimGeneral/Debugging
src_SimGeneral_Debugging_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_Debugging_test,src/SimGeneral/Debugging/test,TEST))
ifeq ($(strip $(HepPDTAnalyzer)),)
HepPDTAnalyzer := self/src/SimGeneral/HepPDTESSource/test
HepPDTAnalyzer_files := $(patsubst src/SimGeneral/HepPDTESSource/test/%,%,$(foreach file,HepPDTAnalyzer.cc,$(eval xfile:=$(wildcard src/SimGeneral/HepPDTESSource/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/HepPDTESSource/test/$(file). Please fix src/SimGeneral/HepPDTESSource/test/BuildFile.))))
HepPDTAnalyzer_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/HepPDTESSource/test/BuildFile
HepPDTAnalyzer_LOC_USE := self   SimGeneral/HepPDTRecord FWCore/Framework FWCore/ParameterSet SimDataFormats/GeneratorProducts 
HepPDTAnalyzer_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,HepPDTAnalyzer,HepPDTAnalyzer,$(SCRAMSTORENAME_LIB),src/SimGeneral/HepPDTESSource/test))
HepPDTAnalyzer_PACKAGE := self/src/SimGeneral/HepPDTESSource/test
ALL_PRODS += HepPDTAnalyzer
HepPDTAnalyzer_INIT_FUNC        += $$(eval $$(call Library,HepPDTAnalyzer,src/SimGeneral/HepPDTESSource/test,src_SimGeneral_HepPDTESSource_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
HepPDTAnalyzer_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,HepPDTAnalyzer,src/SimGeneral/HepPDTESSource/test))
endif
ALL_COMMONRULES += src_SimGeneral_HepPDTESSource_test
src_SimGeneral_HepPDTESSource_test_parent := SimGeneral/HepPDTESSource
src_SimGeneral_HepPDTESSource_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTESSource_test,src/SimGeneral/HepPDTESSource/test,TEST))
ifeq ($(strip $(testSimGeneralHepPDTRecord)),)
testSimGeneralHepPDTRecord := self/src/SimGeneral/HepPDTRecord/test
testSimGeneralHepPDTRecord_files := $(patsubst src/SimGeneral/HepPDTRecord/test/%,%,$(foreach file,testPdtEntry.cc testRunner.cpp,$(eval xfile:=$(wildcard src/SimGeneral/HepPDTRecord/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/HepPDTRecord/test/$(file). Please fix src/SimGeneral/HepPDTRecord/test/BuildFile.))))
testSimGeneralHepPDTRecord_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/HepPDTRecord/test/BuildFile
testSimGeneralHepPDTRecord_LOC_USE := self   SimGeneral/HepPDTRecord cppunit 
testSimGeneralHepPDTRecord_PACKAGE := self/src/SimGeneral/HepPDTRecord/test
ALL_PRODS += testSimGeneralHepPDTRecord
testSimGeneralHepPDTRecord_INIT_FUNC        += $$(eval $$(call Binary,testSimGeneralHepPDTRecord,src/SimGeneral/HepPDTRecord/test,src_SimGeneral_HepPDTRecord_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
testSimGeneralHepPDTRecord_CLASS := TEST
testSimGeneralHepPDTRecord_TEST_RUNNER_CMD :=  testSimGeneralHepPDTRecord 
else
$(eval $(call MultipleWarningMsg,testSimGeneralHepPDTRecord,src/SimGeneral/HepPDTRecord/test))
endif
ALL_COMMONRULES += src_SimGeneral_HepPDTRecord_test
src_SimGeneral_HepPDTRecord_test_parent := SimGeneral/HepPDTRecord
src_SimGeneral_HepPDTRecord_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTRecord_test,src/SimGeneral/HepPDTRecord/test,TEST))
ifeq ($(strip $(CorrelatedNoisifierTest)),)
CorrelatedNoisifierTest := self/src/SimGeneral/NoiseGenerators/test
CorrelatedNoisifierTest_files := $(patsubst src/SimGeneral/NoiseGenerators/test/%,%,$(foreach file,CorrelatedNoisifierTest.cpp,$(eval xfile:=$(wildcard src/SimGeneral/NoiseGenerators/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/NoiseGenerators/test/$(file). Please fix src/SimGeneral/NoiseGenerators/test/BuildFile.))))
CorrelatedNoisifierTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/NoiseGenerators/test/BuildFile
CorrelatedNoisifierTest_LOC_USE := self   clhep root FWCore/Framework FWCore/ServiceRegistry FWCore/Utilities SimGeneral/NoiseGenerators CommonTools/Statistics 
CorrelatedNoisifierTest_PACKAGE := self/src/SimGeneral/NoiseGenerators/test
ALL_PRODS += CorrelatedNoisifierTest
CorrelatedNoisifierTest_INIT_FUNC        += $$(eval $$(call Binary,CorrelatedNoisifierTest,src/SimGeneral/NoiseGenerators/test,src_SimGeneral_NoiseGenerators_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
CorrelatedNoisifierTest_CLASS := TEST
CorrelatedNoisifierTest_TEST_RUNNER_CMD :=  CorrelatedNoisifierTest 
else
$(eval $(call MultipleWarningMsg,CorrelatedNoisifierTest,src/SimGeneral/NoiseGenerators/test))
endif
ifeq ($(strip $(GaussianTailNoiseGeneratorTest)),)
GaussianTailNoiseGeneratorTest := self/src/SimGeneral/NoiseGenerators/test
GaussianTailNoiseGeneratorTest_files := $(patsubst src/SimGeneral/NoiseGenerators/test/%,%,$(foreach file,GaussianTailNoiseGeneratorTest.cc,$(eval xfile:=$(wildcard src/SimGeneral/NoiseGenerators/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/NoiseGenerators/test/$(file). Please fix src/SimGeneral/NoiseGenerators/test/BuildFile.))))
GaussianTailNoiseGeneratorTest_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/NoiseGenerators/test/BuildFile
GaussianTailNoiseGeneratorTest_LOC_USE := self   clhep root FWCore/Framework FWCore/ServiceRegistry FWCore/Utilities SimGeneral/NoiseGenerators CommonTools/Statistics 
GaussianTailNoiseGeneratorTest_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GaussianTailNoiseGeneratorTest,GaussianTailNoiseGeneratorTest,$(SCRAMSTORENAME_LIB),src/SimGeneral/NoiseGenerators/test))
GaussianTailNoiseGeneratorTest_PACKAGE := self/src/SimGeneral/NoiseGenerators/test
ALL_PRODS += GaussianTailNoiseGeneratorTest
GaussianTailNoiseGeneratorTest_INIT_FUNC        += $$(eval $$(call Library,GaussianTailNoiseGeneratorTest,src/SimGeneral/NoiseGenerators/test,src_SimGeneral_NoiseGenerators_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GaussianTailNoiseGeneratorTest_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,GaussianTailNoiseGeneratorTest,src/SimGeneral/NoiseGenerators/test))
endif
ALL_COMMONRULES += src_SimGeneral_NoiseGenerators_test
src_SimGeneral_NoiseGenerators_test_parent := SimGeneral/NoiseGenerators
src_SimGeneral_NoiseGenerators_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_NoiseGenerators_test,src/SimGeneral/NoiseGenerators/test,TEST))
ifeq ($(strip $(runtestSimGeneralPreMixingModule)),)
runtestSimGeneralPreMixingModule := self/src/SimGeneral/PreMixingModule/test
runtestSimGeneralPreMixingModule_files := 1
runtestSimGeneralPreMixingModule_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PreMixingModule/test/BuildFile
runtestSimGeneralPreMixingModule_LOC_USE := self   
runtestSimGeneralPreMixingModule_PACKAGE := self/src/SimGeneral/PreMixingModule/test
ALL_PRODS += runtestSimGeneralPreMixingModule
runtestSimGeneralPreMixingModule_INIT_FUNC        += $$(eval $$(call Binary,runtestSimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/test,src_SimGeneral_PreMixingModule_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_TEST),test,$(SCRAMSTORENAME_LOGS)))
runtestSimGeneralPreMixingModule_CLASS := TEST
runtestSimGeneralPreMixingModule_TEST_RUNNER_CMD :=  run_testPremixPileupAdjustment.sh
else
$(eval $(call MultipleWarningMsg,runtestSimGeneralPreMixingModule,src/SimGeneral/PreMixingModule/test))
endif
ifeq ($(strip $(SimGeneralPreMixingModuleTestPlugins)),)
SimGeneralPreMixingModuleTestPlugins := self/src/SimGeneral/PreMixingModule/test
SimGeneralPreMixingModuleTestPlugins_files := $(patsubst src/SimGeneral/PreMixingModule/test/%,%,$(foreach file,TestPreMixingPileupAnalyzer.cc,$(eval xfile:=$(wildcard src/SimGeneral/PreMixingModule/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/PreMixingModule/test/$(file). Please fix src/SimGeneral/PreMixingModule/test/BuildFile.))))
SimGeneralPreMixingModuleTestPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/PreMixingModule/test/BuildFile
SimGeneralPreMixingModuleTestPlugins_LOC_USE := self   DataFormats/Common FWCore/Framework FWCore/ParameterSet FWCore/Utilities SimDataFormats/PileupSummaryInfo 
SimGeneralPreMixingModuleTestPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralPreMixingModuleTestPlugins,SimGeneralPreMixingModuleTestPlugins,$(SCRAMSTORENAME_LIB),src/SimGeneral/PreMixingModule/test))
SimGeneralPreMixingModuleTestPlugins_PACKAGE := self/src/SimGeneral/PreMixingModule/test
ALL_PRODS += SimGeneralPreMixingModuleTestPlugins
SimGeneralPreMixingModuleTestPlugins_INIT_FUNC        += $$(eval $$(call Library,SimGeneralPreMixingModuleTestPlugins,src/SimGeneral/PreMixingModule/test,src_SimGeneral_PreMixingModule_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralPreMixingModuleTestPlugins_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralPreMixingModuleTestPlugins,src/SimGeneral/PreMixingModule/test))
endif
ALL_COMMONRULES += src_SimGeneral_PreMixingModule_test
src_SimGeneral_PreMixingModule_test_parent := SimGeneral/PreMixingModule
src_SimGeneral_PreMixingModule_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_PreMixingModule_test,src/SimGeneral/PreMixingModule/test,TEST))
ifeq ($(strip $(SimGeneralTrackingAnalysis_test)),)
SimGeneralTrackingAnalysis_test := self/src/SimGeneral/TrackingAnalysis/test
SimGeneralTrackingAnalysis_test_files := $(patsubst src/SimGeneral/TrackingAnalysis/test/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/SimGeneral/TrackingAnalysis/test/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/SimGeneral/TrackingAnalysis/test/$(file). Please fix src/SimGeneral/TrackingAnalysis/test/BuildFile.))))
SimGeneralTrackingAnalysis_test_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/TrackingAnalysis/test/BuildFile
SimGeneralTrackingAnalysis_test_LOC_USE := self   clhep FWCore/Framework SimDataFormats/TrackingAnalysis SimDataFormats/Track SimDataFormats/GeneratorProducts 
SimGeneralTrackingAnalysis_test_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralTrackingAnalysis_test,SimGeneralTrackingAnalysis_test,$(SCRAMSTORENAME_LIB),src/SimGeneral/TrackingAnalysis/test))
SimGeneralTrackingAnalysis_test_PACKAGE := self/src/SimGeneral/TrackingAnalysis/test
ALL_PRODS += SimGeneralTrackingAnalysis_test
SimGeneralTrackingAnalysis_test_INIT_FUNC        += $$(eval $$(call Library,SimGeneralTrackingAnalysis_test,src/SimGeneral/TrackingAnalysis/test,src_SimGeneral_TrackingAnalysis_test,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
SimGeneralTrackingAnalysis_test_CLASS := TEST_LIBRARY
else
$(eval $(call MultipleWarningMsg,SimGeneralTrackingAnalysis_test,src/SimGeneral/TrackingAnalysis/test))
endif
ALL_COMMONRULES += src_SimGeneral_TrackingAnalysis_test
src_SimGeneral_TrackingAnalysis_test_parent := SimGeneral/TrackingAnalysis
src_SimGeneral_TrackingAnalysis_test_INIT_FUNC += $$(eval $$(call CommonProductRules,src_SimGeneral_TrackingAnalysis_test,src/SimGeneral/TrackingAnalysis/test,TEST))
ALL_SUBSYSTEMS+=Configuration
subdirs_src_Configuration = src_Configuration_GenProduction
subdirs_src += src_Configuration
ALL_PACKAGES += Configuration/GenProduction
subdirs_src_Configuration_GenProduction := src_Configuration_GenProduction_python
ifeq ($(strip $(PyConfigurationGenProduction)),)
PyConfigurationGenProduction := self/src/Configuration/GenProduction/python
src_Configuration_GenProduction_python_parent := src/Configuration/GenProduction
ALL_PYTHON_DIRS += $(patsubst src/%,%,src/Configuration/GenProduction/python)
PyConfigurationGenProduction_files := $(patsubst src/Configuration/GenProduction/python/%,%,$(wildcard $(foreach dir,src/Configuration/GenProduction/python ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
PyConfigurationGenProduction_LOC_USE := self   
PyConfigurationGenProduction_PACKAGE := self/src/Configuration/GenProduction/python
ALL_PRODS += PyConfigurationGenProduction
PyConfigurationGenProduction_INIT_FUNC        += $$(eval $$(call PythonProduct,PyConfigurationGenProduction,src/Configuration/GenProduction/python,src_Configuration_GenProduction_python))
else
$(eval $(call MultipleWarningMsg,PyConfigurationGenProduction,src/Configuration/GenProduction/python))
endif
ALL_COMMONRULES += src_Configuration_GenProduction_python
src_Configuration_GenProduction_python_INIT_FUNC += $$(eval $$(call CommonProductRules,src_Configuration_GenProduction_python,src/Configuration/GenProduction/python,PYTHON))
