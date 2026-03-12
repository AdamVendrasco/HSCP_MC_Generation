#!/usr/bin/env python3
import uproot
import awkward as ak
import numpy as np

sample_name = "HSCP-Gluino_Par-M-1800_xqcut150_MC"
year = 2024
GTAG = "150X_mcRun3_2024_realistic_v2"
era = "D"
tag = "MC"  # or DATA

input_file = (
    "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_xqcut150_MC.root"
)

output_file = f"{sample_name}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
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
    "max_events_to_print": 10,

    # Event-level cuts
    "PV_npvsGood": 1,
    "HSCP_n": 1,
    "nIsoTrack": 1,
    "nMuon": 1,

    # Track-level cuts
    "IsoTrack_pt": 55.0,
    "IsoTrack_eta": 2.4,
    "IsoTrack_numberOfValidPixelHits": 2,
    "IsoTrack_fractionOfValidHits": 0.8,
    "IsoTrack_numberOfValidHits": 10,
    "IsoTrack_isHighPurityTrack": True,
    "IsoTrack_normChi2": 5.0,
    "IsoTrack_dz": 0.1,
    "IsoTrack_dxy": 0.02,
    "IsoTrack_pfEnergyOverP": 0.3,
    "IsoTrack_ptErrOverPt": 1.0,
    "IsoTrack_ptErrOverPt2": 0.0008,
    "C": 1.0,
    "K": 1.0,
}


def jagged_isin(jagged_array, valid_values):
    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
    return ak.unflatten(flat_mask, ak.num(jagged_array))


