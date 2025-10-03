#!/usr/bin/env python3
import os
import sys
import argparse
import math
import ROOT
ROOT.gSystem.Load("libHist")
from collections import Counter, defaultdict
from DataFormats.FWLite import Events, Handle
from math import pi

# pdgids came from pythia8 logs
RHADRON_PDGIDS = [
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334
]
DEFAULT_TREE  = "Events"
DEFAULT_LABEL = "genParticles"
DEFAULT_TYPE  = "std::vector<reco::GenParticle>"

def initialize_fwlite():
    """Load FWLite support libraries."""
    for lib in ("libFWCoreFWLite", "libDataFormatsFWLite"):
        if ROOT.gSystem.Load(lib) < 0:
            raise RuntimeError(f"Failed to load {lib}")
    try:
        ROOT.FWLiteEnabler.enable()
    except AttributeError:
        pass

def list_tree_branches(file_path, tree_name=DEFAULT_TREE):
    """Print all branch names in the TTree."""
    f = ROOT.TFile.Open(file_path)
    tree = f.Get(tree_name)
    if not tree:
        print(f"Tree '{tree_name}' not found in {file_path}")
        return
    print(f"\n=== Branches in '{tree_name}' ===")
    for br in tree.GetListOfBranches():
        print(" ", br.GetName())
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
        print(f"\n=== Methods for '{label}' GenParticle ===")
        for m in sorted(dir(p)):
            if not m.startswith("_"):
                print(" ", m)
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
        for p in handle.product():
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
                data['long_lived'].append(int(hasattr(p,"longLived") and p.longLived()))
                moms = [ str(p.motherRef(i).get().pdgId())
                         for i in range(p.numberOfMothers())
                         if p.motherRef(i).isNonnull() ]
                dins = [ str(p.daughterRef(i).get().pdgId())
                         for i in range(p.numberOfDaughters())
                         if p.daughterRef(i).isNonnull() ]
                data['mothers'].append(",".join(moms))
                data['daughters'].append(",".join(dins))
    return data

def extract_top6_ak4_pt(file_path, isolation=False):
    """Return dict with '1th'..'6th' pt lists and 'nJets' per event."""
    f = ROOT.TFile.Open(file_path)
    tree = f.Get(DEFAULT_TREE)
    n = tree.GetEntries()
    counts = { "nJets": [] }
    counts.update({ f"{i}th": [] for i in range(1,7) })
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
            if isolation and any(deltaR(jet.eta(),jet.phi(),e,p)<0.4 for e,p in coords):
                continue
            pts.append(jet.pt())
        counts["nJets"].append(len(pts))
        pts.sort(reverse=True)
        for k in range(min(6,len(pts))):
            counts[f"{k+1}th"].append(pts[k])
    return counts

def extract_all_ak4_eta_phi(file_path, isolation=False):
    """Return lists of (eta,phi) for all AK4 jets, with optional isolation."""
    f = ROOT.TFile.Open(file_path)
    tree = f.Get(DEFAULT_TREE)
    n = tree.GetEntries()
    etas, phis = [], []
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
            if isolation and any(deltaR(jet.eta(),jet.phi(),e,p)<0.4 for e,p in coords):
                continue
            etas.append(jet.eta())
            phis.append(jet.phi())
    return etas, phis

def create_1d_histogram(vals, name, title, bins, val_range):
    h = ROOT.TH1D(name, title, bins, *val_range)
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
    m = min(len(data[k]) for k in keys)
    with open(path, 'w') as f:
        f.write("\t".join(keys) + "\n")
        for i in range(m):
            f.write("\t".join(str(data[k][i]) for k in keys) + "\n")
    print(f"Wrote {m} rows to {path}")

def parse_args():
    p = argparse.ArgumentParser(description="Combined RHadron & AK4 jet analysis")
    p.add_argument("input_file", help="ROOT file")
    p.add_argument("--label", default=DEFAULT_LABEL,
                   help=f"GenParticle branch (default {DEFAULT_LABEL})")
    p.add_argument("--isolation", action="store_true",
                   help="Exclude jets within ΔR<0.4 of RHadrons")
    p.add_argument("--nbins", type=int, default=50,
                   help="Bins for jet pT histos")
    p.add_argument("--alpha", type=float, default=0.3,
                   help="Overlay fill opacity")
    p.add_argument("-o", "--output-dir", default=None,
                   help="Base directory in which to create <base>/plots")
    return p.parse_args()

