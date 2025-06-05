#!/usr/bin/env python
import os
import ROOT
from collections import Counter

# --- CLANG INTERPRETER INCLUDES (unchanged) ---
ROOT.gInterpreter.Declare('#include "DataFormats/Common/interface/Wrapper.h"')
ROOT.gInterpreter.Declare('#include "DataFormats/HepMCCandidate/interface/GenParticle.h"')

# --- USER-SPECIFIED PDGID LIST (unchanged) ---
pdg_list = [
    1000993, 1009213, 1009313, 1009323, 1009113,
    1009223, 1009333, 1091114, 1092114, 1092214,
    1092224, 1093114, 1093214, 1093224, 1093314,
    1093324, 1093334, 1009413, 1009423, 1009433,
    1009443, 1009513, 1009523, 1009533, 1009543,
    1009553, 1094114, 1094214, 1094224, 1094314,
    1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334
]

# --- CONFIGURATION (paths, output directories) ---
samples = [
    {
        "name": "seeded_withFilter",
        "path": "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/root-files/"
                "mg-Rhadron_mGl-1800-CMSSW_13_2_9-n20000-Jet_matching_ON-seeded_withFilter_20k.root"
    },
    {
        "name": "seeded_WithoutFilter",
        "path": "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/root-files/"
                "mg-Rhadron_mGl-1800-CMSSW_13_2_9-n20000-Jet_matching_ON-withoutFilter_seeded_20k.root"
    }
]
output_base_dir = "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/plots/seededstuff"
overlay_dir = os.path.join(output_base_dir, "Overlay")
table_dir = os.path.join(output_base_dir, "Tables")

os.makedirs(output_base_dir, exist_ok=True)
os.makedirs(overlay_dir, exist_ok=True)
os.makedirs(table_dir, exist_ok=True)

# --- LIBRARY LOADING (unchanged) ---
def load_fwlite_libraries():
    for lib in ("libFWCoreFWLite", "libDataFormatsFWLite"):
        if ROOT.gSystem.Load(lib) < 0:
            raise RuntimeError(f"Failed to load {lib}")
    try:
        ROOT.FWLiteEnabler.enable()
    except AttributeError:
        pass

# --- DATA EXTRACTION (rewritten with FWLite::Events + Handle) ---
def read_rhadron_tree_with_eventinfo(file_path):
    """
    Instead of using TTreeReader directly, we use FWLite's Events interface.
    We loop over each event, fetch GenParticleCollection, and for each status==1
    R-hadron store:
      - the event number
      - the bunchCrossing ID
      - the PDGID, mass, charge, pt, eta, phi
      - a small array of mother PDGIDs (if any) and daughter PDGIDs (if any)
    
    Returns a dictionary of lists, keyed by:
      'event' (int), 'bunchCrossing' (int),
      'pdgid', 'mass', 'charge', 'pt', 'eta', 'phi',
      'mothers', 'daughters'
    The 'mothers' and 'daughters' entries are stored as comma-separated strings
    of PDGIDs (e.g. "1000021,1000022") or an empty string if none.
    """
    from DataFormats.FWLite import Events, Handle
    
    # Prepare the handle for reco::GenParticleCollection
    handle = Handle("std::vector<reco::GenParticle>")
    label = "genParticles"  # this should match the label used in your GEN step
    events = Events(file_path)
    
    # Prepare the output dictionary
    particle_data = {
        'event': [],
        'bunchCrossing': [],
        'pdgid': [],
        'mass': [],
        'charge': [],
        'pt': [],
        'eta': [],
        'phi': [],
        'mothers': [],
        'daughters': []
    }
    
    # Loop over every event in the file
    for event in events:
        # Grab event‐level info
        evt_aux = event.eventAuxiliary()
        evt_number = evt_aux.id().event()            # the global event number
        bc_id      = evt_aux.bunchCrossing()         # bunch crossing ID
        
        # Get the GenParticle collection
        event.getByLabel(label, handle)
        gen_parts = handle.product()
        
        # Now loop over each GenParticle in this event
        for p in gen_parts:
            pid = abs(p.pdgId())
            # We're only interested in stable (status == 1) R‐hadrons in the given PDG range
            if (1000600 <= pid <= 1100000) and (p.status() == 1):
                # Kinematic & charge
                pt_val = p.pt()
                eta_val = p.eta()
                phi_val = p.phi()
                mass_val = p.mass()
                charge_val = p.charge()
                
                # --- collect mother PDGIDs as a comma‐sep string ---
                n_moms = p.numberOfMothers()
                if n_moms > 0:
                    mom_pdg_list = []
                    for im in range(n_moms):
                        mom_ref = p.motherRef(im)
                        if mom_ref.isNonnull():
                            mom_pdg_list.append(str(mom_ref.get().pdgId()))
                    mothers_str = ",".join(mom_pdg_list)
                else:
                    mothers_str = ""
                
                # --- collect daughter PDGIDs as a comma‐sep string ---
                n_daus = p.numberOfDaughters()
                if n_daus > 0:
                    dau_pdg_list = []
                    for idau in range(n_daus):
                        dau_ref = p.daughterRef(idau)
                        if dau_ref.isNonnull():
                            dau_pdg_list.append(str(dau_ref.get().pdgId()))
                    daughters_str = ",".join(dau_pdg_list)
                else:
                    daughters_str = ""
                
                # Append everything to our particle_data dict
                particle_data['event'].append(evt_number)
                particle_data['bunchCrossing'].append(bc_id)
                particle_data['pdgid'].append(pid)
                particle_data['mass'].append(mass_val)
                particle_data['charge'].append(charge_val)
                particle_data['pt'].append(pt_val)
                particle_data['eta'].append(eta_val)
                particle_data['phi'].append(phi_val)
                particle_data['mothers'].append(mothers_str)
                particle_data['daughters'].append(daughters_str)
    
    return particle_data


