#!/usr/bin/env python
import os
import sys
import ROOT
from collections import Counter
from DataFormats.FWLite import Events, Handle

ROOT.gStyle.SetOptStat(0)
ROOT.gInterpreter.Declare('#include "DataFormats/Common/interface/Wrapper.h"')
ROOT.gInterpreter.Declare('#include "DataFormats/HepMCCandidate/interface/GenParticle.h"')

PDGID_LIST = [
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334
]

def load_fwlite():
    for lib in ("libFWCoreFWLite", "libDataFormatsFWLite"):
        if ROOT.gSystem.Load(lib) < 0:
            raise RuntimeError(f"Failed to load {lib}")
    try:
        ROOT.FWLiteEnabler.enable()
    except AttributeError:
        pass

def list_branches(input_file, tree_name="Events"):
    file = ROOT.TFile.Open(input_file)
    tree = file.Get(tree_name)
    if not tree:
        print(f"Tree '{tree_name}' not found in file")
        return
    print(f"\n=== Branches in '{tree_name}' ===")
    for branch in tree.GetListOfBranches():
        print(f"  {branch.GetName()}")
    file.Close()

def inspect_methods(input_file, label="genParticles", type_str="std::vector<reco::GenParticle>"):
    events = Events(input_file)
    handle = Handle(type_str)
    for event in events:
        event.getByLabel(label, handle)
        particle = handle.product()[0]
        print(f"\n=== Methods for '{label}' ===")
        for attr in sorted(dir(particle)):
            if not attr.startswith('_'):
                print(f"  {attr}")
        break

def extract_rhadron_data(file_path):
    handle = Handle("std::vector<reco::GenParticle>")
    label = "genParticles"
    events = Events(file_path)
    data = {k: [] for k in ('event', 'pdgid', 'mass', 'charge', 'pt', 'eta', 'phi', 'mothers', 'daughters', 'longLived', 'energy')}
    for event in events:
        aux = event.eventAuxiliary()
        data['event'].append(aux.id().event())
        event.getByLabel(label, handle)
        for p in handle.product():
            pid = abs(p.pdgId())
            if 1000600 <= pid <= 1100000 and p.status() == 1:
                data['pdgid'].append(pid)
                data['mass'].append(p.mass())
                data['charge'].append(p.charge())
                data['pt'].append(p.pt())
                data['energy'].append(p.energy())
                data['eta'].append(p.eta())
                data['phi'].append(p.phi())
                data['longLived'].append(int(p.longLived()) if hasattr(p, 'longLived') else 0)
                data['mothers'].append(",".join(str(p.motherRef(i).get().pdgId()) for i in range(p.numberOfMothers()) if p.motherRef(i).isNonnull()))
                data['daughters'].append(",".join(str(p.daughterRef(i).get().pdgId()) for i in range(p.numberOfDaughters()) if p.daughterRef(i).isNonnull()))
    return data

def create_histogram(values, name, title, bins, value_range):
    hist = ROOT.TH1D(name, title, bins, *value_range)
    for val in values:
        hist.Fill(val)
    return hist

def save_plot(hist, filepath, options=""):
    c = ROOT.TCanvas()
    hist.Draw(options)
    c.SaveAs(filepath)
    c.Close()

def save_table(data, filename):
    # Check table length consistency
    lengths = {k: len(v) for k, v in data.items()}
    min_len = min(lengths.values())
    max_len = max(lengths.values())

    if len(set(lengths.values())) != 1:
        print("[Warning] Mismatched lengths detected:")
        for key, l in lengths.items():
            print(f"  {key}: {l}")
        print(f"Writing only the first {min_len} rows (minimum length).")

    with open(filename, 'w') as f:
        f.write("event\tpdgid\tmass\tcharge\tpt\tenergy\teta\tphi\tmothers\tdaughters\tlongLived\n")
        for i in range(min_len):
            f.write(f"{data['event'][i]}\t{data['pdgid'][i]}\t{data['mass'][i]:.6g}\t{data['charge'][i]:.1f}\t"
                    f"{data['pt'][i]:.6g}\t{data['energy'][i]:.6g}\t{data['eta'][i]:.6g}\t{data['phi'][i]:.6g}\t"
                    f"{data['mothers'][i]}\t{data['daughters'][i]}\t{data['longLived'][i]}\n")
    print(f"Wrote {min_len} rows to {filename}")

