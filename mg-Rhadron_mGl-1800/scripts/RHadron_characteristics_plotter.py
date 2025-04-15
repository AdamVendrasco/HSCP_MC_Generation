#!/usr/bin/env python
import ROOT
import os
import numpy as np

# For some reason my cmssw instance is messed up and I needed to load these libaries
ROOT.gInterpreter.Declare('#include "DataFormats/Common/interface/Wrapper.h"')
ROOT.gInterpreter.Declare('#include "DataFormats/HepMCCandidate/interface/GenParticle.h"')

def load_library(libname, full_path=None):
    if full_path:
        ret = ROOT.gSystem.Load(full_path)
    else:
        ret = ROOT.gSystem.Load(libname)
    if ret < 0:
        raise RuntimeError("Failed to load {}".format(libname))
    else:
        print("Successfully loaded {}".format(libname))

try:
    load_library("libFWCoreFWLite")
    load_library("libDataFormatsFWLite")
except RuntimeError as e:
    print("Library loading error:", e)
    print("Make sure you have initialized the CMSSW environment (e.g., run 'cmsenv' or 'source /cvmfs/cms.cern.ch/cmsset_default.sh').")
    raise


try:
    ROOT.FWLiteEnabler.enable()
except AttributeError:
    pass
# --------------------------------------------------------------------------------------------------------------------------------------
# Actual script below:

filename = "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/root-files/mg-Rhadron_mGl-1800-CMSSW_13_2_9-n1000-Jet_matching_ON-100.root"
work_dir = "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/plots/"

file = ROOT.TFile.Open(filename)
if not file or file.IsZombie():
    raise Exception("Could not open file: " + filename)

tree = file.Get("Events")
if not tree:
    raise Exception("Could not retrieve TTree 'Events'.")

reader = ROOT.TTreeReader("Events", file)
branch_name = "recoGenParticles_genParticles__GEN."
if not reader.GetTree().FindBranch(branch_name):
    raise Exception("Branch '{}' not found in TTree 'Events'.".format(branch_name))

try:
    GenParticleWrapper = getattr(ROOT, "edm::Wrapper<reco::GenParticleCollection>")
except Exception as e:
    raise RuntimeError("Failed to get type 'edm::Wrapper<reco::GenParticleCollection>' from ROOT dictionaries: " + str(e))

genParticlesReader = ROOT.TTreeReaderValue[GenParticleWrapper](reader, branch_name)

rhadron_gen_pt     = []
rhadron_gen_eta    = []
rhadron_gen_phi    = []
rhadron_gen_mass   = []
rhadron_gen_charge = []
rhadron_gen_pdgid  = []

rhadron_count = 0
gen_particle_count = 0

x_min = -1096000
x_max = 1093600

pdgid_hist             = ROOT.TH1D("pdgid_hist", "RHadrons: PDGID Distribution;PDGID;Counts", 100, x_min, x_max)
mass_hist_vs_pdgid_2d  = ROOT.TH2D("mass_hist_vs_pdgid_2d", "RHadrons: 2D Distribution of Mass vs PDGID;PDGID;Mass (GeV)", 40, x_min, x_max, 40, 1800, 1802)
mass_hist_vs_pdgid_3d  = ROOT.TH2D("mass_hist_vs_pdgid_3d", "RHadrons: 3D Histogram of Mass vs PDGID;PDGID;Mass (GeV)", 50, x_min, x_max, 40, 1798, 1802)
charge_hist            = ROOT.TH1D("charge_hist", "RHadrons: Charge;Charge;Counts", 50, -2, 2)

# -------------------------------------------------------------------
# Loop over events using TTreeReader
# -------------------------------------------------------------------
while reader.Next():

    gen_particles_wrapper = genParticlesReader.Get()
    if not gen_particles_wrapper:
        continue
 
    gen_particles = gen_particles_wrapper.product()
    if reader.GetCurrentEntry() % 100 == 0:
        print("Event {} has {} gen particles".format(reader.GetCurrentEntry(), gen_particles.size()))

    for j in range(gen_particles.size()):
        gen_particle_count += 1
        pdgid = gen_particles.at(j).pdgId()
     
        if 1000600 <= abs(pdgid) <= 1100000 and gen_particles.at(j).status() == 1:
            rhadron_count += 1
            pt     = gen_particles.at(j).pt()
            eta    = gen_particles.at(j).eta()
            phi    = gen_particles.at(j).phi()
            mass   = gen_particles.at(j).mass()
            charge = gen_particles.at(j).charge()
            
            rhadron_gen_pt.append(pt)
            rhadron_gen_eta.append(eta)
            rhadron_gen_phi.append(phi)
            rhadron_gen_mass.append(mass)
            rhadron_gen_charge.append(charge)
            rhadron_gen_pdgid.append(pdgid)
            
            pdgid_hist.Fill(pdgid)
            mass_hist_vs_pdgid_2d.Fill(pdgid, mass)
            mass_hist_vs_pdgid_3d.Fill(pdgid, mass)
            charge_hist.Fill(charge)

