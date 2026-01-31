#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function

import os
import sys
import argparse
import math
import errno
import ROOT
ROOT.gSystem.Load("libHist")
ROOT.TH1.AddDirectory(False)  
from collections import Counter, defaultdict
from DataFormats.FWLite import Events, Handle
from math import pi

# pdgids came from Pythia8 logs
RHADRON_PDGIDS = [
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334,1000612, 1000622, 1000632, 1000642, 1000652,
    1006113, 1006211, 1006213, 1006223, 1006311, 1006313,1006321, 1006323, 1006333,
]
DEFAULT_TREE  = "Events"
DEFAULT_LABEL = "genParticles"
DEFAULT_TYPE  = "std::vector<reco::GenParticle>"

def mkdir_p(path):
    """Py2-safe mkdir -p."""
    try:
        os.makedirs(path)
    except OSError as e:
        if e.errno != errno.EEXIST or not os.path.isdir(path):
            raise

def initialize_fwlite():
    """Load FWLite support libraries (Py2-friendly)."""
    for lib in ("libFWCoreFWLite", "libDataFormatsFWLite"):
        if ROOT.gSystem.Load(lib) < 0:
            raise RuntimeError("Failed to load {}".format(lib))
    try:
        ROOT.FWLiteEnabler.enable()
    except AttributeError:
        pass

def list_tree_branches(file_path, tree_name=DEFAULT_TREE):
    """Print all branch names in the TTree."""
    f = ROOT.TFile.Open(file_path)
    if not f or f.IsZombie():
        print("Could not open file {}".format(file_path))
        return
    tree = f.Get(tree_name)
    if not tree:
        print("Tree '{}' not found in {}".format(tree_name, file_path))
        f.Close()
        return
    print("\n=== Branches in '{}' ===".format(tree_name))
    for br in tree.GetListOfBranches():
        print("  {}".format(br.GetName()))
    f.Close()

def show_particle_methods(file_path, label, type_str=DEFAULT_TYPE):
    """Inspect and print methods on the first GenParticle."""
    events = Events(file_path)
    handle = Handle(type_str)
    for evt in events:
        evt.getByLabel(label, handle)
        prod = handle.product()
        if not prod:
            continue
        p = prod[0]
        print("\n=== Methods for '{}' GenParticle ===".format(label))
        for m in sorted(dir(p)):
            if not m.startswith("_"):
                print("  {}".format(m))
        break

def deltaR(eta1, phi1, eta2, phi2):
    """Compute delta R."""
    dphi = abs(phi1 - phi2)
    if dphi > math.pi:
        dphi = 2*math.pi - dphi
    return math.sqrt((eta1 - eta2)**2 + dphi**2)

def extract_rhadron_info(file_path, label):
    """Return a dict of RHadron variables per particle."""
    events = Events(file_path)
    handle = Handle(DEFAULT_TYPE)
    data = {k: [] for k in [
        'event','pdg_id','mass','charge','pt','eta','phi','energy',
        'long_lived','mothers','daughters'
    ]}
    for evt in events:
        evt_num = evt.eventAuxiliary().id().event()
        evt.getByLabel(label, handle)
        prod = handle.product()
        if not prod:
            continue
        for p in prod:
            pid = abs(p.pdgId())
            if 1000600 <= pid <= 1100000 and p.status() == 1:
                data['event'].append(evt_num)
                data['pdg_id'].append(pid)
                data['mass'].append(p.mass())
                data['charge'].append(p.charge())
                data['pt'].append(p.pt())
                data['energy'].append(p.energy())
                data['eta'].append(p.eta())
                data['phi'].append(p.phi())
                ll = 0
                try:
                    ll = int(p.longLived())
                except Exception:
                    ll = 0
                data['long_lived'].append(ll)

                moms = []
                for i in range(p.numberOfMothers()):
                    try:
                        if p.motherRef(i).isNonnull():
                            moms.append(str(p.motherRef(i).get().pdgId()))
                    except Exception:
                        pass
                dins = []
                for i in range(p.numberOfDaughters()):
                    try:
                        if p.daughterRef(i).isNonnull():
                            dins.append(str(p.daughterRef(i).get().pdgId()))
                    except Exception:
                        pass
                data['mothers'].append(",".join(moms))
                data['daughters'].append(",".join(dins))
    return data

