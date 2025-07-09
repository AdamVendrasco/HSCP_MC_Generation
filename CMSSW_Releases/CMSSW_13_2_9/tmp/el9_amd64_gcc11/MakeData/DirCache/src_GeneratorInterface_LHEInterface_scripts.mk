src_GeneratorInterface_LHEInterface_scripts_files := $(filter-out \#% %\#,$(notdir $(wildcard $(foreach dir,$(LOCALTOP)/src/GeneratorInterface/LHEInterface/scripts,$(dir)/*))))
$(eval $(call Src2StoreCopy,src_GeneratorInterface_LHEInterface_scripts,src/GeneratorInterface/LHEInterface/scripts,$(SCRAMSTORENAME_BIN),*))
