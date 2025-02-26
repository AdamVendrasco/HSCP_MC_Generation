import ROOT
import matplotlib.pyplot as plt
import mplhep as hep 
import matplotlib as mpl
import numpy as np  # Import numpy for creating common bin edges

# Apply CMS style and update rcParams for official CMS plots
hep.style.use("CMS")
mpl.rcParams['font.family'] = 'sans-serif'
mpl.rcParams['font.size'] = 12
mpl.rcParams['axes.labelsize'] = 12
mpl.rcParams['axes.titlesize'] = 12
mpl.rcParams['xtick.labelsize'] = 14
mpl.rcParams['ytick.labelsize'] = 14
mpl.rcParams['legend.fontsize'] = 14
mpl.rcParams['lines.linewidth'] = 2
mpl.rcParams['figure.figsize'] = (8, 6)

# ========================================
# Setup and ROOT File Initialization
# ========================================
OUTPUT_DIRECTORY = "/eos/home-a/avendras/mg-Rhadron/plot_archive/gen_RHadron_1800_JetMatching_ON/"
ROOT_FILE_PATH = "/eos/user/a/avendras/mg-Rhadron/mg-Rhadron_mGl-1800/root-files/mg-Rhadron_mGl-1800-CMSSW_12_4_8-n1000-Jet_matching_ON-test.root"
PLOT_IDENTIFIER = "JetMatching_ON"

f = ROOT.TFile.Open(ROOT_FILE_PATH)
tree = f.Get("Events")
n_entries = tree.GetEntries()
print("Total entries in tree:", n_entries)

# ========================================
# Functions for Inspection and Listing
# ========================================
def list_branches():
    """List all branches in the tree."""
    branches = tree.GetListOfBranches()
    print("\nList of branches in the tree:")
    for branch in branches:
        print(branch.GetName())

def inspect_gen_particles(event_index=0):
    """
    Debug: Inspection of reco::GenParticle.
    Prints the methods and attributes of the first gen particle in the event.
    """
    tree.GetEntry(event_index)
    gen_particles_wrapper = getattr(tree, "recoGenParticles_genParticles__GEN", None)
    if gen_particles_wrapper:
        gen_particles = gen_particles_wrapper.product()
        if gen_particles.size() > 0:
            first_gen = gen_particles.at(0)
            print("\nMethods and attributes of reco::GenParticle:")
            print(dir(first_gen))

def inspect_jet_branches():
    """
    Inspecting recoGenJets_ak4GenJets__GEN Branch Contents.
    Checks for both AK4 and AK8 jet branches.
    """
    ak4_branch = tree.GetBranch("recoGenJets_ak4GenJets__GEN.")
    if ak4_branch:
        print("\nFound branch using GetBranch:", ak4_branch.GetName())
    else:
        print("\nBranch recoGenJets_ak4GenJets__GEN not found using GetBranch.")

    ak8_branch = tree.GetBranch("recoGenJets_ak8GenJets__GEN.")
    if ak8_branch:
        print("Found branch using GetBranch:", ak8_branch.GetName())
    else:
        print("Branch recoGenJets_ak8GenJets__GEN not found using GetBranch.")

# Uncomment the following function to debug jet statuses for a given event
# def inspect_jet_statuses(event_index=0):
#     """
#     Debug function to print the pT and status of each AK4 and AK8 jet in a given event.
#     """
#     tree.GetEntry(event_index)
#     ak4jets_wrapper = getattr(tree, "recoGenJets_ak4GenJets__GEN", None)
#     if ak4jets_wrapper:
#         ak4jets = ak4jets_wrapper.product()
#         print(f"\nAK4 Jets in event {event_index}:")
#         for j in range(ak4jets.size()):
#             jet = ak4jets.at(j)
#             print(f"Jet {j}: pT = {jet.pt()}, status = {jet.status()}")
#     ak8jets_wrapper = getattr(tree, "recoGenJets_ak8GenJets__GEN", None)
#     if ak8jets_wrapper:
#         ak8jets = ak8jets_wrapper.product()
#         print(f"\nAK8 Jets in event {event_index}:")
#         for j in range(ak8jets.size()):
#             jet = ak8jets.at(j)
#             print(f"Jet {j}: pT = {jet.pt()}, status = {jet.status()}")

# for debugging
list_branches()
inspect_gen_particles()
inspect_jet_branches()

# ========================================
# Define Target RHadron pdgId Range
# ========================================
target_pdgIds = set(range(1000000, 1010000)) 

# ========================================
# Data Containers for Extraction
# ========================================
all_gen_pt = []       # All Gen RHadron pT values
all_gen_eta = []      # All Gen RHadron eta values
leading_gen_pt = []   # Leading Gen RHadron pT per event
leading_jet_pt_from_gen = []  # Leading jet pT from gen particles (using isJet flag)
leading_ak4_pt = []   # Leading AK4 jet pT from recoGenJets_ak4GenJets__GEN branch
leading_ak8_pt = []   # Leading AK8 jet pT from recoGenJets_ak8GenJets__GEN branch

