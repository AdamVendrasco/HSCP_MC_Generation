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

CMS_IPOS = 0
#CMS.SetExtraText("Private Work: Madgraph5 MC Simulation")
CMS.SetExtraText("Private Work: Pythia8 MC Simulation")
CMS.SetLumi(None, run="Run 3")
CMS.SetEnergy(13.6)

#sample_name = "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150"
sample_name = "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA"
year = 2024
GTAG = "150X_mcRun3_2024_realistic_v2"
era = "D"
tag = "MC"  # or DATA

input_file = f"{sample_name}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
tree_path = "Events"
output_dir = f"plots/{sample_name}_{year}_{era}_{tag}_{GTAG}_preselected_events"

os.makedirs(output_dir, exist_ok=True)

plot_config = {
    "GEN_LeadingRHadron_pt":   (150, 0.0, 3000.0, "Leading GEN RHadron p_{T} [GeV]"),
    "GEN_LeadingRHadron_eta":  (100, -5.0, 5.0, "Leading GEN RHadron #eta"),
    "GEN_LeadingRHadron_phi":  (100, -4.0, 4.0, "Leading GEN RHadron #phi"),
    "GEN_LeadingRHadron_mass": (100, 0.0, 3000.0, "Leading GEN RHadron mass [GeV]"),

    "GEN_SubleadingRHadron_pt":   (150, 0.0, 3000.0, "Subleading GEN RHadron p_{T} [GeV]"),
    "GEN_SubleadingRHadron_eta":  (50, -5.0, 5.0, "Subleading GEN RHadron #eta"),
    "GEN_SubleadingRHadron_phi":  (50, -3.2, 3.2, "Subleading GEN RHadron #phi"),
    "GEN_SubleadingRHadron_mass": (60, 0.0, 3000.0, "Subleading GEN RHadron mass [GeV]"),

    "GEN_diRHadron_pt":   (150, 0.0, 3000.0, "GEN diRhadron p_{T} [GeV]"),
    "GEN_diRHadron_eta":  (50, -5.0, 5.0, "GEN diRhadron #eta"),
    "GEN_diRHadron_phi":  (50, -3.2, 3.2, "GEN diRhadron #phi"),
    "GEN_diRHadron_mass": (60, 0.0, 5000.0, "GEN diRhadron mass [GeV]"),

    "IsoTrack_pt": (60, 0.0, 3000.0, "IsoTrack p_{T} [GeV]"),
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

tree = uproot.open(input_file)[tree_path]
arrays = tree.arrays(list(plot_config.keys()), library="ak")

print(f"[DEBUG] Opened file: {input_file}")
print(f"[DEBUG] Reading tree: {tree_path}")
print(f"[DEBUG] Output directory: {output_dir}")

def draw_single_cmsstyle(
    name,
    xmin,
    xmax,
    hist,
    xtitle,
    ytitle,
    outpng,
    yoffset=1.15,
    titlesize=0.045,
    labelsize=0.040,
    logy=False,
    ymin_log=0.1,
    vline_x=None,
):
    ymax = max(hist.GetMaximum(), 1.0) * 1.35
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

    CMS.cmsDraw(hist, "HIST", lwidth=2, lcolor=ROOT.kBlue + 1, fstyle=0)

    if vline_x is not None:
        y1 = ymin_log if logy else 0.0
        y2 = max(hist.GetMaximum(), 1.0) * 1.05
        line = ROOT.TLine(vline_x, y1, vline_x, y2)
        line.SetLineStyle(ROOT.kDashed)
        line.SetLineWidth(2)
        line.SetLineColor(ROOT.kRed + 1)
        line.Draw("SAME")

    canv.SaveAs(outpng)

for branch, (nbins, xmin, xmax, xtitle) in plot_config.items():
    arr = arrays[branch]

    if arr.ndim > 1:
        arr = ak.flatten(arr, axis=None)

    arr = ak.drop_none(arr)
    values = ak.to_numpy(arr)

    if values.dtype == np.bool_:
        values = values.astype(np.int32)

    values = values[np.isfinite(values)]

    print(f"\n[DEBUG] Branch: {branch}")
    print(f"[DEBUG] Entries: {len(values)}")

    if len(values) > 0:
        print(f"[DEBUG] Min:   {values.min():.6f}")
        print(f"[DEBUG] Max:   {values.max():.6f}")
        print(f"[DEBUG] Mean:  {values.mean():.6f}")
    else:
        print("[DEBUG] No entries after cleaning")

    hist = ROOT.TH1F(f"h_{branch}", "", nbins, xmin, xmax)

    for x in values:
        hist.Fill(float(x))

    hist.SetLineWidth(2)
    hist.SetFillStyle(0)
    hist.SetFillColor(0)
    hist.SetMarkerStyle(0)
    hist.SetMarkerColor(0)

    logy = False
    ytitle = "Events"
    vline_x = None

    if branch == "GEN_diRHadron_pt":
        logy = True
        vline_x = 150.0

    hist.GetXaxis().SetTitle(xtitle)
    hist.GetYaxis().SetTitle(ytitle)

    outpng = f"{output_dir}/{branch}.png"
    draw_single_cmsstyle(
        name=f"c_{branch}",
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

print("\n[DEBUG] Done.")