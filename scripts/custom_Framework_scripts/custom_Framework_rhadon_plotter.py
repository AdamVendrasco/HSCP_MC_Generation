import uproot
import awkward as ak
import numpy as np


input_file = (
    "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2018/HSCP-Gluino_Par-M-1800_xqcut150/output.root"
)

tree_path = "HSCPMiniAODAnalyzer/Events"

rhadron_pdgids = {
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334, 1000612, 1000622, 1000632, 1000642,
    1000652, 1006113, 1006211, 1006213, 1006223, 1006311, 1006313,
    1006321, 1006323, 1006333,
}

cuts = {
    "max_events_to_print": 1,

    # Gen cuts
    "abs_eta_max": 2.4,
    "pt_min": 55.0,

    # dE/dx cuts
    "DeDx_PixelNoL1NOM": 2.0,
    "DeDx_NoL1NOM": 10.0,
    "DeDx_FiPixelNoL1": 0.3,

    # track cuts
    "IsoTrack_pt": 55.0,
    "IsoTrack_eta": 2.4,
    "IsoTrack_fractionOfValidHits": 0.8,
    "IsoTrack_isHighPurityTrack": True,
    "IsoTrack_normChi2": 5.0,
    "IsoTrack_dz": 0.1,
    "IsoTrack_dxy": 0.02,
    "IsoTrack_ptErrOverPt": 0.1,
    "IsoTrack_ptErrOverPt2": 0.0008,
    "IsoTrack_pfEnergyOverP": 0.3,
    "IsoTrack_pfMiniRelIsoAll": 0.02,
    "IsoTrack_IsoSumPt_dr03": 15.0,

    # cuts left to add:
    # Ih > C -> need to calculate C from track variables?
}


def jagged_isin(jagged_array, valid_values):
    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
    return ak.unflatten(flat_mask, ak.num(jagged_array))


def main():
    tree = uproot.open(input_file)[tree_path]
    branches = tree.arrays(
        [
            "GenPart_pdgId",
            "GenPart_pt",
            "GenPart_eta",
            "GenPart_phi",
            "GenPart_mass",

            "DeDx_PixelNoL1NOM",
            "DeDx_NoL1NOM",
            "DeDx_FiPixelNoL1",

            "IsoTrack_pt",
            "IsoTrack_eta",
            "IsoTrack_fractionOfValidHits",
            "IsoTrack_isHighPurityTrack",
            "IsoTrack_normChi2",
            "IsoTrack_dz",
            "IsoTrack_dxy",
            "IsoTrack_ptErrOverPt",
            "IsoTrack_ptErrOverPt2",
            "IsoTrack_pfEnergyOverP",
            "IsoTrack_pfMiniRelIsoAll",
            "IsoTrack_IsoSumPt_dr03",

            "HLT_PFMET120_PFMHT120_IDTight",
            "HLT_PFHT500_PFMET100_PFMHT100_IDTight",
            "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60",
            "HLT_MET105_IsoTrk50",

        ],
        library="ak",
    )

    gen_pdgid = branches["GenPart_pdgId"]
    gen_pt = branches["GenPart_pt"]
    gen_eta = branches["GenPart_eta"]
    gen_phi = branches["GenPart_phi"]
    gen_mass = branches["GenPart_mass"]

    DeDx_PixelNoL1NOM = branches["DeDx_PixelNoL1NOM"]
    DeDx_NoL1NOM = branches["DeDx_NoL1NOM"]
    DeDx_FiPixelNoL1 = branches["DeDx_FiPixelNoL1"]

    IsoTrack_pt = branches["IsoTrack_pt"]
    IsoTrack_eta = branches["IsoTrack_eta"]
    IsoTrack_fractionOfValidHits = branches["IsoTrack_fractionOfValidHits"]
    IsoTrack_isHighPurityTrack = branches["IsoTrack_isHighPurityTrack"]
    IsoTrack_normChi2 = branches["IsoTrack_normChi2"]
    IsoTrack_dz = branches["IsoTrack_dz"]
    IsoTrack_dxy = branches["IsoTrack_dxy"]
    IsoTrack_ptErrOverPt = branches["IsoTrack_ptErrOverPt"]
    IsoTrack_ptErrOverPt2 = branches["IsoTrack_ptErrOverPt2"]
    IsoTrack_pfEnergyOverP = branches["IsoTrack_pfEnergyOverP"]
    IsoTrack_IsoSumPt_dr03 = branches["IsoTrack_IsoSumPt_dr03"]
    IsoTrack_pfMiniRelIsoAll = branches["IsoTrack_pfMiniRelIsoAll"]

    HLT_PFMET120_PFMHT120_IDTight = branches["HLT_PFMET120_PFMHT120_IDTight"]
    HLT_PFHT500_PFMET100_PFMHT100_IDTight = branches["HLT_PFHT500_PFMET100_PFMHT100_IDTight"]
    HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = branches["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"]
    HLT_MET105_IsoTrk50 = branches["HLT_MET105_IsoTrk50"]


    # Gen Rhadron selection
    particle_mask = (
        jagged_isin(abs(gen_pdgid), rhadron_pdgids)
        & (abs(gen_eta) < cuts["abs_eta_max"])
        & (gen_pt > cuts["pt_min"])
    )

    selected = ak.zip(
        {
            "pdgId": gen_pdgid[particle_mask],
            "pt": gen_pt[particle_mask],
            "eta": gen_eta[particle_mask],
            "phi": gen_phi[particle_mask],
            "mass": gen_mass[particle_mask],
        }
    )

    selected = selected[ak.argsort(selected.pt, axis=1, ascending=False)]
    selected = ak.pad_none(selected, 2)

    leading_rhadron = selected[:, 0]
    subleading_rhadron = selected[:, 1]
    has_valid_pair = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron) #keeps only pair lead/sublead rhadrons from GEN

    # Trigger cuts
    trigger_event_mask = (
        HLT_PFMET120_PFMHT120_IDTight
        | HLT_PFHT500_PFMET100_PFMHT100_IDTight
        | HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60
        | HLT_MET105_IsoTrk50
    )

