#!/usr/bin/env python3
import os
import ROOT
import uproot
import awkward as ak
import numpy as np
import cmsstyle as CMS

ROOT.gROOT.SetBatch(True)
ROOT.TH1.SetDefaultSumw2(True)
ROOT.gStyle.SetOptStat(1110)

sample_name_1 = "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150"
sample_name_2 = "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA"

year = 2024
GTAG = "150X_mcRun3_2024_realistic_v2"
era = "D"
tag = "MC"

tree_path = "Events"

input_file_1 = f"{sample_name_1}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
input_file_2 = f"{sample_name_2}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"

output_dir_1 = f"plots/{sample_name_1}_{year}_{era}_{tag}_{GTAG}_preselected_events"
output_dir_2 = f"plots/{sample_name_2}_{year}_{era}_{tag}_{GTAG}_preselected_events"
comparison_dir = f"plots/comparisons_{year}_{era}_{tag}_{GTAG}_preselected_events"

os.makedirs(output_dir_1, exist_ok=True)
os.makedirs(output_dir_2, exist_ok=True)
os.makedirs(comparison_dir, exist_ok=True)

plot_config = {
    "GEN_LeadingRHadron_pt":   (150, 0.0, 3000.0, "Leading GEN RHadron p_{T} [GeV]"),
    "GEN_LeadingRHadron_eta":  (100, -5.0, 5.0, "Leading GEN RHadron #eta"),
    "GEN_LeadingRHadron_phi":  (100, -4.0, 4.0, "Leading GEN RHadron #phi"),
    "GEN_LeadingRHadron_mass": (100, 0.0, 3000.0, "Leading GEN RHadron mass [GeV]"),

    "GEN_SubleadingRHadron_pt":   (150, 0.0, 3000.0, "Subleading GEN RHadron p_{T} [GeV]"),
    "GEN_SubleadingRHadron_eta":  (50, -5.0, 5.0, "Subleading GEN RHadron #eta"),
    "GEN_SubleadingRHadron_phi":  (50, -3.2, 3.2, "Subleading GEN RHadron #phi"),
    "GEN_SubleadingRHadron_mass": (60, 0.0, 3000.0, "Subleading GEN RHadron mass [GeV]"),

    "GEN_diRHadron_pt":   (150, 0.0, 3000.0, "GEN diRHadron p_{T} [GeV]"),
    "GEN_diRHadron_eta":  (50, -5.0, 5.0, "GEN diRHadron #eta"),
    "GEN_diRHadron_phi":  (50, -3.2, 3.2, "GEN diRHadron #phi"),
    "GEN_diRHadron_mass": (60, 0.0, 5000.0, "GEN diRHadron mass [GeV]"),

    "IsoTrack_pt": (150, 0.0, 3000.0, "IsoTrack p_{T} [GeV]"),
    "IsoTrack_eta": (50, -5.0, 5.0, "IsoTrack #eta"),
    "IsoTrack_numberOfValidPixelHits": (20, 0, 20, "IsoTrack number of valid pixel hits"),
    "IsoTrack_fractionOfValidHits": (50, 0.0, 1.0, "IsoTrack fraction of valid hits"),
    "IsoTrack_numberOfValidHits": (20, 0, 20, "IsoTrack number of valid hits"),
    "IsoTrack_isHighPurityTrack": (2, 0, 2, "IsoTrack is high purity track"),
    "IsoTrack_normChi2": (50, 0.0, 10.0, "IsoTrack normalized #chi^{2}"),
    "IsoTrack_dz": (50, -0.5, 0.5, "IsoTrack dz [cm]"),
    "IsoTrack_dxy": (50, -0.5, 0.5, "IsoTrack dxy [cm]"),
    "IsoTrack_pfEnergyOverP": (50, 0.0, 5.0, "IsoTrack PF energy / p"),
    "IsoTrack_ptErrOverPt": (50, 0.0, 0.1, "IsoTrack p_{T} error / p_{T}"),
    "IsoTrack_ptErrOverPt2": (50, 0.0, 0.1, "IsoTrack p_{T} error / p_{T}^{2}"),
}


def set_cms_style_for_sample(sample_name):
    global CMS_IPOS
    CMS_IPOS = 0

    if sample_name == "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150":
        CMS.SetExtraText("Private Work: Madgraph5 MC Simulation")
    elif sample_name == "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA":
        CMS.SetExtraText("Private Work: Pythia8 MC Simulation")
    else:
        CMS.SetExtraText("Private Work: MC Simulation")

    CMS.SetLumi(None, run="Run 3")
    CMS.SetEnergy(13.6)


