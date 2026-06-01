#!/usr/bin/env python3
import os
import ROOT
import uproot
import awkward as ak
import numpy as np
import cmsstyle as CMS

ROOT.gROOT.SetBatch(True)
ROOT.TH1.SetDefaultSumw2(True)
ROOT.gStyle.SetOptStat(0)

SAMPLE_SETS = {
    "Gluino": {
        "mass_point": 1800,
        "overall_label": "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV",       
        "sample_1": {
            "name": "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8",
            "label": "Pythia8: Preselection + Trigger",
        },
         "sample_2": {
            "name": "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut40_qcut60_PTJ20_NoDupCheck",
            "label": "MG5 PTJ 20 (No Bug): Preselection + Trigger",
        },
           
    
    },


    # "gluino_2600": {
    #     "mass_point": 2600,
    #     "overall_label": "HSCP-Gluino_Par-M-2600_TuneCP5_13p6TeV",
    #     "sample_1": {
    #         "name": "HSCP-Gluino_Par-M-2600_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150",
    #         "label": "MadGraph5",
    #     },
    #     "sample_2": {
    #         "name": "HSCP-Gluino_Par-M-2600_TuneCP5_13p6TeV_pythia8_xqcutNA",
    #         "label": "Pythia8",
    #     },
    # },
}

sample = "Gluino"
active_samples = SAMPLE_SETS[sample]

mass_point = active_samples["mass_point"]
sample_type = sample.split("_")[0]
overall_label = active_samples["overall_label"]

sample_name_1 = active_samples["sample_1"]["name"]
sample_name_2 = active_samples["sample_2"]["name"]

label_1 = active_samples["sample_1"]["label"]
label_2 = active_samples["sample_2"]["label"]

year = 2024
GTAG = "150X_mcRun3_2024_realistic_v2"
era = "D"
tag = "TestMC"

trigger_masks = [
    "HLT_MET",
    "HLT_FilterOR",
    "HLT_Mu",
]

preselected_dir = "/uscms/home/avendras/nobackup/HSCP/scripts/custom_Framework_scripts/preselected_rootfiles"
tree_path = "Events"

plot_config = {
    "GEN_LeadingRHadron_pt":   (150, 0.0, 4000.0, "Leading GEN RHadron p_{T} [GeV]"),
    "GEN_LeadingRHadron_eta":  (100, -5.0, 5.0, "Leading GEN RHadron #eta"),
    "GEN_LeadingRHadron_phi":  (100, -4.0, 4.0, "Leading GEN RHadron #phi"),
    "GEN_LeadingRHadron_mass": (100, 0.0, 5000.0, "Leading GEN RHadron mass [GeV]"),

    "GEN_SubleadingRHadron_pt":   (150, 0.0, 4000.0, "Subleading GEN RHadron p_{T} [GeV]"),
    "GEN_SubleadingRHadron_eta":  (100, -5.0, 5.0, "Subleading GEN RHadron #eta"),
    "GEN_SubleadingRHadron_phi":  (100, -4.0, 4.0, "Subleading GEN RHadron #phi"),
    "GEN_SubleadingRHadron_mass": (60, 0.0, 5000.0, "Subleading GEN RHadron mass [GeV]"),

    "GEN_diRHadron_pt":   (150, 0.0, 2500.0, "GEN diRHadron p_{T} [GeV]"),
    "GEN_diRHadron_eta":  (100, -5.0, 5.0, "GEN diRHadron #eta"),
    "GEN_diRHadron_phi":  (100, -4.0, 4.0, "GEN diRHadron #phi"),
    "GEN_diRHadron_mass": (60, 2000.0, 5000.0, "GEN diRHadron mass [GeV]"),

    "IsoTrack_pt": (150, 0.0, 4000.0, "IsoTrack p_{T} [GeV]"),
    "IsoTrack_eta": (100, -5.0, 5.0, "IsoTrack #eta"),
    "IsoTrack_numberOfValidPixelHits": (20, 0.0, 20.0, "IsoTrack number of valid pixel hits"),
    "IsoTrack_fractionOfValidHits": (110, 0.0, 1.1, "IsoTrack fraction of valid hits"),
    "IsoTrack_numberOfValidHits": (50, 0.0, 50.0, "IsoTrack number of valid hits"),
    "IsoTrack_normChi2": (100, 0.0, 10.0, "IsoTrack norm #chi^{2}"),
    "IsoTrack_dz": (100, -0.5, 0.5, "IsoTrack d_{z}"),
    "IsoTrack_dxy": (100, -0.1, 0.1, "IsoTrack d_{xy}"),
    "IsoTrack_pfEnergyOverP": (100, 0.0, 1.0, "IsoTrack PF energy / p"),
    "IsoTrack_ptErrOverPt": (100, 0.0, 2.0, "IsoTrack p_{T} err / p_{T}"),
    "IsoTrack_ptErrOverPt2": (100, 0.0, 0.002, "IsoTrack p_{T}^{2} err / p_{T}^{2}"),
    "DeDx_IhNoL1": (100, 0.0, 10.0, "dE/dx I_{h}"),
    "RecoPFMET": (100, 0.0, 4000.0, "Reco PF MET [GeV]"),
    "HLTPFMET": (100, 0.0, 4000.0, "HLT PF MET [GeV]"),
    "PseudoMET_viaCaloJets": (100, 0.0, 1000.0, "Pseudo MET via Calo Jets [GeV]"),
}

