# Auto generated configuration file
# using: 
# Revision: 1.19 
# Source: /local/reps/CMSSW/CMSSW/Configuration/Applications/python/ConfigBuilder.py,v 
# with command line options: Configuration/GenProduction/python/SMS-StopStop_mStop-1400-fragment_Jet_matching_ON.py --python_filename ../SMS-StopStop_mStop-1400/output-configs/SMS-StopStop_mStop-1400-CMSSW_10_6_19-n1000-Jet_matching_ON-30-1_cfg.py --eventcontent RAWSIM,LHE --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN,LHE --fileout file:../SMS-StopStop_mStop-1400/root-files/SMS-StopStop_mStop-1400-CMSSW_10_6_19-n1000-Jet_matching_ON-30.root --conditions 106X_upgrade2018_realistic_v4 --beamspot Realistic25ns13TeVEarly2018Collision --step LHE,GEN --geometry DB:Extended --era Run2_2018 --mc -n 1000
import FWCore.ParameterSet.Config as cms

from Configuration.Eras.Era_Run2_2018_cff import Run2_2018

process = cms.Process('GEN',Run2_2018)

# import of standard configurations
process.load('Configuration.StandardSequences.Services_cff')
process.load('SimGeneral.HepPDTESSource.pythiapdt_cfi')
process.load('FWCore.MessageService.MessageLogger_cfi')
process.load('Configuration.EventContent.EventContent_cff')
process.load('SimGeneral.MixingModule.mixNoPU_cfi')
process.load('Configuration.StandardSequences.GeometryRecoDB_cff')
process.load('Configuration.StandardSequences.MagneticField_cff')
process.load('Configuration.StandardSequences.Generator_cff')
process.load('IOMC.EventVertexGenerators.VtxSmearedRealistic25ns13TeVEarly2018Collision_cfi')
process.load('GeneratorInterface.Core.genFilterSummary_cff')
process.load('Configuration.StandardSequences.EndOfProcess_cff')
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

process.maxEvents = cms.untracked.PSet(
    input = cms.untracked.int32(1000)
)

# Input source
process.source = cms.Source("EmptySource")

process.options = cms.untracked.PSet(

)

# Production Info
process.configurationMetadata = cms.untracked.PSet(
    annotation = cms.untracked.string('Configuration/GenProduction/python/SMS-StopStop_mStop-1400-fragment_Jet_matching_ON.py nevts:1000'),
    name = cms.untracked.string('Applications'),
    version = cms.untracked.string('$Revision: 1.19 $')
)

# Output definition

process.RAWSIMoutput = cms.OutputModule("PoolOutputModule",
    SelectEvents = cms.untracked.PSet(
        SelectEvents = cms.vstring('generation_step')
    ),
    compressionAlgorithm = cms.untracked.string('LZMA'),
    compressionLevel = cms.untracked.int32(1),
    dataset = cms.untracked.PSet(
        dataTier = cms.untracked.string('GEN'),
        filterName = cms.untracked.string('')
    ),
    eventAutoFlushCompressedSize = cms.untracked.int32(20971520),
    fileName = cms.untracked.string('file:../SMS-StopStop_mStop-1400/root-files/SMS-StopStop_mStop-1400-CMSSW_10_6_19-n1000-Jet_matching_ON-30.root'),
    outputCommands = process.RAWSIMEventContent.outputCommands,
    splitLevel = cms.untracked.int32(0)
)

process.LHEoutput = cms.OutputModule("PoolOutputModule",
    dataset = cms.untracked.PSet(
        dataTier = cms.untracked.string('LHE'),
        filterName = cms.untracked.string('')
    ),
    fileName = cms.untracked.string('file:../SMS-StopStop_mStop-1400/root-files/SMS-StopStop_mStop-1400-CMSSW_10_6_19-n1000-Jet_matching_ON-30_inLHE.root'),
    outputCommands = process.LHEEventContent.outputCommands,
    splitLevel = cms.untracked.int32(0)
)

# Additional output definition

# Other statements
process.genstepfilter.triggerConditions=cms.vstring("generation_step")
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, '106X_upgrade2018_realistic_v4', '')