def main():
    args = parse_args()
    infile = args.input_file
    base = os.path.splitext(os.path.basename(infile))[0]

    # Determine output directory
    if args.output_dir:
        outdir = os.path.join(args.output_dir, base)
    else:
        rundir = os.path.dirname(infile)
        outdir = os.path.join(rundir, "plots", base)
    os.makedirs(outdir, exist_ok=True)

    initialize_fwlite()
    list_tree_branches(infile)
    show_particle_methods(infile, args.label)

    # RHadron extraction + plots/tables
    rh_data = extract_rhadron_info(infile, args.label)

    # PDG ID histogram
    cnt = Counter(rh_data['pdg_id'])
    h_pdg = ROOT.TH1D("pdg_ids", ";PDG ID;Count",
                      len(RHADRON_PDGIDS), 0.5, len(RHADRON_PDGIDS)+0.5)
    if not h_pdg:
        raise RuntimeError("Failed to create pdg_ids hist")
    for i, pid in enumerate(RHADRON_PDGIDS, start=1):
        h_pdg.SetBinContent(i, cnt.get(pid, 0))
        h_pdg.GetXaxis().SetBinLabel(i, str(pid))
    save_canvas(h_pdg, os.path.join(outdir, "pdg_ids.pdf"))

    # 1D kinematic histos
    for var in ['pt','eta','phi','mass','charge','energy']:
        vals = rh_data[var]
        if not vals:
            continue
        mn, mx = min(vals), max(vals)
        if var == 'phi':
            mn, mx = mn - 0.5, mx + 0.5
        h = create_1d_histogram(vals, f"h_{var}", f";{var};Counts",
                                50, (mn, mx))
        save_canvas(h, os.path.join(outdir, f"{var}.pdf"))

    # Δφ of two leading RHadrons
    evtmap = defaultdict(list)
    for e, pt, phi in zip(rh_data['event'], rh_data['pt'], rh_data['phi']):
        evtmap[e].append((pt, phi))
    dphis = []
    for lst in evtmap.values():
        if len(lst) < 2:
            continue
        (p1, f1), (p2, f2) = sorted(lst, key=lambda x: x[0], reverse=True)[:2]
        d = abs(f1 - f2)
        if d > pi:
            d = 2*pi - d
        dphis.append(d)
    if dphis:
        hd = create_1d_histogram(dphis, "dphi", ";#Delta#phi(rad);Counts",
                                 50, (0, 2*pi))
        hd.GetXaxis().SetRangeUser(0, 2*pi)
        save_canvas(hd, os.path.join(outdir, "dphi.pdf"))

    # long-lived vs mass 2D
    mnm, mxm = min(rh_data['mass']), max(rh_data['mass'])
    h2_llm = ROOT.TH2D("ll_vs_mass", ";Long-lived;Mass[GeV]",
                       2, 0, 2, 50, mnm*0.95, mxm*1.05)
    for ll, m in zip(rh_data['long_lived'], rh_data['mass']):
        h2_llm.Fill(ll, m)
    save_canvas(h2_llm, os.path.join(outdir, "long_lived_vs_mass.pdf"), "COLZ")

    # mass vs PDG ID 2D
    h2_mpdg = ROOT.TH2D("mass_vs_pdg", ";PDG ID;Mass[GeV]",
                        len(RHADRON_PDGIDS), 0.5, len(RHADRON_PDGIDS)+0.5,
                        50, mnm, mxm)
    for idx, pid in enumerate(RHADRON_PDGIDS, start=1):
        h2_mpdg.GetXaxis().SetBinLabel(idx, str(pid))
    for pid, m in zip(rh_data['pdg_id'], rh_data['mass']):
        if pid in RHADRON_PDGIDS:
            h2_mpdg.Fill(RHADRON_PDGIDS.index(pid)+1, m)
    save_canvas(h2_mpdg, os.path.join(outdir, "mass_vs_pdgid.pdf"), "COLZ")

    # RHadron eta-phi 2D
    h2_rhad = ROOT.TH2D("rhad_eta_phi", ";#eta;#phi",
                        50, -5.0, 5.0, 64, -pi, pi)
    for eta, phi in zip(rh_data['eta'], rh_data['phi']):
        h2_rhad.Fill(eta, phi)
    save_canvas(h2_rhad, os.path.join(outdir, "rhadron_eta_phi.pdf"), "COLZ")

    write_table(rh_data, os.path.join(outdir, "rhadron_data.tsv"))

    # AK4 jet overlay & multiplicity
    jet_data = extract_top6_ak4_pt(infile, isolation=args.isolation)
    all_pts = [pt for k, pts in jet_data.items() if k != "nJets" for pt in pts]
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
        histos = {}
        for i, L in enumerate(labels, start=1):
            h = ROOT.TH1D(f"h{i}", "", args.nbins, lo, hi)
            for pt in jet_data[f"{i}th"]:
                h.Fill(pt)
            if h.Integral() > 0:
                h.Scale(1.0 / (h.Integral() * h.GetBinWidth(1)))
            histos[L] = h
        c1 = ROOT.TCanvas("c1", "pT overlay", 800, 600)
        c1.SetLogy()
        cols = [ROOT.kBlack, ROOT.kRed, ROOT.kBlue,
                ROOT.kGreen+2, ROOT.kMagenta, ROOT.kOrange]
        leg = ROOT.TLegend(0.6, 0.65, 0.9, 0.9)
        for i, (L, h) in enumerate(histos.items()):
            h.SetLineColor(cols[i])
            h.SetLineWidth(2)
            h.SetFillStyle(1001)
            h.SetFillColorAlpha(cols[i], args.alpha)
            opt = "HIST" if i == 0 else "HIST SAME"
            h.Draw(opt)
            leg.AddEntry(h, L, "lf")
        leg.Draw()
        c1.Update()
        save_canvas(c1, os.path.join(outdir, f"{base}_overlay_1-6pt.png"))

        # multiplicity
        hnj = ROOT.TH1D("hnj", ";# jets;Events",
                        max(jet_data["nJets"])+1, -0.5, max(jet_data["nJets"])+0.5)
        for n in jet_data["nJets"]:
            hnj.Fill(n)
        c2 = ROOT.TCanvas("c2", "njets", 600, 400)
        hnj.SetLineColor(ROOT.kBlue)
        hnj.SetLineWidth(2)
        hnj.Draw("HIST")
        c2.Update()
        save_canvas(c2, os.path.join(outdir, f"{base}_njets.png"))
    else:
        print("No jets found; skipping AK4 jet plots.")

if __name__ == "__main__":
    main()
