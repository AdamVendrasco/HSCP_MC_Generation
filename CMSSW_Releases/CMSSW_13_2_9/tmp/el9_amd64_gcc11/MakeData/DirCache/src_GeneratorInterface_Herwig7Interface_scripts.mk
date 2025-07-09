src_GeneratorInterface_Herwig7Interface_scripts_files := $(filter-out \#% %\#,$(notdir $(wildcard $(foreach dir,$(LOCALTOP)/src/GeneratorInterface/Herwig7Interface/scripts,$(dir)/*))))
$(eval $(call Src2StoreCopy,src_GeneratorInterface_Herwig7Interface_scripts,src/GeneratorInterface/Herwig7Interface/scripts,$(SCRAMSTORENAME_BIN),*))
