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
