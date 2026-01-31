import FWCore.ParameterSet.Config as cms
from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.MCTunesRun3ECM13p6TeV.PythiaCP5Settings_cfi import *
from Configuration.Generator.PSweightsPythia.PythiaPSweightsSettings_cfi import *

externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('root://cmseos.fnal.gov//store/user/avendras/HSCP/gridpack_output/tarballs/RunIII/stops/HSCPgluino_M-1000/HSCPstop_M-1000_xqcut100_el9_amd64_gcc11_CMSSW_13_2_9_xqcut100_tarball.tar.xz '),
    nEvents = cms.untracked.uint32(20000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_xrootd.sh')#Changed to  xrootd run-tarball
    #scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh') 
)

FLAVOR = 'stop'
COM_ENERGY = 13600. # GeV
MASS_POINT = 1000   # GeV
PROCESS_FILE = 'SimG4Core/CustomPhysics/data/stophadronProcessList.txt'
PARTICLE_FILE = 'Configuration/Generator/data/particles_%s_%d_GeV.txt'  % (FLAVOR, MASS_POINT)
SLHA_FILE ='Configuration/Generator/data/HSCP_%s_%d_SLHA.spc' % (FLAVOR, MASS_POINT)
PDT_FILE = 'Configuration/Generator/data/hscppythiapdt%s%d.tbl'  % (FLAVOR, MASS_POINT)
USE_REGGE = False

generator = cms.EDFilter("Pythia8ConcurrentHadronizerFilter",
    pythiaPylistVerbosity = cms.untracked.int32(1),
    filterEfficiency = cms.untracked.double(-1),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    comEnergy = cms.double(COM_ENERGY),
    crossSection = cms.untracked.double(-1),
    maxEventsToPrint = cms.untracked.int32(1),
    SLHAFileForPythia8 = cms.string('%s' % SLHA_FILE), 
    PythiaParameters = cms.PSet(
        pythia8CommonSettingsBlock,
        pythia8CP5SettingsBlock,
        pythia8PSweightsSettingsBlock,
        processParameters = cms.vstring(
            'JetMatching:scheme = 1',
            'JetMatching:merge = on',
            'JetMatching:jetAlgorithm = 2',
            'JetMatching:etaJetMax = 5.',
            'JetMatching:coneRadius = 1.',
            'JetMatching:slowJetPower = 1',
            'JetMatching:qCut = 150.', #this is the actual merging scale
            'JetMatching:clFact = 1', # determines jet-to parton matching
            'JetMatching:nQmatch = 5', #5 for 5-flavour scheme (matching of b-quarks)
            'JetMatching:nJetMax = 2', #number of partons in born matrix element for highest multiplicity
            'JetMatching:doShowerKt = off',
            
            # Enable Rhadrons
            'RHadrons:allow  = on',
            'RHadrons:allowDecay = off',
            'RHadrons:setMasses = on',

       ),
        
        parameterSets = cms.vstring('pythia8CommonSettings',
                                    'pythia8CP5Settings',
                                    'pythia8PSweightsSettings',
                                    'processParameters',
                                    )
                                    
    ) 
)

generator.hscpFlavor = cms.untracked.string(FLAVOR)
generator.massPoint = cms.untracked.int32(MASS_POINT)
generator.particleFile = cms.untracked.string(PARTICLE_FILE)
generator.slhaFile = cms.untracked.string(SLHA_FILE)
generator.processFile = cms.untracked.string(PROCESS_FILE)
generator.pdtFile = cms.FileInPath(PDT_FILE)
generator.useregge = cms.bool(USE_REGGE)

dirhadrongenfilter = cms.EDFilter("MCParticlePairFilter",
    Status = cms.untracked.vint32(1, 1),
    MinPt = cms.untracked.vdouble(0., 0.),
    MinP = cms.untracked.vdouble(0., 0.),
    MaxEta = cms.untracked.vdouble(100., 100.),
    MinEta = cms.untracked.vdouble(-100, -100),
    ParticleCharge = cms.untracked.int32(0),
    ParticleID1 = cms.untracked.vint32(1000612,1000622,1000632,1000642,1000652,1006113,1006211,1006213,1006223,1006311,1006313,1006321,1006323,1006333),
    ParticleID2 = cms.untracked.vint32(1000612,1000622,1000632,1000642,1000652,1006113,1006211,1006213,1006223,1006311,1006313,1006321,1006323,1006333)
)

ProductionFilterSequence = cms.Sequence(generator*dirhadrongenfilter)
