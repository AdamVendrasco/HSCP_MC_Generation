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
    #... need more local files.
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.19-MINIAODSIM.root"
]

THRESH = 1_000_000
MAX_EVENTS_TO_PRINT = 1

NBINS = 40
PT_MIN, PT_MAX   = 0.0, 3500.0
ETA_MIN, ETA_MAX = -6.0, 6.0
PHI_MIN, PHI_MAX = -4.0, 4.0
MASS_MIN, MASS_MAX = 1000.0, 2600.0

PT_PAIR_MIN,  PT_PAIR_MAX   = 0.0, 2500.0
MASS_PAIR_MIN, MASS_PAIR_MAX = 3000.0, 8000.0
P_PAIR_MIN,   P_PAIR_MAX    = -2000.0, 2000.0

counts_packed = Counter()
counts_pruned = Counter()

h_packed = Handle("std::vector<pat::PackedGenParticle>")
h_pruned = Handle("std::vector<reco::GenParticle>")
h_GenMET = Handle("std::vector<reco::GenMET>")

print("\n[Setup] Looking at std::vector<pat::PackedGenParticle> (packedGenParticles)")
print("[Setup] Looking at std::vector<reco::GenParticle> (prunedGenParticles)")
print("[Setup] Looking at std::vector<reco::GenMET> (genMetTrue)")

h_lead_pt_MG5    = ROOT.TH1D("lead_rhad_pt_MG5",     ";leading R-hadron p_{T} [GeV];Events", NBINS, PT_MIN, PT_MAX)
h_sublead_pt_MG5 = ROOT.TH1D("sublead_rhad_pt_MG5",  ";subleading R-hadron p_{T} [GeV];Events", NBINS, PT_MIN, PT_MAX)
h_lead_eta_MG5   = ROOT.TH1D("lead_rhad_eta_MG5",    ";leading R-hadron #eta;Events", NBINS, ETA_MIN, ETA_MAX)
h_sublead_eta_MG5= ROOT.TH1D("sublead_rhad_eta_MG5", ";subleading R-hadron #eta;Events", NBINS, ETA_MIN, ETA_MAX)
h_lead_phi_MG5   = ROOT.TH1D("lead_rhad_phi_MG5",    ";leading R-hadron #phi;Events", NBINS, PHI_MIN, PHI_MAX)
h_sublead_phi_MG5= ROOT.TH1D("sublead_rhad_phi_MG5", ";subleading R-hadron #phi;Events", NBINS, PHI_MIN, PHI_MAX)
h_lead_mass_MG5  = ROOT.TH1D("lead_rhad_mass_MG5",   ";leading R-hadron mass [GeV];Events", NBINS, MASS_MIN, MASS_MAX)
h_sublead_mass_MG5 = ROOT.TH1D("sublead_rhad_mass_MG5",";subleading R-hadron mass [GeV];Events", NBINS, MASS_MIN, MASS_MAX)

h_lead_sublead_Delta_phi_MG5 = ROOT.TH1D("lead_sublead_Delta_phi_MG5", ";|#Delta#phi(lead, sublead)|;Events", NBINS, 0.0, 3.7)

h_rhadpair_pt_MG5   = ROOT.TH1D("rhadpair_pt_MG5",   ";(lead+sublead R-hadrons) p_{T} [GeV];Events", NBINS, 0, 3500)
h_rhadpair_eta_MG5  = ROOT.TH1D("rhadpair_eta_MG5",  ";(lead+sublead R-hadrons) #eta;Events",        NBINS, -8, 8)
h_rhadpair_phi_MG5  = ROOT.TH1D("rhadpair_phi_MG5",  ";(lead+sublead R-hadrons) #phi;Events",        NBINS, -5, 5)
h_rhadpair_mass_MG5 = ROOT.TH1D("rhadpair_mass_MG5", ";(lead+sublead R-hadrons) mass [GeV];Events",  NBINS, MASS_PAIR_MIN, MASS_PAIR_MAX)
h_rhadpair_px_MG5   = ROOT.TH1D("rhadpair_px_MG5",   ";(lead+sublead R-hadrons) p_{x} [GeV];Events", NBINS, P_PAIR_MIN, P_PAIR_MAX)
h_rhadpair_py_MG5   = ROOT.TH1D("rhadpair_py_MG5",   ";(lead+sublead R-hadrons) p_{y} [GeV];Events", NBINS, P_PAIR_MIN, P_PAIR_MAX)
h_rhadpair_pz_MG5   = ROOT.TH1D("rhadpair_pz_MG5",   ";(lead+sublead R-hadrons) p_{z} [GeV];Events", NBINS, -8000, 8000)

