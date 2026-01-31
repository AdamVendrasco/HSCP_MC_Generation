#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Process ROOT files with FWLite to extract RHadron GenParticle information,
produce histograms and tables (including 2-leading RHadron vector sums).
"""
from __future__ import print_function

import os
import sys
import argparse
import errno
from collections import Counter, defaultdict
from math import pi

import ROOT
ROOT.gSystem.Load("libHist")
ROOT.TH1.AddDirectory(False)   
ROOT.gROOT.SetBatch(True)      
ROOT.gStyle.SetOptStat(0)     

from DataFormats.FWLite import Events, Handle
def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as e:
        if e.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise

def create_2d_histogram(name, title, xbins, xmin, xmax, ybins, ymin, ymax, use_float=False):
   
    xmin = float(xmin); xmax = float(xmax)
    ymin = float(ymin); ymax = float(ymax)

    if xmin >= xmax:
        if xmin == xmax:
            xmin -= 1e-6; xmax += 1e-6
        else:
            xmin, xmax = min(xmin, xmax), max(xmin, xmax)
    if ymin >= ymax:
        if ymin == ymax:
            ymin -= 1e-6; ymax += 1e-6
        else:
            ymin, ymax = min(ymin, ymax), max(ymin, ymax)

    ROOT.gROOT.cd()

    h = None
    if not use_float:
        tmp = ROOT.TH2D(name, title, int(xbins), xmin, xmax, int(ybins), ymin, ymax)
        if tmp:
            tmp.SetDirectory(0)
            h = tmp
    if not h:
        tmp = ROOT.TH2F(name, title, int(xbins), xmin, xmax, int(ybins), ymin, ymax)
        if tmp:
            tmp.SetDirectory(0)
            h = tmp
    if not h:
        raise RuntimeError("Failed to create 2D histogram '{}'".format(name))
    return h

def create_1d_histogram(values, name, title, bins, value_range):
    """Create and fill a 1D ROOT histograms."""
    ROOT.gROOT.cd()
    hist = ROOT.TH1D(name, title, int(bins), float(value_range[0]), float(value_range[1]))
    if hist:
        hist.SetDirectory(0)
        hist.SetStats(0)
    for v in values:
        hist.Fill(v)
    return hist

def save_canvas(obj, output_path, draw_options=""):
    """Draw ROOT object on a canvas and save."""
    c = ROOT.TCanvas()
    if hasattr(obj, "SetStats"):
        obj.SetStats(0)
    obj.Draw(draw_options)
    c.Update()
    c.SaveAs(output_path)
    c.Close()

def write_data_table(data, output_path):
    """Write extracted data to a tab-separated table (columnar dict)."""
    keys = list(data.keys())
    lengths = [len(data[k]) for k in keys]
    min_len = min(lengths) if lengths else 0
    with open(output_path, 'w') as f:
        header = "\t".join(keys)
        f.write(header + "\n")
        for i in range(min_len):
            row = [str(data[k][i]) for k in keys]
            f.write("\t".join(row) + "\n")
    print("Wrote {} rows to {}".format(min_len, output_path))

def write_rows_tsv(rows, output_path, field_order=None):
    """Write a list of dict rows to TSV in a stable column order."""
    if not rows:
        print("No rows to write for {}".format(output_path))
        return
    if field_order is None:
        keys = sorted(rows[0].keys())
    else:
        keys = list(field_order)
    with open(output_path, 'w') as f:
        f.write("\t".join(keys) + "\n")
        for r in rows:
            f.write("\t".join(str(r.get(k, "")) for k in keys) + "\n")
    print("Wrote {} rows to {}".format(len(rows), output_path))

def dphi_wrap(phi1, phi2):
    """Return |Delta phi| wrapped into [0, pi]."""
    d = abs(phi1 - phi2)
    if d > pi:
        d = 2*pi - d
    return d


RHADRON_PDGIDS = [
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334, 1000612, 1000622, 1000632, 1000642, 
    1000652, 1006113, 1006211, 1006213, 1006223, 1006311, 1006313, 
    1006321, 1006323, 1006333,
]
DEFAULT_TREE = "Events"
DEFAULT_LABEL = "genParticles"
DEFAULT_TYPE = "std::vector<reco::GenParticle>"

def initialize_fwlite():
    """Load necessary FWLite libraries."""
    for lib in ("libFWCoreFWLite", "libDataFormatsFWLite"):
        if ROOT.gSystem.Load(lib) < 0:
            raise RuntimeError("Failed to load {}".format(lib))
    try:
        ROOT.FWLiteEnabler.enable()
    except AttributeError:
        pass

def list_tree_branches(file_path, tree_name=DEFAULT_TREE):
    """Print branch names available in the given TTree."""
    f = ROOT.TFile.Open(file_path)
    tree = f.Get(tree_name)
    if not tree:
        print("Tree '{}' not found in {}".format(tree_name, file_path))
        return
    print("\n=== Branches in '{}' ===".format(tree_name))
    for branch in tree.GetListOfBranches():
        print("  {}".format(branch.GetName()))
    f.Close()
    ROOT.gROOT.cd()
    
def extract_rhadron_info(file_path, branch_label):
    """Extract RHadron GenParticle information into a data dictionary."""
    events = Events(file_path)
    handle = Handle(DEFAULT_TYPE)
    data = {
        'event': [], 'pdg_id': [], 'mass': [], 'charge': [],
        'pt': [], 'eta': [], 'phi': [], 'energy': [],
        'long_lived': [], 'mothers': [], 'daughters': []
    }

    for event in events:
        evt_number = event.eventAuxiliary().id().event()
        event.getByLabel(branch_label, handle)
        prod = handle.product()
        if not prod:
            continue
        for p in prod:
            pid = abs(p.pdgId())
            if 1000600 <= pid <= 1100000 and p.status() == 1:
                data['event'].append(evt_number)
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


def parse_arguments():
    parser = argparse.ArgumentParser(description="Extract RHadron data and produce plots/tables")
    parser.add_argument('input_file', help='Path to input ROOT file')
    parser.add_argument('--label', default=DEFAULT_LABEL,
                        help='GenParticle branch label (default: {})'.format(DEFAULT_LABEL))
    parser.add_argument('--output-dir', default='./plots',
                        help='Base directory to save plots and tables')
    return parser.parse_args()

def main():
    args = parse_arguments()
    infile = args.input_file
    label = args.label
    base_out_dir = args.output_dir
    sample_name = os.path.splitext(os.path.basename(infile))[0]
    out_dir = os.path.join(base_out_dir, sample_name)
    mkdir_p(out_dir)

    initialize_fwlite()
    list_tree_branches(infile)

    data = extract_rhadron_info(infile, label)
    ROOT.gROOT.cd()

    # ------------------------------------------------------------------
    # PDG ID histogram (fixed list)
    # ------------------------------------------------------------------
    counter = Counter(data['pdg_id'])
    h_pdg = ROOT.TH1D("pdg_ids", ";PDG ID;Count",
                      len(RHADRON_PDGIDS), 0.5, len(RHADRON_PDGIDS) + 0.5)
    h_pdg.SetDirectory(0)
    for idx, pid in enumerate(RHADRON_PDGIDS, start=1):
        if 1 <= idx <= h_pdg.GetNbinsX():
            h_pdg.SetBinContent(idx, counter.get(pid, 0))
            try:
                h_pdg.GetXaxis().SetBinLabel(idx, str(pid))
            except Exception:
                pass
    save_canvas(h_pdg, os.path.join(out_dir, "pdg_ids.pdf"))

    # Dynamic PDG ID histogram (whatever actually appears)
    if counter:
        seen_pids = sorted(counter.keys())
        MAX_BINS = 40
        if len(seen_pids) > MAX_BINS:
            seen_pids = [pid for pid, _ in counter.most_common(MAX_BINS)]
            seen_pids.sort()
        h_pdg_dyn = ROOT.TH1D("pdg_ids_dynamic", ";PDG ID;Count",
                              len(seen_pids), 0.5, len(seen_pids) + 0.5)
        h_pdg_dyn.SetDirectory(0)
        for idx, pid in enumerate(seen_pids, start=1):
            h_pdg_dyn.SetBinContent(idx, counter.get(pid, 0))
            try:
                h_pdg_dyn.GetXaxis().SetBinLabel(idx, str(pid))
            except Exception:
                pass
        save_canvas(h_pdg_dyn, os.path.join(out_dir, "pdg_ids_dynamic.pdf"))

    # ------------------------------------------------------------------
    # Kinematic histograms
    # ------------------------------------------------------------------
    for var in ['pt', 'eta', 'phi', 'mass', 'charge', 'energy']:
        vals = data[var]
        if not vals:
            continue
        mn, mx = (min(vals), max(vals))
        if var == 'phi':
            mn, mx = mn - 0.5, mx + 0.5
        hist = create_1d_histogram(vals, "h_{}".format(var),
                                   ";{};Counts".format(var), 50, (mn, mx))
        save_canvas(hist, os.path.join(out_dir, "{}.pdf".format(var)))

    # ------------------------------------------------------------------
    # dphi of two leading RHadrons (histogram only)
    # ------------------------------------------------------------------
    event_map = defaultdict(list)
    for evt, pt_val, phi_val in zip(data['event'], data['pt'], data['phi']):
        event_map[evt].append((pt_val, phi_val))

    dphi_vals = []
    for lst in event_map.values():
        if len(lst) < 2:
            continue
        (pt1, phi1), (pt2, phi2) = sorted(lst, key=lambda x: x[0], reverse=True)[:2]
        dphi_vals.append(dphi_wrap(phi1, phi2))

    if dphi_vals:
        h_dphi = create_1d_histogram(dphi_vals, "dphi", ";#Delta#phi(rad);Counts", 30, (0, 2*pi))
        h_dphi.GetXaxis().SetRangeUser(0, 2*pi)
        save_canvas(h_dphi, os.path.join(out_dir, "dphi.pdf"))

    # ------------------------------------------------------------------
    # Two-leading RHadrons: 4-vector sum per event → TSV
    # ------------------------------------------------------------------
    from ROOT import TLorentzVector
    event_objs = defaultdict(list)
    for evt, pt_val, eta_val, phi_val, m_val, pid_val in zip(
            data['event'], data['pt'], data['eta'], data['phi'], data['mass'], data['pdg_id']):
        event_objs[evt].append((pt_val, eta_val, phi_val, m_val, pid_val))

    vecsum_rows = []
    for evt, objs in event_objs.items():
        if len(objs) < 2:
            continue
        # pick two leading by pT
        (pt1, eta1, phi1, m1, pid1), (pt2, eta2, phi2, m2, pid2) = sorted(
            objs, key=lambda x: x[0], reverse=True)[:2]

        v1 = TLorentzVector(); v1.SetPtEtaPhiM(pt1, eta1, phi1, m1)
        v2 = TLorentzVector(); v2.SetPtEtaPhiM(pt2, eta2, phi2, m2)
        vsum = v1 + v2

        vecsum_rows.append({
            "event": evt,
            # leading
            "lead_pdgid": int(pid1), "lead_pt": pt1, "lead_eta": eta1, "lead_phi": phi1, "lead_m": m1,
            # subleading
            "sub_pdgid": int(pid2), "sub_pt": pt2, "sub_eta": eta2, "sub_phi": phi2, "sub_m": m2,
            # pair geometry
            "dphi12": dphi_wrap(phi1, phi2),
            # vector sum (4-vector)
            "sum_pt": vsum.Pt(),
            "sum_eta": (vsum.Eta() if vsum.Pt() > 0 else 0.0),
            "sum_phi": vsum.Phi(),
            "sum_m": vsum.M(),
            "sum_p": vsum.P(),
            "sum_E": vsum.E(),
            "sum_px": vsum.Px(),
            "sum_py": vsum.Py(),
            "sum_pz": vsum.Pz(),
            "met_like": vsum.Pt(),
        })

    if vecsum_rows:
        vecsum_cols = [
            "event",
            "lead_pdgid", "lead_pt", "lead_eta", "lead_phi", "lead_m",
            "sub_pdgid", "sub_pt", "sub_eta", "sub_phi", "sub_m",
            "dphi12",
            "sum_pt", "sum_eta", "sum_phi", "sum_m", "sum_p", "sum_E",
            "sum_px", "sum_py", "sum_pz",
            "met_like",
        ]
        write_rows_tsv(vecsum_rows, os.path.join(out_dir, "two_rhadron_vector_sums.tsv"), vecsum_cols)

    # ------------------------------------------------------------------
    # Long-lived vs mass, mass vs PDGID
    # ------------------------------------------------------------------
    if data['mass']:
        ymin = min(data['mass']) * 0.95
        ymax = max(data['mass']) * 1.05

        ll_mass_hist = create_2d_histogram("ll_vs_mass", ";Long-lived;Mass[GeV]",
                                           2, 0.0, 2.0, 50, ymin, ymax)
        for ll, m in zip(data['long_lived'], data['mass']):
            ll_mass_hist.Fill(ll, m)
        save_canvas(ll_mass_hist, os.path.join(out_dir, "long_lived_vs_mass.pdf"), "COLZ")

        mp_hist = create_2d_histogram(
            "mass_vs_pdg",
            ";;Mass[GeV]",  # blank x-title, keep y
            len(RHADRON_PDGIDS), 0.5, len(RHADRON_PDGIDS) + 0.5,
            50, min(data['mass']), max(data['mass'])
        )
        for idx, pid in enumerate(RHADRON_PDGIDS, start=1):
            try:
                mp_hist.GetXaxis().SetBinLabel(idx, str(pid))
            except Exception:
                pass
        mp_hist.LabelsOption("v", "X")
        mp_hist.GetXaxis().SetLabelSize(0.03)
        mp_hist.GetXaxis().SetTitle("")
        mp_hist.GetYaxis().SetTitle("Mass[GeV]")

        for pid, m in zip(data['pdg_id'], data['mass']):
            if pid in RHADRON_PDGIDS:
                mp_hist.Fill(RHADRON_PDGIDS.index(pid) + 1, m)

        save_canvas(mp_hist, os.path.join(out_dir, "mass_vs_pdgid.pdf"), "COLZ")

    # Write TSV of all particles
    write_data_table(data, os.path.join(out_dir, "rhadron_data.tsv"))

if __name__ == "__main__":
    main()
