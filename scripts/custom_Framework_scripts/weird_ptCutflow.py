#!/usr/bin/env python3
import os
import uproot
import awkward as ak
import numpy as np
import ROOT
import cmsstyle as CMS

ROOT.gROOT.SetBatch(True)
ROOT.TH1.SetDefaultSumw2(True)
ROOT.gStyle.SetOptStat(0)

CMS.SetExtraText("Private Work: MC Simulation")
CMS.SetLumi(None, run="Run 3")
CMS.SetEnergy(13.6)

year = 2024
GTAG = "150X_mcRun3_2024_realistic_v2"
era = "D"
tag = "MC"

# Trigger options:
# "HLT_FilterOR"
# "HLT_MET"
# "HLT_Mu"
trigger_masks = [
    "HLT_MET",
    "HLT_FilterOR",
]

samples = [
    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150",
    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA",
]

preselected_dir = "/uscms/home/avendras/nobackup/HSCP/scripts/custom_Framework_scripts/preselected_rootfiles"
plot_dir = "cutflow_plots"
os.makedirs(plot_dir, exist_ok=True)

cutflow_tree = "Cutflow"

def make_hist(name, title, values, nbins=120, xmin=0.0, xmax=3000.0):
    h = ROOT.TH1D(name, title, nbins, xmin, xmax)

    for x in values:
        h.Fill(float(x))

    h.GetXaxis().SetTitle("GEN diRHadron p_{T} [GeV]")
    h.GetYaxis().SetTitle("Events")
    h.SetLineWidth(2)
    return h

def get_branch_as_numpy(arrays, name):
    if name not in arrays.fields:
        raise KeyError(f"Missing branch in Cutflow tree: {name}")

    # Each branch was written as ak.Array([variable_length_numpy_array])
    # so the tree has one entry and we want that first entry.
    return ak.to_numpy(arrays[name][0])

def style_hist(h, color):
    h.SetLineColor(color)
    h.SetMarkerColor(color)
    h.SetLineWidth(2)

def draw_hist_collection(canvas, hists, labels, title, outname, logy=True,
                         legend_coords=(0.52, 0.62, 0.88, 0.88),
                         xline=150.0):
    canvas.cd()
    if logy:
        canvas.SetLogy()
    else:
        canvas.SetLogy(0)

    nonempty = [h for h in hists if h.GetMaximum() > 0]
    if not nonempty:
        print(f"[DEBUG] No non-empty histograms for {title}")
        return

    first_nonempty = nonempty[0]
    maxy = max(h.GetMaximum() for h in nonempty)

    first_nonempty.SetTitle(title)
    first_nonempty.SetMaximum(maxy * 2.0 if logy else maxy * 1.25)
    first_nonempty.SetMinimum(1e-1 if logy else 0.0)

    first_nonempty.Draw("hist")
    for h in hists:
        if h is first_nonempty:
            continue
        if h.GetMaximum() > 0:
            h.Draw("hist same")

    # Vertical line at x = 150 GeV
    ymin = 1e-1 if logy else 0.0
    ymax = maxy * 2.0 if logy else maxy * 1.25
    line150 = ROOT.TLine(xline, ymin, xline, ymax)
    line150.SetLineColor(ROOT.kBlack)
    line150.SetLineStyle(2)
    line150.SetLineWidth(2)
    line150.Draw("same")

    leg = ROOT.TLegend(*legend_coords)
    leg.SetBorderSize(0)
    leg.SetFillStyle(0)
    for h, label in zip(hists, labels):
        leg.AddEntry(h, label, "l")
    leg.Draw()

    canvas.SaveAs(outname)
def safe_get_branch(arrays, name):
    if name in arrays.fields:
        return ak.to_numpy(arrays[name][0])
    return np.asarray([], dtype=np.float64)

