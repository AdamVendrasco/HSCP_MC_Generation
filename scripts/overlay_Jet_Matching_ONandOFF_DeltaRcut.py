#!/usr/bin/env python
import argparse
import math
import ROOT
import matplotlib.pyplot as plt
import mplhep as hep
import matplotlib as mpl
import numpy as np

# Set plotting style
hep.style.use("CMS")
mpl.rcParams.update({
    'font.family': 'sans-serif',
    'font.size': 14,
    'axes.labelsize': 14,
    'axes.titlesize': 14,
    'xtick.labelsize': 14,
    'ytick.labelsize': 14,
    'legend.fontsize': 14,
    'lines.linewidth': 2,
    'figure.figsize': (8, 6)
})

def extract_top6_ak4_pt_from_file_no_isolation(root_file_path):
    """
    Extract the leading, second, third, fourth, and fifth AK4 jet pT values 
    from each event in a ROOT file.
    (No ΔR isolation is applied.)
    """
    f = ROOT.TFile.Open(root_file_path)
    tree = f.Get("Events")
    n_entries = tree.GetEntries()

    leading = []  # Highest pT jet per event
    second = []   # Second highest pT jet per event
    third = []    # Third highest pT jet per event
    fourth = []   # Fourth highest pT jet per event
    fifth = []    # Fifth highest pT jet per event
    sixth = []    # Sixth highest pT jet per event 
    count = 0     # Debug counter for gen particles

    jet_pts, jet_eta, jet_phi = [], [], []
    gen_pts, gen_eta, gen_phi = [], [], []

    for i in range(n_entries):
        tree.GetEntry(i)
        ak4jets_wrapper = getattr(tree, "recoGenJets_ak4GenJets__GEN", None)
        if not ak4jets_wrapper:
            continue
        ak4jets = ak4jets_wrapper.product()

        gen_particles_wrapper = getattr(tree, "recoGenParticles_genParticles__GEN", None)
        if gen_particles_wrapper:
            gen_particles = gen_particles_wrapper.product()
            # Extract generated particle info for debugging if conditions match
            for j in range(gen_particles.size()):
                gen = gen_particles.at(j)
                if 1000600 <= abs(gen.pdgId()) <= 1100000 and gen.status() == 1:
                    count += 1
                    gen_pts.append(gen.pt())
                    gen_eta.append(gen.eta())
                    gen_phi.append(gen.phi())

        jet_pts.clear()
        jet_eta.clear()
        jet_phi.clear()

        # Extract jet information from the event
        for j in range(ak4jets.size()):
            jet = ak4jets.at(j)
            jet_pts.append(jet.pt())
            jet_eta.append(jet.eta())
            jet_phi.append(jet.phi())

        # Sort jet pT values in descending order and record the top jets
        jet_pts.sort(reverse=True)
        if len(jet_pts) >= 1:
            leading.append(jet_pts[0])
        if len(jet_pts) >= 2:
            second.append(jet_pts[1])
        if len(jet_pts) >= 3:
            third.append(jet_pts[2])
        if len(jet_pts) >= 4:
            fourth.append(jet_pts[3])
        if len(jet_pts) >= 5:
            fifth.append(jet_pts[4])
        if len(jet_pts) >= 6:
            sixth.append(jet_pts[5])

    return {
        "leading": leading,
        "second": second,
        "third": third,
        "fourth": fourth,
        "fifth": fifth,
        "sixth": sixth
    }

def deltaR(eta1, phi1, eta2, phi2):
    """
    Compute the ΔR separation between two objects given their eta and phi coordinates.
    """
    dphi = abs(phi1 - phi2)
    if dphi > math.pi:
        dphi = 2 * math.pi - dphi
    return math.sqrt((eta1 - eta2) ** 2 + dphi ** 2)

