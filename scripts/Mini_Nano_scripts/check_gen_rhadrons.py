#!/usr/bin/env python3
import ROOT
import cmsstyle as CMS
from collections import Counter
from ROOT import TLorentzVector
from DataFormats.FWLite import Handle, Events
import subprocess
import shutil

ROOT.gROOT.SetBatch(True)
ROOT.gSystem.Load("libFWCoreFWLite.so")
ROOT.gSystem.Load("libDataFormatsFWLite.so")
ROOT.AutoLibraryLoader.enable()
ROOT.TH1.SetDefaultSumw2(True)

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

MASS_POINT = "1800"
SAMPLE_TYPE = "Gluino"
THRESH = 1_000_000
MAX_EVENTS_TO_PRINT = 0

GENMET_PXY_ABS_THRESH = 0.001

DAS_DATASET = "/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8/RunIII2024Summer24MiniAODv6-150X_mcRun3_2024_realistic_v2-v2/MINIAODSIM"
N_DAS_FILES = 30
DAS_REDIRECTOR = "root://cmsxrootd.fnal.gov/"

MAX_EVENTS_DAS = 0  # 0 = all events
MATCH_DAS_EVENTS_TO_LOCAL = False 


def _normalize_dataset_string(s: str) -> str:
    s = (s or "").strip()
    if "dataset=" in s:
        idx = s.find("dataset=") + len("dataset=")
        rest = s[idx:].lstrip(' "\'')
        end = len(rest)
        for sep in ['"', "'", " "]:
            pos = rest.find(sep)
            if pos != -1:
                end = min(end, pos)
        s = rest[:end].strip()

    if s.startswith("file dataset="):
        s = s[len("file dataset="):].strip()

    return s


def _as_xrootd_url(redirector: str, store_path: str) -> str:
    """
    Build a ROOT xrootd URL with an ABSOLUTE /store/... path.
    """
    r = (redirector or "").strip()
    if not r:
        r = "root://cmsxrootd.fnal.gov/"

    if not r.endswith("/"):
        r += "/"

    p = (store_path or "").strip()
    if p.startswith("root://"):
        idx = p.find("/store/")
        if idx != -1:
            head = p[:idx]
            tail = p[idx:]
            return head + "/" + tail
        return p

    if p.startswith("store/"):
        p = "/" + p
    if not p.startswith("/store/"):
        p = "/" + p.lstrip("/")
    return r + p


def get_das_root_files(dataset, nfiles=20, redirector="root://cmsxrootd.fnal.gov/"):
    """
    Returns a list of xrootd URLs for files in a DAS dataset.
    Requires dasgoclient in PATH.
    """
    if shutil.which("dasgoclient") is None:
        print("[DAS] dasgoclient not found in PATH -> skipping DAS file retrieval.")
        return []

    ds = _normalize_dataset_string(str(dataset))
    if not ds.startswith("/"):
        print(f"[DAS] Dataset string doesn't look like a dataset path: {ds}")
        return []

    query = f"file dataset={ds}"
    cmd = ["dasgoclient", "-query", query, "-limit", str(nfiles)]
    print(f"[DAS] Running: {' '.join(cmd)}")

    p = subprocess.run(cmd, text=True, capture_output=True)
    if p.returncode != 0:
        print("[DAS] dasgoclient returned non-zero exit code:", p.returncode)
        if p.stdout.strip():
            print("[DAS] stdout:\n" + p.stdout.strip())
        if p.stderr.strip():
            print("[DAS] stderr:\n" + p.stderr.strip())
        return []

    files = [line.strip() for line in p.stdout.splitlines() if line.strip()]
    rootfiles = []
    for f in files:
        rootfiles.append(_as_xrootd_url(redirector, f))

    print(f"[DAS] Retrieved {len(rootfiles)} file(s) (limit={nfiles}).")
    return rootfiles


def fill_met_hists(hpt, hphi, hpx, hpy, hsumet, met_obj):
    hpt.Fill(float(met_obj.pt()))
    hphi.Fill(float(met_obj.phi()))
    hpx.Fill(float(met_obj.px()))
    hpy.Fill(float(met_obj.py()))
    hsumet.Fill(float(met_obj.sumEt()))


NBINS = 40
PT_MIN, PT_MAX = 0.0, 3500.0
ETA_MIN, ETA_MAX = -6.0, 6.0
PHI_MIN, PHI_MAX = -4.0, 4.0
MASS_MIN, MASS_MAX = 1000.0, 2600.0

PAIR_PT_BINS, PAIR_PT_MIN, PAIR_PT_MAX = 150, 0.0, 3000.0
PAIR_ETA_BINS, PAIR_ETA_MIN, PAIR_ETA_MAX = 150, -8.0, 8.0
PAIR_PHI_BINS, PAIR_PHI_MIN, PAIR_PHI_MAX = 125, -3.6, 3.6
PAIR_MASS_BINS, PAIR_MASS_MIN, PAIR_MASS_MAX = 150, 3550.0, 9000.0
PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX = 150, -6000.0, 6000.0

MET_PT_BINS, MET_PT_MIN, MET_PT_MAX = 150, 0.0, 5000.0
MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX = 150, -5000.0, 5000.0
MET_PHI_BINS, MET_PHI_MIN, MET_PHI_MAX = 70, -3.5, 3.5

GENMET_PT_MIN, GENMET_PT_MAX = 0.0, 250.0
GENMET_PXY_MIN, GENMET_PXY_MAX = -250.0, 250.0
GENMET_PHI_MIN, GENMET_PHI_MAX = MET_PHI_MIN, MET_PHI_MAX

H2_BINS = 500

counts_packed = Counter()
counts_pruned = Counter()

h_packed = Handle("std::vector<pat::PackedGenParticle>")
h_pruned = Handle("std::vector<reco::GenParticle>")
h_GenMET = Handle("std::vector<reco::GenMET>")
h_PFMET = Handle("std::vector<pat::MET>")
h_PUPPIMET = Handle("std::vector<pat::MET>")

print("\n[Setup] packedGenParticles / prunedGenParticles / genMetTrue / slimmedMETs / slimmedMETsPuppi")