def main():
    tree = uproot.open(input_file)[tree_path]

    branch_names = [
        # GEN branches
        "GenPart_pdgId",
        "GenPart_pt",
        "GenPart_eta",
        "GenPart_phi",
        "GenPart_mass",

        # Event-level branches
        "PV_npvsGood",
        "HSCP_n",
        "nIsoTrack",
        "nMuon",
        "HLT_FilterOR",

        # Reco branches
        "DeDx_Ih",
        "IsoTrack_pt",
        "IsoTrack_eta",
        "IsoTrack_numberOfValidPixelHits",
        "IsoTrack_fractionOfValidHits",
        "IsoTrack_numberOfValidHits",
        "IsoTrack_isHighPurityTrack",
        "IsoTrack_normChi2",
        "IsoTrack_dz",
        "IsoTrack_dxy",
        "IsoTrack_pfEnergyOverP",
        "IsoTrack_ptErrOverPt2",
        "IsoTrack_ptErrOverPt",
    ]

    branches = tree.arrays(branch_names, library="ak")

    gen_pdgid = branches["GenPart_pdgId"]
    gen_pt = branches["GenPart_pt"]
    gen_eta = branches["GenPart_eta"]
    gen_phi = branches["GenPart_phi"]
    gen_mass = branches["GenPart_mass"]

    PV_npvsGood = branches["PV_npvsGood"]
    HSCP_n = branches["HSCP_n"]
    nIsoTrack = branches["nIsoTrack"]
    nMuon = branches["nMuon"]
    HLT_FilterOR = branches["HLT_FilterOR"]

    DeDx_Ih = branches["DeDx_Ih"]
    IsoTrack_pt = branches["IsoTrack_pt"]
    IsoTrack_eta = branches["IsoTrack_eta"]
    IsoTrack_numberOfValidPixelHits = branches["IsoTrack_numberOfValidPixelHits"]
    IsoTrack_fractionOfValidHits = branches["IsoTrack_fractionOfValidHits"]
    IsoTrack_numberOfValidHits = branches["IsoTrack_numberOfValidHits"]
    IsoTrack_isHighPurityTrack = branches["IsoTrack_isHighPurityTrack"]
    IsoTrack_normChi2 = branches["IsoTrack_normChi2"]
    IsoTrack_dz = branches["IsoTrack_dz"]
    IsoTrack_dxy = branches["IsoTrack_dxy"]
    IsoTrack_ptErrOverPt = branches["IsoTrack_ptErrOverPt"]
    IsoTrack_ptErrOverPt2 = branches["IsoTrack_ptErrOverPt2"]
    IsoTrack_pfEnergyOverP = branches["IsoTrack_pfEnergyOverP"]

    # GEN bookkeeping only:
    # identify RHadrons by PDG ID only, with NO extra GEN cuts
    rhadron_mask = jagged_isin(abs(gen_pdgid), rhadron_pdgids)

    rhadrons = ak.zip(
        {
            "pdgId": gen_pdgid[rhadron_mask],
            "pt": gen_pt[rhadron_mask],
            "eta": gen_eta[rhadron_mask],
            "phi": gen_phi[rhadron_mask],
            "mass": gen_mass[rhadron_mask],
        }
    )

    # Sort RHadrons by pT within each event so leading/subleading are consistent
    rhadrons = rhadrons[ak.argsort(rhadrons.pt, axis=1, ascending=False)]
    rhadrons = ak.pad_none(rhadrons, 2)

    leading_rhadron = rhadrons[:, 0]
    subleading_rhadron = rhadrons[:, 1]

    trigger_event_mask = HLT_FilterOR

    # Reco cuts
    reco_candidate_mask = (
        (IsoTrack_pt > cuts["IsoTrack_pt"])
        & (abs(IsoTrack_eta) < cuts["IsoTrack_eta"])
        & (IsoTrack_fractionOfValidHits > cuts["IsoTrack_fractionOfValidHits"])
        & (IsoTrack_numberOfValidPixelHits >= cuts["IsoTrack_numberOfValidPixelHits"])
        & (IsoTrack_numberOfValidHits >= cuts["IsoTrack_numberOfValidHits"])
        & (IsoTrack_isHighPurityTrack == cuts["IsoTrack_isHighPurityTrack"])
        & (IsoTrack_normChi2 < cuts["IsoTrack_normChi2"])
        & (abs(IsoTrack_dz) < cuts["IsoTrack_dz"])
        & (abs(IsoTrack_dxy) < cuts["IsoTrack_dxy"])
        & (IsoTrack_ptErrOverPt < cuts["IsoTrack_ptErrOverPt"])
        & (IsoTrack_ptErrOverPt2 < cuts["IsoTrack_ptErrOverPt2"])
        & (IsoTrack_pfEnergyOverP < cuts["IsoTrack_pfEnergyOverP"])
        & (DeDx_Ih > cuts["C"])
    )

    reco_event_mask = ak.any(reco_candidate_mask, axis=1)

    # Event-level cuts
    event_quality_mask = (
        (PV_npvsGood >= cuts["PV_npvsGood"])
        & (HSCP_n >= cuts["HSCP_n"])
        & (nIsoTrack >= cuts["nIsoTrack"])
        & (nMuon >= cuts["nMuon"])
    )

    # I am requiring that there should be a corresponding GEN RHadron pair in the event
    gen_pair_mask = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron)
    final_event_mask = ( reco_event_mask & trigger_event_mask & event_quality_mask & gen_pair_mask)

    # Leading/subleading RHadron bookkeeping for selected events
    lead_final = leading_rhadron[final_event_mask]
    sub_final = subleading_rhadron[final_event_mask]

    n_final = int(ak.sum(final_event_mask))

    print(f"Total events in input                         = {len(gen_pdgid)}")
    print(f"[DEBUG] Events passing trigger                = {int(ak.sum(trigger_event_mask))}")
    print(f"[DEBUG] Events passing reco cuts              = {int(ak.sum(reco_event_mask))}")
    print(f"[DEBUG] Events passing event cuts             = {int(ak.sum(event_quality_mask))}")
    print(f" Events passing final selection               = {n_final}")

    lead_pdgid = ak.to_numpy(lead_final.pdgId)
    lead_pt = ak.to_numpy(lead_final.pt)
    lead_eta = ak.to_numpy(lead_final.eta)
    lead_phi = ak.to_numpy(lead_final.phi)
    lead_mass = ak.to_numpy(lead_final.mass)

    sub_pdgid = ak.to_numpy(sub_final.pdgId)
    sub_pt = ak.to_numpy(sub_final.pt)
    sub_eta = ak.to_numpy(sub_final.eta)
    sub_phi = ak.to_numpy(sub_final.phi)
    sub_mass = ak.to_numpy(sub_final.mass)

    out = {
        # Full saved GEN info for selected events
        "GenPart_pdgId": gen_pdgid[final_event_mask],
        "GenPart_pt": gen_pt[final_event_mask],
        "GenPart_eta": gen_eta[final_event_mask],
        "GenPart_phi": gen_phi[final_event_mask],
        "GenPart_mass": gen_mass[final_event_mask],

        # Saved reco info for selected events
        "IsoTrack_pt": IsoTrack_pt[final_event_mask],
        "IsoTrack_eta": IsoTrack_eta[final_event_mask],
        "IsoTrack_fractionOfValidHits": IsoTrack_fractionOfValidHits[final_event_mask],
        "IsoTrack_numberOfValidPixelHits": IsoTrack_numberOfValidPixelHits[final_event_mask],
        "IsoTrack_numberOfValidHits": IsoTrack_numberOfValidHits[final_event_mask],
        "IsoTrack_isHighPurityTrack": IsoTrack_isHighPurityTrack[final_event_mask],
        "IsoTrack_normChi2": IsoTrack_normChi2[final_event_mask],
        "IsoTrack_dz": IsoTrack_dz[final_event_mask],
        "IsoTrack_dxy": IsoTrack_dxy[final_event_mask],
        "IsoTrack_ptErrOverPt": IsoTrack_ptErrOverPt[final_event_mask],
        "IsoTrack_ptErrOverPt2": IsoTrack_ptErrOverPt2[final_event_mask],
        "IsoTrack_pfEnergyOverP": IsoTrack_pfEnergyOverP[final_event_mask],
        "DeDx_Ih": DeDx_Ih[final_event_mask],

        # Event-level info
        "PV_npvsGood": PV_npvsGood[final_event_mask],
        "HSCP_n": HSCP_n[final_event_mask],
        "nIsoTrack": nIsoTrack[final_event_mask],
        "nMuon": nMuon[final_event_mask],
        "HLT_FilterOR": HLT_FilterOR[final_event_mask],

        # add reco tracks that passed the reco candidate mask
        "reco_candidate_mask": reco_candidate_mask[final_event_mask],

        # Leading/subleading GEN RHadron bookkeeping
        "LeadingRHadron_pdgId": lead_pdgid,
        "LeadingRHadron_pt": lead_pt,
        "LeadingRHadron_eta": lead_eta,
        "LeadingRHadron_phi": lead_phi,
        "LeadingRHadron_mass": lead_mass,

        "SubleadingRHadron_pdgId": sub_pdgid,
        "SubleadingRHadron_pt": sub_pt,
        "SubleadingRHadron_eta": sub_eta,
        "SubleadingRHadron_phi": sub_phi,
        "SubleadingRHadron_mass": sub_mass,
    }

    with uproot.recreate(output_file) as fout:
        fout["Events"] = out

    print(f"\nWrote selected events to = {output_file}")


if __name__ == "__main__":
    main()