CMS_IPOS = 0
def set_cms_style():
    CMS.SetExtraText(f"Private Work: {mass_point} {sample_type} MC Simulation")
    CMS.SetLumi(None, run="Run 3")
    CMS.SetEnergy(13.6)

def load_arrays(root_file, branches):
    with uproot.open(root_file) as f:
        if tree_path not in f:
            print(f"[SKIP] No '{tree_path}' tree in {root_file} (cutflow-only file)")
            return None
        arrays = f[tree_path].arrays(branches + ["reco_candidate_mask"], library="ak")
        mask = arrays["reco_candidate_mask"]
        for b in branches:
            if arrays[b].ndim > 1:  # jagged per-track branch
                arrays[b] = arrays[b][mask]
        return arrays

def clean_values(arr):
    if isinstance(arr, ak.Array):
        arr = ak.flatten(arr, axis=None)
        arr = ak.to_numpy(arr)
    else:
        arr = np.asarray(arr)

    if arr.size == 0:
        return np.asarray([], dtype=np.float64)

    arr = arr[np.isfinite(arr)]
    return arr.astype(np.float64, copy=False)

def make_hist(name, values, nbins, xmin, xmax, color):
    hist = ROOT.TH1F(f"{name}_{ROOT.TUUID().AsString()}", "", nbins, xmin, xmax)
    hist.SetDirectory(0)

    for x in values:
        hist.Fill(float(x))

    hist.SetLineWidth(2)
    hist.SetLineColor(color)
    hist.SetFillStyle(0)
    hist.SetFillColor(0)
    hist.SetMarkerStyle(0)
    hist.SetMarkerColor(0)
    return hist

def should_use_logy(branch):
    return branch in (
        "GEN_diRHadron_pt",
        "GEN_LeadingRHadron_pt",
        "GEN_SubleadingRHadron_pt",
        "IsoTrack_pt",
    )

def get_vline(branch):
    if branch in (
        "GEN_diRHadron_pt",
        "GEN_LeadingRHadron_pt",
        "GEN_SubleadingRHadron_pt",
        "IsoTrack_pt",
    ):
        return 150.0
    return None

