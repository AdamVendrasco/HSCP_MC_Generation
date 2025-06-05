ALL_TOOLS      += geant4_interface
geant4_interface_EX_INCLUDE := /cvmfs/cms.cern.ch/el9_amd64_gcc11/external/geant4/11.1.1-cef8f654ffc8ce85b4289fbc71e1e0a7/include/Geant4 /cvmfs/cms.cern.ch/el9_amd64_gcc11/external/geant4/11.1.1-cef8f654ffc8ce85b4289fbc71e1e0a7/include
geant4_interface_EX_USE := clhep vecgeom zlib expat xerces-c root_cxxdefaults
geant4_interface_EX_FLAGS_CPPDEFINES  := -DGNU_GCC -DG4V9
geant4_interface_EX_FLAGS_CXXFLAGS  := -ftls-model=global-dynamic -pthread

