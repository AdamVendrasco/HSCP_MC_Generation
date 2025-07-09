ifeq ($(strip $(GeneratorInterfaceGenFiltersPlugins)),)
GeneratorInterfaceGenFiltersPlugins := self/src/GeneratorInterface/GenFilters/plugins
PLUGINS:=yes
GeneratorInterfaceGenFiltersPlugins_files := $(patsubst src/GeneratorInterface/GenFilters/plugins/%,%,$(foreach file,*.cc,$(eval xfile:=$(wildcard src/GeneratorInterface/GenFilters/plugins/$(file)))$(if $(xfile),$(xfile),$(warning No such file exists: src/GeneratorInterface/GenFilters/plugins/$(file). Please fix src/GeneratorInterface/GenFilters/plugins/BuildFile.))))
GeneratorInterfaceGenFiltersPlugins_BuildFile    := $(WORKINGDIR)/cache/bf/src/GeneratorInterface/GenFilters/plugins/BuildFile
GeneratorInterfaceGenFiltersPlugins_LOC_USE := self   FWCore/ParameterSet FWCore/Framework FWCore/Utilities SimDataFormats/GeneratorProducts GeneratorInterface/Core SimGeneral/HepPDTRecord DataFormats/GeometryVector DataFormats/GeometrySurface TrackPropagation/SteppingHelixPropagator MagneticField/Records TrackingTools/TrajectoryState TrackingTools/TrajectoryParametrization TrackingTools/Records CommonTools/UtilAlgos FWCore/ServiceRegistry TrackingTools/GeomPropagators DataFormats/HepMCCandidate DataFormats/JetReco DataFormats/Math SimDataFormats/HTXS fastjet boost heppdt clhep rootcore pythia6 pythia8 
GeneratorInterfaceGenFiltersPlugins_PRE_INIT_FUNC += $$(eval $$(call edmPlugin,GeneratorInterfaceGenFiltersPlugins,GeneratorInterfaceGenFiltersPlugins,$(SCRAMSTORENAME_LIB),src/GeneratorInterface/GenFilters/plugins))
GeneratorInterfaceGenFiltersPlugins_PACKAGE := self/src/GeneratorInterface/GenFilters/plugins
ALL_PRODS += GeneratorInterfaceGenFiltersPlugins
GeneratorInterface/GenFilters_forbigobj+=GeneratorInterfaceGenFiltersPlugins
GeneratorInterfaceGenFiltersPlugins_INIT_FUNC        += $$(eval $$(call Library,GeneratorInterfaceGenFiltersPlugins,src/GeneratorInterface/GenFilters/plugins,src_GeneratorInterface_GenFilters_plugins,$(SCRAMSTORENAME_BIN),,$(SCRAMSTORENAME_LIB),$(SCRAMSTORENAME_LOGS),edm))
GeneratorInterfaceGenFiltersPlugins_CLASS := LIBRARY
else
$(eval $(call MultipleWarningMsg,GeneratorInterfaceGenFiltersPlugins,src/GeneratorInterface/GenFilters/plugins))
endif
ALL_COMMONRULES += src_GeneratorInterface_GenFilters_plugins
src_GeneratorInterface_GenFilters_plugins_parent := GeneratorInterface/GenFilters
src_GeneratorInterface_GenFilters_plugins_INIT_FUNC += $$(eval $$(call CommonProductRules,src_GeneratorInterface_GenFilters_plugins,src/GeneratorInterface/GenFilters/plugins,PLUGINS))