def extract_top6_ak4_pt_from_file_with_isolation(root_file_path):
    """
    Extract the leading, second, third, fourth, and fifth AK4 jet pT values 
    from each event in a ROOT file.
    Applies a jet isolation requirement: jets with an RHadron (pdgId between 1000600 and 1100000, status==1)
    within ΔR < 0.4 are excluded.
    """
    f = ROOT.TFile.Open(root_file_path)
    tree = f.Get("Events")
    n_entries = tree.GetEntries()

    leading = []  # Highest pT jet per event
    second = []   # Second highest pT jet per event
    third = []    # Third highest pT jet per event
    fourth = []   # Fourth highest pT jet per event
    fifth = []    # Fifth highest pT jet per event
    sixth = []    # Sixth highest pT jet per event    

    for i in range(n_entries):
        tree.GetEntry(i)
        ak4jets_wrapper = getattr(tree, "recoGenJets_ak4GenJets__GEN", None)
        if not ak4jets_wrapper:
            continue
        ak4jets = ak4jets_wrapper.product()

        gen_particles_wrapper = getattr(tree, "recoGenParticles_genParticles__GEN", None)
        if not gen_particles_wrapper:
            continue
        gen_particles = gen_particles_wrapper.product()

        jet_candidates = []
        # Loop over jets in the event
        for j in range(ak4jets.size()):
            jet = ak4jets.at(j)
            passes_isolation = True

            # Check for nearby RHadrons
            for k in range(gen_particles.size()):
                gen = gen_particles.at(k)
                if 1000600 <= abs(gen.pdgId()) <= 1100000 and gen.status() == 1:
                    if deltaR(jet.eta(), jet.phi(), gen.eta(), gen.phi()) < 0.4:
                        passes_isolation = False
                        break

            if passes_isolation:
                jet_candidates.append((jet.pt(), jet.eta(), jet.phi()))

        # Sort jets by pT in descending order and record the top jets
        jet_candidates.sort(key=lambda x: x[0], reverse=True)
        if len(jet_candidates) >= 1:
            leading.append(jet_candidates[0][0])
        if len(jet_candidates) >= 2:
            second.append(jet_candidates[1][0])
        if len(jet_candidates) >= 3:
            third.append(jet_candidates[2][0])
        if len(jet_candidates) >= 4:
            fourth.append(jet_candidates[3][0])
        if len(jet_candidates) >= 5:
            fifth.append(jet_candidates[4][0])
        if len(jet_candidates) >= 6:
            sixth.append(jet_candidates[5][0])
    return {
        "leading": leading,
        "second": second,
        "third": third,
        "fourth": fourth,
        "fifth": fifth,
        "sixth": sixth
    }

def plot_overlay_histograms(data_dict, xlabel, title, filename, bins, x_range=None):
    """
    Generate and save an overlay histogram from multiple datasets using common bins.
    
    Parameters:
        data_dict (dict): Dictionary where keys are labels and values are lists of data points.
        xlabel (str): Label for the x-axis.
        title (str): Plot title.
        filename (str): File path to save the output plot.
        bins (array-like): Bin edges to be used for all histograms.
        x_range (tuple, optional): x-axis limits (min, max). Defaults to None.
    """
    plt.figure(figsize=(8, 6))
    for label, data in data_dict.items():
        plt.hist(data, bins=bins, histtype="step", label=label, density=True)

    if x_range is not None:
        plt.xlim(x_range)
    plt.xlabel(xlabel)
    plt.ylabel("Normalized Counts")
    plt.title(title)
    plt.yscale("log")
    plt.legend()
    plt.savefig(filename)
    print(f"Overlay histogram saved as {filename}")
    plt.close()

def main(args):
    # Define file paths for jet-matching OFF and ON datasets
    file_off = (
        "/eos/user/a/avendras/mg-Rhadron/mg-Rhadron_mGl-1800/"
        "root-files/mg-Rhadron_mGl-1800-CMSSW_12_4_8-n1000-Jet_matching_OFF-test.root"
    )
    file_on = (
        "/eos/user/a/avendras/mg-Rhadron/mg-Rhadron_mGl-1800/"
        "root-files/mg-Rhadron_mGl-1800-CMSSW_12_4_8-n1000-Jet_matching_ON-test.root"
    )

    # Choose extraction function and output directory based on the --isolation flag.
    if args.isolation:
        extraction_function = extract_top6_ak4_pt_from_file_with_isolation
        file_suffix = "_isolation_"
        output_dir = "/eos/user/a/avendras/mg-Rhadron/plot_archive/gen_RHadron_1800_JetMatcing_ONandOFF/isolation_cut/"
    else:
        extraction_function = extract_top6_ak4_pt_from_file_no_isolation
        file_suffix = ""
        output_dir = "/eos/user/a/avendras/mg-Rhadron/plot_archive/gen_RHadron_1800_JetMatcing_ONandOFF/no_isolation_cut/"

    # Extract jet pT data from both ROOT files
    data_off = extraction_function(file_off)
    data_on = extraction_function(file_on)

    # Loop over the jet ranks and generate overlay histograms
    for rank in ["leading", "second", "third", "fourth", "fifth", "sixth"]:
        if not data_off[rank] or not data_on[rank]:
            print(f"Skipping {rank} jet plot due to insufficient data in one of the datasets.")
            continue

        # Determine common binning based on global min and max
        global_min = min(min(data_off[rank]), min(data_on[rank]))
        global_max = max(max(data_off[rank]), max(data_on[rank]))
        common_bins = np.linspace(global_min, global_max, 51)

        overlay_data = {
            "Jet Matching OFF": data_off[rank],
            "Jet Matching ON": data_on[rank]
        }

        output_filename = (
            f"{output_dir.rstrip('/')}/overlay_ak4_jet_pt_comparison_{rank}{file_suffix}.png"
        )
        plot_overlay_histograms(
            overlay_data,
            xlabel="AK4 Jet pT (GeV)",
            title=f"{rank.capitalize()} recoGen AK4 Jet pT Distribution",
            filename=output_filename,
            bins=common_bins
        )

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generate overlay histograms comparing AK4 jet pT distributions from two datasets."
    )
    parser.add_argument(
        "--isolation",
        action="store_true",
        help="Apply jet isolation using ΔR < 0.4 (selects jets with no nearby RHadrons)."
    )
    args = parser.parse_args()
    main(args)
