ifeq ($(strip $(SimG4Core/HelpfulWatchers)),)
ALL_COMMONRULES += src_SimG4Core_HelpfulWatchers_src
src_SimG4Core_HelpfulWatchers_src_parent := SimG4Core/HelpfulWatchers
src_SimG4Core_HelpfulWatchers_src_INIT_FUNC := $$(eval $$(call CommonProductRules,src_SimG4Core_HelpfulWatchers_src,src/SimG4Core/HelpfulWatchers/src,LIBRARY))
SimG4CoreHelpfulWatchers := self/SimG4Core/HelpfulWatchers
SimG4Core/HelpfulWatchers := SimG4CoreHelpfulWatchers
SimG4CoreHelpfulWatchers_files := $(patsubst src/SimG4Core/HelpfulWatchers/src/%,%,$(wildcard $(foreach dir,src/SimG4Core/HelpfulWatchers/src ,$(foreach ext,$(SRC_FILES_SUFFIXES),$(dir)/*.$(ext)))))
SimG4CoreHelpfulWatchers_BuildFile    := $(WORKINGDIR)/cache/bf/src/SimG4Core/HelpfulWatchers/BuildFile
SimG4CoreHelpfulWatchers_LOC_USE := self   FWCore/Framework FWCore/ParameterSet SimG4Core/Watcher SimG4Core/Notification boost geant4core CommonTools/UtilAlgos MagneticField/Engine MagneticField/Records SimG4Core/Physics 
SimG4CoreHelpfulWatchers_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,SimG4CoreHelpfulWatchers,SimG4CoreHelpfulWatchers,$(SCRAMSTORENAME_LIB),src/SimG4Core/HelpfulWatchers/src))
SimG4CoreHelpfulWatchers_PACKAGE := self/src/SimG4Core/HelpfulWatchers/src
ALL_PRODS += SimG4CoreHelpfulWatchers
SimG4CoreHelpfulWatchers_CLASS := LIBRARY
SimG4Core/HelpfulWatchers_forbigobj+=SimG4CoreHelpfulWatchers
SimG4CoreHelpfulWatchers_INIT_FUNC        += $$(eval $$(call Library,SimG4CoreHelpfulWatchers,src/SimG4Core/HelpfulWatchers/src,src_SimG4Core_HelpfulWatchers_src,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
endif
