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
    "root://cmseos.fnal.gov//eos/uscms/store/user/avendras/HSCP/gridpack_output/root_files/PrivateSamples-Gael/Pileup_included/HSCP-Gluino_Par-M-1800/HSCP-Gluino_Par-M-1800_xqcut150_el8_amd64_gcc12_2024-CMSSW_14_0_22-n5000-Run3_2024-job82856820.19-MINIAODSIM.root"
    
]

THRESH = 1_000_000
MAX_EVENTS_TO_PRINT = 1

NBINS = 40
PT_MIN, PT_MAX   = 0.0, 3500.0
ETA_MIN, ETA_MAX = -6.0, 6.0
PHI_MIN, PHI_MAX = -4.0, 4.0
MASS_MIN, MASS_MAX = 1000.0, 2600.0

counts_packed = Counter()
counts_pruned = Counter()

h_packed = Handle("std::vector<pat::PackedGenParticle>")
h_pruned = Handle("std::vector<reco::GenParticle>")
h_GenMET = Handle("std::vector<reco::GenMET>")

print("\n[Setup] Looking at std::vector<pat::PackedGenParticle> (packedGenParticles)")
print("[Setup] Looking at std::vector<reco::GenParticle> (prunedGenParticles)")
print("[Setup] Looking at std::vector<reco::GenMET> (genMetTrue)")

h_lead_pt    = ROOT.TH1D("lead_rhad_pt_packed",     ";leading packed R-hadron p_{T} [GeV];Events", NBINS, PT_MIN, PT_MAX)
h_sublead_pt = ROOT.TH1D("sublead_rhad_pt_packed",  ";subleading packed R-hadron p_{T} [GeV];Events", NBINS, PT_MIN, PT_MAX)

h_lead_eta   = ROOT.TH1D("lead_rhad_eta_packed",    ";leading packed R-hadron #eta;Events", NBINS, ETA_MIN, ETA_MAX)
h_sublead_eta= ROOT.TH1D("sublead_rhad_eta_packed", ";subleading packed R-hadron #eta;Events", NBINS, ETA_MIN, ETA_MAX)

h_lead_phi   = ROOT.TH1D("lead_rhad_phi_packed",    ";leading packed R-hadron #phi;Events", NBINS, PHI_MIN, PHI_MAX)
h_sublead_phi= ROOT.TH1D("sublead_rhad_phi_packed", ";subleading packed R-hadron #phi;Events", NBINS, PHI_MIN, PHI_MAX)

h_lead_mass  = ROOT.TH1D("lead_rhad_mass_packed",   ";leading packed R-hadron mass [GeV];Events", NBINS, MASS_MIN, MASS_MAX)
h_sublead_mass = ROOT.TH1D("sublead_rhad_mass_packed",";subleading packed R-hadron mass [GeV];Events", NBINS, MASS_MIN, MASS_MAX)

h_lead_sublead_Delta_phi = ROOT.TH1D("lead_sublead_Delta_phi_packed", ";|#Delta#phi(lead, sublead)|;Events", NBINS, 0.0, 3.7)

h_GenMET_pt    = ROOT.TH1D("GenMET_pt",    ";GEN MET p_{T} [GeV];Events", 200, 0.0, 1000.0)
h_GenMET_phi   = ROOT.TH1D("GenMET_phi",   ";GEN MET #phi;Events",        70, -3.5, 3.5)
h_GenMET_px    = ROOT.TH1D("GenMET_px",    ";GEN MET p_{x} [GeV];Events", 200, -1000.0, 1000.0)
h_GenMET_py    = ROOT.TH1D("GenMET_py",    ";GEN MET p_{y} [GeV];Events", 200, -1000.0, 1000.0)
h_GenMET_sumEt = ROOT.TH1D("GenMET_sumEt", ";GEN MET #SigmaE_{T} [GeV];Events", 200, 0.0, 9000.0)

for h in (
    h_lead_pt, h_sublead_pt,
    h_lead_eta, h_sublead_eta,
    h_lead_phi, h_sublead_phi,
    h_lead_mass, h_sublead_mass,
    h_lead_sublead_Delta_phi,
    h_GenMET_pt, h_GenMET_phi, h_GenMET_px, h_GenMET_py, h_GenMET_sumEt
):
    h.SetFillStyle(0)
    h.SetFillColor(0)
    h.SetMarkerStyle(0)

n_scanned = 0