h_lead_pt_MG5 = ROOT.TH1D("lead_rhad_pt_MG5", ";leading R-hadron p_{T} [GeV];Events", NBINS, PT_MIN, PT_MAX)
h_sublead_pt_MG5 = ROOT.TH1D("sublead_rhad_pt_MG5", ";subleading R-hadron p_{T} [GeV];Events", NBINS, PT_MIN, PT_MAX)
h_lead_eta_MG5 = ROOT.TH1D("lead_rhad_eta_MG5", ";leading R-hadron #eta;Events", NBINS, ETA_MIN, ETA_MAX)
h_sublead_eta_MG5 = ROOT.TH1D("sublead_rhad_eta_MG5", ";subleading R-hadron #eta;Events", NBINS, ETA_MIN, ETA_MAX)
h_lead_phi_MG5 = ROOT.TH1D("lead_rhad_phi_MG5", ";leading R-hadron #phi;Events", NBINS, PHI_MIN, PHI_MAX)
h_sublead_phi_MG5 = ROOT.TH1D("sublead_rhad_phi_MG5", ";subleading R-hadron #phi;Events", NBINS, PHI_MIN, PHI_MAX)
h_lead_mass_MG5 = ROOT.TH1D("lead_rhad_mass_MG5", ";leading R-hadron mass [GeV];Events", NBINS, MASS_MIN, MASS_MAX)
h_sublead_mass_MG5 = ROOT.TH1D("sublead_rhad_mass_MG5", ";subleading R-hadron mass [GeV];Events", NBINS, MASS_MIN, MASS_MAX)

h_lead_sublead_Delta_phi_MG5 = ROOT.TH1D("lead_sublead_Delta_phi_MG5", ";|#Delta#phi(lead, sublead)|;Events", NBINS, 0.0, 3.7)

