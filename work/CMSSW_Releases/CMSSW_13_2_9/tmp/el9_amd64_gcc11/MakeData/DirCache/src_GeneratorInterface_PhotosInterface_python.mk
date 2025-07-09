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
