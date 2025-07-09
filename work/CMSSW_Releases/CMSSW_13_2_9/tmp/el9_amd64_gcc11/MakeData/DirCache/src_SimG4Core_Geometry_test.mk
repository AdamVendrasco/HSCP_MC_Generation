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
