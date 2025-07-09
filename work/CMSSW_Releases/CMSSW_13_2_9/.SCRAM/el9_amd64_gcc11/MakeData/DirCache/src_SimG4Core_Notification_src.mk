ifeq ($(strip $(SimG4Core/Notification)),)
ALL_COMMONRULES += src_SimG4Core_Notification_src
src_SimG4Core_Notification_src_parent := SimG4Core/Notification
src_SimG4Core_Notification_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_Notification_src,src/SimG4Core/Notification/src,LIBRARY))
SimG4CoreNotification := self/SimG4Core/Notification
SimG4Core/Notification := SimG4CoreNotification
SimG4CoreNotification_files := $(patsubst src/SimG4Core/Notification/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/Notification/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreNotification_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/Notification/BuildFile
SimG4CoreNotification_LOC_USE := self   SimDataFormats/Forward SimDataFormats/Track SimDataFormats/Vertex DataFormats/Math geant4core FWCore/MessageLogger rootmath expat hepmc 
SimG4CoreNotification_EX_LIB   := SimG4CoreNotification
SimG4CoreNotification_EX_USE   := $(foreach d,$(SimG4CoreNotification_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CoreNotification_PACKAGE := self/src/SimG4Core/Notification/src
ALL_PRODS += SimG4CoreNotification
SimG4CoreNotification_CLASS := LIBRARY
SimG4Core/Notification_forbigobj+=SimG4CoreNotification
SimG4CoreNotification_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreNotification,src/SimG4Core/Notification/src,src_SimG4Core_Notification_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
