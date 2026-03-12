#!/usr/bin/env python3
import uproot
import awkward as ak
import numpy as np


input_file = (
    "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_xqcut150_MC.root"
)

output_file = "selected_events.root"
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
    "C": 0.5,  # Find 2024 C & K values!!!
    "K": 0.5,  # Find 2024 C & K values!!!

    # GEN RHadron -- Not a cut in the final selection just for me to store information in the output file about GEN
    "Gen_abs_eta_max": 2.4,
    "Gen_pt_min": 55.0,
}


def jagged_isin(jagged_array, valid_values):
    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
    return ak.unflatten(flat_mask, ak.num(jagged_array))


def main():
    tree = uproot.open(input_file)[tree_path]

    branch_names = [
        # GEN branches used in selection
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

        # Reco branches
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

        # Triggers used in cuts
        "HLT_PFMET120_PFMHT120_IDTight",
        "HLT_PFHT500_PFMET100_PFMHT100_IDTight",
        "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60",
        "HLT_MET105_IsoTrk50",
    ]

    branches = tree.arrays(branch_names, library="ak")

    gen_pdgid = branches["GenPart_pdgId"]
    gen_pt = branches["GenPart_pt"]
    gen_eta = branches["GenPart_eta"]
    gen_phi = branches["GenPart_phi"]
    gen_mass = branches["GenPart_mass"]

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

    HLT_PFMET120_PFMHT120_IDTight = branches["HLT_PFMET120_PFMHT120_IDTight"]
    HLT_PFHT500_PFMET100_PFMHT100_IDTight = branches["HLT_PFHT500_PFMET100_PFMHT100_IDTight"]
    HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = branches["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"]
    HLT_MET105_IsoTrk50 = branches["HLT_MET105_IsoTrk50"]

    # Event-level branches loaded but not used yet in final_event_mask below
    PV_npvsGood = branches["PV_npvsGood"]
    HSCP_n = branches["HSCP_n"]
    nIsoTrack = branches["nIsoTrack"]
    nMuon = branches["nMuon"]

    particle_mask = (
        jagged_isin(abs(gen_pdgid), rhadron_pdgids)
        & (abs(gen_eta) < cuts["Gen_abs_eta_max"])
        & (gen_pt > cuts["Gen_pt_min"])
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
    has_valid_pair = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron)

    # Trigger cuts
    trigger_event_mask = (
        HLT_PFMET120_PFMHT120_IDTight
        | HLT_PFHT500_PFMET100_PFMHT100_IDTight
        | HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60
        | HLT_MET105_IsoTrk50
    )

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
    )

    reco_event_mask = ak.any(reco_candidate_mask, axis=1)

    # Event-level cuts
    event_quality_mask = (
        (PV_npvsGood >= cuts["PV_npvsGood"])
        & (HSCP_n >= cuts["HSCP_n"])
        & (nIsoTrack >= cuts["nIsoTrack"])
        & (nMuon >= cuts["nMuon"])
    )

    # Final event selection
    final_event_mask =  reco_event_mask & trigger_event_mask & event_quality_mask #& has_valid_pair -- has_valid_pair (GEN cut) is not applied
    lead_final = leading_rhadron[final_event_mask]
    sub_final = subleading_rhadron[final_event_mask]

    out = {
        "GenPart_pdgId": gen_pdgid[final_event_mask],
        "GenPart_pt": gen_pt[final_event_mask],
        "GenPart_eta": gen_eta[final_event_mask],
        "GenPart_phi": gen_phi[final_event_mask],
        "GenPart_mass": gen_mass[final_event_mask],

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

        "PV_npvsGood": PV_npvsGood[final_event_mask],
        "HSCP_n": HSCP_n[final_event_mask],
        "nIsoTrack": nIsoTrack[final_event_mask],
        "nMuon": nMuon[final_event_mask],

        "HLT_PFMET120_PFMHT120_IDTight": HLT_PFMET120_PFMHT120_IDTight[final_event_mask],
        "HLT_PFHT500_PFMET100_PFMHT100_IDTight": HLT_PFHT500_PFMET100_PFMHT100_IDTight[final_event_mask],
        "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60[final_event_mask],
        "HLT_MET105_IsoTrk50": HLT_MET105_IsoTrk50[final_event_mask],
        "reco_candidate_mask": reco_candidate_mask[final_event_mask],


        #Do I want to save leading/sublead rhadrons here? I could probably just sort in the plotter script
        #"LeadingRHadron_pdgId": ak.to_numpy(ak.fill_none(lead_final.pdgId, -999)),
        #"LeadingRHadron_pt": ak.to_numpy(ak.fill_none(lead_final.pt, -999.0)),
        #"LeadingRHadron_eta": ak.to_numpy(ak.fill_none(lead_final.eta, -999.0)),
        #"LeadingRHadron_phi": ak.to_numpy(ak.fill_none(lead_final.phi, -999.0)),
        #"LeadingRHadron_mass": ak.to_numpy(ak.fill_none(lead_final.mass, -999.0)),
        #"SubleadingRHadron_pdgId": ak.to_numpy(ak.fill_none(sub_final.pdgId, -999)),
        #"SubleadingRHadron_pt": ak.to_numpy(ak.fill_none(sub_final.pt, -999.0)),
        #"SubleadingRHadron_eta": ak.to_numpy(ak.fill_none(sub_final.eta, -999.0)),
        #"SubleadingRHadron_phi": ak.to_numpy(ak.fill_none(sub_final.phi, -999.0)),
        #"SubleadingRHadron_mass": ak.to_numpy(ak.fill_none(sub_final.mass, -999.0)),
    }

    with uproot.recreate(output_file) as fout:
        fout["Events"] = out

    print(f"Total events in input          = {len(gen_pdgid)}")
    #print(f"[DEBUG] Events with RHadron pair       = {int(ak.sum(has_valid_pair))}")
    print(f"[DEBUG] Events passing trigger         = {int(ak.sum(trigger_event_mask))}")
    print(f"[DEBUG] Events passing reco cuts       = {int(ak.sum(reco_event_mask))}")
    print(f"[DEBUG] Events passing event cuts      = {int(ak.sum(event_quality_mask))}")
    print(f"[DEBUG] Events passing final selection = {int(ak.sum(final_event_mask))}")
    print(f"Wrote selected events to       = {output_file}")

if __name__ == "__main__":
    main()