def draw_single(name, xmin, xmax, hist, xtitle, ytitle, outpng, logy=False, ymin_log=0.1, vline_x=None):
    ymax = max(hist.GetMaximum(), 1.0) * (10.0 if logy else 1.35)
    ymin = ymin_log if logy else 0.0

    canv = CMS.cmsCanvas(name, xmin, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=CMS_IPOS)

    if logy:
        canv.SetLogy(True)
        hist.SetMinimum(ymin_log)

    frame = CMS.GetCmsCanvasHist(canv)
    frame.GetXaxis().SetTitleSize(0.045)
    frame.GetYaxis().SetTitleSize(0.045)
    frame.GetXaxis().SetLabelSize(0.040)
    frame.GetYaxis().SetLabelSize(0.040)
    frame.GetYaxis().SetTitleOffset(1.2)

    canv.Modified()
    canv.Update()

    CMS.cmsDraw(hist, "HIST", lwidth=2, lcolor=hist.GetLineColor(), fstyle=0)

    if vline_x is not None:
        y1 = ymin_log if logy else 0.0
        y2 = max(hist.GetMaximum(), 1.0) * (3.0 if logy else 1.05)
        line = ROOT.TLine(vline_x, y1, vline_x, y2)
        line.SetLineStyle(ROOT.kDashed)
        line.SetLineWidth(2)
        line.SetLineColor(ROOT.kRed + 1)
        line.Draw("SAME")

    canv.SaveAs(outpng)

def draw_comparison_with_ratio(
    name, xmin, xmax, hist1, hist2, xtitle, ytitle, outpng,
    label1, label2, logy=False, ymin_log=1e-4,
    normalize=False, ratio_ymin=0.0, ratio_ymax=2.0, vline_x=None, ratio_label=None):
    set_cms_style()
    h1 = hist1.Clone(f"{name}_h1")
    h2 = hist2.Clone(f"{name}_h2")
    h1.SetDirectory(0)
    h2.SetDirectory(0)

    if normalize:
        int1 = h1.Integral(0, h1.GetNbinsX() + 1)
        int2 = h2.Integral(0, h2.GetNbinsX() + 1)
        if int1 > 0:
            h1.Scale(1.0 / int1)
        if int2 > 0:
            h2.Scale(1.0 / int2)

    ymax = max(h1.GetMaximum(), h2.GetMaximum(), 1e-12) * (10.0 if logy else 1.35)
    ymin = ymin_log if logy else 0.0

    canv = ROOT.TCanvas(name, "", 800, 800)
    canv.cd()

    top = ROOT.TPad(f"{name}_top", "", 0.0, 0.30, 1.0, 1.0)
    bot = ROOT.TPad(f"{name}_bot", "", 0.0, 0.00, 1.0, 0.30)

    top.SetTopMargin(0.08)
    top.SetBottomMargin(0.02)
    bot.SetTopMargin(0.02)
    bot.SetBottomMargin(0.35)

    if logy:
        top.SetLogy(True)
        h1.SetMinimum(ymin_log)
        h2.SetMinimum(ymin_log)

    top.Draw()
    bot.Draw()

    top.cd()

    frame = h1.Clone(f"{name}_frame")
    frame.Reset("ICES")
    frame.SetMinimum(ymin)
    frame.SetMaximum(ymax)
    frame.GetXaxis().SetLabelSize(0)
    frame.GetXaxis().SetTitleSize(0)
    frame.GetYaxis().SetTitle(ytitle)
    frame.GetYaxis().SetTitleSize(0.045)
    frame.GetYaxis().SetLabelSize(0.040)
    frame.GetYaxis().SetTitleOffset(1.3)
    frame.Draw("AXIS")

    CMS.cmsDraw(h1, "HIST", lwidth=2, lcolor=ROOT.kBlue + 1, fstyle=0)
    CMS.cmsDraw(h2, "HIST SAME", lwidth=2, lstyle=ROOT.kDashed, lcolor=ROOT.kRed + 1, fstyle=0)

    if vline_x is not None:
        y1 = ymin_log if logy else 0.0
        y2 = max(h1.GetMaximum(), h2.GetMaximum(), 1.0) * (3.0 if logy else 1.05)
        line_top = ROOT.TLine(vline_x, y1, vline_x, y2)
        line_top.SetLineStyle(ROOT.kDashed)
        line_top.SetLineWidth(2)
        line_top.SetLineColor(ROOT.kBlack)
        line_top.Draw("SAME")

    leg = CMS.cmsLeg(0.55, 0.75, 0.88, 0.88, textSize=0.035)
    leg.AddEntry(h1, label1, "l")
    leg.AddEntry(h2, label2, "l")
    leg.Draw()

    top.Modified()
    top.Update()
    bot.cd()

    ratio = h1.Clone(f"{name}_ratio")
    ratio.Reset("ICES")
    ratio.SetStats(0)
    ratio.SetMarkerStyle(20)
    ratio.SetMarkerSize(0.9)
    ratio.SetMarkerColor(ROOT.kBlack)
    ratio.SetLineColor(ROOT.kBlack)
    ratio.SetLineWidth(1)

    for i in range(1, h1.GetNbinsX() + 1):
        a = h1.GetBinContent(i)
        ea = h1.GetBinError(i)
        b = h2.GetBinContent(i)
        eb = h2.GetBinError(i)

        if a == 0 and b == 0:
            continue

        if b > 0:
            r = a / b
            dr = r * ((ea / a) ** 2 + (eb / b) ** 2) ** 0.5 if a > 0 else r * (eb / b)
            ratio.SetBinContent(i, r)
            ratio.SetBinError(i, dr)

    ratio.SetMinimum(min(ratio_ymin, -0.05))
    ratio.SetMaximum(ratio_ymax)
    ratio.GetYaxis().SetTitle(ratio_label if ratio_label is not None else f"{label1}/{label2}")
    ratio.GetYaxis().SetNdivisions(505)
    ratio.GetYaxis().SetTitleSize(0.11)
    ratio.GetYaxis().SetLabelSize(0.10)
    ratio.GetYaxis().SetTitleOffset(0.50)
    ratio.GetXaxis().SetTitle(xtitle)
    ratio.GetXaxis().SetTitleSize(0.13)
    ratio.GetXaxis().SetLabelSize(0.12)
    ratio.GetXaxis().SetTitleOffset(1.0)
    ratio.Draw("E1P")

    line = ROOT.TLine(xmin, 1.0, xmax, 1.0)
    line.SetLineStyle(ROOT.kDashed)
    line.SetLineWidth(2)
    line.SetLineColor(ROOT.kBlack)
    line.Draw("SAME")

    if vline_x is not None:
        line_ratio = ROOT.TLine(vline_x, ratio.GetMinimum(), vline_x, ratio_ymax)
        line_ratio.SetLineStyle(ROOT.kDashed)
        line_ratio.SetLineWidth(2)
        line_ratio.SetLineColor(ROOT.kBlack)
        line_ratio.Draw("SAME")

    bot.Modified()
    bot.Update()

    canv.SaveAs(outpng)

