#!/usr/bin/env python
import argparse
import os
import math
import ROOT


def deltaR(eta1, phi1, eta2, phi2):
    """
    Compute the ΔR separation between two objects.
    """
    dphi = abs(phi1 - phi2)
    if dphi > math.pi:
        dphi = 2*math.pi - dphi
    return math.sqrt((eta1 - eta2)**2 + dphi**2)


def extract_top6_ak4_pt(root_file_path, isolation=False):
    """
    Extract up to six leading AK4 jet pT's per event,
    optionally excluding jets within ΔR<0.4 of any RHadron.
    """
    f = ROOT.TFile.Open(root_file_path)
    tree = f.Get("Events")
    n_entries = tree.GetEntries()

    counts = { f"{i}th": [] for i in range(1,7) }
    for i in range(n_entries):
        tree.GetEntry(i)
        jets_wr = getattr(tree, "recoGenJets_ak4GenJets__GEN", None)
        if not jets_wr:
            continue
        jets = jets_wr.product()
        rhadrons = []
        if isolation:
            gp_wr = getattr(tree, "recoGenParticles_genParticles__GEN", None)
            if gp_wr:
                gps = gp_wr.product()
                for j in range(gps.size()):
                    g = gps.at(j)
                    if 1000600 <= abs(g.pdgId()) <= 1100000 and g.status() == 1:
                        rhadrons.append((g.eta(), g.phi()))

        pts = []
        for j in range(jets.size()):
            jet = jets.at(j)
            if isolation and any(deltaR(jet.eta(), jet.phi(), et, ph) < 0.4 for et,ph in rhadrons):
                continue
            pts.append(jet.pt())

        pts.sort(reverse=True)
        for idx in range(min(6, len(pts))):
            counts[f"{idx+1}th"].append(pts[idx])
    return counts


def main():
    parser = argparse.ArgumentParser(
        description="Overlay pT of the 1st–6th AK4 jets from one ROOT file."
    )
    parser.add_argument("input_file", help="Path to the ROOT file")
    parser.add_argument(
        "--isolation", action="store_true",
        help="Exclude jets within ΔR<0.4 of any RHadron"
    )
    parser.add_argument(
        "--nbins", type=int, default=50,
        help="Number of bins in each histogram"
    )
    parser.add_argument(
        "--alpha", type=float, default=0.3,
        help="Fill opacity (0 = transparent, 1 = solid)"
    )
    args = parser.parse_args()

    # Disable the default statistics box
    ROOT.gStyle.SetOptStat(0)

    data = extract_top6_ak4_pt(args.input_file, isolation=args.isolation)
    all_pts = [pt for pts in data.values() for pt in pts]
    if not all_pts:
        print("No jets found; nothing to plot.")
        return
    lo, hi = min(all_pts), max(all_pts)
    nbins = args.nbins
    alpha = args.alpha

    labels = ["Leading", "2nd", "3rd", "4th", "5th", "6th"]

    # normalize histograms
    histos = {}
    for i, (rank, pts) in enumerate(data.items()):
        title = (
            "Leading AK4 Jet PT;AK4 jet pT [GeV];Normalized Counts"
            if i == 0 else
            ";AK4 jet pT [GeV];Normalized Counts"
        )
        name = f"h{i+1}"
        h = ROOT.TH1D(name, title, nbins, lo, hi)
        for pt in pts:
            h.Fill(pt)
        if h.Integral() > 0:
            h.Scale(1.0 / (h.Integral() * h.GetBinWidth(1)))
        histos[labels[i]] = h

    # Draw overlay
    c = ROOT.TCanvas("c", "c", 800, 600)
    c.SetLogy()
    colors = [ROOT.kBlack, ROOT.kRed, ROOT.kBlue,
              ROOT.kGreen+2, ROOT.kMagenta, ROOT.kOrange]
    legend = ROOT.TLegend(0.6, 0.65, 0.9, 0.9)

    for i, (label, h) in enumerate(histos.items()):
        h.SetLineColor(colors[i])
        h.SetLineWidth(2)
        h.SetFillStyle(1001)
        h.SetFillColorAlpha(colors[i], alpha)
        draw_opt = "HIST" if i == 0 else "HIST SAME"
        h.Draw(draw_opt)
        legend.AddEntry(h, label, "lf")

    legend.Draw()
    c.Update()

    # Save output
    base = os.path.splitext(os.path.basename(args.input_file))[0]
    suffix = "_iso" if args.isolation else ""
    outname = f"{base}{suffix}_overlay_1-6pt.png"
    c.SaveAs(outname)
    print(f"Saved overlay to {outname}")

if __name__ == "__main__":
    main()