def extract_top6_ak4_pt(file_path, isolation=False):
    """Return dict with '1th'..'6th' pt lists and 'nJets' per event."""
    f = ROOT.TFile.Open(file_path)
    if not f or f.IsZombie():
        return {"nJets": []}
    tree = f.Get(DEFAULT_TREE)
    if not tree:
        f.Close()
        return {"nJets": []}

    n = tree.GetEntries()
    counts = {"nJets": []}
    for i in range(1, 7):
        counts["{}th".format(i)] = []

    for i in range(n):
        tree.GetEntry(i)
        jw = getattr(tree, "recoGenJets_ak4GenJets__GEN", None)
        if not jw:
            counts["nJets"].append(0)
            continue
        jets = jw.product()
        coords = []
        if isolation:
            gp = getattr(tree, "recoGenParticles_genParticles__GEN", None)
            if gp:
                for j in range(gp.product().size()):
                    g = gp.product().at(j)
                    if 1000600 <= abs(g.pdgId()) <= 1100000 and g.status()==1:
                        coords.append((g.eta(), g.phi()))
        pts = []
        for j in range(jets.size()):
            jet = jets.at(j)
            if isolation:
                blocked = False
                for (e, p) in coords:
                    if deltaR(jet.eta(), jet.phi(), e, p) < 0.4:
                        blocked = True
                        break
                if blocked:
                    continue
            pts.append(jet.pt())
        counts["nJets"].append(len(pts))
        pts.sort(reverse=True)
        m = min(6, len(pts))
        for k in range(m):
            counts["{}th".format(k+1)].append(pts[k])

    f.Close()
    return counts

def extract_all_ak4_eta_phi(file_path, isolation=False):
    """Return lists of (eta,phi) for all AK4 jets, with optional isolation."""
    etas, phis = [], []
    f = ROOT.TFile.Open(file_path)
    if not f or f.IsZombie():
        return etas, phis
    tree = f.Get(DEFAULT_TREE)
    if not tree:
        f.Close()
        return etas, phis

    n = tree.GetEntries()
    for i in range(n):
        tree.GetEntry(i)
        jw = getattr(tree, "recoGenJets_ak4GenJets__GEN", None)
        if not jw:
            continue
        jets = jw.product()
        coords = []
        if isolation:
            gp = getattr(tree, "recoGenParticles_genParticles__GEN", None)
            if gp:
                for j in range(gp.product().size()):
                    g = gp.product().at(j)
                    if 1000600 <= abs(g.pdgId()) <= 1100000 and g.status()==1:
                        coords.append((g.eta(), g.phi()))
        for j in range(jets.size()):
            jet = jets.at(j)
            if isolation:
                skip = False
                for (e, p) in coords:
                    if deltaR(jet.eta(), jet.phi(), e, p) < 0.4:
                        skip = True
                        break
                if skip:
                    continue
            etas.append(jet.eta())
            phis.append(jet.phi())

    f.Close()
    return etas, phis

def create_1d_histogram(vals, name, title, bins, val_range):
    h = ROOT.TH1D(name, title, bins, val_range[0], val_range[1])
    for x in vals:
        h.Fill(x)
    return h

def save_canvas(obj, path, opt=""):
    """
    Save either a histogram/graph or a TCanvas to file.
    If obj is a TCanvas, call its SaveAs; otherwise draw on temp canvas.
    """
    if isinstance(obj, ROOT.TCanvas):
        obj.SaveAs(path)
    else:
        c = ROOT.TCanvas()
        obj.Draw(opt)
        c.SaveAs(path)
        c.Close()

def write_table(data, path):
    keys = list(data.keys())
    m = min(len(data[k]) for k in keys) if keys else 0
    with open(path, 'w') as f:
        f.write("\t".join(keys) + "\n")
        for i in range(m):
            f.write("\t".join(str(data[k][i]) for k in keys) + "\n")
    print("Wrote {} rows to {}".format(m, path))