def load_arrays(input_file, branches):
    tree = uproot.open(input_file)[tree_path]
    return tree.arrays(branches, library="ak")

def clean_values(arr):
    if arr.ndim > 1:
        arr = ak.flatten(arr, axis=None)

    arr = ak.drop_none(arr)
    values = ak.to_numpy(arr)

    if values.dtype == np.bool_:
        values = values.astype(np.int32)

    values = values[np.isfinite(values)]
    return values

def make_hist(branch, values, nbins, xmin, xmax, color=ROOT.kBlue + 1):
    hist = ROOT.TH1F(f"h_{branch}_{ROOT.TUUID().AsString()}", "", nbins, xmin, xmax)

    for x in values:
        hist.Fill(float(x))

    hist.SetLineWidth(2)
    hist.SetLineColor(color)
    hist.SetFillStyle(0)
    hist.SetFillColor(0)
    hist.SetMarkerStyle(0)
    hist.SetMarkerColor(0)
    return hist

def draw_single_cmsstyle( name, xmin, xmax, hist, xtitle, ytitle, outpng, yoffset=1.15, titlesize=0.045, labelsize=0.040, logy=False, ymin_log=0.1, vline_x=None,):
    ymax = max(hist.GetMaximum(), 1.0) * (10.0 if logy else 1.35)
    ymin = ymin_log if logy else 0.0

    canv = CMS.cmsCanvas(
        name,
        xmin,
        xmax,
        ymin,
        ymax,
        xtitle,
        ytitle,
        square=False,
        iPos=CMS_IPOS,
    )

    if logy:
        canv.SetLogy(True)
        hist.SetMinimum(ymin_log)

    frame = CMS.GetCmsCanvasHist(canv)
    frame.GetXaxis().SetTitleSize(titlesize)
    frame.GetYaxis().SetTitleSize(titlesize)
    frame.GetXaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetLabelSize(labelsize)
    frame.GetYaxis().SetTitleOffset(yoffset)

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

def draw_comparison_with_ratio( name, xmin, xmax, hist1, hist2, xtitle, ytitle, outpng, label1, label2, ratio_ymin=0.0, ratio_ymax=2.0, yoffset=1.01, titlesize=0.045, labelsize=0.040, logy=False, ymin_log=1e-6, normalize=False, include_overflow=True, vline_x=None,):
    h1 = hist1.Clone(f"{name}_h1")
    h2 = hist2.Clone(f"{name}_h2")
    h1.SetDirectory(0)
    h2.SetDirectory(0)

    if normalize:
        nb = h1.GetNbinsX()
        lo = 0 if include_overflow else 1
        hi = nb + 1 if include_overflow else nb

        int1 = h1.Integral(lo, hi)
        int2 = h2.Integral(lo, hi)

        if int1 > 0:
            h1.Scale(1.0 / int1)
        if int2 > 0:
            h2.Scale(1.0 / int2)

    ymax = max(h1.GetMaximum(), h2.GetMaximum(), 1e-12) * 1.35
    ymin = ymin_log if logy else 0.0

    canv = CMS.cmsCanvas(name, xmin, xmax, ymin, ymax, xtitle, ytitle, square=False, iPos=CMS_IPOS)
    canv.cd()

    top = ROOT.TPad(f"{name}_top", "", 0.0, 0.30, 1.0, 1.0)
    bot = ROOT.TPad(f"{name}_bot", "", 0.0, 0.00, 1.0, 0.30)

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

    hframe = h1.Clone(f"{name}_frame")
    hframe.Reset("ICES")
    hframe.SetMinimum(ymin)
    hframe.SetMaximum(ymax)
    hframe.GetXaxis().SetLabelSize(0)
    hframe.GetXaxis().SetTitleSize(0)

    hframe.GetYaxis().SetTitle(ytitle)
    hframe.GetYaxis().SetTitleSize(titlesize)
    hframe.GetYaxis().SetLabelSize(labelsize)
    hframe.GetYaxis().SetTitleOffset(yoffset)
    hframe.Draw("AXIS")

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

    nb = h1.GetNbinsX()
    topcap = ratio_ymax * 0.98

    for i in range(1, nb + 1):
        a = h1.GetBinContent(i) #mg5
        ea = h1.GetBinError(i)
        b = h2.GetBinContent(i) #pythia
        eb = h2.GetBinError(i)

        if a == 0 and b == 0:
            continue

        if b > 0:
            r = a / b
            if a > 0:
                dr = r * ((ea / a) ** 2 + (eb / b) ** 2) ** 0.5
            else:
                dr = r * (eb / b)
            ratio.SetBinContent(i, r)
            ratio.SetBinError(i, dr)
        else:
            if a == 0:
                ratio.SetBinContent(i, 1.0)
                ratio.SetBinError(i, 0.0)
            else:
                ratio.SetBinContent(i, topcap)
                ratio.SetBinError(i, 0.0)

    ratio.SetMinimum(min(ratio_ymin, -0.05))
    ratio.SetMaximum(ratio_ymax)

    ratio.GetYaxis().SetTitle("Madgraph5/Pythia8")
    ratio.GetYaxis().SetNdivisions(505)
    ratio.GetYaxis().SetTitleSize(0.11)
    ratio.GetYaxis().SetLabelSize(0.10)
    ratio.GetYaxis().SetTitleOffset(0.55)

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
        line_ratio = ROOT.TLine(vline_x, ratio_ymin, vline_x, ratio_ymax)
        line_ratio.SetLineStyle(ROOT.kDashed)
        line_ratio.SetLineWidth(2)
        line_ratio.SetLineColor(ROOT.kBlack)
        line_ratio.Draw("SAME")

    bot.Modified()
    bot.Update()

    canv.SaveAs(outpng)

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