# --- PLOTTING HELPERS (unchanged) ---
def draw_and_save(hist_obj, file_name, draw_options=""):
    ROOT.gStyle.SetOptStat(0)
    if hasattr(hist_obj, 'SetStats'):
        hist_obj.SetStats(0)
    if isinstance(hist_obj, ROOT.TH1) and not isinstance(hist_obj, ROOT.TH2):
        hist_name = hist_obj.GetName()
        if "seeded_WithoutFilter" in hist_name:
            hist_obj.SetFillColorAlpha(ROOT.kRed, 0.35)
            hist_obj.SetFillStyle(1001)
        elif "seeded_withFilter" in hist_name:
            hist_obj.SetFillColorAlpha(ROOT.kBlue, 0.35)
            hist_obj.SetFillStyle(1001)
    canvas = ROOT.TCanvas()
    hist_obj.Draw(draw_options)
    canvas.SaveAs(file_name)
    canvas.Close()

def create_1d_histogram(values, hist_name, hist_title, bin_count, value_range):
    hist = ROOT.TH1D(hist_name, hist_title, bin_count, *value_range)
    for v in values:
        hist.Fill(v)
    return hist

def write_rhadron_table(sample_name, data_dict, output_dir):
    """
    Writes a tab‐delimited text file.  Each line corresponds to one R-hadron,
    and columns are:
      event  bunchCrossing  pdgid  mass  charge  pt  eta  phi  mothers  daughters
    """
    fname = os.path.join(output_dir, f"{sample_name}_rhadron_table.txt")
    with open(fname, 'w') as f:
        # Write a header:
        f.write("event\tbunchCrossing\tpdgid\tmass\tcharge\tpt\teta\tphi\tmothers\tdaughters\n")
        
        n = len(data_dict['pdgid'])  # assume all columns have the same length
        for i in range(n):
            evt     = data_dict['event'][i]
            bx      = data_dict['bunchCrossing'][i]
            pid     = data_dict['pdgid'][i]
            mass    = data_dict['mass'][i]
            charge  = data_dict['charge'][i]
            ptval   = data_dict['pt'][i]
            etaval  = data_dict['eta'][i]
            phival  = data_dict['phi'][i]
            moms    = data_dict['mothers'][i]
            daus    = data_dict['daughters'][i]
            
            f.write(
                "{:d}\t{:d}\t{:d}\t{:.6g}\t{:.1f}\t{:.6g}\t{:.6g}\t{:.6g}\t{}\t{}\n"
                .format(evt, bx, pid, mass, charge, ptval, etaval, phival, moms, daus)
            )
    print(f"Wrote {n} entries (including event/bunchCrossing + mother/daughter IDs) to {fname}")