for FILE in FILES:
    print(f"\n[Input] {FILE}")
    events = Events(FILE)
    printed_this_file = 0

    for evt in events:
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
                h_GenMET_pt.Fill(float(met.pt()))
                h_GenMET_phi.Fill(float(met.phi()))
                h_GenMET_px.Fill(float(met.px()))
                h_GenMET_py.Fill(float(met.py()))
                h_GenMET_sumEt.Fill(float(met.sumEt()))

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

        if lead is not None:
            tlv1, pdgid1 = lead
            h_lead_pt.Fill(tlv1.Pt())
            h_lead_eta.Fill(tlv1.Eta())
            h_lead_phi.Fill(tlv1.Phi())
            h_lead_mass.Fill(tlv1.M())

        if sub_lead is not None:
            tlv2, pdgid2 = sub_lead
            h_sublead_pt.Fill(tlv2.Pt())
            h_sublead_eta.Fill(tlv2.Eta())
            h_sublead_phi.Fill(tlv2.Phi())
            h_sublead_mass.Fill(tlv2.M())

        if lead is not None and sub_lead is not None:
            dphi = float(tlv1.DeltaPhi(tlv2))
            h_lead_sublead_Delta_phi.Fill(abs(dphi))

        if MAX_EVENTS_TO_PRINT != 0 and (MAX_EVENTS_TO_PRINT < 0 or printed_this_file < MAX_EVENTS_TO_PRINT):
            printed_this_file += 1

            if lead is None:
                print(f"[packed] file_evt {printed_this_file:5d}  global_evt {n_scanned:5d}  lead: (none)  sublead: (none)")
            elif sub_lead is None:
                print(
                    f"[packed] file_evt {printed_this_file:5d}  global_evt {n_scanned:5d}  "
                    f"lead: ({pdgid1}, pt={tlv1.Pt():.2f} GeV, eta={tlv1.Eta():.3f}, phi={tlv1.Phi():.3f}, m={tlv1.M():.2f} GeV)  "
                    f"sublead: (none)"
                )
            else:
                print(
                    f"[packed] file_evt {printed_this_file:5d}  global_evt {n_scanned:5d}  "
                    f"lead: ({pdgid1}, pt={tlv1.Pt():.2f} GeV, eta={tlv1.Eta():.3f}, phi={tlv1.Phi():.3f}, m={tlv1.M():.2f} GeV)  "
                    f"sublead: ({pdgid2}, pt={tlv2.Pt():.2f} GeV, eta={tlv2.Eta():.3f}, phi={tlv2.Phi():.3f}, m={tlv2.M():.2f} GeV)"
                )

print("\nTop Packed PDGIDs with |pdgId| > 1,000,000:")
for pdgid, c in counts_packed.most_common(30):
    print(f"{pdgid:10d}  {c}")

print("\nTop Pruned PDGIDs with |pdgId| > 1,000,000:")
for pdgid, c in counts_pruned.most_common(30):
    print(f"{pdgid:10d}  {c}")

total_rhads_packed = sum(counts_packed.values())
print(f"[Check] total packed R-hadrons (sum over PDGIDs) = {total_rhads_packed}")
print(f"[Check] total pruned gluino (lastCopy)           = {counts_pruned.get(1000021, 0)}")

outroot = "rhad_packed_kinematics.root"
fout = ROOT.TFile(outroot, "RECREATE")
for h in (
    h_lead_pt, h_sublead_pt,
    h_lead_eta, h_sublead_eta,
    h_lead_phi, h_sublead_phi,
    h_lead_mass, h_sublead_mass,
    h_lead_sublead_Delta_phi,
    h_GenMET_pt, h_GenMET_phi, h_GenMET_px, h_GenMET_py, h_GenMET_sumEt
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
    leg.AddEntry(h1, "Leading (packed)", "l")
    leg.AddEntry(h2, "Subleading (packed)", "l")
    leg.Draw()

    canv.SaveAs(outpng)
    print(f"[Output] wrote PNG: {outpng}")

# R-hadron plots
draw_overlay("c_rhad_pt_packed",   PT_MIN,   PT_MAX,   h_lead_pt,   h_sublead_pt,   "packed R-hadron p_{T} [GeV]", "Events", "rhad_pt_packed.png",    yoffset=1.01)
draw_overlay("c_rhad_eta_packed",  ETA_MIN,  ETA_MAX,  h_lead_eta,  h_sublead_eta,  "packed R-hadron #eta",       "Events", "rhad_eta_packed.png",  yoffset=1.01)
draw_overlay("c_rhad_phi_packed",  PHI_MIN,  PHI_MAX,  h_lead_phi,  h_sublead_phi,  "packed R-hadron #phi",       "Events", "rhad_phi_packed.png",   yoffset=1.01)
draw_overlay("c_rhad_mass_packed", MASS_MIN, MASS_MAX, h_lead_mass, h_sublead_mass, "packed R-hadron mass [GeV]",  "Events", "rhad_mass_packed.png",  yoffset=1.01)
draw_single ("c_dphi",             0.0,      3.5,      h_lead_sublead_Delta_phi,   "|#Delta#phi(lead, sublead)|", "Events", "lead_sublead_dphi_packed.png",yoffset=1.01)

# GEN MET plots
draw_single("c_genmet_pt",    0.0,  700.0,  h_GenMET_pt,    "GEN MET p_{T} [GeV]",        "Events", "genmet_pt.png",   logy=True,  yoffset=1.01,  ymin_log=0.1)
draw_single("c_genmet_phi",  -3.5,    3.5,  h_GenMET_phi,   "GEN MET #phi",               "Events", "genmet_phi.png",  logy=True,  yoffset=1.01)
draw_single("c_genmet_px",  -600.0,  600.0, h_GenMET_px,    "GEN MET p_{x} [GeV]",        "Events", "genmet_px.png",   logy=True,  yoffset=1.01)
draw_single("c_genmet_py",  -600.0,  600.0, h_GenMET_py,    "GEN MET p_{y} [GeV]",        "Events", "genmet_py.png",   logy=True,  yoffset=1.01)
draw_single("c_genmet_sumEt", 0.0,  9000.0, h_GenMET_sumEt, "#SigmaE_{T} [GeV]",  "Events", "genmet_sumEt.png", logy=True,  yoffset=1.01)