process.tmpGenParticlesForJetsNoNu = cms.EDProducer("InputGenJetsParticleSelector",
    excludeFromResonancePids = cms.vuint32(12, 13, 14, 16),
    excludeResonances = cms.bool(False),
    ignoreParticleIDs = cms.vuint32(
        1000022, 1000012, 1000014, 1000016, 2000012, 
        2000014, 2000016, 1000039, 5100039, 4000012, 
        4000014, 4000016, 9900012, 9900014, 9900016, 
        39, 12, 14, 16
    ),
    partonicFinalState = cms.bool(False),
    src = cms.InputTag("tmpGenParticles"),
    tausAsJets = cms.bool(False)
)


process.tmpAk4GenJetsNoNu = cms.EDProducer("FastjetJetProducer",
    Active_Area_Repeats = cms.int32(5),
    GhostArea = cms.double(0.01),
    Ghost_EtaMax = cms.double(6.0),
    Rho_EtaMax = cms.double(4.5),
    doAreaFastjet = cms.bool(False),
    doPUOffsetCorr = cms.bool(False),
    doPVCorrection = cms.bool(False),
    doRhoFastjet = cms.bool(False),
    inputEMin = cms.double(0.0),
    inputEtMin = cms.double(0.0),
    jetAlgorithm = cms.string('AntiKt'),
    jetPtMin = cms.double(3.0),
    jetType = cms.string('GenJet'),
    maxBadEcalCells = cms.uint32(9999999),
    maxBadHcalCells = cms.uint32(9999999),
    maxProblematicEcalCells = cms.uint32(9999999),
    maxProblematicHcalCells = cms.uint32(9999999),
    maxRecoveredEcalCells = cms.uint32(9999999),
    maxRecoveredHcalCells = cms.uint32(9999999),
    minSeed = cms.uint32(14327),
    nSigmaPU = cms.double(1.0),
    rParam = cms.double(0.4),
    radiusPU = cms.double(0.5),
    src = cms.InputTag("tmpGenParticlesForJetsNoNu"),
    srcPVs = cms.InputTag(""),
    useDeterministicSeed = cms.bool(True)
)


process.genHTFilter = cms.EDFilter("GenHTFilter",
    genHTcut = cms.double(200.0),
    jetEtaCut = cms.double(5.0),
    jetPtCut = cms.double(30.0),
    src = cms.InputTag("tmpAk4GenJetsNoNu")
)


process.tmpGenMetTrue = cms.EDProducer("GenMETProducer",
    applyFiducialThresholdForFractions = cms.bool(False),
    globalThreshold = cms.double(0.0),
    onlyFiducialParticles = cms.bool(False),
    src = cms.InputTag("tmpGenParticlesForJetsNoNu"),
    usePt = cms.bool(True)
)


