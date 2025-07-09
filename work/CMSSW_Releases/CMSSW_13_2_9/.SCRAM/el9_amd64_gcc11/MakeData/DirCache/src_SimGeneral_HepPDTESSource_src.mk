ifeq ($(strip $(SimGeneral/HepPDTESSource)),)
ALL_COMMONRULES += src_SimGeneral_HepPDTESSource_src
src_SimGeneral_HepPDTESSource_src_parent := SimGeneral/HepPDTESSource
src_SimGeneral_HepPDTESSource_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimGeneral_HepPDTESSource_src,src/SimGeneral/HepPDTESSource/src,LIBRARY))
SimGeneralHepPDTESSource := self/SimGeneral/HepPDTESSource
SimGeneral/HepPDTESSource := SimGeneralHepPDTESSource
SimGeneralHepPDTESSource_files := $(patsubst src/SimGeneral/HepPDTESSource/src/%,%,$(wildcard $(foreach dir,src/SimGeneral/HepPDTESSource/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimGeneralHepPDTESSource_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimGeneral/HepPDTESSource/BuildFile
SimGeneralHepPDTESSource_LOC_USE := self   SimGeneral/HepPDTRecord heppdt 
SimGeneralHepPDTESSource_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimGeneralHepPDTESSource,SimGeneralHepPDTESSource,$(SCRAMSTORENAME_LIB),src/SimGeneral/HepPDTESSource/src))
SimGeneralHepPDTESSource_PACKAGE := self/src/SimGeneral/HepPDTESSource/src
ALL_PRODS += SimGeneralHepPDTESSource
SimGeneralHepPDTESSource_CLASS := LIBRARY
SimGeneral/HepPDTESSource_forbigobj+=SimGeneralHepPDTESSource
SimGeneralHepPDTESSource_INIT_FUNC        += $$(eval $$(call Library,SimGeneralHepPDTESSource,src/SimGeneral/HepPDTESSource/src,src_SimGeneral_HepPDTESSource_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