def main():
    if not (2 <= len(sys.argv) <= 3):
        print(f"Usage: {sys.argv[0]} <input_root_file> [<label>] (default: genParticles)")
        sys.exit(1)

    input_file = sys.argv[1]
    inspect_label = sys.argv[2] if len(sys.argv) == 3 else 'genParticles'
    sample = os.path.splitext(os.path.basename(input_file))[0]

    output_dir = f"/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/plots/{sample}"
    os.makedirs(output_dir, exist_ok=True)

    load_fwlite()
    list_branches(input_file)
    inspect_methods(input_file, inspect_label)

    data = extract_rhadron_data(input_file)

    # PDGID histogram
    counter = Counter(data['pdgid'])
    h_pdgid = ROOT.TH1D("pdgids", ";PDGID;Count", len(PDGID_LIST), 0.5, len(PDGID_LIST) + 0.5)
    for idx, pid in enumerate(PDGID_LIST, 1):
        h_pdgid.SetBinContent(idx, counter.get(pid, 0))
        h_pdgid.GetXaxis().SetBinLabel(idx, str(pid))
    save_plot(h_pdgid, os.path.join(output_dir, f"pdgid_{sample}.pdf"))

    # Kinematics
    variables = ['pt', 'eta', 'phi', 'mass', 'charge', 'energy']
    for var in variables:
        vals = data[var]
        if vals:
            vmin, vmax = min(vals), max(vals)
            if var == 'phi':
                vmin, vmax = vmin - 0.5, vmax + 0.5
            hist = create_histogram(vals, f"{var}_{sample}", f";{var};Counts", 50, (vmin, vmax))
            save_plot(hist, os.path.join(output_dir, f"{var}_{sample}.pdf"))

    # longLived
    h_ll = create_histogram(data['longLived'], f"longLived_{sample}", ";longLived;Count", 2, (0, 2))
    save_plot(h_ll, os.path.join(output_dir, f"longLived_{sample}.pdf"))

    # longLived vs mass
    min_mass, max_mass = min(data['mass']), max(data['mass'])
    pad = 0.05 * (max_mass - min_mass)
    h_ll_mass = ROOT.TH2D("ll_mass", ";longLived;Mass [GeV]", 2, 0, 2, 50, min_mass - pad, max_mass + pad)
    for ll, mass in zip(data['longLived'], data['mass']):
        h_ll_mass.Fill(ll, mass)
    save_plot(h_ll_mass, os.path.join(output_dir, f"longLived_vs_mass_{sample}.pdf"), "COLZ")

    # mass vs PDGID
    h_mass_pdg = ROOT.TH2D("mass_pdgid", ";PDGID;Mass [GeV]", len(PDGID_LIST), 0.5, len(PDGID_LIST) + 0.5, 50, min_mass - pad, max_mass + pad)
    for idx, pid in enumerate(PDGID_LIST, 1):
        h_mass_pdg.GetXaxis().SetBinLabel(idx, str(pid))
    for pid, mass in zip(data['pdgid'], data['mass']):
        if pid in PDGID_LIST:
            h_mass_pdg.Fill(PDGID_LIST.index(pid) + 1, mass)
    save_plot(h_mass_pdg, os.path.join(output_dir, f"mass_vs_pdgid_{sample}.pdf"), "COLZ")

    save_table(data, os.path.join(output_dir, f"{sample}_rhadron_table.txt"))

if __name__ == "__main__":
    main()
