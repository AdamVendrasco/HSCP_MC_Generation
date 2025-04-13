import ROOT
import matplotlib.pyplot as plt
import mplhep as hep
import matplotlib as mpl
import numpy as np

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

def extract_top3_ak4_pt_from_file(root_file_path):
    """
    Extract the leading, second, and third AK4 jet pT values from each event in a ROOT file.

    The function:
      - Reads the "Events" tree and retrieves the jet collection stored as
        "recoGenJets_ak4GenJets__GEN".
      - Additionally, for each event, it extracts generated particle information
        (pt, eta, phi) for RHadrons with pdgId between 1000600 and 1100000 (status==1)
        for debugging purposes.
      - Collects all jet pT values, sorts them in descending order, and records the
        top three values (if available).

    Args:
        root_file_path: Path to the ROOT file.

    Returns:
        dict: Dictionary with keys "leading", "second", and "third" containing lists of jet pT values.
    """
    f = ROOT.TFile.Open(root_file_path)
    tree = f.Get("Events")
    n_entries = tree.GetEntries()
    
    count = 0     # Debug counter
    
    leading, second, third    = [], [], []
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
            for j in range(gen_particles.size()):
                gen = gen_particles.at(j)
                #extract Rhadron infomration if the gen_particle is in the pdgid range
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

        # Sort jet pT values in descending order and record the top three
        jet_pts.sort(reverse=True)
        if len(jet_pts) >= 1:
            leading.append(jet_pts[0])
        if len(jet_pts) >= 2:
            second.append(jet_pts[1])
        if len(jet_pts) >= 3:
            third.append(jet_pts[2])

    return {"leading": leading, "second": second, "third": third}


def plot_overlay_histograms(data_dict, xlabel, title, filename, bins, x_range=None):
    """
    Generate and save an overlay histogram from multiple datasets using common bins.

    Args:
        data_dict (dict): Dictionary with keys as labels and values as lists of data points.
            - xlabel (str): Label for the x-axis.
            - title (str): Plot title.
            - filename (str): Path to save the output plot.
            - bins (array-like): Bin edges to be used for all histograms.
            - x_range (tuple, optional): x-axis limits (min, max). Defaults to None.
    """
    plt.figure(figsize=(8, 6))
    for label, data in data_dict.items():
        plt.hist(data, bins=bins, histtype="step", label=label)

    if x_range is not None:
        plt.xlim(x_range)
    plt.xlabel(xlabel)
    plt.ylabel("Counts")
    plt.title(title)
    plt.yscale("log")
    plt.legend()
    plt.savefig(filename)
    print(f"Overlay histogram saved as {filename}")
    plt.close()


def main():
    file_off = (
        "/eos/user/a/avendras/mg-Rhadron/mg-Rhadron_mGl-1800/"
        "root-files/mg-Rhadron_mGl-1800-CMSSW_12_4_8-n1000-Jet_matching_OFF-test.root"
    )
    file_on = (
        "/eos/user/a/avendras/mg-Rhadron/mg-Rhadron_mGl-1800/"
        "root-files/mg-Rhadron_mGl-1800-CMSSW_12_4_8-n1000-Jet_matching_ON-test.root"
    )

    # Extract the top three jet pT values for both datasets
    data_off = extract_top3_ak4_pt_from_file(file_off)
    data_on = extract_top3_ak4_pt_from_file(file_on)

    # Loop over the three jet "ranks" and generate overlay histograms for each
    for rank in ["leading", "second", "third"]:
        if not data_off[rank] or not data_on[rank]:
            print(f"Skipping {rank} jet plot due to insufficient data in one of the datasets.")
            continue

        global_min = min(min(data_off[rank]), min(data_on[rank]))
        global_max = max(max(data_off[rank]), max(data_on[rank]))
        common_bins = np.linspace(global_min, global_max, 21)

        overlay_data = {
            "Jet Matching OFF": data_off[rank],
            "Jet Matching ON": data_on[rank]
        }

        output_filename = (
            f"/eos/user/a/avendras/mg-Rhadron/plot_archive/gen_RHadron_1800_JetMatcing_ONandOFF/"
            f"overlay_ak4_jet_pt_comparison_{rank}.png"
        )

        plot_overlay_histograms(
            overlay_data,
            xlabel="AK4 Jet pT (GeV)",
            title=f"{rank.capitalize()} recoGen AK4 Jet pT Distribution",
            filename=output_filename,
            bins=common_bins
        )


if __name__ == "__main__":
    main()
