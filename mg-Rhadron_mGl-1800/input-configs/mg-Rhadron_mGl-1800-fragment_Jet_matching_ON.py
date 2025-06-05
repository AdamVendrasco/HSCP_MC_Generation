import FWCore.ParameterSet.Config as cms

externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/input-configs/mg-Rhadron_mGl-1800_el9_amd64_gcc11_CMSSW_13_2_9_tarball.tar.xz'),
    nEvents = cms.untracked.uint32(20000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)

from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.MCTunes2017.PythiaCP5Settings_cfi import *

generator = cms.EDFilter("Pythia8HadronizerFilter",
    maxEventsToPrint = cms.untracked.int32(1),
    pythiaPylistVerbosity = cms.untracked.int32(1),
    filterEfficiency = cms.untracked.double(1.0),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    comEnergy = cms.double(13600.),
    PythiaParameters = cms.PSet(
        pythia8CommonSettingsBlock,
        pythia8CP5SettingsBlock,
        processParameters = cms.vstring(
            'JetMatching:setMad = on',
            'JetMatching:scheme = 1',
            'JetMatching:merge = on',
            'JetMatching:jetAlgorithm = 2',
            'JetMatching:etaJetMax = 5.',
            'JetMatching:coneRadius = 1.',
            'JetMatching:slowJetPower = 1',
            'JetMatching:qCut = 100.', #this is the actual merging scale
            'JetMatching:clFact = 1', # determines jet-to parton matching
            'JetMatching:nQmatch = 5', #5 for 5-flavour scheme (matching of b-quarks)
            'JetMatching:nJetMax = 1', #number of partons in born matrix element for highest multiplicity
            'JetMatching:doShowerKt = off',
            
            # Enable Rhadrons
            'RHadrons:allow  = on',
            'RHadrons:allowDecay = off',
            'RHadrons:setMasses = on',
            'RHadrons:probGluinoball = 0.1',

           # Additional hadronization and debug information
           'HadronLevel:Hadronize = on',  # Ensure hadronization is enabled
           'PartonLevel:ISR = on',  # Enable Initial State Radiation
           'PartonLevel:FSR = on',  # Enable Final State Radiation
           'PartonLevel:MPI = on',  # Enable Multi-Parton Interactions
           'Check:particleData = on',  # Check particle properties
           
           # Extended verbosity for debugging
           'Main:timesAllowErrors = 10000',  # how many aborts before run stops
           'Init:showChangedSettings = on',  # list changed settings that differ from default
           'Init:showProcesses = on',
           'Init:showChangedParticleData = on', # list changed particle data
           'Init:showAllSettings = on',  # Show all settings
           'Next:numberCount = 100',  # print message every n events
           'Next:numberShowEvent = 0',# set to 0 here (we do events separately)
           'Next:numberShowInfo = 1',  # print event information n times
           'Next:numberShowProcess = 1',  # print process record n times
           'Next:numberShowEvent = 1',  # print event record n times
       ),
        
        parameterSets = cms.vstring('pythia8CommonSettings',
                                    'pythia8CP5Settings',
                                    'processParameters',
                                    )
    )
)

# We would like to change the particleID lists to be more inclusive of all RHadrons.
dirhadrongenfilter = cms.EDFilter("MCParticlePairFilter",
    Status = cms.untracked.vint32(1, 1),
    MinPt = cms.untracked.vdouble(0., 0.),
    MinP = cms.untracked.vdouble(0., 0.),
    MaxEta = cms.untracked.vdouble(100., 100.),
    MinEta = cms.untracked.vdouble(-100, -100),
    ParticleCharge = cms.untracked.int32(0),
    ParticleID1 = cms.untracked.vint32(1000993,1009213,1009313,1009323,1009113,1009223,1009333,1091114,1092114,1092214,1092224,1093114,1093214,1093224,1093314,1093324,1093334),
    ParticleID2 = cms.untracked.vint32(1000993,1009213,1009313,1009323,1009113,1009223,1009333,1091114,1092114,1092214,1092224,1093114,1093214,1093224,1093314,1093324,1093334)
)

ProductionFilterSequence = cms.Sequence(generator * dirhadrongenfilter)