process.generator = cms.EDFilter("Pythia8HadronizerFilter",
    ConfigDescription = cms.string('T2tt_dM-10to80_1400_1388'),
    PythiaParameters = cms.PSet(
        JetMatchingParameters = cms.vstring(
            'JetMatching:setMad = off', 
            'JetMatching:scheme = 1', 
            'JetMatching:merge = on', 
            'JetMatching:jetAlgorithm = 2', 
            'JetMatching:etaJetMax = 5.', 
            'JetMatching:coneRadius = 1.', 
            'JetMatching:slowJetPower = 1', 
            'JetMatching:qCut = 70', 
            'JetMatching:nQmatch = 5', 
            'JetMatching:nJetMax = 2', 
            'JetMatching:doShowerKt = off', 
            '6:m0 = 172.5', 
            '24:mMin = 0.1', 
            'Check:abortIfVeto = on'
        ),
        parameterSets = cms.vstring(
            'pythia8CommonSettings', 
            'pythia8CP2Settings', 
            'JetMatchingParameters'
        ),
        pythia8CP2Settings = cms.vstring(
            'Tune:pp 14', 
            'Tune:ee 7', 
            'MultipartonInteractions:ecmPow=0.1391', 
            'MultipartonInteractions:bProfile=2', 
            'MultipartonInteractions:pT0Ref=2.306', 
            'MultipartonInteractions:coreRadius=0.3755', 
            'MultipartonInteractions:coreFraction=0.3269', 
            'ColourReconnection:range=2.323', 
            'SigmaTotal:zeroAXB=off', 
            'SpaceShower:rapidityOrder=off', 
            'SpaceShower:alphaSvalue=0.13', 
            'TimeShower:alphaSvalue=0.13', 
            'SigmaTotal:mode = 0', 
            'SigmaTotal:sigmaEl = 21.89', 
            'SigmaTotal:sigmaTot = 100.309', 
            'PDF:pSet=LHAPDF6:NNPDF31_lo_as_0130'
        ),
        pythia8CommonSettings = cms.vstring(
            'Tune:preferLHAPDF = 2', 
            'Main:timesAllowErrors = 10000', 
            'Check:epTolErr = 0.01', 
            'Beams:setProductionScalesFromLHEF = off', 
            'SLHA:keepSM = on', 
            'SLHA:minMassSM = 1000.', 
            'ParticleDecays:limitTau0 = on', 
            'ParticleDecays:tau0Max = 10', 
            'ParticleDecays:allowPhotonRadiation = on', 
            '1000006:tau0 = 2.000000e+01', 
            'ParticleDecays:tau0Max = 1000.1', 
            'LesHouches:setLifetime = 2', 
            'RHadrons:allow  = on', 
            'RHadrons:allowDecay = on', 
            'RHadrons:setMasses = on'
        )
    ),
    SLHATableForPythia8 = cms.string('\nBLOCK MASS  # Mass Spectrum\n# PDG code           mass       particle\n   1000001     1.00000000E+05   # ~d_L\n   2000001     1.00000000E+05   # ~d_R\n   1000002     1.00000000E+05   # ~u_L\n   2000002     1.00000000E+05   # ~u_R\n   1000003     1.00000000E+05   # ~s_L\n   2000003     1.00000000E+05   # ~s_R\n   1000004     1.00000000E+05   # ~c_L\n   2000004     1.00000000E+05   # ~c_R\n   1000005     1.00000000E+05   # ~b_1\n   2000005     1.00000000E+05   # ~b_2\n   1000006     1.400000e+03          # ~t_1\n   2000006     1.00000000E+05   # ~t_2\n   1000011     1.00000000E+05   # ~e_L\n   2000011     1.00000000E+05   # ~e_R\n   1000012     1.00000000E+05   # ~nu_eL\n   1000013     1.00000000E+05   # ~mu_L\n   2000013     1.00000000E+05   # ~mu_R\n   1000014     1.00000000E+05   # ~nu_muL\n   1000015     1.00000000E+05   # ~tau_1\n   2000015     1.00000000E+05   # ~tau_2\n   1000016     1.00000000E+05   # ~nu_tauL\n   1000021     1.00000000E+05    # ~g\n   1000022     1.388000e+03           # ~chi_10\n   1000023     1.00000000E+05   # ~chi_20\n   1000025     1.00000000E+05   # ~chi_30\n   1000035     1.00000000E+05   # ~chi_40\n   1000024     1.00000000E+05   # ~chi_1+\n   1000037     1.00000000E+05   # ~chi_2+\n\n# DECAY TABLE\n#         PDG            Width\nDECAY   1000001     0.00000000E+00   # sdown_L decays\nDECAY   2000001     0.00000000E+00   # sdown_R decays\nDECAY   1000002     0.00000000E+00   # sup_L decays\nDECAY   2000002     0.00000000E+00   # sup_R decays\nDECAY   1000003     0.00000000E+00   # sstrange_L decays\nDECAY   2000003     0.00000000E+00   # sstrange_R decays\nDECAY   1000004     0.00000000E+00   # scharm_L decays\nDECAY   2000004     0.00000000E+00   # scharm_R decays\nDECAY   1000005     0.00000000E+00   # sbottom1 decays\nDECAY   2000005     0.00000000E+00   # sbottom2 decays\nDECAY   1000006     9.866349e-15   # stop1 decays\n    0.00000000E+00    4    1000022      5     -1    2  # dummy allowed decay, in order to turn on off-shell decays\n    0.50000000E+00    3    1000022      5   24\n    0.50000000E+00    2    1000022      4 \nDECAY   2000006     0.00000000E+00   # stop2 decays\nDECAY   1000011     0.00000000E+00   # selectron_L decays\nDECAY   2000011     0.00000000E+00   # selectron_R decays\nDECAY   1000012     0.00000000E+00   # snu_elL decays\nDECAY   1000013     0.00000000E+00   # smuon_L decays\nDECAY   2000013     0.00000000E+00   # smuon_R decays\nDECAY   1000014     0.00000000E+00   # snu_muL decays\nDECAY   1000015     0.00000000E+00   # stau_1 decays\nDECAY   2000015     0.00000000E+00   # stau_2 decays\nDECAY   1000016     0.00000000E+00   # snu_tauL decays\nDECAY   1000021     0.00000000E+00   # gluino decays\nDECAY   1000022     0.00000000E+00   # neutralino1 decays\nDECAY   1000023     0.00000000E+00   # neutralino2 decays\nDECAY   1000024     0.00000000E+00   # chargino1+ decays\nDECAY   1000025     0.00000000E+00   # neutralino3 decays\nDECAY   1000035     0.00000000E+00   # neutralino4 decays\nDECAY   1000037     0.00000000E+00   # chargino2+ decays\n'),
    comEnergy = cms.double(13000.0),
    filterEfficiency = cms.untracked.double(1.0),
    maxEventsToPrint = cms.untracked.int32(1),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    pythiaPylistVerbosity = cms.untracked.int32(1)
)


