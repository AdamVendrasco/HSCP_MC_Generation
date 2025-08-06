#!/usr/bin/env python3
"""
Process ROOT files with FWLite to extract RHadron GenParticle information,
produce histograms and tables.
"""
import os
import sys
import argparse
import ROOT
from collections import Counter, defaultdict
from DataFormats.FWLite import Events, Handle
from math import pi

# Constants
RHADRON_PDGIDS = [
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334
]
DEFAULT_TREE = "Events"
DEFAULT_LABEL = "genParticles"
DEFAULT_TYPE = "std::vector<reco::GenParticle>"


def initialize_fwlite():
    """Load necessary FWLite libraries."""
    for lib in ("libFWCoreFWLite", "libDataFormatsFWLite"):
        if ROOT.gSystem.Load(lib) < 0:
            raise RuntimeError(f"Failed to load {lib}")
    try:
        ROOT.FWLiteEnabler.enable()
    except AttributeError:
        pass


def list_tree_branches(file_path, tree_name=DEFAULT_TREE):
    """Print branch names available in the given TTree."""
    root_file = ROOT.TFile.Open(file_path)
    tree = root_file.Get(tree_name)
    if not tree:
        print(f"Tree '{tree_name}' not found in {file_path}")
        return
    print(f"\n=== Branches in '{tree_name}' ===")
    for branch in tree.GetListOfBranches():
        print(f"  {branch.GetName()}")
    root_file.Close()


def show_particle_methods(file_path, branch_label, type_str=DEFAULT_TYPE):
    """Inspect available methods on the first GenParticle in the file."""
    events = Events(file_path)
    handle = Handle(type_str)
    for event in events:
        event.getByLabel(branch_label, handle)
        particle = handle.product()[0]
        print(f"\n=== Methods for '{branch_label}' ===")
        for method in sorted(dir(particle)):
            if not method.startswith('_'):
                print(f"  {method}")
        break


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
        for p in handle.product():
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
                data['long_lived'].append(int(hasattr(p, 'longLived') and p.longLived()))
                moms = [str(p.motherRef(i).get().pdgId()) 
                        for i in range(p.numberOfMothers()) 
                        if p.motherRef(i).isNonnull()]
                dins = [str(p.daughterRef(i).get().pdgId())
                        for i in range(p.numberOfDaughters())
                        if p.daughterRef(i).isNonnull()]
                data['mothers'].append(",".join(moms))
                data['daughters'].append(",".join(dins))
    return data


def create_1d_histogram(values, name, title, bins, value_range):
    """Create and fill a 1D ROOT histogram."""
    hist = ROOT.TH1D(name, title, bins, *value_range)
    for v in values:
        hist.Fill(v)
    return hist


def save_canvas(histogram, output_path, draw_options=""):
    """Draw histogram on canvas and save to file."""
    canvas = ROOT.TCanvas()
    histogram.Draw(draw_options)
    canvas.SaveAs(output_path)
    canvas.Close()


def write_data_table(data, output_path):
    """Write extracted data to a tab-separated table."""
    keys = list(data.keys())
    lengths = [len(data[k]) for k in keys]
    min_len = min(lengths)
    with open(output_path, 'w') as f:
        header = "\t".join(keys)
        f.write(header + "\n")
        for i in range(min_len):
            row = [str(data[k][i]) for k in keys]
            f.write("\t".join(row) + "\n")
    print(f"Wrote {min_len} rows to {output_path}")


def parse_arguments():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(description="Extract RHadron data and produce plots/tables")
    parser.add_argument('input_file', help='Path to input ROOT file')
    parser.add_argument('--label', default=DEFAULT_LABEL,help=f'GenParticle branch label (default: {DEFAULT_LABEL})')
    parser.add_argument('--output-dir', default='./plots',help='Base directory to save plots and tables')
    return parser.parse_args()


