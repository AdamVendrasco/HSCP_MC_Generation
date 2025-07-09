ifeq ($(strip $(SimGeneral/HepPDTRecord)),)
ALL_COMMONRULES += src_SimGeneral_HepPDTRecord_src
src_SimGeneral_HepPDTRecord_src_parent := SimGeneral/HepPDTRecord
src_SimGeneral_HepPDTRecord_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTRecord_src,src/SimGeneral/HepPDTRecord/src,LIBRARY))
SimGeneralHepPDTRecord := self/SimGeneral/HepPDTRecord
SimGeneral/HepPDTRecord := SimGeneralHepPDTRecord
SimGeneralHepPDTRecord_files := $(patsubst src/SimGeneral/HepPDTRecord/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/HepPDTRecord/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralHepPDTRecord_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/HepPDTRecord/BuildFile
SimGeneralHepPDTRecord_LOC_USE := self   FWCore/Framework FWCore/ParameterSet heppdt 
SimGeneralHepPDTRecord_EX_LIB   := SimGeneralHepPDTRecord
SimGeneralHepPDTRecord_EX_USE   := $(foreach d,$(SimGeneralHepPDTRecord_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimGeneralHepPDTRecord_PACKAGE := self/src/SimGeneral/HepPDTRecord/src
ALL_PRODS += SimGeneralHepPDTRecord
SimGeneralHepPDTRecord_CLASS := LIBRARY
SimGeneral/HepPDTRecord_forbigobj+=SimGeneralHepPDTRecord
SimGeneralHepPDTRecord_INIT_FUNC        += $$(eval $$(call Library,SimGeneralHepPDTRecord,src/SimGeneral/HepPDTRecord/src,src_SimGeneral_HepPDTRecord_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),))
endif