process.genMETfilter1 = cms.EDFilter("CandViewSelector",
    cut = cms.string('pt > 100'),
    src = cms.InputTag("tmpGenMetTrue")
)


process.genMETfilter2 = cms.EDFilter("CandViewCountFilter",
    minNumber = cms.uint32(1),
    src = cms.InputTag("genMETfilter1")
)


process.tmpGenParticles = cms.EDProducer("GenParticleProducer",
    abortOnUnknownPDGCode = cms.untracked.bool(False),
    saveBarCodes = cms.untracked.bool(True),
    src = cms.InputTag("generator","unsmeared")
)


process.externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('/cvmfs/cms.cern.ch/phys_generator/gridpacks/UL/13TeV/madgraph/V5_2.6.5/sus_sms/SMS-StopStop_v2/SMS-StopStop_mStop-1400_slc7_amd64_gcc700_CMSSW_10_6_19_tarball.tar.xz'),
    generateConcurrently = cms.untracked.bool(False),
    nEvents = cms.untracked.uint32(1000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)


process.ProductionFilterSequence = cms.Sequence(process.generator+process.tmpGenParticles+process.tmpGenParticlesForJetsNoNu+process.tmpAk4GenJetsNoNu+process.genHTFilter+process.tmpGenMetTrue+process.genMETfilter1+process.genMETfilter2)

# Path and EndPath definitions
process.lhe_step = cms.Path(process.externalLHEProducer)
process.generation_step = cms.Path(process.pgen)
process.genfiltersummary_step = cms.EndPath(process.genFilterSummary)
process.endjob_step = cms.EndPath(process.endOfProcess)
process.RAWSIMoutput_step = cms.EndPath(process.RAWSIMoutput)
process.LHEoutput_step = cms.EndPath(process.LHEoutput)

# Schedule definition
process.schedule = cms.Schedule(process.lhe_step,process.generation_step,process.genfiltersummary_step,process.endjob_step,process.RAWSIMoutput_step,process.LHEoutput_step)
from PhysicsTools.PatAlgos.tools.helpers import associatePatAlgosToolsTask
associatePatAlgosToolsTask(process)
# filter all path with the production filter sequence
for path in process.paths:
	if path in ['lhe_step']: continue
	getattr(process,path).insert(0, process.ProductionFilterSequence)

# customisation of the process.

# Automatic addition of the customisation function from Configuration.DataProcessing.Utils
from Configuration.DataProcessing.Utils import addMonitoring 

#call to customisation function addMonitoring imported from Configuration.DataProcessing.Utils
process = addMonitoring(process)

# End of customisation functions

# Customisation from command line

# Add early deletion of temporary data products to reduce peak memory need
from Configuration.StandardSequences.earlyDeleteSettings_cff import customiseEarlyDelete
process = customiseEarlyDelete(process)
# End adding early deletion