# --- MAIN WORKFLOW (modified only in the “data extraction” step) ---
if __name__ == "__main__":
    load_fwlite_libraries()
    
    # Use the new reader that also grabs event/bxID & parents/children
    sample_data = {
        s['name']: read_rhadron_tree_with_eventinfo(s['path'])
        for s in samples
    }
    
    
    minMass = float('inf')
    maxMass = float('-inf')
    for data in sample_data.values():
        for m in data['mass']:
            if m < minMass: minMass = m
            if m > maxMass: maxMass = m
    pad = 0.05 * (maxMass - minMass)
    minMass -= pad
    maxMass += pad

    # PDGID counters (same as before)
    pdg_counters = {
        sample_name: Counter(data_dict['pdgid'])
        for sample_name, data_dict in sample_data.items()
    }
    # Print them (unchanged)
    for sample_name, pdg_counter in pdg_counters.items():
        total = sum(pdg_counter.values())
        print(f"\n=== Sample '{sample_name}' : {total} RHadrons ===")
        for pid in sorted(pdg_counter):
            print(f"  PDGID {pid:7d}: {pdg_counter[pid]:5d} entries")

    # Compute difference (unchanged)
    name1, name2 = list(pdg_counters.keys())
    counter1 = pdg_counters[name1]
    counter2 = pdg_counters[name2]

    print(f"\n=== Difference: '{name1}' minus '{name2}' ===")
    for pid in sorted(set(counter1.keys()) | set(counter2.keys())):
        c1 = counter1.get(pid, 0)
        c2 = counter2.get(pid, 0)
        diff = c1 - c2
        if diff != 0:
            print(f"  PDGID {pid:7d}: {name1} {c1:5d} – {name2} {c2:5d} = {diff:+5d}")

    # Per‐sample histograms (unchanged except you explicitly pick out the keys you want)
    for sample_name, data_dict in sample_data.items():
        sample_dir = os.path.join(output_base_dir, sample_name)
        os.makedirs(sample_dir, exist_ok=True)

        # PDG ID counts
        pdg_counts = {pid: data_dict['pdgid'].count(pid) for pid in pdg_list}
        hist_pdg_counts = ROOT.TH1D(
            f"pdg_{sample_name}", ";PDGID;Counts",
            len(pdg_list), 0, len(pdg_list)
        )
        for idx, pid in enumerate(pdg_list, 1):
            hist_pdg_counts.SetBinContent(idx, pdg_counts[pid])
            hist_pdg_counts.GetXaxis().SetBinLabel(idx, str(pid))
        draw_and_save(
            hist_pdg_counts,
            os.path.join(sample_dir, f"Rhadron_pdgid_{sample_name}_20k.pdf")
        )

        # Kinematic & charge histograms
        binning = {'pt': 45, 'eta': 35, 'phi': 35, 'mass': 35, 'charge': 50}
        for variable, bin_count in binning.items():
            values = data_dict[variable]
            if not values:
                continue
            if variable == 'phi':
                value_range = (min(values) - 0.5, max(values) + 0.5)
            else:
                value_range = (min(values), max(values))
            hist = create_1d_histogram(
                values,
                f"{variable}_{sample_name}",
                f";{variable};Counts",
                bin_count,
                value_range
            )
            draw_and_save(
                hist,
                os.path.join(sample_dir, f"Rhadron_{variable}_{sample_name}_20k.pdf")
            )

        # Mass vs PDGID scatter (same as before)
        hist2_pdgid_mass = ROOT.TH2D(
            f"mass_vs_pdg_{sample_name}",
            ";;GEN Mass (GeV)",
            len(pdg_list), 0.5, len(pdg_list)+0.5,
            50, minMass, maxMass
        )
        for idx, pid in enumerate(pdg_list, 1):
            hist2_pdgid_mass.GetXaxis().SetBinLabel(idx, str(pid))
        for pid, mass in zip(data_dict['pdgid'], data_dict['mass']):
            if pid in pdg_list:
                hist2_pdgid_mass.Fill(pdg_list.index(pid) + 1, mass)
        hist2_pdgid_mass.GetXaxis().LabelsOption("v")
        hist2_pdgid_mass.GetYaxis().SetTitleOffset(1.5)
        draw_and_save(
            hist2_pdgid_mass,
            os.path.join(sample_dir, f"Rhadron_mass_vs_pdg_{sample_name}_20k.pdf"),
            "COLZ"
        )

    # Overlay PDG ID counts (unchanged)
    n_bins = len(pdg_list)
    hist_no_filter = ROOT.TH1D("pid_no", ";PDGID;Counts", n_bins, 0, n_bins)
    hist_with_filter = ROOT.TH1D("pid_wt", ";PDGID;Counts", n_bins, 0, n_bins)
    for idx, pid in enumerate(pdg_list, 1):
        hist_no_filter.SetBinContent(
            idx, sample_data['seeded_WithoutFilter']['pdgid'].count(pid)
        )
        hist_with_filter.SetBinContent(
            idx, sample_data['seeded_withFilter']['pdgid'].count(pid)
        )
        hist_no_filter.GetXaxis().SetBinLabel(idx, str(pid))
        hist_with_filter.GetXaxis().SetBinLabel(idx, str(pid))
    hist_no_filter.SetFillColorAlpha(ROOT.kRed, 0.35)
    hist_no_filter.SetFillStyle(1001)
    hist_with_filter.SetFillColorAlpha(ROOT.kBlue, 0.35)
    hist_with_filter.SetFillStyle(1001)
    hist_no_filter.SetLineColor(ROOT.kRed)
    hist_with_filter.SetLineColor(ROOT.kBlue)

    canvas_pdg_overlay = ROOT.TCanvas()
    hist_no_filter.Draw("HIST")
    hist_with_filter.Draw("HIST SAME")
    legend = ROOT.TLegend(0.7, 0.75, 0.9, 0.9)
    legend.AddEntry(hist_no_filter, "seeded_WithoutFilter", "f")
    legend.AddEntry(hist_with_filter, "seeded_withFilter", "f")
    legend.Draw()
    canvas_pdg_overlay.SaveAs(os.path.join(overlay_dir, "Rhadron_pdgid_overlay_20k.pdf"))
    canvas_pdg_overlay.Close()

    # Overlay kinematic & charge histograms (unchanged)
    for variable, bin_count in {'pt': 45, 'eta': 35, 'phi': 35, 'mass': 35, 'charge': 50}.items():
        vals_no   = sample_data['seeded_WithoutFilter'][variable]
        vals_with = sample_data['seeded_withFilter'][variable]
        if not vals_no and not vals_with:
            continue
        all_vals = vals_no + vals_with

        if variable == 'phi':
            value_range = (min(all_vals) - 0.5, max(all_vals) + 0.5)
        else:
            value_range = (min(all_vals), max(all_vals))

        hist_no_filter = ROOT.TH1D(
            f"{variable}_no", f";{variable};Counts", bin_count, *value_range
        )
        hist_with_filter = ROOT.TH1D(
            f"{variable}_wt", f";{variable};Counts", bin_count, *value_range
        )

        for v in vals_no:
            hist_no_filter.Fill(v)
        for v in vals_with:
            hist_with_filter.Fill(v)

        hist_no_filter.SetFillColorAlpha(ROOT.kRed, 0.35)
        hist_no_filter.SetFillStyle(1001)
        hist_with_filter.SetFillColorAlpha(ROOT.kBlue, 0.35)
        hist_with_filter.SetFillStyle(1001)
        hist_no_filter.SetLineColor(ROOT.kRed)
        hist_with_filter.SetLineColor(ROOT.kBlue)

        canvas_variable_overlay = ROOT.TCanvas()
        hist_no_filter.Draw("HIST")
        hist_with_filter.Draw("HIST SAME")
        legend_var = ROOT.TLegend(0.7, 0.75, 0.9, 0.9)
        legend_var.AddEntry(hist_no_filter, "seeded_WithoutFilter", "f")
        legend_var.AddEntry(hist_with_filter, "seeded_withFilter", "f")
        legend_var.Draw()
        canvas_variable_overlay.SaveAs(
            os.path.join(overlay_dir, f"Rhadron_{variable}_overlay_20k.pdf")
        )
        canvas_variable_overlay.Close()

    # Overlay mass vs PDGID scatter (unchanged)
    hist2_no_filter = ROOT.TH2D(
        "mass_vs_pdg_no", ";PDGID;GEN Mass (GeV)",
        n_bins, 0.5, n_bins + 0.5, 50, minMass, maxMass
    )
    hist2_with_filter = ROOT.TH2D(
        "mass_vs_pdg_wt", ";PDGID;Mass (GeV)",
        n_bins, 0, n_bins, 50, minMass, maxMass
    )
    for idx, pid in enumerate(pdg_list, 1):
        hist2_no_filter.GetXaxis().SetBinLabel(idx, str(pid))
        hist2_with_filter.GetXaxis().SetBinLabel(idx, str(pid))
    for pid, mass in zip(sample_data['seeded_WithoutFilter']['pdgid'],
                         sample_data['seeded_WithoutFilter']['mass']):
        if pid in pdg_list:
            hist2_no_filter.Fill(pdg_list.index(pid) + 1, mass)
    for pid, mass in zip(sample_data['seeded_withFilter']['pdgid'],
                         sample_data['seeded_withFilter']['mass']):
        if pid in pdg_list:
            hist2_with_filter.Fill(pdg_list.index(pid) + 1, mass)
    for hist in (hist2_no_filter, hist2_with_filter):
        hist.GetXaxis().LabelsOption("v")
    canvas_scatter_overlay = ROOT.TCanvas("c2", "", 1200, 600)
    canvas_scatter_overlay.Divide(2, 1)
    canvas_scatter_overlay.cd(1)
    hist2_no_filter.Draw("COLZ")
    canvas_scatter_overlay.cd(2)
    hist2_with_filter.Draw("COLZ")
    canvas_scatter_overlay.SaveAs(os.path.join(overlay_dir, "Rhadron_scatter_overlay_20k.pdf"))
    canvas_scatter_overlay.Close()

    # --- Finally, write out the text files (one per sample) including event & bx & parents/daughters ---
    for sample_name, data_dict in sample_data.items():
        write_rhadron_table(sample_name, data_dict, table_dir)