def process_one(sample_name, TriggerMask):
    input_file = (
        f"{preselected_dir}/"
        f"{sample_name}_{TriggerMask}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
    )

    output_png_main = (
        f"{plot_dir}/gen_dirhadron_cutflow_"
        f"{sample_name}_{TriggerMask}_{year}_{era}_{tag}_{GTAG}.png"
    )
    output_png_trg = (
        f"{plot_dir}/gen_dirhadron_trigger_breakdown_"
        f"{sample_name}_{TriggerMask}_{year}_{era}_{tag}_{GTAG}.png"
    )

    print("\n==================================================")
    print(f"[DEBUG] Sample       = {sample_name}")
    print(f"[DEBUG] TriggerMask  = {TriggerMask}")
    print(f"[DEBUG] Input file   = {input_file}")
    print("==================================================")

    if not os.path.exists(input_file):
        print(f"[WARN] Missing input file, skipping:")
        print(f"       {input_file}")
        return

    f = uproot.open(input_file)
    tree = f[cutflow_tree]
    arrays = tree.arrays(library="ak")

    # Main cutflow
    pt_gen_pair = get_branch_as_numpy(arrays, "pt_gen_pair")
    pt_gen_pair_event = get_branch_as_numpy(arrays, "pt_gen_pair_event")
    pt_gen_pair_event_reco = get_branch_as_numpy(arrays, "pt_gen_pair_event_reco")
    pt_gen_pair_event_reco_trigger = get_branch_as_numpy(arrays, "pt_gen_pair_event_reco_trigger")

    # Trigger breakdown branches
    pt_trg_PFMET120_PFMHT120_IDTight = safe_get_branch(arrays, "pt_trg_PFMET120_PFMHT120_IDTight")
    pt_trg_PFHT500_PFMET100_PFMHT100_IDTight = safe_get_branch(arrays, "pt_trg_PFHT500_PFMET100_PFMHT100_IDTight")
    pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = safe_get_branch(arrays, "pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60")
    pt_trg_MET105_IsoTrk50 = safe_get_branch(arrays, "pt_trg_MET105_IsoTrk50")
    pt_trg_HLT_FilterOR = safe_get_branch(arrays, "pt_trg_HLT_FilterOR")
    pt_trg_HLT_Mu50 = safe_get_branch(arrays, "pt_trg_HLT_Mu50")
    pt_trg_IsoMu24 = safe_get_branch(arrays, "pt_trg_IsoMu24")
    pt_trg_IsoMu27 = safe_get_branch(arrays, "pt_trg_IsoMu27")
    pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ = safe_get_branch(
        arrays, "pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ"
    )
    pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL = safe_get_branch(
        arrays, "pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL"
    )

    print(f"Reading: {input_file}")
    print("")
    print(f"{'pt_gen_pair':45s} = {len(pt_gen_pair)}")
    print(f"{'pt_gen_pair_event':45s} = {len(pt_gen_pair_event)}")
    print(f"{'pt_gen_pair_event_reco':45s} = {len(pt_gen_pair_event_reco)}")
    print(f"{'pt_gen_pair_event_reco_trigger':45s} = {len(pt_gen_pair_event_reco_trigger)}")
    print("")

    # Main cutflow
    main_defs = [
        ("gen_pair", pt_gen_pair, ROOT.kBlack),
        ("gen_pair + event", pt_gen_pair_event, ROOT.kBlue + 1),
        ("gen_pair + event + reco", pt_gen_pair_event_reco, ROOT.kGreen + 2),
        ("final preselection: gen_pair + event + reco + trigger", pt_gen_pair_event_reco_trigger, ROOT.kRed + 1),
    ]

    hists_main = []
    labels_main = []
    for name, values, color in main_defs:
        h = make_hist(
            name=f"h_{sample_name}_{TriggerMask}_{name.replace(' ', '_').replace('+', 'plus').replace(':', '')}",
            title=name,
            values=values,
            nbins=120,
            xmin=0.0,
            xmax=3000.0,
        )
        style_hist(h, color)
        hists_main.append(h)
        labels_main.append(f"{name} ({len(values)})")

    c_main = ROOT.TCanvas(f"c_main_{sample_name}_{TriggerMask}", "c_main", 1100, 800)
    draw_hist_collection(
        canvas=c_main,
        hists=hists_main,
        labels=labels_main,
        title=f"{sample_name}: GEN diRHadron p_{{T}} cutflow ({TriggerMask})",
        outname=output_png_main,
        logy=True,
        legend_coords=(0.48, 0.62, 0.88, 0.88),
    )

    # Trigger-specific breakdown
    if TriggerMask == "HLT_MET":
        trg_defs = [
            ("PFMET120_PFMHT120_IDTight", pt_trg_PFMET120_PFMHT120_IDTight, ROOT.kMagenta + 1),
            ("PFHT500_PFMET100_PFMHT100_IDTight", pt_trg_PFHT500_PFMET100_PFMHT100_IDTight, ROOT.kOrange + 7),
            ("PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60", pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60, ROOT.kCyan + 1),
            ("MET105_IsoTrk50", pt_trg_MET105_IsoTrk50, ROOT.kBlue + 2),
        ]
        trg_title = f"{sample_name}: MET trigger breakdown"

    elif TriggerMask == "HLT_FilterOR":
        trg_defs = [
            ("HLT_FilterOR", pt_trg_HLT_FilterOR, ROOT.kRed + 1),
        ]
        trg_title = f"{sample_name}: HLT_FilterOR breakdown"

    else:  # HLT_Mu
        trg_defs = [
            ("HLT_Mu50", pt_trg_HLT_Mu50, ROOT.kMagenta + 1),
            ("HLT_IsoMu24", pt_trg_IsoMu24, ROOT.kOrange + 7),
            ("HLT_IsoMu27", pt_trg_IsoMu27, ROOT.kCyan + 1),
            ("HLT_Mu8_TrkIsoVVL_Ele23...", pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ, ROOT.kBlue + 2),
            ("HLT_Mu23_TrkIsoVVL_Ele12...", pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL, ROOT.kGreen + 2),
        ]
        trg_title = f"{sample_name}: muon trigger breakdown"

    print(f"{'Trigger breakdown branches:':45s}")
    for name, values, _ in trg_defs:
        print(f"{name:45s} = {len(values)}")

    hists_trg = []
    labels_trg = []
    for name, values, color in trg_defs:
        h = make_hist(
            name=f"h_trg_{sample_name}_{TriggerMask}_{name.replace('/', '_')}",
            title=name,
            values=values,
            nbins=120,
            xmin=0.0,
            xmax=3000.0,
        )
        style_hist(h, color)
        hists_trg.append(h)
        labels_trg.append(f"{name} ({len(values)})")

    c_trg = ROOT.TCanvas(f"c_trg_{sample_name}_{TriggerMask}", "c_trg", 1100, 800)
    draw_hist_collection(
        canvas=c_trg,
        hists=hists_trg,
        labels=labels_trg,
        title=f"{trg_title} ({TriggerMask})",
        outname=output_png_trg,
        logy=True,
        legend_coords=(0.36, 0.58, 0.88, 0.88),
    )

    print("")
    print(f"Wrote: {output_png_main}")
    print(f"Wrote: {output_png_trg}")

if __name__ == "__main__":
    for sample_name in samples:
        for TriggerMask in trigger_masks:
            process_one(sample_name, TriggerMask)

    print("\n[DEBUG] Done.")