h_GenMET_pt_MG5    = ROOT.TH1D("GenMET_pt_MG5",    ";GEN MET p_{T} [GeV];Events", 200, 0.0, 1000.0)
h_GenMET_phi_MG5   = ROOT.TH1D("GenMET_phi_MG5",   ";GEN MET #phi;Events",        70, -3.5, 3.5)
h_GenMET_px_MG5    = ROOT.TH1D("GenMET_px_MG5",   ";GEN MET p_{x} [GeV];Events", 200, -1000.0, 1000.0)
h_GenMET_py_MG5    = ROOT.TH1D("GenMET_py_MG5",    ";GEN MET p_{y} [GeV];Events", 200, -1000.0, 1000.0)
h_GenMET_sumEt_MG5 = ROOT.TH1D("GenMET_sumEt_MG5", ";GEN MET #SigmaE_{T} [GeV];Events", 200, 0.0, 9000.0)

for h in (
    h_lead_pt_MG5, h_sublead_pt_MG5,
    h_lead_eta_MG5, h_sublead_eta_MG5,
    h_lead_phi_MG5, h_sublead_phi_MG5,
    h_lead_mass_MG5, h_sublead_mass_MG5,
    h_lead_sublead_Delta_phi_MG5,
    h_rhadpair_pt_MG5, h_rhadpair_eta_MG5, h_rhadpair_phi_MG5, h_rhadpair_mass_MG5,
    h_rhadpair_px_MG5, h_rhadpair_py_MG5, h_rhadpair_pz_MG5,
    h_GenMET_pt_MG5, h_GenMET_phi_MG5, h_GenMET_px_MG5, h_GenMET_py_MG5, h_GenMET_sumEt_MG5
):
    h.SetFillStyle(0)
    h.SetFillColor(0)
    h.SetMarkerStyle(0)

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

        got_genmet = evt.getByLabel("genMetTrue", h_GenMET)
        if not got_genmet:
            got_genmet = evt.getByLabel(("genMetTrue", "", "DIGI2RAW"), h_GenMET)

        if got_genmet:
            for met in h_GenMET.product():
                h_GenMET_pt_MG5.Fill(float(met.pt()))
                h_GenMET_phi_MG5.Fill(float(met.phi()))
                h_GenMET_px_MG5.Fill(float(met.px()))
                h_GenMET_py_MG5.Fill(float(met.py()))
                h_GenMET_sumEt_MG5.Fill(float(met.sumEt()))

        for particle in packed:
            pdgid = int(particle.pdgId())
            if abs(pdgid) > THRESH:
                counts_packed[pdgid] += 1

        for particle in pruned:
            pdgid = int(particle.pdgId())
            if abs(pdgid) >= THRESH and particle.statusFlags().isLastCopy():
                counts_pruned[pdgid] += 1

        vecs = []  # list of (TLorentzVector, pdgid)
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

        #(prevents stale prints)
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

            # -----------------------------
            # 4-vector = tlv1 + tlv2 (ONLY the two R-hadrons)
            # -----------------------------
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
    h_GenMET_pt_MG5, h_GenMET_phi_MG5, h_GenMET_px_MG5, h_GenMET_py_MG5, h_GenMET_sumEt_MG5
):
    h.Write()
fout.Close()
print(f"[Output] wrote ROOT file: {outroot}")


CMS.SetExtraText("Private Work: Gluino GEN-level MC Simulation")
CMS.SetLumi(None, run="Run 3")
CMS.SetEnergy(13.6)

def draw_single(name, xmin, xmax, h, xtitle, ytitle, outpng, yoffset=1.45, titlesize=0.045, labelsize=0.040, logy=False, ymin_log=0.1):
    ymax = max(h.GetMaximum(), 1.0) * 1.35
    ymin = ymin_log if logy else 0.0
    canv = CMS.cmsCanvas(name, xmin, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=11)
    if logy:
        canv.SetLogy(True)
        h.SetMinimum(ymin_log)

    frame = CMS.GetCmsCanvasHist(canv)
    frame.GetXaxis().SetTitleSize(titlesize)
    frame.GetYaxis().SetTitleSize(titlesize)
    frame.GetXaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetTitleOffset(yoffset)

    canv.Modified()
    canv.Update()

    CMS.cmsDraw(h, "HIST", lwidth=2, lcolor=ROOT.kBlue + 1, fstyle=0)

    canv.SaveAs(outpng)
    print(f"[Output] wrote PNG: {outpng}")


def draw_overlay(name, xmin, xmax, h1, h2, xtitle, ytitle, outpng, yoffset=1.45, titlesize=0.045, labelsize=0.040, logy=False, ymin_log=0.1):
    ymax = max(h1.GetMaximum(), h2.GetMaximum(), 1.0) * 1.35
    ymin = ymin_log if logy else 0.0

    canv = CMS.cmsCanvas(name, xmin, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=11)
    if logy:
        canv.SetLogy(True)
        h1.SetMinimum(ymin_log)
        h2.SetMinimum(ymin_log)

    frame = CMS.GetCmsCanvasHist(canv)
    frame.GetXaxis().SetTitleSize(titlesize)
    frame.GetYaxis().SetTitleSize(titlesize)
    frame.GetXaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetTitleOffset(yoffset)

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