def parse_args():
    p = argparse.ArgumentParser(description="Combined RHadron & AK4 jet analysis (Python 2 compatible)")
    p.add_argument("input_file", help="ROOT file")
    p.add_argument("--label", default=DEFAULT_LABEL,
                   help="GenParticle branch (default {})".format(DEFAULT_LABEL))
    p.add_argument("--isolation", action="store_true",
                   help="Exclude jets within dR<0.4 of RHadrons")
    p.add_argument("--nbins", type=int, default=50,
                   help="Bins for jet pT histos")
    p.add_argument("--alpha", type=float, default=0.3,
                   help="Overlay fill opacity")
    p.add_argument("-o", "--output-dir", default=None,
                   help="Base dir in which to create <base>/plots")
    return p.parse_args()

def main():
    args = parse_args()
    infile = args.input_file
    base = os.path.splitext(os.path.basename(infile))[0]

    if args.output_dir:
        outdir = os.path.join(args.output_dir, base)
    else:
        rundir = os.path.dirname(infile)
        outdir = os.path.join(rundir, "plots", base)
    mkdir_p(outdir)

    initialize_fwlite()
    list_tree_branches(infile)
    show_particle_methods(infile, args.label)
    ROOT.gROOT.cd()
    
    rh_data = extract_rhadron_info(infile, args.label)

    # PDG ID histogram
    cnt = Counter(rh_data.get('pdg_id', []))
    h_pdg = ROOT.TH1D("pdg_ids", ";PDG ID;Count",
                      len(RHADRON_PDGIDS), 0.5, len(RHADRON_PDGIDS)+0.5)
    if not h_pdg:
        raise RuntimeError("Failed to create pdg_ids hist")
    for i, pid in enumerate(RHADRON_PDGIDS, start=1):
        h_pdg.SetBinContent(i, cnt.get(pid, 0))
        try:
            h_pdg.GetXaxis().SetBinLabel(i, "%d" % pid)
        except Exception:
            pass
    h_pdg.GetXaxis().LabelsOption("v")
    save_canvas(h_pdg, os.path.join(outdir, "pdg_ids.pdf"))

    # 1D kinematic histos
    for var in ['pt','eta','phi','mass','charge','energy']:
        vals = rh_data.get(var, [])
        if not vals:
            continue
        mn, mx = min(vals), max(vals)
        if var == 'phi':
            mn, mx = mn - 0.5, mx + 0.5
        h = create_1d_histogram(vals, "h_{}".format(var), ";{};Counts".format(var),
                                50, (mn, mx))
        save_canvas(h, os.path.join(outdir, "{}.pdf".format(var)))

    # dphi of two leading RHadrons
    evtmap = defaultdict(list)
    for e, pt, phi in zip(rh_data.get('event', []), rh_data.get('pt', []), rh_data.get('phi', [])):
        evtmap[e].append((pt, phi))
    dphis = []
    for lst in evtmap.values():
        if len(lst) < 2:
            continue
        lst_sorted = sorted(lst, key=lambda x: x[0], reverse=True)[:2]
        (p1, f1), (p2, f2) = lst_sorted[0], lst_sorted[1]
        d = abs(f1 - f2)
        if d > pi:
            d = 2*pi - d
        dphis.append(d)
    if dphis:
        hd = create_1d_histogram(dphis, "dphi", ";#Delta#phi(rad);Counts",
                                 50, (0, 2*pi))
        hd.GetXaxis().SetRangeUser(0, 2*pi)
        save_canvas(hd, os.path.join(outdir, "dphi.pdf"))

    # long-lived vs mass 2D and others
    if rh_data.get('mass', []):
        mnm, mxm = min(rh_data['mass']), max(rh_data['mass'])

        # long-lived vs mass
        h2_llm = ROOT.TH2D("ll_vs_mass", ";Long-lived;Mass[GeV]",
                           2, 0, 2, 50, mnm*0.95, mxm*1.05)
        for ll, m in zip(rh_data.get('long_lived', []), rh_data.get('mass', [])):
            h2_llm.Fill(ll, m)
        save_canvas(h2_llm, os.path.join(outdir, "long_lived_vs_mass.pdf"), "COLZ")

        # mass vs PDG ID 2D
        h2_mpdg = ROOT.TH2D("mass_vs_pdg", ";PDG ID;Mass[GeV]",
                            len(RHADRON_PDGIDS), 0.5, len(RHADRON_PDGIDS)+0.5,
                            50, mnm, mxm)
        for idx, pid in enumerate(RHADRON_PDGIDS, start=1):
            try:
                h2_mpdg.GetXaxis().SetBinLabel(idx, "%d" % pid)
            except Exception:
                pass
        h2_mpdg.GetXaxis().LabelsOption("v")
        for pid, m in zip(rh_data.get('pdg_id', []), rh_data.get('mass', [])):
            if pid in RHADRON_PDGIDS:
                h2_mpdg.Fill(RHADRON_PDGIDS.index(pid)+1, m)
        save_canvas(h2_mpdg, os.path.join(outdir, "mass_vs_pdgid.pdf"), "COLZ")

        # RHadron eta-phi 2D
        h2_rhad = ROOT.TH2D("rhad_eta_phi", ";#eta;#phi",
                            50, -5.0, 5.0, 64, -pi, pi)
        for eta, phi in zip(rh_data.get('eta', []), rh_data.get('phi', [])):
            h2_rhad.Fill(eta, phi)
        save_canvas(h2_rhad, os.path.join(outdir, "rhadron_eta_phi.pdf"), "COLZ")

    write_table(rh_data, os.path.join(outdir, "rhadron_data.tsv"))

    # AK4 jet overlay & multiplicity
    jet_data = extract_top6_ak4_pt(infile, isolation=args.isolation)
    all_pts = []
    for key in ["1th","2th","3th","4th","5th","6th"]:
        all_pts.extend(jet_data.get(key, []))

    if all_pts:
        # AK4 jet eta-phi 2D
        jet_etas, jet_phis = extract_all_ak4_eta_phi(infile, isolation=args.isolation)
        if jet_etas:
            h2_jet = ROOT.TH2D("jet_eta_phi", ";#eta;#phi",
                               50, -5.0, 5.0, 64, -pi, pi)
            for e, p in zip(jet_etas, jet_phis):
                h2_jet.Fill(e, p)
            save_canvas(h2_jet, os.path.join(outdir, "jet_eta_phi.pdf"), "COLZ")

        # pT overlay
        lo, hi = min(all_pts), max(all_pts)
        labels = ["Leading","2nd","3rd","4th","5th","6th"]
        keys_in_order = ["1th","2th","3th","4th","5th","6th"]
        histos = []
        for i, key in enumerate(keys_in_order):
            h = ROOT.TH1D("h{}".format(i+1), "", args.nbins, lo, hi)
            for pt in jet_data.get(key, []):
                h.Fill(pt)
            #if h.Integral() > 0:
            #     h.Scale(1.0 / h.Integral()) 
            histos.append((labels[i], h))

        c1 = ROOT.TCanvas("c1", "pT overlay", 800, 600)
        c1.SetLogy()
        cols = [ROOT.kBlack, ROOT.kRed, ROOT.kBlue,
                ROOT.kGreen+2, ROOT.kMagenta, ROOT.kOrange]
        leg = ROOT.TLegend(0.6, 0.65, 0.9, 0.9)
        first = True
        for i, (L, h) in enumerate(histos):
            h.SetLineColor(cols[i])
            h.SetLineWidth(2)
            h.SetFillStyle(1001)
            h.SetFillColorAlpha(cols[i], args.alpha)
            opt = "HIST" if first else "HIST SAME"
            h.Draw(opt)
            leg.AddEntry(h, L, "lf")
            first = False
        leg.Draw()
        c1.Update()
        save_canvas(c1, os.path.join(outdir, "{}_overlay_1-6pt.png".format(base)))

        # multiplicity
        njs = jet_data.get("nJets", [])
        if njs:
            maxnj = max(njs)
            hnj = ROOT.TH1D("hnj", ";# jets;Events", maxnj+1, -0.5, maxnj+0.5)
            for n in njs:
                hnj.Fill(n)
            c2 = ROOT.TCanvas("c2", "njets", 600, 400)
            hnj.SetLineColor(ROOT.kBlue)
            hnj.SetLineWidth(2)
            hnj.Draw("HIST")
            c2.Update()
            save_canvas(c2, os.path.join(outdir, "{}_njets.png".format(base)))
    else:
        print("No jets found; skipping AK4 jet plots.")

if __name__ == "__main__":
    main()
