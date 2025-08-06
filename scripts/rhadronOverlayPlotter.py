#!/usr/bin/env python
import os
import ROOT
from collections import Counter
from DataFormats.FWLite import Events, Handle

# --- Setup ROOT ---
ROOT.gInterpreter.Declare('#include "DataFormats/Common/interface/Wrapper.h"')
ROOT.gInterpreter.Declare('#include "DataFormats/HepMCCandidate/interface/GenParticle.h"')

# --- Configuration ---
PDG_IDS = [
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334
]

SAMPLES = [
    {
        "name": "with_filter",
        "path": "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/root-files/mg-Rhadron_mGl-1800-CMSSW_13_2_9-n20000-Jet_matching_ON-seeded_withFilter_20k.root"
    },
    {
        "name": "without_filter",
        "path": "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/root-files/mg-Rhadron_mGl-1800-CMSSW_13_2_9-n20000-Jet_matching_ON-withoutFilter_seeded_20k.root"
    }
]

OUTPUT_DIR = "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/plots/seededstuff"
TABLE_DIR = os.path.join(OUTPUT_DIR, "Tables")
OVERLAY_DIR = os.path.join(OUTPUT_DIR, "Overlay")

for d in (OUTPUT_DIR, TABLE_DIR, OVERLAY_DIR):
    os.makedirs(d, exist_ok=True)

# --- FWLite Initialization ---
def initialize_fwlite():
    for lib in ("libFWCoreFWLite", "libDataFormatsFWLite"):
        if ROOT.gSystem.Load(lib) < 0:
            raise RuntimeError(f"Failed to load {lib}")
    try:
        ROOT.FWLiteEnabler.enable()
    except AttributeError:
        pass

# --- Data Extraction ---
def extract_rhadrons(file_path):
    handle = Handle("std::vector<reco::GenParticle>")
    label = "genParticles"
    events = Events(file_path)

    data = {k: [] for k in ("event", "bunch", "pdgid", "mass", "charge", "pt", "eta", "phi", "mothers", "daughters")}

    for event in events:
        aux = event.eventAuxiliary()
        event_id = aux.id().event()
        bunch_id = aux.bunchCrossing()

        event.getByLabel(label, handle)
        for p in handle.product():
            pid = abs(p.pdgId())
            if (1000600 <= pid <= 1100000) and p.status() == 1:
                data["event"].append(event_id)
                data["bunch"].append(bunch_id)
                data["pdgid"].append(pid)
                data["mass"].append(p.mass())
                data["charge"].append(p.charge())
                data["pt"].append(p.pt())
                data["eta"].append(p.eta())
                data["phi"].append(p.phi())
                
                moms = [str(p.motherRef(i).get().pdgId()) for i in range(p.numberOfMothers()) if p.motherRef(i).isNonnull()]
                daus = [str(p.daughterRef(i).get().pdgId()) for i in range(p.numberOfDaughters()) if p.daughterRef(i).isNonnull()]
                
                data["mothers"].append(",".join(moms))
                data["daughters"].append(",".join(daus))
    return data

# --- Plotting ---
def create_hist1d(values, name, title, bins, rng):
    h = ROOT.TH1D(name, title, bins, *rng)
    for v in values:
        h.Fill(v)
    return h

def save_canvas(hist, filepath, options=""):
    canvas = ROOT.TCanvas()
    hist.Draw(options)
    canvas.SaveAs(filepath)
    canvas.Close()

# --- Table Writer ---
def write_table(name, data, directory):
    path = os.path.join(directory, f"{name}_rhadron_table.txt")
    with open(path, 'w') as f:
        f.write("event\tbunchCrossing\tpdgid\tmass\tcharge\tpt\teta\tphi\tmothers\tdaughters\n")
        for i in range(len(data['pdgid'])):
            f.write(
                f"{data['event'][i]}\t{data['bunch'][i]}\t{data['pdgid'][i]}\t{data['mass'][i]:.6g}\t"
                f"{data['charge'][i]:.1f}\t{data['pt'][i]:.6g}\t{data['eta'][i]:.6g}\t{data['phi'][i]:.6g}\t"
                f"{data['mothers'][i]}\t{data['daughters'][i]}\n"
            )
    print(f"Saved table to {path}")

