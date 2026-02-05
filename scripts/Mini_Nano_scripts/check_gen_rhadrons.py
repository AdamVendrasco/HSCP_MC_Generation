#!/usr/bin/env python3
import ROOT
import cmsstyle as CMS
from collections import Counter
from ROOT import TLorentzVector
from DataFormats.FWLite import Handle, Events

ROOT.gROOT.SetBatch(True)
ROOT.gSystem.Load("libFWCoreFWLite.so")
ROOT.gSystem.Load("libDataFormatsFWLite.so")
ROOT.AutoLibraryLoader.enable()

FILES = [
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.0-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.1-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.2-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.3-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.4-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.5-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.6-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.7-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.8-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.9-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.10-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.11-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.12-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.13-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.14-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.15-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.16-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.17-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.18-MINIAODSIM.root",
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.19-MINIAODSIM.root",
]

THRESH = 1_000_000
MAX_EVENTS_TO_PRINT = 0

GENMET_PXY_ABS_THRESH = 0.001  # GeV (applied as |px|>thr AND |py|>thr)

# Individual R-hadron binning
NBINS = 40
PT_MIN, PT_MAX   = 0.0, 3500.0
ETA_MIN, ETA_MAX = -6.0, 6.0
PHI_MIN, PHI_MAX = -4.0, 4.0
MASS_MIN, MASS_MAX = 1000.0, 2600.0

PAIR_PT_BINS, PAIR_PT_MIN, PAIR_PT_MAX = 150, 0.0, 3000.0
PAIR_ETA_BINS, PAIR_ETA_MIN, PAIR_ETA_MAX   = 150, -8.0, 8.0
PAIR_PHI_BINS,  PAIR_PHI_MIN,  PAIR_PHI_MAX  = 125, -3.6, 3.6
PAIR_MASS_BINS, PAIR_MASS_MIN, PAIR_MASS_MAX = 150, 3550.0, 9000.0
PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX  = 150, -6000.0, 6000.0

MET_PT_BINS, MET_PT_MIN, MET_PT_MAX = 150, 0.0, 5000.0
MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX = 150, -5000.0, 5000.0
MET_PHI_BINS, MET_PHI_MIN, MET_PHI_MAX = 70, -3.5, 3.5

# GenMET 
GENMET_PT_MIN, GENMET_PT_MAX = 0.0, 250.0
GENMET_PXY_MIN, GENMET_PXY_MAX = -250.0, 250.0
GENMET_PHI_MIN, GENMET_PHI_MAX = MET_PHI_MIN, MET_PHI_MAX

counts_packed = Counter()
counts_pruned = Counter()

h_packed   = Handle("std::vector<pat::PackedGenParticle>")  # packedGenParticles
h_pruned   = Handle("std::vector<reco::GenParticle>")       # prunedGenParticles
h_GenMET   = Handle("std::vector<reco::GenMET>")            # genMetTrue
h_PFMET    = Handle("std::vector<pat::MET>")                # slimmedMETs
h_PUPPIMET = Handle("std::vector<pat::MET>")                # slimmedMETsPuppi

print("\n[Setup] Looking at std::vector<pat::PackedGenParticle> (packedGenParticles)")
print("[Setup] Looking at std::vector<reco::GenParticle> (prunedGenParticles)")
print("[Setup] Looking at std::vector<reco::GenMET> (genMetTrue)")
print("[Setup] Looking at std::vector<pat::MET> (slimmedMETs)")
print("[Setup] Looking at std::vector<pat::MET> (slimmedMETsPuppi)")


# Individual R-hadron hists
h_lead_pt_MG5    = ROOT.TH1D("lead_rhad_pt_MG5",     ";leading R-hadron p_{T} [GeV];Events", NBINS, PT_MIN, PT_MAX)
h_sublead_pt_MG5 = ROOT.TH1D("sublead_rhad_pt_MG5",  ";subleading R-hadron p_{T} [GeV];Events", NBINS, PT_MIN, PT_MAX)
h_lead_eta_MG5   = ROOT.TH1D("lead_rhad_eta_MG5",    ";leading R-hadron #eta;Events", NBINS, ETA_MIN, ETA_MAX)
h_sublead_eta_MG5= ROOT.TH1D("sublead_rhad_eta_MG5", ";subleading R-hadron #eta;Events", NBINS, ETA_MIN, ETA_MAX)
h_lead_phi_MG5   = ROOT.TH1D("lead_rhad_phi_MG5",    ";leading R-hadron #phi;Events", NBINS, PHI_MIN, PHI_MAX)
h_sublead_phi_MG5= ROOT.TH1D("sublead_rhad_phi_MG5", ";subleading R-hadron #phi;Events", NBINS, PHI_MIN, PHI_MAX)
h_lead_mass_MG5  = ROOT.TH1D("lead_rhad_mass_MG5",   ";leading R-hadron mass [GeV];Events", NBINS, MASS_MIN, MASS_MAX)
h_sublead_mass_MG5 = ROOT.TH1D("sublead_rhad_mass_MG5",";subleading R-hadron mass [GeV];Events", NBINS, MASS_MIN, MASS_MAX)