# ========================================
# Extraction Functions
# ========================================
def extract_gen_particles(event_index):
    """
    Extracts leading gen particle pT for a given event (for target RHadrons).
    Also collects all gen particle pT and eta values.
    """
    tree.GetEntry(event_index)
    gen_particles_wrapper = getattr(tree, "recoGenParticles_genParticles__GEN", None)
    if not gen_particles_wrapper:
        return

    gen_particles = gen_particles_wrapper.product()
    if event_index % 100 == 0:
        print(f"Event {event_index} has {gen_particles.size()} gen particles")
    
    leading_pt = 0
    for j in range(gen_particles.size()):
        gen = gen_particles.at(j)
        # Check if the particle's pdgId code range for RHadrons
        if 1000600 <= abs(gen.pdgId()) <= 1100000 and gen.status() == 1:
            print(gen.pdgId())
            all_gen_pt.append(gen.pt())
            all_gen_eta.append(gen.eta())
            if gen.pt() > leading_pt:
                leading_pt = gen.pt()
    if leading_pt > 0:
        leading_gen_pt.append(leading_pt)

def extract_leading_jet_pt_from_gen(event_index):
    """
    Extracts the leading jet pT from gen particles marked as jets (isJet() == True)
    in a given event.
    """
    tree.GetEntry(event_index)
    gen_particles_wrapper = getattr(tree, "recoGenParticles_genParticles__GEN", None)
    if not gen_particles_wrapper:
        return

    gen_particles = gen_particles_wrapper.product()
    max_pt = 0
    for j in range(gen_particles.size()):
        gen = gen_particles.at(j)
        if gen.isJet() and gen.pt() > max_pt:
            max_pt = gen.pt()
    if max_pt > 0:
        leading_jet_pt_from_gen.append(max_pt)

def extract_leading_ak4_pt(event_index):
    """
    Extracts the leading AK4 jet pT from the recoGenJets_ak4GenJets__GEN branch.
    Note: The 'jet.status() == 1' condition has been removed to avoid filtering out valid jets.
    """
    tree.GetEntry(event_index)
    ak4jets_wrapper = getattr(tree, "recoGenJets_ak4GenJets__GEN", None)
    if not ak4jets_wrapper:
        return
    ak4jets = ak4jets_wrapper.product()
    if ak4jets.size() == 0:
        return
    max_pt = 0.0
    for j in range(ak4jets.size()):
        jet = ak4jets.at(j)
        # Removed the jet.status() check here
        if jet.pt() > max_pt:
            max_pt = jet.pt()
    if max_pt > 0:
        leading_ak4_pt.append(max_pt)

def extract_leading_ak8_pt(event_index):
    """
    Extracts the leading AK8 jet pT from the recoGenJets_ak8GenJets__GEN branch.
    """
    tree.GetEntry(event_index)
    ak8jets_wrapper = getattr(tree, "recoGenJets_ak8GenJets__GEN", None)
    if not ak8jets_wrapper:
        return
    ak8jets = ak8jets_wrapper.product()
    if ak8jets.size() == 0:
        return
    max_pt = 0.0
    for j in range(ak8jets.size()):
        jet = ak8jets.at(j)
        if jet.pt() > max_pt:
            max_pt = jet.pt()
    if max_pt > 0:
        leading_ak8_pt.append(max_pt)

def process_events():
    """Process each event to extract all RHadron and jet information."""
    for i in range(n_entries):
        extract_gen_particles(i)
        extract_leading_jet_pt_from_gen(i)
        extract_leading_ak4_pt(i)
        extract_leading_ak8_pt(i)

# ========================================
# Plotting Functions
# ========================================
def plot_histogram(data, xlabel, title, filename, bins=20, x_range=None, color="red"):
    """Generates and saves a histogram for a given dataset."""
    plt.clf()
    plt.figure(figsize=(8, 6))
    plt.hist(data, bins=bins, histtype="step", color=color)
    if x_range is not None:
        plt.xlim(x_range)
    plt.xlabel(xlabel)
    plt.ylabel("Counts")
    plt.title(title)
    plt.yscale("log")
    if xlabel == "Gen RHadron Eta":
        plt.ylim(1, max(plt.ylim()[1], 1e6))
    
    base, ext = filename.rsplit('.', 1)
    final_filename = f"{base}_{PLOT_IDENTIFIER}.{ext}"
    plt.savefig(f"{OUTPUT_DIRECTORY}{final_filename}")
    print(f"Histogram saved as {final_filename}")
    plt.close()