def make_input_file(sample_name, trigger_mask):
    return (
        f"{preselected_dir}/"
        f"{sample_name}_{trigger_mask}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
    )

def make_individual_plots(sample_name, input_file, output_dir):
    print(f"\n[DEBUG] Processing sample: {sample_name}")
    print(f"[DEBUG] Input file: {input_file}")

    os.makedirs(output_dir, exist_ok=True)

    set_cms_style()
    arrays = load_arrays(input_file, list(plot_config.keys()))
    if arrays is None:
        return None
    cleaned = {}

    for branch, (nbins, xmin, xmax, xtitle) in plot_config.items():
        values = clean_values(arrays[branch])
        cleaned[branch] = values

        print(f"[DEBUG] {branch}: {len(values)} entries")
        if get_vline(branch) is not None:
            total = len(values)
            if total == 0:
                print(f"[DEBUG] {sample_name} | {branch}: no entries")
            else:
                below = np.count_nonzero(values < get_vline(branch))
                frac = below / total
                print(
                    f"[DEBUG] {sample_name} | {branch}: "
                    f"{below}/{total} below {get_vline(branch):.1f} GeV "
                    f"= {frac:.6f} ({100.0*frac:.2f}%)"
                )
        hist = make_hist(branch, values, nbins, xmin, xmax, ROOT.kBlue + 1)

        outpng = os.path.join(output_dir, f"{branch}.png")

        draw_single(
            name=f"c_{branch}_{sample_name}",
            xmin=xmin,
            xmax=xmax,
            hist=hist,
            xtitle=xtitle,
            ytitle="Events",
            outpng=outpng,
            logy=should_use_logy(branch),
            vline_x=get_vline(branch),
        )

    return cleaned

