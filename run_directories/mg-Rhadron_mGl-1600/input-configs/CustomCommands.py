#import FWCore.ParameterSet.Config as cms
#from Configuration.StandardSequences.earlyDeleteSettings_cff import customiseEarlyDelete
#
#def addCustomisation(process):
#    # —— Message logger and random seeds ——
#
#    # Ensure FwkReport exists on both cerr and cout:
#    process.MessageLogger.cerr.FwkReport = cms.untracked.PSet(
#        reportEvery = cms.untracked.int32(1)
#    )
#    process.MessageLogger.cout.FwkReport = cms.untracked.PSet(
#        reportEvery = cms.untracked.int32(1)
#    )
#
#    # Then set thresholds and other PSets:
#    #process.MessageLogger.cerr.threshold = 'INFO'
#    #process.MessageLogger.cerr.G4cout    = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#    #process.MessageLogger.cerr.G4cerr    = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#    #process.MessageLogger.cerr.SimG4CoreApplication   = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#    #process.MessageLogger.cerr.SimG4CorePhysicsLists = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#    #process.MessageLogger.cerr.SimG4CoreGeometry     = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#
#    #process.MessageLogger.cout.threshold = 'INFO'
#    #process.MessageLogger.cout.G4cout    = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#    #process.MessageLogger.cout.G4cerr    = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#    #process.MessageLogger.cout.SimG4CoreApplication   = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#    #process.MessageLogger.cout.SimG4CorePhysicsLists = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#    #process.MessageLogger.cout.SimG4CoreGeometry     = cms.untracked.PSet(limit = cms.untracked.int32(-1))
#
#    # Random seeds:
#    process.RandomNumberGeneratorService.generator.initialSeed   = cms.untracked.uint32(123456789)
#    process.RandomNumberGeneratorService.g4SimHits.initialSeed   = cms.untracked.uint32(987654321)
#    process.RandomNumberGeneratorService.VtxSmeared.initialSeed  = cms.untracked.uint32(192837465)
#    process.rndmStore = cms.EDProducer('RandomEngineStateProducer')
#
#    # —— Custom Geant4 physics and particle dump ——  
#    process.load('SimG4Core.CustomPhysics.CustomPhysics_cfi')
#    process.customPhysicsSetup.particlesDef = cms.FileInPath('SimGeneral/HepPDTESSource/data/Pythia8_RhadronParticleDataTable.dat')
#    process.g4SimHits.Physics.type = cms.string('SimG4Core/Physics/CustomPhysics')
#    process.g4SimHits.Physics = cms.PSet(
#        process.g4SimHits.Physics,
#        process.customPhysicsSetup
#    )
#    process.g4SimHits.G4Commands = cms.vstring(
#        '/control/verbose 2',
#        '/run/verbose 2',
#        '/run/initialize',
#        '/run/particle/dumpList'
#    )
#
#    # —— Early-delete to save memory ——  
#    process = customiseEarlyDelete(process)
#
#    return process


import FWCore.ParameterSet.Config as cms
from Configuration.StandardSequences.earlyDeleteSettings_cff import customiseEarlyDelete

def addCustomisation(process):
    # — Always apply logging & RNG seeds (LHE, GEN, SIM) —
    process.MessageLogger.cerr.FwkReport = cms.untracked.PSet(reportEvery = cms.untracked.int32(1))
    process.MessageLogger.cout.FwkReport = cms.untracked.PSet(reportEvery = cms.untracked.int32(1))

    process.RandomNumberGeneratorService.generator.initialSeed  = cms.untracked.uint32(123456789)
    process.RandomNumberGeneratorService.g4SimHits.initialSeed  = cms.untracked.uint32(987654321)
    process.RandomNumberGeneratorService.VtxSmeared.initialSeed = cms.untracked.uint32(192837465)
    process.rndmStore = cms.EDProducer('RandomEngineStateProducer')

    # — Only if running SIM (i.e. g4SimHits is defined) —
    #if hasattr(process, 'g4SimHits'):
    #    process.MessageLogger.cerr.threshold = 'INFO'
    #    process.MessageLogger.cerr.G4cout    = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    process.MessageLogger.cerr.G4cerr    = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    process.MessageLogger.cerr.SimG4CoreCustomPhysics = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    process.MessageLogger.cerr.SimG4CoreApplication   = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    #process.MessageLogger.cerr.SimG4CorePhysicsLists = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    #process.MessageLogger.cerr.SimG4CoreGeometry     = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    process.MessageLogger.cout.threshold = 'INFO'
    #    process.MessageLogger.cout.G4cout    = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    process.MessageLogger.cout.G4cerr    = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    process.MessageLogger.cout.SimG4CoreApplication   = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    process.MessageLogger.cout.SimG4CoreCustomPhysics = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    #process.MessageLogger.cout.SimG4CorePhysicsLists = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    #process.MessageLogger.cout.SimG4CoreGeometry     = cms.untracked.PSet(limit = cms.untracked.int32(-1))
    #    process.load('SimG4Core.CustomPhysics.CustomPhysics_cfi')
    #    process.customPhysicsSetup.particlesDef = cms.FileInPath('SimG4Core/CustomPhysics/data/Pythia8_RhadronParticleDataTable_edited.dat')
    #    process.customPhysicsSetup.processesDef = cms.FileInPath('SimG4Core/CustomPhysics/data/UpdatedRhadronProcessList.txt')
    #    process.g4SimHits.Physics.type      = cms.string('SimG4Core/Physics/CustomPhysics')
    #    process.g4SimHits.Physics.Verbosity = cms.untracked.int32(1)
    #    process.g4SimHits.Physics = cms.PSet(
    #      process.g4SimHits.Physics,
    #      process.customPhysicsSetup
    #    )
    #    process.g4SimHits.G4Commands = cms.vstring(
    #        '/control/verbose 2',
    #        '/run/verbose 1',
    #        '/event/verbose 1',
    #        '/run/initialize',              # build physics list
    #        '/run/particle/dumpList',       # list all particles (look for R+, R0, R-)
    #        '/process/list Hadronic',       # list hadronic processes (case‐sensitive)
    #        '/process/dump FullModelHadronicProcess R+',  
    #        '/process/dump CMSSIMPInelasticProcess R0',
    #        '/run/beamOn 1'                 # shoot one test event
    #        

    # — Early delete to save memory —
    process = customiseEarlyDelete(process)
    return process