# R-hadron plots
draw_overlay("c_rhad_pt_MG5",   PT_MIN,   PT_MAX,   h_lead_pt_MG5,   h_sublead_pt_MG5,   "R-hadron p_{T} [GeV]", "Events", "rhad_pt_MG5.png",    yoffset=1.01)
draw_overlay("c_rhad_eta_MG5",  ETA_MIN,  ETA_MAX,  h_lead_eta_MG5,  h_sublead_eta_MG5,  "R-hadron #eta",       "Events", "rhad_eta_MG5.png",  yoffset=1.01)
draw_overlay("c_rhad_phi_MG5",  PHI_MIN,  PHI_MAX,  h_lead_phi_MG5,  h_sublead_phi_MG5,  "R-hadron #phi",       "Events", "rhad_phi_MG5.png",   yoffset=1.01)
draw_overlay("c_rhad_mass_MG5", MASS_MIN, MASS_MAX, h_lead_mass_MG5, h_sublead_mass_MG5, "R-hadron mass [GeV]", "Events", "rhad_mass_MG5.png",  yoffset=1.01)
draw_single ("c_dphi_MG5",      0.0,      3.5,      h_lead_sublead_Delta_phi_MG5,   "|#Delta#phi(lead, sublead)|", "Events", "lead_sublead_dphi_MG5.png", yoffset=1.01)

# sum rhadrons plots (lead+sublead only)
draw_single("c_rhadpair_pt_MG5",   0,   3500,    h_rhadpair_pt_MG5,   "(lead+sublead R-hadrons) p_{T} [GeV]", "Events", "rhadpair_pt_MG5.png", yoffset=1.01)
draw_single("c_rhadpair_eta_MG5",  -8,           8,              h_rhadpair_eta_MG5,  "(lead+sublead R-hadrons) #eta",        "Events", "rhadpair_eta_MG5.png",  yoffset=1.01)
draw_single("c_rhadpair_phi_MG5",  -5,           5,              h_rhadpair_phi_MG5,  "(lead+sublead R-hadrons) #phi",        "Events", "rhadpair_phi_MG5.png",  yoffset=1.01)
draw_single("c_rhadpair_mass_MG5", MASS_PAIR_MIN, MASS_PAIR_MAX,  h_rhadpair_mass_MG5, "(lead+sublead R-hadrons) mass [GeV]",  "Events", "rhadpair_mass_MG5.png", yoffset=1.01)

draw_single("c_rhadpair_px_MG5",   P_PAIR_MIN,    P_PAIR_MAX,     h_rhadpair_px_MG5,   "(lead+sublead R-hadrons) p_{x} [GeV]", "Events", "rhadpair_px_MG5.png",   yoffset=1.01)
draw_single("c_rhadpair_py_MG5",   P_PAIR_MIN,    P_PAIR_MAX,     h_rhadpair_py_MG5,   "(lead+sublead R-hadrons) p_{y} [GeV]", "Events", "rhadpair_py_MG5.png",   yoffset=1.01)
draw_single("c_rhadpair_pz_MG5",   -8000,    8000,     h_rhadpair_pz_MG5,   "(lead+sublead R-hadrons) p_{z} [GeV]", "Events", "rhadpair_pz_MG5.png",   yoffset=1.01)

# GEN MET plots
draw_single("c_genmet_pt_MG5",    0.0,  1000.0,  h_GenMET_pt_MG5,    "GEN MET p_{T} [GeV]",        "Events", "genmet_pt_MG5.png",    logy=True,  yoffset=1.01,  ymin_log=0.1)
draw_single("c_genmet_phi_MG5",  -3.5,    3.5,  h_GenMET_phi_MG5,   "GEN MET #phi",               "Events", "genmet_phi_MG5.png",   logy=True,  yoffset=1.01)
draw_single("c_genmet_px_MG5",  -1000.0, 1000.0, h_GenMET_px_MG5,    "GEN MET p_{x} [GeV]",        "Events", "genmet_px_MG5.png",    logy=True,  yoffset=1.01)
draw_single("c_genmet_py_MG5",  -1000.0,  1000.0, h_GenMET_py_MG5,    "GEN MET p_{y} [GeV]",        "Events", "genmet_py_MG5.png",    logy=True,  yoffset=1.01)
draw_single("c_genmet_sumEt_MG5", 0.0,  9000.0, h_GenMET_sumEt_MG5, "#SigmaE_{T} [GeV]",          "Events", "genmet_sumEt_MG5.png", logy=True,  yoffset=1.01)