def make_comparison_plots(cleaned1, cleaned2, sample_name_1, sample_name_2, output_dir, label1, label2):
    os.makedirs(output_dir, exist_ok=True)
    set_cms_style()
    for branch, (nbins, xmin, xmax, xtitle) in plot_config.items():
        hist1_counts = make_hist(f"{branch}_1_counts", cleaned1[branch], nbins, xmin, xmax, ROOT.kBlue + 1)
        hist2_counts = make_hist(f"{branch}_2_counts", cleaned2[branch], nbins, xmin, xmax, ROOT.kRed + 1)

        outpng_counts = os.path.join(output_dir, f"{branch}_comparison_counts_ratio.png")

        draw_comparison_with_ratio(
            name=f"compare_counts_{branch}",
            xmin=xmin,
            xmax=xmax,
            hist1=hist1_counts,
            hist2=hist2_counts,
            xtitle=xtitle,
            ytitle="Events",
            outpng=outpng_counts,
            label1=label1,
            label2=label2,
            logy=should_use_logy(branch),
            normalize=False,
            vline_x=get_vline(branch),
            ratio_label="Pythia8/MG5 (No Bug)"
        )

        hist1_shape = make_hist(f"{branch}_1_shape", cleaned1[branch], nbins, xmin, xmax, ROOT.kBlue + 1)
        hist2_shape = make_hist(f"{branch}_2_shape", cleaned2[branch], nbins, xmin, xmax, ROOT.kRed + 1)

        outpng_shape = os.path.join(output_dir, f"{branch}_comparison_shape_ratio-Normto1.png")

        draw_comparison_with_ratio(
            name=f"compare_shape_{branch}",
            xmin=xmin,
            xmax=xmax,
            hist1=hist1_shape,
            hist2=hist2_shape,
            xtitle=xtitle,
            ytitle="Normalized Events",
            outpng=outpng_shape,
            label1=label1,
            label2=label2,
            logy=should_use_logy(branch),
            normalize=True,
            vline_x=get_vline(branch),
            ratio_label="Pythia8/MG5 (No Bug)"
        )

def main():
    base_output_dir = f"plots/Pythia+MG5/{overall_label}_NoBug_Pythia"

    for trigger_mask in trigger_masks:
        print("\n" + "=" * 80)
        print(f"[DEBUG] TriggerMask = {trigger_mask}")
        print("=" * 80)

        input_file_1 = make_input_file(sample_name_1, trigger_mask)
        input_file_2 = make_input_file(sample_name_2, trigger_mask)

        trigger_dir = os.path.join(base_output_dir, trigger_mask)
        os.makedirs(trigger_dir, exist_ok=True)

        sample1_dir = os.path.join(
            trigger_dir,
            f"{sample_name_1}_{trigger_mask}_{year}_{era}_{tag}_{GTAG}_preselected_events"
        )
        sample2_dir = os.path.join(
            trigger_dir,
            f"{sample_name_2}_{trigger_mask}_{year}_{era}_{tag}_{GTAG}_preselected_events"
        )
        comparison_dir = os.path.join(
            trigger_dir,
            f"comparisons_{overall_label}_{trigger_mask}_{year}_{era}_{tag}_{GTAG}_preselected_events"
        )

        cleaned1 = make_individual_plots(sample_name_1, input_file_1, sample1_dir)
        cleaned2 = make_individual_plots(sample_name_2, input_file_2, sample2_dir)

        if cleaned1 is None or cleaned2 is None:
            print(f"[SKIP] Skipping comparison for {trigger_mask} — one or both samples have no Events tree")
            continue

        make_comparison_plots(
            cleaned1,
            cleaned2,
            sample_name_1,
            sample_name_2,
            comparison_dir,
            label1=label_1,
            label2=label_2,
        )

if __name__ == "__main__":
    main()