def main():
    args = parse_arguments()
    infile = args.input_file
    label = args.label
    base_out_dir = args.output_dir
    sample_name = os.path.splitext(os.path.basename(infile))[0]
    out_dir = os.path.join(base_out_dir, sample_name)
    os.makedirs(out_dir, exist_ok=True)

    initialize_fwlite()
    list_tree_branches(infile)
    show_particle_methods(infile, label)

    data = extract_rhadron_info(infile, label)

    # Histogram: PDG IDs
    counter = Counter(data['pdg_id'])
    h_pdg = ROOT.TH1D(
        "pdg_ids", ";PDG ID;Count",
        len(RHADRON_PDGIDS), 0.5, len(RHADRON_PDGIDS) + 0.5
    )
    for idx, pid in enumerate(RHADRON_PDGIDS, start=1):
        h_pdg.SetBinContent(idx, counter.get(pid, 0))
        h_pdg.GetXaxis().SetBinLabel(idx, str(pid))
    save_canvas(h_pdg, os.path.join(out_dir, "pdg_ids.pdf"))

    # Kinematic histograms
    for var in ['pt', 'eta', 'phi', 'mass', 'charge', 'energy']:
        vals = data[var]
        if not vals:
            continue
        min_val, max_val = (min(vals), max(vals))
        if var == 'phi':
            min_val, max_val = min_val - 0.5, max_val + 0.5
        hist = create_1d_histogram(
            vals, f"h_{var}", f";{var};Counts",
            50, (min_val, max_val)
        )
        save_canvas(hist, os.path.join(out_dir, f"{var}.pdf"))

    # dphi between leading two RHadrons
    event_map = defaultdict(list)
    for evt, pt_val, phi_val in zip(data['event'], data['pt'], data['phi']):
        event_map[evt].append((pt_val, phi_val))
    dphi_vals = []
    for hist_list in event_map.values():
        if len(hist_list) < 2:
            continue
        (pt1, phi1), (pt2, phi2) = sorted(
            hist_list, key=lambda x: x[0], reverse=True
        )[:2]
        delta = abs(phi1 - phi2)
        if delta < 0:
            delta += 2*pi
        elif delta >= 2*pi:
            delta -= 2*pi
        dphi_vals.append(delta)
    if dphi_vals:
        h_dphi = create_1d_histogram(
            dphi_vals, "dphi", ";#Delta#phi(rad);Counts",
            50, (0, 2*pi)
        )
        h_dphi.GetXaxis().SetRangeUser(0, 2*pi)
        save_canvas(h_dphi, os.path.join(out_dir, "dphi.pdf"))

    # Long-lived vs mass 2D
    ll_mass_hist = ROOT.TH2D(
        "ll_vs_mass", ";Long-lived;Mass[GeV]", 2, 0, 2, 50,
        min(data['mass']) * 0.95, max(data['mass']) * 1.05
    )
    for ll, m in zip(data['long_lived'], data['mass']):
        ll_mass_hist.Fill(ll, m)
    save_canvas(ll_mass_hist, os.path.join(out_dir, "long_lived_vs_mass.pdf"), "COLZ")

    min_mass = min(data['mass'])
    max_mass = max(data['mass'])
    mp_hist = ROOT.TH2D(
        "mass_vs_pdg", ";PDG ID;Mass[GeV]",
        len(RHADRON_PDGIDS), 0.5, len(RHADRON_PDGIDS) + 0.5,
        50, min_mass, max_mass
    )
    for idx, pid in enumerate(RHADRON_PDGIDS, start=1):
        mp_hist.GetXaxis().SetBinLabel(idx, str(pid))
    for pid, m in zip(data['pdg_id'], data['mass']):
        if pid in RHADRON_PDGIDS:
            mp_hist.Fill(RHADRON_PDGIDS.index(pid) + 1, m)

    mp_hist.GetYaxis().SetRangeUser(min_mass, max_mass)
    save_canvas(mp_hist, os.path.join(out_dir, "mass_vs_pdgid.pdf"), "COLZ")

    # Write table
    write_data_table(data, os.path.join(out_dir, "rhadron_data.tsv"))


if __name__ == "__main__":
    main()