print("-------------------------------------------")
print("Total gen_particle_count: {}".format(gen_particle_count))
print("Total Rhadron_count: {}".format(rhadron_count))
print("-------------------------------------------")

rhadron_gen_pdgid_np = np.array(rhadron_gen_pdgid)
unique_pdgids, counts = np.unique(rhadron_gen_pdgid_np, return_counts=True)
if len(unique_pdgids) > 0:
    most_common_index = np.argmax(counts)
    most_common_pdgid = unique_pdgids[most_common_index]
    most_common_count = counts[most_common_index]
    print("The most common pdgid is: {} with a count of {}".format(most_common_pdgid, most_common_count))
else:
    print("No RHadron PDG IDs found.")

if len(rhadron_gen_pt) > 0:
    pt_min = np.min(rhadron_gen_pt)
    pt_max = np.max(rhadron_gen_pt)
    pt_hist = ROOT.TH1D("pt_hist", "RHadrons: pT; pT (GeV); Counts", 40, pt_min, pt_max)
    for val in rhadron_gen_pt:
        pt_hist.Fill(val)
else:
    pt_hist = None

if len(rhadron_gen_eta) > 0:
    eta_min = np.min(rhadron_gen_eta)
    eta_max = np.max(rhadron_gen_eta)
    eta_hist = ROOT.TH1D("eta_hist", "RHadrons: Eta; Eta; Counts", 35, eta_min, eta_max)
    for val in rhadron_gen_eta:
        eta_hist.Fill(val)
else:
    eta_hist = None

if len(rhadron_gen_phi) > 0:
    phi_min = np.min(rhadron_gen_phi)
    phi_max = np.max(rhadron_gen_phi)
    phi_hist = ROOT.TH1D("phi_hist", "RHadrons: Phi; Phi; Counts", 35, phi_min, phi_max)
    for val in rhadron_gen_phi:
        phi_hist.Fill(val)
else:
    phi_hist = None

if len(rhadron_gen_mass) > 0:
    mass_min = np.min(rhadron_gen_mass)
    mass_max = np.max(rhadron_gen_mass)
    mass_hist = ROOT.TH1D("mass_hist", "RHadrons: Mass Distribution; Mass (GeV); Counts", 30, mass_min, mass_max)
    for val in rhadron_gen_mass:
        mass_hist.Fill(val)
else:
    mass_hist = None

if len(rhadron_gen_charge) > 0 and len(rhadron_gen_pdgid) > 0:
    charge_vs_pdgid_hist = ROOT.TH2D("charge_vs_pdgid_hist", "RHadrons: 2D Distribution of Charge vs PDGID;PDGID;Charge", 40, x_min, x_max, 40, -2, 2)
    for i in range(len(rhadron_gen_charge)):
        charge_vs_pdgid_hist.Fill(rhadron_gen_pdgid[i], rhadron_gen_charge[i])
else:
    charge_vs_pdgid_hist = None

if not os.path.exists(work_dir):
    os.makedirs(work_dir)

c = ROOT.TCanvas("c", "Canvas", 800, 600)

pdgid_hist.Draw()
c.SaveAs(os.path.join(work_dir, "Rhadron_pdgid_histogram.pdf"))

c.Clear()
mass_hist_vs_pdgid_2d.Draw("COLZ")
c.SaveAs(os.path.join(work_dir, "Rhadron_mass_vs_pdgid_2d.pdf"))

c.Clear()
mass_hist_vs_pdgid_3d.Draw("LEGO2")
c.SaveAs(os.path.join(work_dir, "Rhadron_mass_vs_pdgid_3d.pdf"))

c.Clear()
charge_hist.Draw()
c.SaveAs(os.path.join(work_dir, "Rhadron_charge_histogram.pdf"))

if pt_hist:
    c.Clear()
    pt_hist.Draw()
    c.SaveAs(os.path.join(work_dir, "Rhadron_pT_histogram.pdf"))

if eta_hist:
    c.Clear()
    eta_hist.Draw()
    c.SaveAs(os.path.join(work_dir, "Rhadron_eta_histogram.pdf"))

if phi_hist:
    c.Clear()
    phi_hist.Draw()
    c.SaveAs(os.path.join(work_dir, "Rhadron_phi_histogram.pdf"))

if mass_hist:
    c.Clear()
    mass_hist.Draw()
    c.SaveAs(os.path.join(work_dir, "Rhadron_mass_histogram.pdf"))

if charge_vs_pdgid_hist:
    c.Clear()
    charge_vs_pdgid_hist.Draw("COLZ")
    c.SaveAs(os.path.join(work_dir, "Rhadron_pdgid_vs_charge.pdf"))

c.Close()