h_lead_sublead_Delta_phi_MG5 = ROOT.TH1D("lead_sublead_Delta_phi_MG5", ";|#Delta#phi(lead, sublead)|;Events", NBINS, 0.0, 3.7)

# rhadron-pair hists 
h_rhadpair_pt_MG5   = ROOT.TH1D("rhadpair_pt_MG5",   ";(lead+sublead R-hadrons) p_{T} [GeV];Events", PAIR_PT_BINS,   PAIR_PT_MIN,   PAIR_PT_MAX)
h_rhadpair_eta_MG5  = ROOT.TH1D("rhadpair_eta_MG5",  ";(lead+sublead R-hadrons) #eta;Events",        PAIR_ETA_BINS,  PAIR_ETA_MIN,  PAIR_ETA_MAX)
h_rhadpair_phi_MG5  = ROOT.TH1D("rhadpair_phi_MG5",  ";(lead+sublead R-hadrons) #phi;Events",        PAIR_PHI_BINS,  PAIR_PHI_MIN,  PAIR_PHI_MAX)
h_rhadpair_mass_MG5 = ROOT.TH1D("rhadpair_mass_MG5", ";(lead+sublead R-hadrons) mass [GeV];Events",  PAIR_MASS_BINS, PAIR_MASS_MIN, PAIR_MASS_MAX)
h_rhadpair_px_MG5   = ROOT.TH1D("rhadpair_px_MG5",   ";(lead+sublead R-hadrons) p_{x} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)
h_rhadpair_py_MG5   = ROOT.TH1D("rhadpair_py_MG5",   ";(lead+sublead R-hadrons) p_{y} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)
h_rhadpair_pz_MG5   = ROOT.TH1D("rhadpair_pz_MG5",   ";(lead+sublead R-hadrons) p_{z} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)


# MET
h_GenMET_pt_MG5    = ROOT.TH1D("GenMET_pt_MG5",    ";GEN MET p_{T} [GeV];Events", 200,  0,  250)
h_GenMET_phi_MG5   = ROOT.TH1D("GenMET_phi_MG5",   ";GEN MET #phi;Events",        100, -3.6, 3.6)
h_GenMET_px_MG5    = ROOT.TH1D("GenMET_px_MG5",    ";GEN MET p_{x} [GeV];Events", 200, -250.0, 250.0)
h_GenMET_py_MG5    = ROOT.TH1D("GenMET_py_MG5",    ";GEN MET p_{y} [GeV];Events", 200, -250.0, 250.0)
h_GenMET_sumEt_MG5 = ROOT.TH1D("GenMET_sumEt_MG5", ";GEN MET #SigmaE_{T} [GeV];Events", 200, 0.0, 9000.0)

# phi only if |px| and |py| exceed threshold
h_GenMET_phi_pxpyThresh_MG5 = ROOT.TH1D(
    "GenMET_phi_pxpyThresh_MG5",
    f";GEN MET #phi (|p_{{x}}|>|p_{{y}}|>{GENMET_PXY_ABS_THRESH} GeV);Events",
    100, -3.6, 3.6
)

h_PFMET_pt_MG5    = ROOT.TH1D("PFMET_pt_MG5",    ";PF MET p_{T} [GeV];Events", MET_PT_BINS,  MET_PT_MIN,  MET_PT_MAX)
h_PFMET_phi_MG5   = ROOT.TH1D("PFMET_phi_MG5",   ";PF MET #phi;Events",        MET_PHI_BINS, MET_PHI_MIN, MET_PHI_MAX)
h_PFMET_px_MG5    = ROOT.TH1D("PFMET_px_MG5",    ";PF MET p_{x} [GeV];Events", MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX)
h_PFMET_py_MG5    = ROOT.TH1D("PFMET_py_MG5",    ";PF MET p_{y} [GeV];Events", MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX)
h_PFMET_sumEt_MG5 = ROOT.TH1D("PFMET_sumEt_MG5", ";PF MET #SigmaE_{T} [GeV];Events", 200, 0.0, 9000.0)

h_PUPPIMET_pt_MG5    = ROOT.TH1D("PUPPIMET_pt_MG5",    ";PUPPI MET p_{T} [GeV];Events", MET_PT_BINS,  MET_PT_MIN,  MET_PT_MAX)
h_PUPPIMET_phi_MG5   = ROOT.TH1D("PUPPIMET_phi_MG5",   ";PUPPI MET #phi;Events",        MET_PHI_BINS, MET_PHI_MIN, MET_PHI_MAX)
h_PUPPIMET_px_MG5    = ROOT.TH1D("PUPPIMET_px_MG5",    ";PUPPI MET p_{x} [GeV];Events", MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX)
h_PUPPIMET_py_MG5    = ROOT.TH1D("PUPPIMET_py_MG5",    ";PUPPI MET p_{y} [GeV];Events", MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX)
h_PUPPIMET_sumEt_MG5 = ROOT.TH1D("PUPPIMET_sumEt_MG5", ";PUPPI MET #SigmaE_{T} [GeV];Events", 200, 0.0, 9000.0)


# GenMET 2D hists (MG5)
H2_BINS = 500 

h_GenMETphivsGenMETpt_MG5 = ROOT.TH2D( "GenMETphivsGenMETpt_MG5", ";GEN MET p_{T} [GeV];GEN MET #phi", H2_BINS, GENMET_PT_MIN, GENMET_PT_MAX, H2_BINS, GENMET_PHI_MIN, GENMET_PHI_MAX)
h_GenMETptvsGenMETpx_MG5 = ROOT.TH2D( "GenMETptvsGenMETpx_MG5", ";GEN MET p_{T} [GeV];GEN MET p_{x} [GeV]", H2_BINS, GENMET_PT_MIN, GENMET_PT_MAX, H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX)
h_GenMETptvsGenMETpy_MG5 = ROOT.TH2D("GenMETptvsGenMETpy_MG5",";GEN MET p_{T} [GeV];GEN MET p_{y} [GeV]",H2_BINS, GENMET_PT_MIN, GENMET_PT_MAX,H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX)
h_GenMETpxvsGenMETphi_MG5 = ROOT.TH2D("GenMETpxvsGenMETphi_MG5",";GEN MET p_{x} [GeV];GEN MET #phi",H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX,H2_BINS, GENMET_PHI_MIN, GENMET_PHI_MAX)
h_GenMETpyvsGenMETphi_MG5 = ROOT.TH2D("GenMETpyvsGenMETphi_MG5",";GEN MET p_{y} [GeV];GEN MET #phi",H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX,H2_BINS, GENMET_PHI_MIN, GENMET_PHI_MAX)
h_GenMETpxvsGenMETpy_MG5 = ROOT.TH2D("GenMETpxvsGenMETpy_MG5",";GEN MET p_{x} [GeV];GEN MET p_{y} [GeV]",H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX,H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX)

for h in (
    h_lead_pt_MG5, h_sublead_pt_MG5,
    h_lead_eta_MG5, h_sublead_eta_MG5,
    h_lead_phi_MG5, h_sublead_phi_MG5,
    h_lead_mass_MG5, h_sublead_mass_MG5,
    h_lead_sublead_Delta_phi_MG5,
    h_rhadpair_pt_MG5, h_rhadpair_eta_MG5, h_rhadpair_phi_MG5, h_rhadpair_mass_MG5,
    h_rhadpair_px_MG5, h_rhadpair_py_MG5, h_rhadpair_pz_MG5,
    h_GenMET_pt_MG5, h_GenMET_phi_MG5, h_GenMET_px_MG5, h_GenMET_py_MG5, h_GenMET_sumEt_MG5,
    h_GenMET_phi_pxpyThresh_MG5,
    h_PFMET_pt_MG5, h_PFMET_phi_MG5, h_PFMET_px_MG5, h_PFMET_py_MG5, h_PFMET_sumEt_MG5,
    h_PUPPIMET_pt_MG5, h_PUPPIMET_phi_MG5, h_PUPPIMET_px_MG5, h_PUPPIMET_py_MG5, h_PUPPIMET_sumEt_MG5,
    # 2D:
    h_GenMETphivsGenMETpt_MG5,
    h_GenMETptvsGenMETpx_MG5,
    h_GenMETptvsGenMETpy_MG5,
    h_GenMETpxvsGenMETphi_MG5,
    h_GenMETpyvsGenMETphi_MG5,
    h_GenMETpxvsGenMETpy_MG5,
):
    h.SetFillStyle(0)
    h.SetFillColor(0)
    h.SetMarkerStyle(0)

def fill_met_hists(hpt, hphi, hpx, hpy, hsumet, met_obj):
    hpt.Fill(float(met_obj.pt()))
    hphi.Fill(float(met_obj.phi()))
    hpx.Fill(float(met_obj.px()))
    hpy.Fill(float(met_obj.py()))
    hsumet.Fill(float(met_obj.sumEt()))

n_scanned = 0

for FILE in FILES:
    print(f"\n[Input] {FILE}")
    events = Events(FILE)
    printed_this_file = 0
    file_evt = 0

    for evt in events:
        file_evt += 1
        n_scanned += 1

        evt.getByLabel("packedGenParticles", h_packed)
        evt.getByLabel("prunedGenParticles", h_pruned)
        packed = h_packed.product()
        pruned = h_pruned.product()

        # GEN MET (genMetTrue)
        got_genmet = evt.getByLabel("genMetTrue", h_GenMET)
        if not got_genmet:
            got_genmet = evt.getByLabel(("genMetTrue", "", "DIGI2RAW"), h_GenMET)

        if got_genmet:
            for met in h_GenMET.product():
                # 1D fills
                fill_met_hists(h_GenMET_pt_MG5, h_GenMET_phi_MG5, h_GenMET_px_MG5, h_GenMET_py_MG5, h_GenMET_sumEt_MG5, met)

                pt  = float(met.pt())
                phi = float(met.phi())
                px  = float(met.px())
                py  = float(met.py())

                # only fill phi if both components are above threshold in absolute value
                if abs(px) > GENMET_PXY_ABS_THRESH and abs(py) > GENMET_PXY_ABS_THRESH:
                    h_GenMET_phi_pxpyThresh_MG5.Fill(phi)

                # 2D fills
                h_GenMETphivsGenMETpt_MG5.Fill(pt, phi)
                h_GenMETptvsGenMETpx_MG5.Fill(pt, px)
                h_GenMETptvsGenMETpy_MG5.Fill(pt, py)
                h_GenMETpxvsGenMETphi_MG5.Fill(px, phi)
                h_GenMETpyvsGenMETphi_MG5.Fill(py, phi)
                h_GenMETpxvsGenMETpy_MG5.Fill(px, py)

        # Offline PF MET (slimmedMETs)
        got_pfmet = evt.getByLabel("slimmedMETs", h_PFMET)
        if got_pfmet and len(h_PFMET.product()) > 0:
            met = h_PFMET.product()[0]
            fill_met_hists(h_PFMET_pt_MG5, h_PFMET_phi_MG5, h_PFMET_px_MG5, h_PFMET_py_MG5, h_PFMET_sumEt_MG5, met)

        # Offline PUPPI MET (slimmedMETsPuppi)
        got_puppimet = evt.getByLabel("slimmedMETsPuppi", h_PUPPIMET)
        if got_puppimet and len(h_PUPPIMET.product()) > 0:
            met = h_PUPPIMET.product()[0]
            fill_met_hists(h_PUPPIMET_pt_MG5, h_PUPPIMET_phi_MG5, h_PUPPIMET_px_MG5, h_PUPPIMET_py_MG5, h_PUPPIMET_sumEt_MG5, met)

        for particle in packed:
            pdgid = int(particle.pdgId())
            if abs(pdgid) > THRESH:
                counts_packed[pdgid] += 1

        for particle in pruned:
            pdgid = int(particle.pdgId())
            if abs(pdgid) >= THRESH and particle.statusFlags().isLastCopy():
                counts_pruned[pdgid] += 1

        vecs = []
        for particle in packed:
            pdgid = int(particle.pdgId())
            if abs(pdgid) <= THRESH:
                continue
            tlv = TLorentzVector()
            tlv.SetPtEtaPhiM(
                float(particle.pt()),
                float(particle.eta()),
                float(particle.phi()),
                float(particle.mass())
            )
            vecs.append((tlv, pdgid))

        vecs.sort(key=lambda vm: vm[0].Pt(), reverse=True)

        lead     = vecs[0] if len(vecs) >= 1 else None
        sub_lead = vecs[1] if len(vecs) >= 2 else None

        tlv1 = tlv2 = None
        pdgid1 = pdgid2 = None
        rhad_pair = None

        if lead is not None:
            tlv1, pdgid1 = lead
            h_lead_pt_MG5.Fill(tlv1.Pt())
            h_lead_eta_MG5.Fill(tlv1.Eta())
            h_lead_phi_MG5.Fill(tlv1.Phi())
            h_lead_mass_MG5.Fill(tlv1.M())

        if sub_lead is not None:
            tlv2, pdgid2 = sub_lead
            h_sublead_pt_MG5.Fill(tlv2.Pt())
            h_sublead_eta_MG5.Fill(tlv2.Eta())
            h_sublead_phi_MG5.Fill(tlv2.Phi())
            h_sublead_mass_MG5.Fill(tlv2.M())

        if lead is not None and sub_lead is not None:
            dphi = float(tlv1.DeltaPhi(tlv2))
            h_lead_sublead_Delta_phi_MG5.Fill(abs(dphi))

            rhad_pair = tlv1 + tlv2

            h_rhadpair_pt_MG5.Fill(rhad_pair.Pt())
            h_rhadpair_eta_MG5.Fill(rhad_pair.Eta())
            h_rhadpair_phi_MG5.Fill(rhad_pair.Phi())
            h_rhadpair_mass_MG5.Fill(rhad_pair.M())
            h_rhadpair_px_MG5.Fill(rhad_pair.Px())
            h_rhadpair_py_MG5.Fill(rhad_pair.Py())
            h_rhadpair_pz_MG5.Fill(rhad_pair.Pz())

        if MAX_EVENTS_TO_PRINT != 0 and (MAX_EVENTS_TO_PRINT < 0 or printed_this_file < MAX_EVENTS_TO_PRINT):
            printed_this_file += 1

            if lead is None:
                print(f"[packed collection] file_evt {file_evt:5d}  global_evt {n_scanned:5d}")
                print("lead: (none)")
                print("sublead: (none)")
                print()

            elif sub_lead is None:
                print(f"[packed collection] file_evt {file_evt:5d}  global_evt {n_scanned:5d}")
                print(f"lead: ({pdgid1}, pt={tlv1.Pt():.2f} GeV, eta={tlv1.Eta():.3f}, phi={tlv1.Phi():.3f}, m={tlv1.M():.2f} GeV)")
                print("sublead: (none)")
                print()

            else:
                print(f"[packed collection] file_evt {file_evt:5d}  global_evt {n_scanned:5d}")
                print(f"lead:    ({pdgid1}, pt={tlv1.Pt():.2f} GeV, eta={tlv1.Eta():.3f}, phi={tlv1.Phi():.3f}, m={tlv1.M():.2f} GeV)")
                print(f"sublead: ({pdgid2}, pt={tlv2.Pt():.2f} GeV, eta={tlv2.Eta():.3f}, phi={tlv2.Phi():.3f}, m={tlv2.M():.2f} GeV)")
                print(f"lead     (px={tlv1.Px():.2f}, py={tlv1.Py():.2f}, pz={tlv1.Pz():.2f})")
                print(f"sublead  (px={tlv2.Px():.2f}, py={tlv2.Py():.2f}, pz={tlv2.Pz():.2f})")
                print(f"pair:    (pt={rhad_pair.Pt():.2f} GeV, eta={rhad_pair.Eta():.3f}, phi={rhad_pair.Phi():.3f}, "
                      f"m={rhad_pair.M():.2f} GeV, px={rhad_pair.Px():.2f}, py={rhad_pair.Py():.2f}, pz={rhad_pair.Pz():.2f})")
                print()

print("\nTop Packed Collection PDGIDs with |pdgId| > 1,000,000:")
for pdgid, c in counts_packed.most_common(30):
    print(f"{pdgid:10d}  {c}")

print("\nTop Pruned PDGIDs with |pdgId| > 1,000,000:")
for pdgid, c in counts_pruned.most_common(30):
    print(f"{pdgid:10d}  {c}")

total_rhads_packed = sum(counts_packed.values())
print(f"[Check] total packed R-hadrons (sum over PDGIDs) = {total_rhads_packed}")
print(f"[Check] total pruned gluino (lastCopy)           = {counts_pruned.get(1000021, 0)}")

outroot = "rhad_kinematics.root"
fout = ROOT.TFile(outroot, "RECREATE")
for h in (
    h_lead_pt_MG5, h_sublead_pt_MG5,
    h_lead_eta_MG5, h_sublead_eta_MG5,
    h_lead_phi_MG5, h_sublead_phi_MG5,
    h_lead_mass_MG5, h_sublead_mass_MG5,
    h_lead_sublead_Delta_phi_MG5,
    h_rhadpair_pt_MG5, h_rhadpair_eta_MG5, h_rhadpair_phi_MG5, h_rhadpair_mass_MG5,
    h_rhadpair_px_MG5, h_rhadpair_py_MG5, h_rhadpair_pz_MG5,
    h_GenMET_pt_MG5, h_GenMET_phi_MG5, h_GenMET_px_MG5, h_GenMET_py_MG5, h_GenMET_sumEt_MG5,
    h_GenMET_phi_pxpyThresh_MG5,
    h_PFMET_pt_MG5, h_PFMET_phi_MG5, h_PFMET_px_MG5, h_PFMET_py_MG5, h_PFMET_sumEt_MG5,
    h_PUPPIMET_pt_MG5, h_PUPPIMET_phi_MG5, h_PUPPIMET_px_MG5, h_PUPPIMET_py_MG5, h_PUPPIMET_sumEt_MG5,
    # 2D:
    h_GenMETphivsGenMETpt_MG5,
    h_GenMETptvsGenMETpx_MG5,
    h_GenMETptvsGenMETpy_MG5,
    h_GenMETpxvsGenMETphi_MG5,
    h_GenMETpyvsGenMETphi_MG5,
    h_GenMETpxvsGenMETpy_MG5,
):
    h.Write()
fout.Close()
print(f"[Output] wrote ROOT file: {outroot}")

def report_flow(h, label):
    nb = h.GetNbinsX()
    uf = h.GetBinContent(0)
    of = h.GetBinContent(nb + 1)
    xmin = h.GetXaxis().GetXmin()
    xmax = h.GetXaxis().GetXmax()
    entries = h.GetEntries()
    if uf > 0 or of > 0:
        frac_of = (of / entries) if entries > 0 else 0.0
        frac_uf = (uf / entries) if entries > 0 else 0.0
        print(f"[Flow] {label}: range=[{xmin:g},{xmax:g}]  under={uf:.0f} ({frac_uf:.3%})  over={of:.0f} ({frac_of:.3%})")
    else:
        print(f"[Flow] {label}: range=[{xmin:g},{xmax:g}]  under=0  over=0")

print("\n[Flow report] rhadron pair hist under/overflow (pair = tlv1 + tlv2):")
report_flow(h_rhadpair_pt_MG5,   "RhadPair pt")
report_flow(h_rhadpair_eta_MG5,  "RhadPair eta")
report_flow(h_rhadpair_phi_MG5,  "RhadPair phi")
report_flow(h_rhadpair_mass_MG5, "RhadPair mass")
report_flow(h_rhadpair_px_MG5,   "RhadPair px")
report_flow(h_rhadpair_py_MG5,   "RhadPair py")
report_flow(h_rhadpair_pz_MG5,   "RhadPair pz")

print("\n[Flow report] MET hist under/overflow:")
report_flow(h_GenMET_pt_MG5,    "GenMET pt")
report_flow(h_PFMET_pt_MG5,     "PF MET pt")
report_flow(h_PUPPIMET_pt_MG5,  "PUPPI MET pt")
report_flow(h_GenMET_px_MG5,    "GenMET px")
report_flow(h_PFMET_px_MG5,     "PF MET px")
report_flow(h_PUPPIMET_px_MG5,  "PUPPI MET px")
report_flow(h_GenMET_py_MG5,    "GenMET py")
report_flow(h_PFMET_py_MG5,     "PF MET py")
report_flow(h_PUPPIMET_py_MG5,  "PUPPI MET py")

CMS.SetExtraText("Private Work: Gluino GEN-level MC Simulation")
CMS.SetLumi(None, run="Run 3")
CMS.SetEnergy(13.6)

def draw_single(name, xmin, xmax, h, xtitle, ytitle, outpng,
                yoffset=1.45, titlesize=0.045, labelsize=0.040,
                logy=False, ymin_log=0.1,
                logx=False, xmin_log=0.1):
    xmin_use = xmin
    if logx and xmin_use <= 0:
        xmin_use = xmin_log

    ymax = max(h.GetMaximum(), 1.0) * 1.35
    ymin = ymin_log if logy else 0.0

    canv = CMS.cmsCanvas(name, xmin_use, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=11)
    if logy:
        canv.SetLogy(True)
        h.SetMinimum(ymin_log)
    if logx:
        canv.SetLogx(True)

    frame = CMS.GetCmsCanvasHist(canv)
    frame.GetXaxis().SetTitleSize(titlesize)
    frame.GetYaxis().SetTitleSize(titlesize)
    frame.GetXaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetTitleOffset(yoffset)

    if logx:
        frame.GetXaxis().SetMoreLogLabels(True)
        frame.GetXaxis().SetNoExponent(True)

    canv.Modified()
    canv.Update()

    CMS.cmsDraw(h, "HIST", lwidth=2, lcolor=ROOT.kBlue + 1, fstyle=0)

    canv.SaveAs(outpng)
    print(f"[Output] wrote PNG: {outpng}")

def draw_2d_colz(name, xmin, xmax, ymin, ymax, h2, xtitle, ytitle, outpng,
                 titlesize=0.045, labelsize=0.040, yoffset=1.0,
                 logz=False, logx=False, xmin_log=0.1):
    xmin_use = xmin
    if logx and xmin_use <= 0:
        xmin_use = xmin_log

    canv = CMS.cmsCanvas(name, xmin_use, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=11)
    canv.SetRightMargin(0.16)

    if logz:
        canv.SetLogz(True)
    if logx:
        canv.SetLogx(True)

    frame = CMS.GetCmsCanvasHist(canv)
    frame.GetXaxis().SetTitleSize(titlesize)
    frame.GetYaxis().SetTitleSize(titlesize)
    frame.GetXaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetTitleOffset(yoffset)

    if logx:
        frame.GetXaxis().SetMoreLogLabels(True)
        frame.GetXaxis().SetNoExponent(True)

    h2.SetStats(0)
    h2.GetZaxis().SetTitle("Events")

    canv.Modified()
    canv.Update()

    h2.Draw("COLZ SAME")

    canv.SaveAs(outpng)
    print(f"[Output] wrote PNG: {outpng}")

def draw_overlay(name, xmin, xmax, h1, h2, xtitle, ytitle, outpng,
                 yoffset=1.45, titlesize=0.045, labelsize=0.040,
                 logy=False, ymin_log=0.1,
                 logx=False, xmin_log=0.1):
    xmin_use = xmin
    if logx and xmin_use <= 0:
        xmin_use = xmin_log

    ymax = max(h1.GetMaximum(), h2.GetMaximum(), 1.0) * 1.35
    ymin = ymin_log if logy else 0.0

    canv = CMS.cmsCanvas(name, xmin_use, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=11)
    if logy:
        canv.SetLogy(True)
        h1.SetMinimum(ymin_log)
        h2.SetMinimum(ymin_log)
    if logx:
        canv.SetLogx(True)

    frame = CMS.GetCmsCanvasHist(canv)
    frame.GetXaxis().SetTitleSize(titlesize)
    frame.GetYaxis().SetTitleSize(titlesize)
    frame.GetXaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetTitleOffset(yoffset)

    if logx:
        frame.GetXaxis().SetMoreLogLabels(True)
        frame.GetXaxis().SetNoExponent(True)

    canv.Modified()
    canv.Update()

    CMS.cmsDraw(h1, "HIST",      lwidth=2, lcolor=ROOT.kBlue + 1, fstyle=0)
    CMS.cmsDraw(h2, "HIST SAME", lwidth=2, lstyle=ROOT.kDashed, lcolor=ROOT.kRed + 1, fstyle=0)

    leg = CMS.cmsLeg(0.60, 0.75, 0.88, 0.88, textSize=0.04)
    leg.AddEntry(h1, "Leading", "l")
    leg.AddEntry(h2, "Subleading", "l")
    leg.Draw()

    canv.SaveAs(outpng)
    print(f"[Output] wrote PNG: {outpng}")


# Individual R-hadron plots
draw_overlay("c_rhad_pt_MG5",   PT_MIN,   PT_MAX,   h_lead_pt_MG5,   h_sublead_pt_MG5,  "R-hadron p_{T} [GeV]", "Events", "rhad_pt_MG5.png",   yoffset=1.01)
draw_overlay("c_rhad_eta_MG5",  ETA_MIN,  ETA_MAX,  h_lead_eta_MG5,  h_sublead_eta_MG5, "R-hadron #eta",        "Events", "rhad_eta_MG5.png",  yoffset=1.01)
draw_overlay("c_rhad_phi_MG5",  PHI_MIN,  PHI_MAX,  h_lead_phi_MG5,  h_sublead_phi_MG5, "R-hadron #phi",        "Events", "rhad_phi_MG5.png",  yoffset=1.01)
draw_overlay("c_rhad_mass_MG5", MASS_MIN, MASS_MAX, h_lead_mass_MG5, h_sublead_mass_MG5,"R-hadron mass [GeV]",  "Events", "rhad_mass_MG5.png", yoffset=1.01)
draw_single ("c_dphi_MG5",      0.0,      3.5,      h_lead_sublead_Delta_phi_MG5, "|#Delta#phi(lead, sublead)|", "Events", "lead_sublead_dphi_MG5.png", yoffset=1.01)


# combined rhadron plots
draw_single("c_rhadpair_pt_MG5",   PAIR_PT_MIN,   PAIR_PT_MAX,   h_rhadpair_pt_MG5,   "(lead+sublead R-hadrons) p_{T} [GeV]", "Events", "rhadpair_pt_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_rhadpair_eta_MG5",  PAIR_ETA_MIN,  PAIR_ETA_MAX,  h_rhadpair_eta_MG5,  "(lead+sublead R-hadrons) #eta",        "Events", "rhadpair_eta_MG5.png",  logy=True, yoffset=1.01)
draw_single("c_rhadpair_phi_MG5",  PAIR_PHI_MIN,  PAIR_PHI_MAX,  h_rhadpair_phi_MG5,  "(lead+sublead R-hadrons) #phi",        "Events", "rhadpair_phi_MG5.png",  logy=True, yoffset=1.01)
draw_single("c_rhadpair_mass_MG5", PAIR_MASS_MIN, PAIR_MASS_MAX, h_rhadpair_mass_MG5, "(lead+sublead R-hadrons) mass [GeV]",  "Events", "rhadpair_mass_MG5.png", logy=True, yoffset=1.01)
draw_single("c_rhadpair_px_MG5",   PAIR_PXYZ_MIN, PAIR_PXYZ_MAX, h_rhadpair_px_MG5,   "(lead+sublead R-hadrons) p_{x} [GeV]", "Events", "rhadpair_px_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_rhadpair_py_MG5",   PAIR_PXYZ_MIN, PAIR_PXYZ_MAX, h_rhadpair_py_MG5,   "(lead+sublead R-hadrons) p_{y} [GeV]", "Events", "rhadpair_py_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_rhadpair_pz_MG5",   PAIR_PXYZ_MIN, PAIR_PXYZ_MAX, h_rhadpair_pz_MG5,   "(lead+sublead R-hadrons) p_{z} [GeV]", "Events", "rhadpair_pz_MG5.png",   logy=True, yoffset=1.01)


# MET plots 
draw_single("c_genmet_pt_MG5",      0,  250,  h_GenMET_pt_MG5,   "GEN MET p_{T} [GeV]",   "Events", "genmet_pt_MG5.png",   logy=True, yoffset=1.01, ymin_log=0.1)
draw_single("c_genmet_phi_MG5",     MET_PHI_MIN, MET_PHI_MAX, h_GenMET_phi_MG5,  "GEN MET #phi",          "Events", "genmet_phi_MG5.png",  logy=True, yoffset=1.01)
draw_single("c_genmet_px_MG5",      0, 250, h_GenMET_px_MG5,   "GEN MET p_{x} [GeV]",   "Events", "genmet_px_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_genmet_py_MG5",      0, 250, h_GenMET_py_MG5,   "GEN MET p_{y} [GeV]",   "Events", "genmet_py_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_genmet_sumEt_MG5",   0.0, 9000.0, h_GenMET_sumEt_MG5, "#SigmaE_{T} [GeV]", "Events", "genmet_sumEt_MG5.png", logy=True, yoffset=1.01)

draw_single("c_genmet_phi_pxpyThresh_MG5",MET_PHI_MIN, MET_PHI_MAX,h_GenMET_phi_pxpyThresh_MG5,f"GEN MET #phi (|p_{{x}}|,|p_{{y}}| > {GENMET_PXY_ABS_THRESH} GeV)","Events","genmet_phi_pxpyThresh_MG5.png",logy=True, yoffset=1.01)
draw_single("c_pfmet_pt_MG5",       MET_PT_MIN,  MET_PT_MAX,  h_PFMET_pt_MG5,    "PF MET p_{T} [GeV]",    "Events", "pfmet_pt_MG5.png",    logy=True, yoffset=1.01, ymin_log=0.1)
draw_single("c_pfmet_phi_MG5",      MET_PHI_MIN, MET_PHI_MAX, h_PFMET_phi_MG5,   "PF MET #phi",           "Events", "pfmet_phi_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_pfmet_px_MG5",       MET_PXY_MIN, MET_PXY_MAX, h_PFMET_px_MG5,    "PF MET p_{x} [GeV]",    "Events", "pfmet_px_MG5.png",    logy=True, yoffset=1.01)
draw_single("c_pfmet_py_MG5",       MET_PXY_MIN, MET_PXY_MAX, h_PFMET_py_MG5,    "PF MET p_{y} [GeV]",    "Events", "pfmet_py_MG5.png",    logy=True, yoffset=1.01)
draw_single("c_pfmet_sumEt_MG5",    0.0, 9000.0, h_PFMET_sumEt_MG5, "#SigmaE_{T} [GeV]", "Events", "pfmet_sumEt_MG5.png", logy=True, yoffset=1.01)

draw_single("c_puppimet_pt_MG5",    MET_PT_MIN,  MET_PT_MAX,  h_PUPPIMET_pt_MG5, "PUPPI MET p_{T} [GeV]", "Events", "puppimet_pt_MG5.png", logy=True, yoffset=1.01, ymin_log=0.1)
draw_single("c_puppimet_phi_MG5",   MET_PHI_MIN, MET_PHI_MAX, h_PUPPIMET_phi_MG5,"PUPPI MET #phi",        "Events", "puppimet_phi_MG5.png", logy=True, yoffset=1.01)
draw_single("c_puppimet_px_MG5",    MET_PXY_MIN, MET_PXY_MAX, h_PUPPIMET_px_MG5, "PUPPI MET p_{x} [GeV]", "Events", "puppimet_px_MG5.png",  logy=True, yoffset=1.01)
draw_single("c_puppimet_py_MG5",    MET_PXY_MIN, MET_PXY_MAX, h_PUPPIMET_py_MG5, "PUPPI MET p_{y} [GeV]", "Events", "puppimet_py_MG5.png",  logy=True, yoffset=1.01)
draw_single("c_puppimet_sumEt_MG5", 0.0, 9000.0, h_PUPPIMET_sumEt_MG5, "#SigmaE_{T} [GeV]", "Events", "puppimet_sumEt_MG5.png", logy=True, yoffset=1.01)
# 2D MET plots
draw_2d_colz("c_genmet_phi_vs_pt_MG5",GENMET_PT_MIN, GENMET_PT_MAX,GENMET_PHI_MIN, GENMET_PHI_MAX,h_GenMETphivsGenMETpt_MG5,"GEN MET p_{T} [GeV]", "GEN MET #phi","genmet_phi_vs_pt_MG5.png",logz=True)
draw_2d_colz("c_genmet_pt_vs_px_MG5",GENMET_PT_MIN, GENMET_PT_MAX,GENMET_PXY_MIN, GENMET_PXY_MAX,h_GenMETptvsGenMETpx_MG5,"GEN MET p_{T} [GeV]", "GEN MET p_{x} [GeV]","genmet_pt_vs_px_MG5.png",logz=True)
draw_2d_colz("c_genmet_pt_vs_py_MG5",GENMET_PT_MIN, GENMET_PT_MAX,GENMET_PXY_MIN, GENMET_PXY_MAX,h_GenMETptvsGenMETpy_MG5,"GEN MET p_{T} [GeV]", "GEN MET p_{y} [GeV]","genmet_pt_vs_py_MG5.png",logz=True)
draw_2d_colz("c_genmet_px_vs_phi_MG5",GENMET_PXY_MIN, GENMET_PXY_MAX,GENMET_PHI_MIN, GENMET_PHI_MAX,h_GenMETpxvsGenMETphi_MG5,"GEN MET p_{x} [GeV]", "GEN MET #phi","genmet_px_vs_phi_MG5.png",logz=True)
draw_2d_colz("c_genmet_py_vs_phi_MG5",GENMET_PXY_MIN, GENMET_PXY_MAX,GENMET_PHI_MIN, GENMET_PHI_MAX,h_GenMETpyvsGenMETphi_MG5,"GEN MET p_{y} [GeV]", "GEN MET #phi","genmet_py_vs_phi_MG5.png",logz=True)
draw_2d_colz("c_genmet_px_vs_py_MG5",GENMET_PXY_MIN, GENMET_PXY_MAX,GENMET_PXY_MIN, GENMET_PXY_MAX,h_GenMETpxvsGenMETpy_MG5,"GEN MET p_{x} [GeV]", "GEN MET p_{y} [GeV]","genmet_px_vs_py_MG5.png",logz=True)