def plot_overlay_histograms(data_dict, xlabel, title, filename, bins=50, x_range=None):
    """
    Generates and saves an overlay of histograms for multiple datasets.
    If bins is given as an integer, compute common bin edges across all datasets.
    """
    plt.clf()
    plt.figure(figsize=(8, 6))
    
    # Compute common bins if an integer is provided
    if isinstance(bins, int):
        # Ensure that each dataset is non-empty before computing global min/max
        non_empty_data = [data for data in data_dict.values() if len(data) > 0]
        if non_empty_data:
            global_min = min(min(data) for data in non_empty_data)
            global_max = max(max(data) for data in non_empty_data)
            common_bins = np.linspace(global_min, global_max, bins + 1)
        else:
            common_bins = bins
    else:
        common_bins = bins

    for label, data in data_dict.items():
        plt.hist(data, bins=common_bins, histtype="step", label=label)
    if x_range is not None:
        plt.xlim(x_range)
    plt.xlabel(xlabel)
    plt.ylabel("Counts")
    plt.title(title)
    plt.yscale("log")
    if xlabel == "Gen RHadron Eta":
        plt.ylim(1, max(plt.ylim()[1], 1e6))
    plt.legend()

    # Modify the filename to include the identifier.
    base, ext = filename.rsplit('.', 1)
    final_filename = f"{base}_{PLOT_IDENTIFIER}.{ext}"
    plt.savefig(f"{OUTPUT_DIRECTORY}{final_filename}")
    print(f"Overlay histogram saved as {final_filename}")
    plt.close()

def plot_all_histograms():
    """Plot all the histograms as required."""
    # ========================================
    # Plotting RHadron pT Distributions
    # ========================================
    overlay_data = {
        "Leading Gen RHadron pT": leading_gen_pt,
        "All Gen RHadron pT": all_gen_pt,
    }
    plot_overlay_histograms(
        overlay_data,
        xlabel="Gen RHadron pT (GeV)",
        title="Overlay of Leading and All Gen_1800_RHadron pT Distributions",
        filename="overlay_gen_RHadron_pt_histogram.png",
        bins=50
    )

    hist_params = {
        "leading_pt": {
            "xlabel": "Leading Gen_1800_RHadron pT (GeV)",
            "title": "Leading Gen_1800_RHadron pT Distribution",
            "filename": "leading_gen_RHadron_pt_histogram.png",
            "bins": 50,
            "color": "blue"
        },
        "all_pt": {
            "xlabel": "All Gen_1800_RHadron pT (GeV)",
            "title": "All Gen_1800_RHadron pT Distribution",
            "filename": "all_gen_RHadron_pt_histogram.png",
            "bins": 50,
            "color": "orange"
        },
        "all_gen_eta": {
            "xlabel": "All Gen_1800_RHadron Eta",
            "title": "All 1800_Gen_RHadron Eta",
            "filename": "gen_RHadron_eta_histogram.png",
            "bins": 50,
            "color": "orange"
        }  
    }
    gen_particle_data = {
        "leading_pt": leading_gen_pt,
        "all_pt": all_gen_pt,
        "all_gen_eta": all_gen_eta  
    }
    for key, params in hist_params.items():
        plot_histogram(
            gen_particle_data[key],
            xlabel=params["xlabel"],
            title=params["title"],
            filename=params["filename"],
            bins=params["bins"],
            color=params["color"]
        )

    # ========================================
    # Plotting Leading AK4 Jet pT Distribution
    # ========================================
    plot_histogram(
        leading_ak4_pt,
        xlabel="Leading AK4 Jet pT (GeV)",
        title="Leading recoGen AK4 Jet pT Distribution",
        filename="leading_ak4_jet_pt_histogram.png",
        bins=50,
        color="blue"
    )

    # ========================================
    # Plotting Leading AK8 Jet pT Distribution
    # ========================================
    plot_histogram(
        leading_ak8_pt,
        xlabel="Leading AK8 Jet pT (GeV)",
        title="Leading recoGen AK8 Jet pT Distribution",
        filename="leading_ak8_jet_pt_histogram.png",
        bins=50,
        color="orange"
    )

    # ========================================
    # Plotting Overlay of Leading AK4 and AK8 Jet pT Distributions
    # ========================================
    overlay_ak_jets = {
        "Leading AK4 Jet": leading_ak4_pt,
        "Leading AK8 Jet": leading_ak8_pt
    }
    plot_overlay_histograms(
        overlay_ak_jets,
        xlabel="Jet pT (GeV)",
        title="Overlay of Leading recoGen AK4 and AK8 Jet pT Distributions",
        filename="overlay_leading_ak4_ak8_jet_pt_histogram.png",
        bins=50
    )

# ========================================
# Main Execution Block
# ========================================
if __name__ == "__main__":
    # Process each event to extract RHadron and jet information
    process_events()
    
    print(f"\nExtracted leading jet (from gen particles) pT for {len(leading_jet_pt_from_gen)} events.")
    print(f"\nExtracted leading AK4 jet pT for {len(leading_ak4_pt)} events.")
    print(f"\nExtracted leading AK8 jet pT for {len(leading_ak8_pt)} events.")
    
    # Generate and save all histograms
    plot_all_histograms()