def make_individual_plots(sample_name, input_file, output_dir):
    print(f"\n[DEBUG] Processing sample: {sample_name}")
    print(f"[DEBUG] Opened file: {input_file}")
    print(f"[DEBUG] Reading tree: {tree_path}")
    print(f"[DEBUG] Output directory: {output_dir}")

    set_cms_style_for_sample(sample_name)
    arrays = load_arrays(input_file, list(plot_config.keys()))
    cleaned = {}

    for branch, (nbins, xmin, xmax, xtitle) in plot_config.items():
        arr = arrays[branch]
        values = clean_values(arr)
        cleaned[branch] = values

        print(f"\n[DEBUG] Branch: {branch}")
        print(f"[DEBUG] Entries: {len(values)}")

        if len(values) > 0:
            print(f"[DEBUG] Min:   {values.min():.6f}")
            print(f"[DEBUG] Max:   {values.max():.6f}")
            print(f"[DEBUG] Mean:  {values.mean():.6f}")
        else:
            print("[DEBUG] No entries after cleaning")

        hist = make_hist(branch, values, nbins, xmin, xmax, ROOT.kBlue + 1)

        logy = should_use_logy(branch)
        vline_x = get_vline(branch)
        ytitle = "Events"

        hist.GetXaxis().SetTitle(xtitle)
        hist.GetYaxis().SetTitle(ytitle)

        outpng = f"{output_dir}/{branch}.png"
        draw_single_cmsstyle(
            name=f"c_{branch}_{sample_name}",
            xmin=xmin,
            xmax=xmax,
            hist=hist,
            xtitle=xtitle,
            ytitle=ytitle,
            outpng=outpng,
            yoffset=1.15,
            logy=logy,
            vline_x=vline_x,
        )

        print(f"[DEBUG] Wrote {outpng}")

    return cleaned

cleaned_1 = make_individual_plots(sample_name_1, input_file_1, output_dir_1)
cleaned_2 = make_individual_plots(sample_name_2, input_file_2, output_dir_2)


comparison_branch = "GEN_diRHadron_pt"
nbins, xmin, xmax, xtitle = plot_config[comparison_branch]

CMS_IPOS = 0
CMS.SetExtraText("Private Work: MC Simulation Comparison")
CMS.SetLumi(None, run="Run 3")
CMS.SetEnergy(13.6)

hist1 = make_hist( f"{comparison_branch}_sample1", cleaned_1[comparison_branch], nbins, xmin, xmax, ROOT.kBlue + 1,)
hist2 = make_hist( f"{comparison_branch}_sample2", cleaned_2[comparison_branch], nbins, xmin, xmax, ROOT.kRed + 1)
comparison_outpng = f"{comparison_dir}/{comparison_branch}_comparison_ratio.png"

draw_comparison_with_ratio(
    name=f"c_{comparison_branch}_comparison_ratio",
    xmin=xmin,
    xmax=xmax,
    hist1=hist1,
    hist2=hist2,
    xtitle=xtitle,
    ytitle="Normalized Events",
    outpng=comparison_outpng,
    label1="MadGraph5: Ntuplizer + Preselection",
    label2="Pythia8: Ntuplizer + Preselection",
    ratio_ymin=0.0,
    ratio_ymax=2.0,
    logy=True,
    ymin_log=1e-6,
    normalize=True,
    include_overflow=True,
    vline_x=150.0,
)

print(f"\n[DEBUG] Wrote comparison plot with ratio: {comparison_outpng}")
print("\n[DEBUG] Done.")