# --- Main Execution ---
def main():
    initialize_fwlite()

    sample_data = {
        s["name"]: extract_rhadrons(s["path"])
        for s in SAMPLES
    }

    # Get global min/max mass range
    all_masses = sample_data['with_filter']['mass'] + sample_data['without_filter']['mass']
    mass_min = min(all_masses)
    mass_max = max(all_masses)
    margin = 0.05 * (mass_max - mass_min)
    mass_range = (mass_min - margin, mass_max + margin)

    # --- Overlay 1D plots ---
    for variable, bins in {"pt": 45, "eta": 35, "phi": 35, "mass": 35}.items():
        vals_no = sample_data['without_filter'][variable]
        vals_yes = sample_data['with_filter'][variable]
        if not vals_no and not vals_yes:
            continue
        all_vals = vals_no + vals_yes
        rng = (min(all_vals) - 0.5, max(all_vals) + 0.5) if variable == 'phi' else (min(all_vals), max(all_vals))

        h_no = create_hist1d(vals_no, f"{variable}_no", f";{variable};Count", bins, rng)
        h_yes = create_hist1d(vals_yes, f"{variable}_yes", f";{variable};Count", bins, rng)

        h_no.SetFillColorAlpha(ROOT.kRed, 0.35)
        h_yes.SetFillColorAlpha(ROOT.kBlue, 0.35)
        h_no.SetLineColor(ROOT.kRed)
        h_yes.SetLineColor(ROOT.kBlue)

        canvas = ROOT.TCanvas()
        h_no.Draw("HIST")
        h_yes.Draw("HIST SAME")

        legend = ROOT.TLegend(0.7, 0.75, 0.9, 0.9)
        legend.AddEntry(h_no, "without_filter", "f")
        legend.AddEntry(h_yes, "with_filter", "f")
        legend.Draw()

        canvas.SaveAs(os.path.join(OVERLAY_DIR, f"overlay_{variable}.pdf"))
        canvas.Close()

    for name, data in sample_data.items():
        out_dir = os.path.join(OUTPUT_DIR, name)
        os.makedirs(out_dir, exist_ok=True)

        # 1D Histograms
        for var, bins in {"pt": 45, "eta": 35, "phi": 35, "mass": 35, "charge": 50}.items():
            vals = data[var]
            if not vals:
                continue
            rng = (min(vals) - 0.5, max(vals) + 0.5) if var == "phi" else (min(vals), max(vals))
            hist = create_hist1d(vals, f"{var}_{name}", f";{var};Count", bins, rng)
            save_canvas(hist, os.path.join(out_dir, f"{var}_{name}.pdf"))

        # PDGID histogram
        counts = Counter(data['pdgid'])
        hist_pdg = ROOT.TH1D(f"pdgid_{name}", ";PDGID;Count", len(PDG_IDS), 0, len(PDG_IDS))
        for idx, pid in enumerate(PDG_IDS, 1):
            hist_pdg.SetBinContent(idx, counts.get(pid, 0))
            hist_pdg.GetXaxis().SetBinLabel(idx, str(pid))
        save_canvas(hist_pdg, os.path.join(out_dir, f"pdgid_{name}.pdf"))

        # Mass vs PDGID 2D
        hist2d = ROOT.TH2D(f"mass_vs_pdgid_{name}", ";PDGID;Mass [GeV]", len(PDG_IDS), 0.5, len(PDG_IDS)+0.5, 50, *mass_range)
        for pid, m in zip(data['pdgid'], data['mass']):
            if pid in PDG_IDS:
                hist2d.Fill(PDG_IDS.index(pid) + 1, m)
        save_canvas(hist2d, os.path.join(out_dir, f"mass_vs_pdgid_{name}.pdf"), "COLZ")

        write_table(name, data, TABLE_DIR)

if __name__ == "__main__":
    main()