# reco mask: dedx + IsoTracks
    reco_candidate_mask = (
          (IsoTrack_pt > cuts["IsoTrack_pt"])
        & (abs(IsoTrack_eta) < cuts["IsoTrack_eta"])
        & (IsoTrack_fractionOfValidHits > cuts["IsoTrack_fractionOfValidHits"])
        & (IsoTrack_isHighPurityTrack == cuts["IsoTrack_isHighPurityTrack"])
        & (IsoTrack_normChi2 < cuts["IsoTrack_normChi2"])
        & (abs(IsoTrack_dz) < cuts["IsoTrack_dz"])
        & (abs(IsoTrack_dxy) < cuts["IsoTrack_dxy"])
        & (IsoTrack_ptErrOverPt < cuts["IsoTrack_ptErrOverPt"])
        & (IsoTrack_ptErrOverPt2 < cuts["IsoTrack_ptErrOverPt2"])
        & (IsoTrack_pfEnergyOverP < cuts["IsoTrack_pfEnergyOverP"])
        & (IsoTrack_pfMiniRelIsoAll < cuts["IsoTrack_pfMiniRelIsoAll"])
        & (IsoTrack_IsoSumPt_dr03 < cuts["IsoTrack_IsoSumPt_dr03"])

        & (DeDx_PixelNoL1NOM >= cuts["DeDx_PixelNoL1NOM"])
        & (DeDx_NoL1NOM >= cuts["DeDx_NoL1NOM"])
        & (DeDx_FiPixelNoL1 >= cuts["DeDx_FiPixelNoL1"])
    )

    reco_event_mask = ak.any(reco_candidate_mask, axis=1)

    # Final event selection
    final_event_mask = has_valid_pair & reco_event_mask & trigger_event_mask


    # Summary
    print(f"Total events                   = {len(gen_pdgid)}")
    print(f"Events with RHadron pair       = {int(ak.sum(has_valid_pair))}")
    print(f"Events passing trigger         = {int(ak.sum(trigger_event_mask))}")
    print(f"Events passing reco cuts       = {int(ak.sum(reco_event_mask))}")
    print(f"Events passing final selection = {int(ak.sum(final_event_mask))}")

    print("\nFirst few selected events:")
    shown = 0

    for event_index in range(len(final_event_mask)):
        if not bool(final_event_mask[event_index]):
            continue

        lead = leading_rhadron[event_index]
        sub = subleading_rhadron[event_index]
        candidate_passes = ak.to_list(reco_candidate_mask[event_index])

        print(f"\nEvent {event_index}")
        print(f"  reco_candidate_mask           = {candidate_passes}")
        print(f"  DeDx_PixelNoL1NOM             = {ak.to_list(DeDx_PixelNoL1NOM[event_index])}")
        print(f"  DeDx_NoL1NOM                  = {ak.to_list(DeDx_NoL1NOM[event_index])}")
        print(f"  DeDx_FiPixelNoL1              = {ak.to_list(DeDx_FiPixelNoL1[event_index])}")
        print(f"  IsoTrack_pt                   = {ak.to_list(IsoTrack_pt[event_index])}")
        print(f"  IsoTrack_eta                  = {ak.to_list(IsoTrack_eta[event_index])}")
        print(f"  IsoTrack_fractionOfValidHits  = {ak.to_list(IsoTrack_fractionOfValidHits[event_index])}")
        print(f"  IsoTrack_isHighPurityTrack    = {ak.to_list(IsoTrack_isHighPurityTrack[event_index])}")
        print(f"  IsoTrack_normChi2             = {ak.to_list(IsoTrack_normChi2[event_index])}")
        print(f"  IsoTrack_dz                   = {ak.to_list(IsoTrack_dz[event_index])}")
        print(f"  IsoTrack_dxy                  = {ak.to_list(IsoTrack_dxy[event_index])}")
        print(f"  IsoTrack_ptErrOverPt          = {ak.to_list(IsoTrack_ptErrOverPt[event_index])}")
        print(f"  IsoTrack_ptErrOverPt2         = {ak.to_list(IsoTrack_ptErrOverPt2[event_index])}")
        print(f"  IsoTrack_pfEnergyOverP        = {ak.to_list(IsoTrack_pfEnergyOverP[event_index])}")
        print(f"  IsoTrack_pfMiniRelIsoAll           = {ak.to_list(IsoTrack_pfMiniRelIsoAll[event_index])}")
        print(f"  IsoTrack_pfMiniRelIsoAll = {ak.type(IsoTrack_pfMiniRelIsoAll)}")
        print(f"  IsoTrack_IsoSumPt_dr03        = {ak.to_list(IsoTrack_IsoSumPt_dr03[event_index])}")

        print(f"  HLT_PFMET120_PFMHT120_IDTight               = {bool(HLT_PFMET120_PFMHT120_IDTight[event_index])}")
        print(f"  HLT_PFHT500_PFMET100_PFMHT100_IDTight       = {bool(HLT_PFHT500_PFMET100_PFMHT100_IDTight[event_index])}")
        print(f"  HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = {bool(HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60[event_index])}")
        print(f"  HLT_MET105_IsoTrk50                         = {bool(HLT_MET105_IsoTrk50[event_index])}")

        print(
            f"  Leading RHadron   : "
            f"pdgId={int(lead.pdgId)}, "
            f"pt={float(lead.pt):.3f}, "
            f"eta={float(lead.eta):.3f}, "
            f"phi={float(lead.phi):.3f}, "
            f"mass={float(lead.mass):.3f}"
        )
        print(
            f"  Subleading RHadron: "
            f"pdgId={int(sub.pdgId)}, "
            f"pt={float(sub.pt):.3f}, "
            f"eta={float(sub.eta):.3f}, "
            f"phi={float(sub.phi):.3f}, "
            f"mass={float(sub.mass):.3f}"
        )

        shown += 1
        if shown >= cuts["max_events_to_print"]:
            break


if __name__ == "__main__":
    main()