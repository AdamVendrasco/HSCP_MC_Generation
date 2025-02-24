import ROOT
import matplotlib.pyplot as plt
import mplhep as hep  
import matplotlib as mpl
import numpy as np  # Import numpy for creating common bin edges

hep.style.use("CMS")
mpl.rcParams['font.family'] = 'sans-serif'
mpl.rcParams['font.size'] = 14
mpl.rcParams['axes.labelsize'] = 14
mpl.rcParams['axes.titlesize'] = 14
mpl.rcParams['xtick.labelsize'] = 14
mpl.rcParams['ytick.labelsize'] = 14
mpl.rcParams['legend.fontsize'] = 14
mpl.rcParams['lines.linewidth'] = 2
mpl.rcParams['figure.figsize'] = (8, 6)

def extract_leading_ak4_pt_from_file(root_file_path):
    """
    Extracts the leading AK4 jet pT (only jets with status == 1) from a given ROOT file.
    Returns a list of leading pT values, one per event.
    """
    f = ROOT.TFile.Open(root_file_path)
    tree = f.Get("Events")
    n_entries = tree.GetEntries()
    leading_ak4_pt = []
    for i in range(n_entries):
        tree.GetEntry(i)
        ak4jets_wrapper = getattr(tree, "recoGenJets_ak4GenJets__GEN", None)
        if not ak4jets_wrapper:
            continue
        ak4jets = ak4jets_wrapper.product()
        if ak4jets.size() == 0:
            continue
        max_pt = 0.0
        for j in range(ak4jets.size()):
            jet = ak4jets.at(j)
            if jet.pt() > max_pt:
                max_pt = jet.pt()
        if max_pt > 0:
            leading_ak4_pt.append(max_pt)
    return leading_ak4_pt

def plot_overlay_histograms(data_dict, xlabel, title, filename, bins, x_range=None):
    """
    Generates and saves an overlay histogram from multiple datasets using common bins.
    """
    plt.clf()
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

file_off = "/eos/user/a/avendras/mg-Rhadron/mg-Rhadron_mGl-1800/root-files/mg-Rhadron_mGl-1800-CMSSW_12_4_8-n1000-Jet_matching_OFF-test.root"
file_on  = "/eos/user/a/avendras/mg-Rhadron/mg-Rhadron_mGl-1800/root-files/mg-Rhadron_mGl-1800-CMSSW_12_4_8-n1000-Jet_matching_ON-test.root"

leading_ak4_off = extract_leading_ak4_pt_from_file(file_off)
leading_ak4_on  = extract_leading_ak4_pt_from_file(file_on)

# Determine the global minimum and maximum pT values from both datasets
global_min = min(min(leading_ak4_off), min(leading_ak4_on))
global_max = max(max(leading_ak4_off), max(leading_ak4_on))

# Create a fixed array of bin edges for 20 bins (requires 21 edges)
common_bins = np.linspace(global_min, global_max, 21)

overlay_data = {
    "Jet Matching OFF": leading_ak4_off,
    "Jet Matching ON":  leading_ak4_on
}

output_filename = "/eos/user/a/avendras/mg-Rhadron/plot_archive/gen_RHadron_1800_JetMatcing_ONandOFF/overlay_leading_ak4_jet_pt_comparison.png"

plot_overlay_histograms(
    overlay_data,
    xlabel="Leading AK4 Jet pT (GeV)",
    title="Leading recoGen AK4 Jet pT Distribution",
    filename=output_filename,
    bins=common_bins
)