h_rhadpair_pt_MG5 = ROOT.TH1D("rhadpair_pt_MG5", ";(lead+sublead R-hadrons) p_{T} [GeV];Events", PAIR_PT_BINS, PAIR_PT_MIN, PAIR_PT_MAX)
h_rhadpair_eta_MG5 = ROOT.TH1D("rhadpair_eta_MG5", ";(lead+sublead R-hadrons) #eta;Events", PAIR_ETA_BINS, PAIR_ETA_MIN, PAIR_ETA_MAX)
h_rhadpair_phi_MG5 = ROOT.TH1D("rhadpair_phi_MG5", ";(lead+sublead R-hadrons) #phi;Events", PAIR_PHI_BINS, PAIR_PHI_MIN, PAIR_PHI_MAX)
h_rhadpair_mass_MG5 = ROOT.TH1D("rhadpair_mass_MG5", ";(lead+sublead R-hadrons) mass [GeV];Events", PAIR_MASS_BINS, PAIR_MASS_MIN, PAIR_MASS_MAX)
h_rhadpair_px_MG5 = ROOT.TH1D("rhadpair_px_MG5", ";(lead+sublead R-hadrons) p_{x} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)
h_rhadpair_py_MG5 = ROOT.TH1D("rhadpair_py_MG5", ";(lead+sublead R-hadrons) p_{y} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)
h_rhadpair_pz_MG5 = ROOT.TH1D("rhadpair_pz_MG5", ";(lead+sublead R-hadrons) p_{z} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)

h_GenMET_pt_MG5 = ROOT.TH1D("GenMET_pt_MG5", ";GEN MET p_{T} [GeV];Events", 200, 0, 250)
h_GenMET_phi_MG5 = ROOT.TH1D("GenMET_phi_MG5", ";GEN MET #phi;Events", 100, -3.6, 3.6)
h_GenMET_px_MG5 = ROOT.TH1D("GenMET_px_MG5", ";GEN MET p_{x} [GeV];Events", 200, -250.0, 250.0)
h_GenMET_py_MG5 = ROOT.TH1D("GenMET_py_MG5", ";GEN MET p_{y} [GeV];Events", 200, -250.0, 250.0)
h_GenMET_sumEt_MG5 = ROOT.TH1D("GenMET_sumEt_MG5", ";GEN MET #SigmaE_{T} [GeV];Events", 200, 0.0, 9000.0)
h_GenMET_phi_pxpyThresh_MG5 = ROOT.TH1D("GenMET_phi_pxpyThresh_MG5",f";GEN MET #phi (|p_{{x}}|,|p_{{y}}|>{GENMET_PXY_ABS_THRESH} GeV);Events",100, -3.6, 3.6)

h_PFMET_pt_MG5 = ROOT.TH1D("PFMET_pt_MG5", ";PF MET p_{T} [GeV];Events", MET_PT_BINS, MET_PT_MIN, MET_PT_MAX)
h_PFMET_phi_MG5 = ROOT.TH1D("PFMET_phi_MG5", ";PF MET #phi;Events", MET_PHI_BINS, MET_PHI_MIN, MET_PHI_MAX)
h_PFMET_px_MG5 = ROOT.TH1D("PFMET_px_MG5", ";PF MET p_{x} [GeV];Events", MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX)
h_PFMET_py_MG5 = ROOT.TH1D("PFMET_py_MG5", ";PF MET p_{y} [GeV];Events", MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX)
h_PFMET_sumEt_MG5 = ROOT.TH1D("PFMET_sumEt_MG5", ";PF MET #SigmaE_{T} [GeV];Events", 200, 0.0, 9000.0)

h_PUPPIMET_pt_MG5 = ROOT.TH1D("PUPPIMET_pt_MG5", ";PUPPI MET p_{T} [GeV];Events", MET_PT_BINS, MET_PT_MIN, MET_PT_MAX)
h_PUPPIMET_phi_MG5 = ROOT.TH1D("PUPPIMET_phi_MG5", ";PUPPI MET #phi;Events", MET_PHI_BINS, MET_PHI_MIN, MET_PHI_MAX)
h_PUPPIMET_px_MG5 = ROOT.TH1D("PUPPIMET_px_MG5", ";PUPPI MET p_{x} [GeV];Events", MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX)
h_PUPPIMET_py_MG5 = ROOT.TH1D("PUPPIMET_py_MG5", ";PUPPI MET p_{y} [GeV];Events", MET_PXY_BINS, MET_PXY_MIN, MET_PXY_MAX)
h_PUPPIMET_sumEt_MG5 = ROOT.TH1D("PUPPIMET_sumEt_MG5", ";PUPPI MET #SigmaE_{T} [GeV];Events", 200, 0.0, 9000.0)

h_GenMETphivsGenMETpt_MG5 = ROOT.TH2D("GenMETphivsGenMETpt_MG5", ";GEN MET p_{T} [GeV];GEN MET #phi",H2_BINS, GENMET_PT_MIN, GENMET_PT_MAX,H2_BINS, GENMET_PHI_MIN, GENMET_PHI_MAX)
h_GenMETptvsGenMETpx_MG5 = ROOT.TH2D("GenMETptvsGenMETpx_MG5", ";GEN MET p_{T} [GeV];GEN MET p_{x} [GeV]",H2_BINS, GENMET_PT_MIN, GENMET_PT_MAX,H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX)
h_GenMETptvsGenMETpy_MG5 = ROOT.TH2D("GenMETptvsGenMETpy_MG5", ";GEN MET p_{T} [GeV];GEN MET p_{y} [GeV]",H2_BINS, GENMET_PT_MIN, GENMET_PT_MAX,H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX)
h_GenMETpxvsGenMETphi_MG5 = ROOT.TH2D("GenMETpxvsGenMETphi_MG5", ";GEN MET p_{x} [GeV];GEN MET #phi",H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX,H2_BINS, GENMET_PHI_MIN, GENMET_PHI_MAX)
h_GenMETpyvsGenMETphi_MG5 = ROOT.TH2D("GenMETpyvsGenMETphi_MG5", ";GEN MET p_{y} [GeV];GEN MET #phi",H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX,H2_BINS, GENMET_PHI_MIN, GENMET_PHI_MAX)
h_GenMETpxvsGenMETpy_MG5 = ROOT.TH2D("GenMETpxvsGenMETpy_MG5", ";GEN MET p_{x} [GeV];GEN MET p_{y} [GeV]",H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX,H2_BINS, GENMET_PXY_MIN, GENMET_PXY_MAX)

h_GenParticle_pt_MG5   = ROOT.TH1D("GenParticle_pt_MG5",   ";GenParticle p_{T} [GeV];Particles", 200, PT_MIN, PT_MAX)
h_GenParticle_eta_MG5  = ROOT.TH1D("GenParticle_eta_MG5",  ";GenParticle #eta;Particles",        200, ETA_MIN, ETA_MAX)
h_GenParticle_phi_MG5  = ROOT.TH1D("GenParticle_phi_MG5",  ";GenParticle #phi;Particles",        200, PHI_MIN, PHI_MAX)
h_GenParticle_mass_MG5 = ROOT.TH1D("GenParticle_mass_MG5", ";GenParticle mass [GeV];Particles",  200, 0.0, 3000.0)

h_GenParticle_pt_DAS   = ROOT.TH1D("GenParticle_pt_DAS",   ";GenParticle p_{T} [GeV];Particles", 200, PT_MIN, PT_MAX)
h_GenParticle_eta_DAS  = ROOT.TH1D("GenParticle_eta_DAS",  ";GenParticle #eta;Particles",        200, ETA_MIN, ETA_MAX)
h_GenParticle_phi_DAS  = ROOT.TH1D("GenParticle_phi_DAS",  ";GenParticle #phi;Particles",        200, PHI_MIN, PHI_MAX)
h_GenParticle_mass_DAS = ROOT.TH1D("GenParticle_mass_DAS", ";GenParticle mass [GeV];Particles",  200, 0.0, 3000.0)

# DAS (Pythia8) rhadron-pair histograms
h_rhadpair_pt_DAS = ROOT.TH1D("rhadpair_pt_DAS", ";(lead+sublead R-hadrons) p_{T} [GeV];Events", PAIR_PT_BINS, PAIR_PT_MIN, PAIR_PT_MAX)
h_rhadpair_eta_DAS = ROOT.TH1D("rhadpair_eta_DAS", ";(lead+sublead R-hadrons) #eta;Events", PAIR_ETA_BINS, PAIR_ETA_MIN, PAIR_ETA_MAX)
h_rhadpair_phi_DAS = ROOT.TH1D("rhadpair_phi_DAS", ";(lead+sublead R-hadrons) #phi;Events", PAIR_PHI_BINS, PAIR_PHI_MIN, PAIR_PHI_MAX)
h_rhadpair_mass_DAS = ROOT.TH1D("rhadpair_mass_DAS", ";(lead+sublead R-hadrons) mass [GeV];Events", PAIR_MASS_BINS, PAIR_MASS_MIN, PAIR_MASS_MAX)
h_rhadpair_px_DAS = ROOT.TH1D("rhadpair_px_DAS", ";(lead+sublead R-hadrons) p_{x} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)
h_rhadpair_py_DAS = ROOT.TH1D("rhadpair_py_DAS", ";(lead+sublead R-hadrons) p_{y} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)
h_rhadpair_pz_DAS = ROOT.TH1D("rhadpair_pz_DAS", ";(lead+sublead R-hadrons) p_{z} [GeV];Events", PAIR_PXYZ_BINS, PAIR_PXYZ_MIN, PAIR_PXYZ_MAX)

for h in (
    h_lead_pt_MG5, h_sublead_pt_MG5, h_lead_eta_MG5, h_sublead_eta_MG5,
    h_lead_phi_MG5, h_sublead_phi_MG5, h_lead_mass_MG5, h_sublead_mass_MG5,
    h_lead_sublead_Delta_phi_MG5,
    h_rhadpair_pt_MG5, h_rhadpair_eta_MG5, h_rhadpair_phi_MG5, h_rhadpair_mass_MG5,
    h_rhadpair_px_MG5, h_rhadpair_py_MG5, h_rhadpair_pz_MG5,
    h_GenMET_pt_MG5, h_GenMET_phi_MG5, h_GenMET_px_MG5, h_GenMET_py_MG5, h_GenMET_sumEt_MG5,
    h_GenMET_phi_pxpyThresh_MG5,
    h_PFMET_pt_MG5, h_PFMET_phi_MG5, h_PFMET_px_MG5, h_PFMET_py_MG5, h_PFMET_sumEt_MG5,
    h_PUPPIMET_pt_MG5, h_PUPPIMET_phi_MG5, h_PUPPIMET_px_MG5, h_PUPPIMET_py_MG5, h_PUPPIMET_sumEt_MG5,
    h_GenMETphivsGenMETpt_MG5, h_GenMETptvsGenMETpx_MG5, h_GenMETptvsGenMETpy_MG5,
    h_GenMETpxvsGenMETphi_MG5, h_GenMETpyvsGenMETphi_MG5, h_GenMETpxvsGenMETpy_MG5,
    h_GenParticle_pt_MG5, h_GenParticle_eta_MG5, h_GenParticle_phi_MG5, h_GenParticle_mass_MG5,
    h_GenParticle_pt_DAS, h_GenParticle_eta_DAS, h_GenParticle_phi_DAS, h_GenParticle_mass_DAS,
    h_rhadpair_pt_DAS, h_rhadpair_eta_DAS, h_rhadpair_phi_DAS, h_rhadpair_mass_DAS,
    h_rhadpair_px_DAS, h_rhadpair_py_DAS, h_rhadpair_pz_DAS,
):
    h.SetFillStyle(0)
    h.SetFillColor(0)
    h.SetMarkerStyle(0)

n_scanned = 0

for FILE in FILES:
    print(f"\n[Input] {FILE}")
    try:
        events = Events(FILE)
    except Exception as e:
        print(f"[WARN] Could not open file with FWLite Events(): {e}")
        continue

    printed_this_file = 0
    file_evt = 0

    for evt in events:
        file_evt += 1
        n_scanned += 1

        evt.getByLabel("packedGenParticles", h_packed)
        evt.getByLabel("prunedGenParticles", h_pruned)
        packed = h_packed.product()
        pruned = h_pruned.product()

        got_genmet = evt.getByLabel("genMetTrue", h_GenMET)
        if not got_genmet:
            got_genmet = evt.getByLabel(("genMetTrue", "", "DIGI2RAW"), h_GenMET)

        if got_genmet:
            for met in h_GenMET.product():
                fill_met_hists(h_GenMET_pt_MG5, h_GenMET_phi_MG5, h_GenMET_px_MG5, h_GenMET_py_MG5, h_GenMET_sumEt_MG5, met)

                pt = float(met.pt())
                phi = float(met.phi())
                px = float(met.px())
                py = float(met.py())

                if abs(px) > GENMET_PXY_ABS_THRESH and abs(py) > GENMET_PXY_ABS_THRESH:
                    h_GenMET_phi_pxpyThresh_MG5.Fill(phi)

                h_GenMETphivsGenMETpt_MG5.Fill(pt, phi)
                h_GenMETptvsGenMETpx_MG5.Fill(pt, px)
                h_GenMETptvsGenMETpy_MG5.Fill(pt, py)
                h_GenMETpxvsGenMETphi_MG5.Fill(px, phi)
                h_GenMETpyvsGenMETphi_MG5.Fill(py, phi)
                h_GenMETpxvsGenMETpy_MG5.Fill(px, py)

        got_pfmet = evt.getByLabel("slimmedMETs", h_PFMET)
        if got_pfmet and len(h_PFMET.product()) > 0:
            met = h_PFMET.product()[0]
            fill_met_hists(h_PFMET_pt_MG5, h_PFMET_phi_MG5, h_PFMET_px_MG5, h_PFMET_py_MG5, h_PFMET_sumEt_MG5, met)

        got_puppimet = evt.getByLabel("slimmedMETsPuppi", h_PUPPIMET)
        if got_puppimet and len(h_PUPPIMET.product()) > 0:
            met = h_PUPPIMET.product()[0]
            fill_met_hists(h_PUPPIMET_pt_MG5, h_PUPPIMET_phi_MG5, h_PUPPIMET_px_MG5, h_PUPPIMET_py_MG5, h_PUPPIMET_sumEt_MG5, met)

        # thresholded GenParticle kinematics (local)
        for particle in packed:
            pdgid = int(particle.pdgId())
            if abs(pdgid) > THRESH:
                counts_packed[pdgid] += 1
                h_GenParticle_pt_MG5.Fill(float(particle.pt()))
                h_GenParticle_eta_MG5.Fill(float(particle.eta()))
                h_GenParticle_phi_MG5.Fill(float(particle.phi()))
                h_GenParticle_mass_MG5.Fill(float(particle.mass()))

        for particle in pruned:
            pdgid = int(particle.pdgId())
            if abs(pdgid) >= THRESH and particle.statusFlags().isLastCopy():
                counts_pruned[pdgid] += 1

        # R-hadron leading/subleading
        vecs = []
        for particle in packed:
            pdgid = int(particle.pdgId())
            if abs(pdgid) <= THRESH:
                continue
            tlv = TLorentzVector()
            tlv.SetPtEtaPhiM(float(particle.pt()), float(particle.eta()), float(particle.phi()), float(particle.mass()))
            vecs.append((tlv, pdgid))

        vecs.sort(key=lambda vm: vm[0].Pt(), reverse=True)
        lead = vecs[0] if len(vecs) >= 1 else None
        sub_lead = vecs[1] if len(vecs) >= 2 else None

        tlv1 = tlv2 = None
        rhad_pair = None

        if lead is not None:
            tlv1, _ = lead
            h_lead_pt_MG5.Fill(tlv1.Pt())
            h_lead_eta_MG5.Fill(tlv1.Eta())
            h_lead_phi_MG5.Fill(tlv1.Phi())
            h_lead_mass_MG5.Fill(tlv1.M())

        if sub_lead is not None:
            tlv2, _ = sub_lead
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

print(f"\n[Local] Total local events processed = {n_scanned}")
print(f"[Check] total packed R-hadrons (sum over PDGIDs) = {sum(counts_packed.values())}")
print(f"[Check] total pruned gluino (lastCopy)           = {counts_pruned.get(1000021, 0)}")

# Cap DAS events to match local events (if not normalized)
if MATCH_DAS_EVENTS_TO_LOCAL:
    if n_scanned > 0:
        MAX_EVENTS_DAS = int(n_scanned)
        print(f"[DAS] MATCH_DAS_EVENTS_TO_LOCAL=True -> Capping DAS scan to MAX_EVENTS_DAS={MAX_EVENTS_DAS}")
    else:
        print("[DAS] MATCH_DAS_EVENTS_TO_LOCAL=True but local processed 0 events -> leaving MAX_EVENTS_DAS unchanged.")

das_files = get_das_root_files(DAS_DATASET, nfiles=N_DAS_FILES, redirector=DAS_REDIRECTOR)

if len(das_files) == 0:
    print("[DAS] No DAS files returned -> DAS histograms will remain empty.")
else:
    print(f"[DAS] Will scan {len(das_files)} DAS file(s) for packedGenParticles...")
    das_evt_total = 0
    das_files_ok = 0

    for f in das_files:
        print(f"[DAS] Input: {f}")
        try:
            ev_das = Events(f)
        except Exception as e:
            print(f"[DAS] WARN could not open (skipping): {e}")
            continue

        das_files_ok += 1

        try:
            for evt in ev_das:
                if MAX_EVENTS_DAS > 0 and das_evt_total >= MAX_EVENTS_DAS:
                    break

                das_evt_total += 1

                ok = evt.getByLabel("packedGenParticles", h_packed)
                if not ok:
                    continue
                packed_das = h_packed.product()

                # thresholded GenParticle kinematics (DAS)
                for p in packed_das:
                    pdgid = int(p.pdgId())
                    if abs(pdgid) > THRESH:
                        h_GenParticle_pt_DAS.Fill(float(p.pt()))
                        h_GenParticle_eta_DAS.Fill(float(p.eta()))
                        h_GenParticle_phi_DAS.Fill(float(p.phi()))
                        h_GenParticle_mass_DAS.Fill(float(p.mass()))

                vecs_das = []
                for p in packed_das:
                    pdgid = int(p.pdgId())
                    if abs(pdgid) <= THRESH:
                        continue
                    tlv = TLorentzVector()
                    tlv.SetPtEtaPhiM(float(p.pt()), float(p.eta()), float(p.phi()), float(p.mass()))
                    vecs_das.append(tlv)

                vecs_das.sort(key=lambda v: v.Pt(), reverse=True)

                if len(vecs_das) >= 2:
                    rhad_pair_das = vecs_das[0] + vecs_das[1]
                    h_rhadpair_pt_DAS.Fill(rhad_pair_das.Pt())
                    h_rhadpair_eta_DAS.Fill(rhad_pair_das.Eta())
                    h_rhadpair_phi_DAS.Fill(rhad_pair_das.Phi())
                    h_rhadpair_mass_DAS.Fill(rhad_pair_das.M())
                    h_rhadpair_px_DAS.Fill(rhad_pair_das.Px())
                    h_rhadpair_py_DAS.Fill(rhad_pair_das.Py())
                    h_rhadpair_pz_DAS.Fill(rhad_pair_das.Pz())

        except Exception as e:
            print(f"[DAS] WARN exception while scanning file (skipping rest of this file): {e}")

        if MAX_EVENTS_DAS > 0 and das_evt_total >= MAX_EVENTS_DAS:
            break

    print(f"[DAS] Opened {das_files_ok}/{len(das_files)} file(s)")
    print(f"[DAS] Filled DAS entries: pt={h_GenParticle_pt_DAS.GetEntries():.0f}, eta={h_GenParticle_eta_DAS.GetEntries():.0f}, "
          f"phi={h_GenParticle_phi_DAS.GetEntries():.0f}, mass={h_GenParticle_mass_DAS.GetEntries():.0f} "
          f"from {das_evt_total} event(s)")

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
    h_GenMETphivsGenMETpt_MG5, h_GenMETptvsGenMETpx_MG5, h_GenMETptvsGenMETpy_MG5,
    h_GenMETpxvsGenMETphi_MG5, h_GenMETpyvsGenMETphi_MG5, h_GenMETpxvsGenMETpy_MG5,
    h_GenParticle_pt_MG5, h_GenParticle_eta_MG5, h_GenParticle_phi_MG5, h_GenParticle_mass_MG5,
    h_GenParticle_pt_DAS, h_GenParticle_eta_DAS, h_GenParticle_phi_DAS, h_GenParticle_mass_DAS,
    h_rhadpair_pt_DAS, h_rhadpair_eta_DAS, h_rhadpair_phi_DAS, h_rhadpair_mass_DAS,
    h_rhadpair_px_DAS, h_rhadpair_py_DAS, h_rhadpair_pz_DAS,
):
    h.Write()
fout.Close()
print(f"[Output] wrote ROOT file: {outroot}")


CMS_IPOS = 0
CMS.SetExtraText(f"Private Work: {MASS_POINT} {SAMPLE_TYPE} MC Simulation")
CMS.SetLumi(None, run="Run 3")
CMS.SetEnergy(13.6)


def draw_single(name, xmin, xmax, h, xtitle, ytitle, outpng,
                yoffset=1.45, titlesize=0.045, labelsize=0.040,
                logy=False, ymin_log=0.1, logx=False, xmin_log=0.1):
    xmin_use = xmin
    if logx and xmin_use <= 0:
        xmin_use = xmin_log

    ymax = max(h.GetMaximum(), 1.0) * 1.35
    ymin = ymin_log if logy else 0.0

    canv = CMS.cmsCanvas(name, xmin_use, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=CMS_IPOS)
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

    canv = CMS.cmsCanvas(name, xmin_use, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=CMS_IPOS)
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
                 logy=False, ymin_log=0.1, logx=False, xmin_log=0.1):
    xmin_use = xmin
    if logx and xmin_use <= 0:
        xmin_use = xmin_log

    ymax = max(h1.GetMaximum(), h2.GetMaximum(), 1.0) * 1.35
    ymin = ymin_log if logy else 0.0

    canv = CMS.cmsCanvas(name, xmin_use, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=CMS_IPOS)
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

    CMS.cmsDraw(h1, "HIST", lwidth=2, lcolor=ROOT.kBlue + 1, fstyle=0)
    CMS.cmsDraw(h2, "HIST SAME", lwidth=2, lstyle=ROOT.kDashed, lcolor=ROOT.kRed + 1, fstyle=0)

    leg = CMS.cmsLeg(0.60, 0.75, 0.88, 0.88, textSize=0.04)
    leg.AddEntry(h1, "Leading", "l")
    leg.AddEntry(h2, "Subleading", "l")
    leg.Draw()

    canv.SaveAs(outpng)
    print(f"[Output] wrote PNG: {outpng}")

def draw_compare_samples_with_ratio(
    name,
    xmin, xmax,
    h_local, h_das,
    xtitle, ytitle,
    outpng,
    ratio_ymin=0.0, ratio_ymax=2.0,
    yoffset=1.45, titlesize=0.045, labelsize=0.040,
    logy=False, ymin_log=0.1,
    logx=False, xmin_log=0.1,
    normalize=True,
    include_overflow=True,
):
    """
    Overlay (MG5 local vs DAS Pythia8) with ratio pad below.
    - If normalize=True: scales each hist to unit area (shape compare).
    - Ratio is hard-coded to: MadGraph5 / Pythia8
    """
    h_mg5 = h_local.Clone(f"{name}_mg5_draw")
    h_p8  = h_das.Clone(f"{name}_p8_draw")
    h_mg5.SetDirectory(0)
    h_p8.SetDirectory(0)

    # Normalize to unit area 
    if normalize:
        nb = h_mg5.GetNbinsX()
        lo = 0 if include_overflow else 1
        hi = nb + 1 if include_overflow else nb
        int_mg5 = h_mg5.Integral(lo, hi)
        int_p8  = h_p8.Integral(lo, hi)

        if int_mg5 > 0:
            h_mg5.Scale(1.0 / int_mg5)
        if int_p8 > 0:
            h_p8.Scale(1.0 / int_p8)

    xmin_use = xmin
    if logx and xmin_use <= 0:
        xmin_use = xmin_log

    ymax = max(h_mg5.GetMaximum(), h_p8.GetMaximum(), 1e-12) * 1.35
    ymin = ymin_log if logy else 0.0
    canv = CMS.cmsCanvas(name, xmin_use, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=CMS_IPOS)
    canv.cd()
    top = ROOT.TPad(f"{name}_top", "", 0.0, 0.30, 1.0, 1.0)
    bot = ROOT.TPad(f"{name}_bot", "", 0.0, 0.00, 1.0, 0.30)
    top.SetBottomMargin(0.02)
    bot.SetTopMargin(0.02)
    bot.SetBottomMargin(0.35)
    bot.SetGridx(False)
    bot.SetGridy(False)

    if logy:
        top.SetLogy(True)
        h_mg5.SetMinimum(ymin_log)
        h_p8.SetMinimum(ymin_log)
    if logx:
        top.SetLogx(True)
        bot.SetLogx(True)

    top.Draw()
    bot.Draw()
    top.cd()

    hframe = h_mg5.Clone(f"{name}_frame")
    hframe.Reset("ICES")
    hframe.SetMinimum(ymin)
    hframe.SetMaximum(ymax)

    hframe.GetXaxis().SetLabelSize(0)
    hframe.GetXaxis().SetTitleSize(0)

    hframe.GetYaxis().SetTitle(ytitle)
    hframe.GetYaxis().SetTitleSize(titlesize)
    hframe.GetYaxis().SetLabelSize(labelsize)
    hframe.GetYaxis().SetTitleOffset(yoffset)

    if logx:
        hframe.GetXaxis().SetMoreLogLabels(True)
        hframe.GetXaxis().SetNoExponent(True)

    hframe.Draw("AXIS")

    CMS.cmsDraw(h_mg5, "HIST",      lwidth=2, lcolor=ROOT.kBlue + 1, fstyle=0)
    CMS.cmsDraw(h_p8,  "HIST SAME", lwidth=2, lstyle=ROOT.kDashed, lcolor=ROOT.kRed + 1, fstyle=0)

    leg = CMS.cmsLeg(0.55, 0.75, 0.88, 0.88, textSize=0.035)
    leg.AddEntry(h_mg5, "MadGraph5 (Private)", "l")
    leg.AddEntry(h_p8,  "Pythia8 (Official)",  "l")
    leg.Draw()

    top.Modified()
    top.Update()

    # -------------
    # Bottom pad (ratio)
    # -------------
    bot.cd()

    ratio = h_mg5.Clone(f"{name}_ratio")
    ratio.Reset("ICES")
    ratio.SetStats(0)
    ratio.SetMarkerStyle(20)
    ratio.SetMarkerSize(0.9)
    ratio.SetMarkerColor(ROOT.kBlack)
    ratio.SetLineColor(ROOT.kBlack)
    ratio.SetLineWidth(1)

    nb = h_mg5.GetNbinsX()
    for i in range(1, nb + 1):
        a  = h_mg5.GetBinContent(i)  # MG5
        ea = h_mg5.GetBinError(i)
        b  = h_p8.GetBinContent(i)   # Pythia8
        eb = h_p8.GetBinError(i)

        if b > 0:
            r = a / b   #MG5/Pythia8
            if a > 0:
                dr = r * ((ea / a) ** 2 + (eb / b) ** 2) ** 0.5
            else:
                dr = r * (eb / b)  # if a=0, just keep denom term
            ratio.SetBinContent(i, r)
            ratio.SetBinError(i, dr)
        else:
            ratio.SetBinContent(i, 0.0)
            ratio.SetBinError(i, 0.0)

    ratio.SetMinimum(ratio_ymin)
    ratio.SetMaximum(ratio_ymax)

    ratio.GetYaxis().SetTitle("MadGraph5/Pythia8")
    ratio.GetYaxis().SetNdivisions(505)
    ratio.GetYaxis().SetTitleSize(0.11)
    ratio.GetYaxis().SetLabelSize(0.10)
    ratio.GetYaxis().SetTitleOffset(0.55)

    ratio.GetXaxis().SetTitle(xtitle)
    ratio.GetXaxis().SetTitleSize(0.13)
    ratio.GetXaxis().SetLabelSize(0.12)
    ratio.GetXaxis().SetTitleOffset(1.0)

    if logx:
        ratio.GetXaxis().SetMoreLogLabels(True)
        ratio.GetXaxis().SetNoExponent(True)

    ratio.Draw("E1")

    # Horizontal reference line at 1
    line = ROOT.TLine(xmin_use, 1.0, xmax, 1.0)
    line.SetLineStyle(ROOT.kDashed)
    line.SetLineWidth(2)
    line.SetLineColor(ROOT.kBlack)
    line.Draw("SAME")

    bot.Modified()
    bot.Update()

    canv.SaveAs(outpng)
    print(f"[Output] wrote PNG: {outpng}")


# MG5-only plots
draw_overlay("c_rhad_pt_MG5",   PT_MIN, PT_MAX,   h_lead_pt_MG5,   h_sublead_pt_MG5,   "R-hadron pT [GeV]", " ", "rhad_pt_MG5.png",   yoffset=1.01)
draw_overlay("c_rhad_eta_MG5",  ETA_MIN, ETA_MAX, h_lead_eta_MG5,  h_sublead_eta_MG5,  "R-hadron #eta",         " ", "rhad_eta_MG5.png",  yoffset=1.01)
draw_overlay("c_rhad_phi_MG5",  PHI_MIN, PHI_MAX, h_lead_phi_MG5,  h_sublead_phi_MG5,  "R-hadron #phi",         " ", "rhad_phi_MG5.png",  yoffset=1.01)
draw_overlay("c_rhad_mass_MG5", MASS_MIN, MASS_MAX, h_lead_mass_MG5, h_sublead_mass_MG5, "R-hadron mass [GeV]", " ", "rhad_mass_MG5.png", yoffset=1.01)
draw_single("c_dphi_MG5", 0.0, 3.5, h_lead_sublead_Delta_phi_MG5, "|#Delta#phi(lead, sublead)|", " ", "lead_sublead_dphi_MG5.png", yoffset=1.01)

draw_single("c_rhadpair_pt_MG5",   PAIR_PT_MIN,   PAIR_PT_MAX,   h_rhadpair_pt_MG5,   "(lead+sublead R-hadrons) pT [GeV]", " ", "rhadpair_pt_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_rhadpair_eta_MG5",  PAIR_ETA_MIN,  PAIR_ETA_MAX,  h_rhadpair_eta_MG5,  "(lead+sublead R-hadrons) #eta",         " ", "rhadpair_eta_MG5.png",  logy=True, yoffset=1.01)
draw_single("c_rhadpair_phi_MG5",  PAIR_PHI_MIN,  PAIR_PHI_MAX,  h_rhadpair_phi_MG5,  "(lead+sublead R-hadrons) #phi",         " ", "rhadpair_phi_MG5.png",  logy=True, yoffset=1.01)
draw_single("c_rhadpair_mass_MG5", PAIR_MASS_MIN, PAIR_MASS_MAX, h_rhadpair_mass_MG5, "(lead+sublead R-hadrons) mass [GeV]",    " ", "rhadpair_mass_MG5.png", logy=True, yoffset=1.01)
draw_single("c_rhadpair_px_MG5",   PAIR_PXYZ_MIN, PAIR_PXYZ_MAX, h_rhadpair_px_MG5,   "(lead+sublead R-hadrons) px [GeV]",   " ", "rhadpair_px_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_rhadpair_py_MG5",   PAIR_PXYZ_MIN, PAIR_PXYZ_MAX, h_rhadpair_py_MG5,   "(lead+sublead R-hadrons) py [GeV]",   " ", "rhadpair_py_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_rhadpair_pz_MG5",   PAIR_PXYZ_MIN, PAIR_PXYZ_MAX, h_rhadpair_pz_MG5,   "(lead+sublead R-hadrons) pz [GeV]",   " ", "rhadpair_pz_MG5.png",   logy=True, yoffset=1.01)

draw_single("c_genmet_pt_MG5",    0, 250, h_GenMET_pt_MG5,    "GEN MET pT [GeV]", " ", "genmet_pt_MG5.png",    logy=True, yoffset=1.01, ymin_log=0.1)
draw_single("c_genmet_phi_MG5",   MET_PHI_MIN, MET_PHI_MAX, h_GenMET_phi_MG5, "GEN MET #phi", " ", "genmet_phi_MG5.png", logy=True, yoffset=1.01)
draw_single("c_genmet_px_MG5",   -250, 250, h_GenMET_px_MG5,  "GEN MET px [GeV]", " ", "genmet_px_MG5.png",     logy=True, yoffset=1.01)
draw_single("c_genmet_py_MG5",   -250, 250, h_GenMET_py_MG5,  "GEN MET py [GeV]", " ", "genmet_py_MG5.png",     logy=True, yoffset=1.01)
draw_single("c_genmet_sumEt_MG5", 0.0, 9000.0, h_GenMET_sumEt_MG5, "#SigmaE_{T} [GeV]", " ", "genmet_sumEt_MG5.png", logy=True, yoffset=1.01)

draw_single("c_genmet_phi_pxpyThresh_MG5", MET_PHI_MIN, MET_PHI_MAX,h_GenMET_phi_pxpyThresh_MG5,f"GEN MET #phi (|p_{{x}}|,|p_{{y}}| > {GENMET_PXY_ABS_THRESH} GeV)", " ","genmet_phi_pxpyThresh_MG5.png",logy=True, yoffset=1.01)

draw_single("c_pfmet_pt_MG5",    MET_PT_MIN, MET_PT_MAX,  h_PFMET_pt_MG5,    "PF MET pT [GeV]", " ", "pfmet_pt_MG5.png",    logy=True, yoffset=1.01, ymin_log=0.1)
draw_single("c_pfmet_phi_MG5",   MET_PHI_MIN, MET_PHI_MAX, h_PFMET_phi_MG5,  "PF MET #phi",        " ", "pfmet_phi_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_pfmet_px_MG5",    MET_PXY_MIN, MET_PXY_MAX, h_PFMET_px_MG5,   "PF MET px [GeV]", " ", "pfmet_px_MG5.png",    logy=True, yoffset=1.01)
draw_single("c_pfmet_py_MG5",    MET_PXY_MIN, MET_PXY_MAX, h_PFMET_py_MG5,   "PF MET py [GeV]", " ", "pfmet_py_MG5.png",    logy=True, yoffset=1.01)
draw_single("c_pfmet_sumEt_MG5", 0.0, 9000.0, h_PFMET_sumEt_MG5, "#SigmaE_{T} [GeV]", " ", "pfmet_sumEt_MG5.png", logy=True, yoffset=1.01)

draw_single("c_puppimet_pt_MG5",    MET_PT_MIN, MET_PT_MAX,  h_PUPPIMET_pt_MG5,   "PUPPI MET pT [GeV]", " ", "puppimet_pt_MG5.png",    logy=True, yoffset=1.01, ymin_log=0.1)
draw_single("c_puppimet_phi_MG5",   MET_PHI_MIN, MET_PHI_MAX, h_PUPPIMET_phi_MG5, "PUPPI MET #phi",        " ", "puppimet_phi_MG5.png",   logy=True, yoffset=1.01)
draw_single("c_puppimet_px_MG5",    MET_PXY_MIN, MET_PXY_MAX, h_PUPPIMET_px_MG5,  "PUPPI MET px [GeV]", " ", "puppimet_px_MG5.png",    logy=True, yoffset=1.01)
draw_single("c_puppimet_py_MG5",    MET_PXY_MIN, MET_PXY_MAX, h_PUPPIMET_py_MG5,  "PUPPI MET py [GeV]", " ", "puppimet_py_MG5.png",    logy=True, yoffset=1.01)
draw_single("c_puppimet_sumEt_MG5", 0.0, 9000.0, h_PUPPIMET_sumEt_MG5, "#SigmaE_{T} [GeV]", " ", "puppimet_sumEt_MG5.png", logy=True, yoffset=1.01)

draw_2d_colz("c_genmet_phi_vs_pt_MG5", GENMET_PT_MIN, GENMET_PT_MAX, GENMET_PHI_MIN, GENMET_PHI_MAX, h_GenMETphivsGenMETpt_MG5, "GEN MET pT [GeV]", "GEN MET #phi", "genmet_phi_vs_pt_MG5.png", logz=True)
draw_2d_colz("c_genmet_pt_vs_px_MG5",  GENMET_PT_MIN, GENMET_PT_MAX, GENMET_PXY_MIN, GENMET_PXY_MAX, h_GenMETptvsGenMETpx_MG5,  "GEN MET pT [GeV]", "GEN MET px [GeV]", "genmet_pt_vs_px_MG5.png", logz=True)
draw_2d_colz("c_genmet_pt_vs_py_MG5",  GENMET_PT_MIN, GENMET_PT_MAX, GENMET_PXY_MIN, GENMET_PXY_MAX, h_GenMETptvsGenMETpy_MG5,  "GEN MET pT [GeV]", "GEN MET py [GeV]", "genmet_pt_vs_py_MG5.png", logz=True)
draw_2d_colz("c_genmet_px_vs_phi_MG5", GENMET_PXY_MIN, GENMET_PXY_MAX, GENMET_PHI_MIN, GENMET_PHI_MAX, h_GenMETpxvsGenMETphi_MG5, "GEN MET px [GeV]", "GEN MET #phi", "genmet_px_vs_phi_MG5.png", logz=True)
draw_2d_colz("c_genmet_py_vs_phi_MG5", GENMET_PXY_MIN, GENMET_PXY_MAX, GENMET_PHI_MIN, GENMET_PHI_MAX, h_GenMETpyvsGenMETphi_MG5, "GEN MET py [GeV]", "GEN MET #phi", "genmet_pyvsphi_MG5.png", logz=True)
draw_2d_colz("c_genmet_px_vs_py_MG5",  GENMET_PXY_MIN, GENMET_PXY_MAX, GENMET_PXY_MIN, GENMET_PXY_MAX, h_GenMETpxvsGenMETpy_MG5,  "GEN MET px [GeV]", "GEN MET py [GeV]", "genmet_px_vs_py_MG5.png", logz=True)


# Draw local vs DAS comparisons
if h_GenParticle_pt_DAS.GetEntries() > 0:
    draw_compare_samples_with_ratio("c_genparticle_pt_local_vs_das",PT_MIN, PT_MAX,h_GenParticle_pt_MG5, h_GenParticle_pt_DAS,"GenParticle pT [GeV]", " ","genparticle_pt_MG5_vs_DAS_Pythia8.png",    logy=True, ymin_log=0.1, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio("c_genparticle_eta_local_vs_das",ETA_MIN, ETA_MAX,h_GenParticle_eta_MG5, h_GenParticle_eta_DAS,"GenParticle #eta", " ","genparticle_eta_MG5_vs_DAS_Pythia8.png",     logy=False, ymin_log=0.1, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio("c_genparticle_phi_local_vs_das",PHI_MIN, PHI_MAX,h_GenParticle_phi_MG5, h_GenParticle_phi_DAS,"GenParticle #phi", " ","genparticle_phi_MG5_vs_DAS_Pythia8.png",     logy=True, ymin_log=0.1, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio("c_genparticle_mass_local_vs_das",0.0, 3000.0,h_GenParticle_mass_MG5, h_GenParticle_mass_DAS,"GenParticle mass [GeV]", " ","genparticle_mass_MG5_vs_DAS_Pythia8.png",logy=True, ymin_log=0.1, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
else:
    print("[DAS] Skipping all local-vs-DAS GenParticle comparison PNGs because DAS histograms are empty.")


# MG5 rhad-pair vs DAS rhad-pair comparisons w/ ratio 
if h_rhadpair_pt_DAS.GetEntries() > 0 and h_rhadpair_pt_MG5.GetEntries() > 0:
    draw_compare_samples_with_ratio( "c_rhadpair_pt_MG5_vs_DAS", PAIR_PT_MIN, PAIR_PT_MAX, h_rhadpair_pt_MG5, h_rhadpair_pt_DAS, "(lead+sublead R-hadrons) pT [GeV]", " ", "rhadpair_pt_MG5_vs_DAS_Pythia8.png",            logy=True, ymin_log=1e-6, yoffset=1.01, ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio("c_rhadpair_eta_MG5_vs_DAS",PAIR_ETA_MIN, PAIR_ETA_MAX,h_rhadpair_eta_MG5, h_rhadpair_eta_DAS,"(lead+sublead R-hadrons) #eta", " ","rhadpair_eta_MG5_vs_DAS_Pythia8.png",                  logy=False, ymin_log=1e-6, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio("c_rhadpair_phi_MG5_vs_DAS",PAIR_PHI_MIN, PAIR_PHI_MAX,h_rhadpair_phi_MG5, h_rhadpair_phi_DAS,"(lead+sublead R-hadrons) #phi", " ","rhadpair_phi_MG5_vs_DAS_Pythia8.png",                  logy=True, ymin_log=1e-6, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio( "c_rhadpair_mass_MG5_vs_DAS", PAIR_MASS_MIN, PAIR_MASS_MAX, h_rhadpair_mass_MG5, h_rhadpair_mass_DAS, "(lead+sublead R-hadrons) mass [GeV]", " ", "rhadpair_mass_MG5_vs_DAS_Pythia8.png", logy=True, ymin_log=1e-6, yoffset=1.01, ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio("c_rhadpair_px_MG5_vs_DAS",PAIR_PXYZ_MIN, PAIR_PXYZ_MAX,h_rhadpair_px_MG5, h_rhadpair_px_DAS,"(lead+sublead R-hadrons) px [GeV]", " ","rhadpair_px_MG5_vs_DAS_Pythia8.png",             logy=True, ymin_log=1e-6, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio("c_rhadpair_py_MG5_vs_DAS",PAIR_PXYZ_MIN, PAIR_PXYZ_MAX,h_rhadpair_py_MG5, h_rhadpair_py_DAS,"(lead+sublead R-hadrons) py [GeV]", " ","rhadpair_py_MG5_vs_DAS_Pythia8.png",             logy=True, ymin_log=1e-6, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
    draw_compare_samples_with_ratio("c_rhadpair_pz_MG5_vs_DAS",PAIR_PXYZ_MIN, PAIR_PXYZ_MAX,h_rhadpair_pz_MG5, h_rhadpair_pz_DAS,"(lead+sublead R-hadrons) pz [GeV]", " ","rhadpair_pz_MG5_vs_DAS_Pythia8.png",             logy=True, ymin_log=1e-6, yoffset=1.01,ratio_ymin=0.0, ratio_ymax=2.0)
else:
    print("[Compare] Skipping rhadron-pair MG5-vs-DAS plots because one side is empty.")
