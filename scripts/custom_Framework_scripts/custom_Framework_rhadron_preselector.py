#!/usr/bin/env python3
import uproot
import awkward as ak
import numpy as np
import ROOT
import os

year = 2024
GTAG = "150X_mcRun3_2024_realistic_v2"
era = "D"
tag = "MC"

tree_path = "HSCPMiniAODAnalyzer/Events"
output_dir = "/uscms/home/avendras/nobackup/HSCP/scripts/custom_Framework_scripts/preselected_rootfiles"

samples = {
    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150":
        "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",

    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA":
        "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA_MC.root",
}

trigger_options = [
    "HLT_FilterOR",
    "HLT_MET",
    "HLT_Mu",
]

rhadron_pdgids = {
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,  # gluinos
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334,

    1000612, 1000622, 1000632, 1000642, 1000652, 1006113, 1006211,  # stops
    1006213, 1006223, 1006311, 1006313, 1006321, 1006323, 1006333,
}

cuts = {
    "max_events_to_print": 1,

    # Event-level cuts
    "PV_npvsGood": 1,
    "HSCP_n": 1,
    "nIsoTrack": 1,
    "nMuon": 1,
    "PseudoMET_viaCaloJets": 170.0, #PseudoCaloMET  

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
    "DeDx_Ih": 1.0,

}

gen_branches = [
    "GenPart_pdgId",
    "GenPart_pt",
    "GenPart_eta",
    "GenPart_phi",
    "GenPart_mass",
]

event_branches = [
    "PV_npvsGood",
    "HSCP_n",
    "nIsoTrack",
    "nMuon",
    "PseudoMET_viaCaloJets",
]

trigger_branches = [
    "HLT_PFMET120_PFMHT120_IDTight",
    "HLT_PFHT500_PFMET100_PFMHT100_IDTight",
    "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60",
    "HLT_MET105_IsoTrk50",
    "HLT_Mu50",
    "HLT_IsoMu24",
    "HLT_IsoMu27",
    "HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ",
    "HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL",
    "HLT_FilterOR",
]

reco_branches = [
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

all_branch_names = gen_branches + event_branches + trigger_branches + reco_branches


def jagged_isin(jagged_array, valid_values):
    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
    return ak.unflatten(flat_mask, ak.num(jagged_array))


def build_tlorentz_vectors(lead_final, sub_final, max_print=10):
    lead_tlv = []
    sub_tlv = []
    GEN_dirhadron_sum = []

    n_selected = len(lead_final)
    print(f"\n[DEBUG] Building TLorentzVectors for {n_selected} selected events")

    for i in range(n_selected):
        v1 = ROOT.TLorentzVector()
        v1.SetPtEtaPhiM(
            float(lead_final.pt[i]),
            float(lead_final.eta[i]),
            float(lead_final.phi[i]),
            float(lead_final.mass[i]),
        )
        lead_tlv.append(v1)

        v2 = ROOT.TLorentzVector()
        v2.SetPtEtaPhiM(
            float(sub_final.pt[i]),
            float(sub_final.eta[i]),
            float(sub_final.phi[i]),
            float(sub_final.mass[i]),
        )
        sub_tlv.append(v2)

        GEN_dirhadron_sum.append(v1 + v2)

    n_to_print = min(max_print, n_selected)
    print(f"[DEBUG] Printing first {n_to_print} selected events")

    for i in range(n_to_print):
        print(f"\n[DEBUG] Selected event {i}")

        print("  Leading GEN RHadron:")
        print(f"    pdgId = {int(lead_final.pdgId[i])}")
        print(f"    pt    = {lead_tlv[i].Pt():.6f}")
        print(f"    eta   = {lead_tlv[i].Eta():.6f}")
        print(f"    phi   = {lead_tlv[i].Phi():.6f}")
        print(f"    mass  = {lead_tlv[i].M():.6f}")

        print("  Subleading GEN RHadron:")
        print(f"    pdgId = {int(sub_final.pdgId[i])}")
        print(f"    pt    = {sub_tlv[i].Pt():.6f}")
        print(f"    eta   = {sub_tlv[i].Eta():.6f}")
        print(f"    phi   = {sub_tlv[i].Phi():.6f}")
        print(f"    mass  = {sub_tlv[i].M():.6f}")

        print("  Sum of GEN RHadrons:")
        print(f"    pt    = {GEN_dirhadron_sum[i].Pt():.6f}")
        print(f"    eta   = {GEN_dirhadron_sum[i].Eta():.6f}")
        print(f"    phi   = {GEN_dirhadron_sum[i].Phi():.6f}")
        print(f"    mass  = {GEN_dirhadron_sum[i].M():.6f}")

    return lead_tlv, sub_tlv, GEN_dirhadron_sum


def build_gen_dirhadron_pt(lead, sub):
    valid_mask = ~ak.is_none(lead) & ~ak.is_none(sub)
    lead = lead[valid_mask]
    sub = sub[valid_mask]

    pts = []
    for i in range(len(lead)):
        v1 = ROOT.TLorentzVector()
        v1.SetPtEtaPhiM(
            float(lead.pt[i]),
            float(lead.eta[i]),
            float(lead.phi[i]),
            float(lead.mass[i]),
        )

        v2 = ROOT.TLorentzVector()
        v2.SetPtEtaPhiM(
            float(sub.pt[i]),
            float(sub.eta[i]),
            float(sub.phi[i]),
            float(sub.mass[i]),
        )

        pts.append((v1 + v2).Pt())

    return np.asarray(pts, dtype=np.float64)


def process_one(sample_name, input_file, TriggerMask):
    output_file = (
        f"{output_dir}/"
        f"{sample_name}_{TriggerMask}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
    )

    print("=" * 60)
    print(f"[INPUT] Sample      = {sample_name}")
    print(f"[INPUT] Input File  = {input_file}")
    print(f"[INPUT] TriggerMask = {TriggerMask}")
    print(f"[OUTPUT] Output File = {output_file}")
    print("=" * 60)

    tree = uproot.open(input_file)[tree_path]
    branches = tree.arrays(all_branch_names, library="ak")

    # Pull branches dynamically
    data = {name: branches[name] for name in all_branch_names}

    gen_pdgid = data["GenPart_pdgId"]
    gen_pt = data["GenPart_pt"]
    gen_eta = data["GenPart_eta"]
    gen_phi = data["GenPart_phi"]
    gen_mass = data["GenPart_mass"]

    PV_npvsGood = data["PV_npvsGood"]
    HSCP_n = data["HSCP_n"]
    nIsoTrack = data["nIsoTrack"]
    nMuon = data["nMuon"]

    HLT_FilterOR = data["HLT_FilterOR"]
    HLT_PFMET120_PFMHT120_IDTight = data["HLT_PFMET120_PFMHT120_IDTight"]
    HLT_PFHT500_PFMET100_PFMHT100_IDTight = data["HLT_PFHT500_PFMET100_PFMHT100_IDTight"]
    HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = data["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"]
    HLT_MET105_IsoTrk50 = data["HLT_MET105_IsoTrk50"]
    HLT_Mu50 = data["HLT_Mu50"]
    HLT_IsoMu24 = data["HLT_IsoMu24"]
    HLT_IsoMu27 = data["HLT_IsoMu27"]
    HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ = data["HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ"]
    HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL = data["HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL"]

    DeDx_Ih = data["DeDx_Ih"]
    IsoTrack_pt = data["IsoTrack_pt"]
    IsoTrack_eta = data["IsoTrack_eta"]
    IsoTrack_numberOfValidPixelHits = data["IsoTrack_numberOfValidPixelHits"]
    IsoTrack_fractionOfValidHits = data["IsoTrack_fractionOfValidHits"]
    IsoTrack_numberOfValidHits = data["IsoTrack_numberOfValidHits"]
    IsoTrack_isHighPurityTrack = data["IsoTrack_isHighPurityTrack"]
    IsoTrack_normChi2 = data["IsoTrack_normChi2"]
    IsoTrack_dz = data["IsoTrack_dz"]
    IsoTrack_dxy = data["IsoTrack_dxy"]
    IsoTrack_pfEnergyOverP = data["IsoTrack_pfEnergyOverP"]
    IsoTrack_ptErrOverPt = data["IsoTrack_ptErrOverPt"]
    IsoTrack_ptErrOverPt2 = data["IsoTrack_ptErrOverPt2"]
    PseudoMET_viaCaloJets = data["PseudoMET_viaCaloJets"]

    rhadron_mask = jagged_isin(abs(gen_pdgid), rhadron_pdgids)

    rhadrons = ak.zip({
        "pdgId": gen_pdgid[rhadron_mask],
        "pt": gen_pt[rhadron_mask],
        "eta": gen_eta[rhadron_mask],
        "phi": gen_phi[rhadron_mask],
        "mass": gen_mass[rhadron_mask],
    })

    print(f"[DEBUG] Total events in input                 = {len(gen_pdgid)}")
    print(f"[DEBUG] Events with >=1 GEN RHadron           = {int(ak.sum(ak.num(rhadrons) >= 1))}")
    print(f"[DEBUG] Events with >=2 GEN RHadrons          = {int(ak.sum(ak.num(rhadrons) >= 2))}")

    rhadrons = rhadrons[ak.argsort(rhadrons.pt, axis=1, ascending=False)]
    rhadrons = ak.pad_none(rhadrons, 2)

    leading_rhadron = rhadrons[:, 0]
    subleading_rhadron = rhadrons[:, 1]

    trigger_masks = {
        "HLT_FilterOR": HLT_FilterOR,
        "HLT_MET": (HLT_PFMET120_PFMHT120_IDTight | HLT_PFHT500_PFMET100_PFMHT100_IDTight | HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 | HLT_MET105_IsoTrk50),
        "HLT_Mu": (HLT_Mu50 | HLT_IsoMu24 | HLT_IsoMu27 | HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ | HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL),
    }

    if TriggerMask not in trigger_masks:
        raise ValueError(f"Unknown TriggerMask: {TriggerMask}")

    trigger_event_mask = trigger_masks[TriggerMask]
    print(f"[DEBUG] Using trigger definition            = {TriggerMask}")

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
        & (DeDx_Ih > cuts["DeDx_Ih"])
    
    )

    reco_event_mask = ak.any(reco_candidate_mask, axis=1)
    event_quality_mask = (
        (PV_npvsGood >= cuts["PV_npvsGood"])
        & (HSCP_n >= cuts["HSCP_n"])
        & (nIsoTrack >= cuts["nIsoTrack"])
        & (nMuon >= cuts["nMuon"])  
        & (PseudoMET_viaCaloJets > cuts["PseudoMET_viaCaloJets"])
    )

    gen_pair_mask = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron)
    final_event_mask = (reco_event_mask & trigger_event_mask & event_quality_mask & gen_pair_mask)

    lead_final = leading_rhadron[final_event_mask]
    sub_final = subleading_rhadron[final_event_mask]

    n_final = int(ak.sum(final_event_mask))

    print(f"[DEBUG] Events passing trigger                = {int(ak.sum(trigger_event_mask))}")
    print(f"[DEBUG] Events passing reco cuts              = {int(ak.sum(reco_event_mask))}")
    print(f"[DEBUG] Events passing event cuts             = {int(ak.sum(event_quality_mask))}")
    print(f"[DEBUG] Events with GEN RHadron pair          = {int(ak.sum(gen_pair_mask))}")
    print(f"[DEBUG] Events passing final selection        = {n_final}")

    pt_gen_pair = build_gen_dirhadron_pt(
        leading_rhadron[gen_pair_mask],
        subleading_rhadron[gen_pair_mask],
    )

    pt_gen_pair_event = build_gen_dirhadron_pt(
        leading_rhadron[gen_pair_mask & event_quality_mask],
        subleading_rhadron[gen_pair_mask & event_quality_mask],
    )

    pt_gen_pair_event_reco = build_gen_dirhadron_pt(
        leading_rhadron[gen_pair_mask & event_quality_mask & reco_event_mask],
        subleading_rhadron[gen_pair_mask & event_quality_mask & reco_event_mask],
    )

    pt_gen_pair_event_reco_trigger = build_gen_dirhadron_pt(
        leading_rhadron[gen_pair_mask & event_quality_mask & reco_event_mask & trigger_event_mask],
        subleading_rhadron[gen_pair_mask & event_quality_mask & reco_event_mask & trigger_event_mask],
    )

    empty = np.asarray([], dtype=np.float64)

    cutflow_arrays = {
        "pt_gen_pair": pt_gen_pair,
        "pt_gen_pair_event": pt_gen_pair_event,
        "pt_gen_pair_event_reco": pt_gen_pair_event_reco,
        "pt_gen_pair_event_reco_trigger": pt_gen_pair_event_reco_trigger,

        "pt_trg_PFMET120_PFMHT120_IDTight": empty.copy(),
        "pt_trg_PFHT500_PFMET100_PFMHT100_IDTight": empty.copy(),
        "pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": empty.copy(),
        "pt_trg_MET105_IsoTrk50": empty.copy(),

        "pt_trg_HLT_Mu50": empty.copy(),
        "pt_trg_IsoMu24": empty.copy(),
        "pt_trg_IsoMu27": empty.copy(),
        "pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ": empty.copy(),
        "pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL": empty.copy(),

        "pt_trg_HLT_FilterOR": empty.copy(),
    }

    trigger_cutflow_map = {
        "HLT_FilterOR": {
            "pt_trg_HLT_FilterOR": HLT_FilterOR,
        },

        "HLT_MET": {
            "pt_trg_PFMET120_PFMHT120_IDTight": HLT_PFMET120_PFMHT120_IDTight,
            "pt_trg_PFHT500_PFMET100_PFMHT100_IDTight": HLT_PFHT500_PFMET100_PFMHT100_IDTight,
            "pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60,
            "pt_trg_MET105_IsoTrk50": HLT_MET105_IsoTrk50,
        },

        "HLT_Mu": {
            "pt_trg_IsoMu24": HLT_IsoMu24,
            "pt_trg_IsoMu27": HLT_IsoMu27,
            "pt_trg_HLT_Mu50": HLT_Mu50,
            "pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ": HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ,
            "pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL": HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL,
        },
    }

    for out_name, trig_mask in trigger_cutflow_map[TriggerMask].items():
        cut_mask = gen_pair_mask & event_quality_mask & reco_event_mask & trig_mask
        cutflow_arrays[out_name] = build_gen_dirhadron_pt(
            leading_rhadron[cut_mask],
            subleading_rhadron[cut_mask],
        )

    print(f"[DEBUG] Cutflow pt_gen_pair entries                    = {len(pt_gen_pair)}")
    print(f"[DEBUG] Cutflow pt_gen_pair_event entries              = {len(pt_gen_pair_event)}")
    print(f"[DEBUG] Cutflow pt_gen_pair_event_reco entries         = {len(pt_gen_pair_event_reco)}")
    print(f"[DEBUG] Cutflow pt_gen_pair_event_reco_trigger entries = {len(pt_gen_pair_event_reco_trigger)}")

    if n_final == 0:
        print("[DEBUG] No selected events found")
        return

    print(f"[DEBUG] lead_final length                     = {len(lead_final)}")
    print(f"[DEBUG] sub_final length                      = {len(sub_final)}")
    print(f"[DEBUG] First selected leading pdgId          = {int(lead_final.pdgId[0])}")
    print(f"[DEBUG] First selected subleading pdgId       = {int(sub_final.pdgId[0])}")

    lead_tlv, sub_tlv, GEN_dirhadron_sum = build_tlorentz_vectors(
        lead_final,
        sub_final,
        max_print=cuts["max_events_to_print"]
    )

    out = {}

    for name in gen_branches + event_branches + reco_branches + trigger_branches:
        out[name] = data[name][final_event_mask]

    out["reco_candidate_mask"] = reco_candidate_mask[final_event_mask]

    # Saving derived GEN RHadron objects
    out["GEN_LeadingRHadron_pdgId"] = np.array([int(x) for x in ak.to_list(lead_final.pdgId)], dtype=np.int32)
    out["GEN_LeadingRHadron_pt"] = np.array([v.Pt() for v in lead_tlv], dtype=np.float64)
    out["GEN_LeadingRHadron_eta"] = np.array([v.Eta() for v in lead_tlv], dtype=np.float64)
    out["GEN_LeadingRHadron_phi"] = np.array([v.Phi() for v in lead_tlv], dtype=np.float64)
    out["GEN_LeadingRHadron_mass"] = np.array([v.M() for v in lead_tlv], dtype=np.float64)

    out["GEN_SubleadingRHadron_pdgId"] = np.array([int(x) for x in ak.to_list(sub_final.pdgId)], dtype=np.int32)
    out["GEN_SubleadingRHadron_pt"] = np.array([v.Pt() for v in sub_tlv], dtype=np.float64)
    out["GEN_SubleadingRHadron_eta"] = np.array([v.Eta() for v in sub_tlv], dtype=np.float64)
    out["GEN_SubleadingRHadron_phi"] = np.array([v.Phi() for v in sub_tlv], dtype=np.float64)
    out["GEN_SubleadingRHadron_mass"] = np.array([v.M() for v in sub_tlv], dtype=np.float64)

    out["GEN_diRHadron_pt"] = np.array([v.Pt() for v in GEN_dirhadron_sum], dtype=np.float64)
    out["GEN_diRHadron_eta"] = np.array([v.Eta() for v in GEN_dirhadron_sum], dtype=np.float64)
    out["GEN_diRHadron_phi"] = np.array([v.Phi() for v in GEN_dirhadron_sum], dtype=np.float64)
    out["GEN_diRHadron_mass"] = np.array([v.M() for v in GEN_dirhadron_sum], dtype=np.float64)

    cutflow_out = {name: ak.Array([arr]) for name, arr in cutflow_arrays.items()}

    os.makedirs(output_dir, exist_ok=True)
    with uproot.recreate(output_file) as fout:
        fout["Events"] = out
        fout["Cutflow"] = cutflow_out

    print(f"\n[DEBUG] Wrote selected events: {output_file}")
    print("[DEBUG] Saved leading/subleading/summed GEN 4-vectors as pt/eta/phi/mass branches")
    print("[DEBUG] Saved Cutflow tree with intermediate GEN diRHadron pT arrays\n")

def main():
    for sample_name, input_file in samples.items():
        for TriggerMask in trigger_options:
            process_one(sample_name, input_file, TriggerMask)

if __name__ == "__main__":
    main()
















# oringinal way I did it with the trigger mask via only HLT_FilterOR
#import uproot
#import awkward as ak
#import numpy as np
#import ROOT
#
#sample_name = "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150" #mg5 name
##sample_name = "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA" #pythia name
#year = 2024
#GTAG = "150X_mcRun3_2024_realistic_v2"
#era = "D"
#tag = "MC"  # or DATA
#
#if sample_name == "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150":
#        input_file = ("/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root") #mg5 nutple
#elif sample_name == "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA":
#        input_file = ("/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA_MC.root") #pythia nutple
#output_file = f"{sample_name}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
#tree_path = "HSCPMiniAODAnalyzer/Events"
#
#rhadron_pdgids = {
#    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
#    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
#    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
#    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
#    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
#    1095314, 1095324, 1095334, 1000612, 1000622, 1000632, 1000642,
#    1000652, 1006113, 1006211, 1006213, 1006223, 1006311, 1006313,
#    1006321, 1006323, 1006333,
#}
#
#cuts = {
#    "max_events_to_print": 1,
#
#    # Event-level cuts
#    "PV_npvsGood": 1,
#    "HSCP_n": 1,
#    "nIsoTrack": 1,
#    "nMuon": 1,
#
#    # Track-level cuts
#    "IsoTrack_pt": 55.0,
#    "IsoTrack_eta": 2.4,
#    "IsoTrack_numberOfValidPixelHits": 2,
#    "IsoTrack_fractionOfValidHits": 0.8,
#    "IsoTrack_numberOfValidHits": 10,
#    "IsoTrack_isHighPurityTrack": True,
#    "IsoTrack_normChi2": 5.0,
#    "IsoTrack_dz": 0.1,
#    "IsoTrack_dxy": 0.02,
#    "IsoTrack_pfEnergyOverP": 0.3,
#    "IsoTrack_ptErrOverPt": 1.0,
#    "IsoTrack_ptErrOverPt2": 0.0008,
#    "C": 1.0,
#    "K": 1.0,
#}
#
#def jagged_isin(jagged_array, valid_values):
#    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
#    return ak.unflatten(flat_mask, ak.num(jagged_array))
#
#def build_tlorentz_vectors(lead_final, sub_final, max_print=10):
#    lead_tlv = []
#    sub_tlv = []
#    GEN_dirhadron_sum = []
#
#    n_selected = len(lead_final)
#    print(f"\n Building TLorentzVectors for {n_selected} selected events")
#
#    for i in range(n_selected):
#        v1 = ROOT.TLorentzVector()
#        v1.SetPtEtaPhiM(
#            float(lead_final.pt[i]),
#            float(lead_final.eta[i]),
#            float(lead_final.phi[i]),
#            float(lead_final.mass[i]),
#        )
#        lead_tlv.append(v1)
#
#        v2 = ROOT.TLorentzVector()
#        v2.SetPtEtaPhiM(
#            float(sub_final.pt[i]),
#            float(sub_final.eta[i]),
#            float(sub_final.phi[i]),
#            float(sub_final.mass[i]),
#        )
#        sub_tlv.append(v2)
#
#        v_sum = v1 + v2
#        GEN_dirhadron_sum.append(v_sum)
#
#    n_to_print = min(max_print, n_selected)
#    print(f"[DEBUG] Printing first {n_to_print} selected events")
#
#    for i in range(n_to_print):
#        print(f"\n[DEBUG] Selected event {i}")
#
#        print("  Leading GEN RHadron:")
#        print(f"    pdgId = {int(lead_final.pdgId[i])}")
#        print(f"    pt    = {lead_tlv[i].Pt():.6f}")
#        print(f"    eta   = {lead_tlv[i].Eta():.6f}")
#        print(f"    phi   = {lead_tlv[i].Phi():.6f}")
#        print(f"    mass  = {lead_tlv[i].M():.6f}")
#
#        print("  Subleading GEN RHadron:")
#        print(f"    pdgId = {int(sub_final.pdgId[i])}")
#        print(f"    pt    = {sub_tlv[i].Pt():.6f}")
#        print(f"    eta   = {sub_tlv[i].Eta():.6f}")
#        print(f"    phi   = {sub_tlv[i].Phi():.6f}")
#        print(f"    mass  = {sub_tlv[i].M():.6f}")
#
#        print("  Sum of GEN RHadrons:")
#        print(f"    pt    = {GEN_dirhadron_sum[i].Pt():.6f}")
#        print(f"    eta   = {GEN_dirhadron_sum[i].Eta():.6f}")
#        print(f"    phi   = {GEN_dirhadron_sum[i].Phi():.6f}")
#        print(f"    mass  = {GEN_dirhadron_sum[i].M():.6f}")
#
#    return lead_tlv, sub_tlv, GEN_dirhadron_sum
#
#def main():
#    tree = uproot.open(input_file)[tree_path]
#
#    branch_names = [
#        # GEN branches
#        "GenPart_pdgId",
#        "GenPart_pt",
#        "GenPart_eta",
#        "GenPart_phi",
#        "GenPart_mass",
#
#        # Event-level branches
#        "PV_npvsGood",
#        "HSCP_n",
#        "nIsoTrack",
#        "nMuon",
#        "HLT_FilterOR",
#
#        # Reco branches
#        "DeDx_Ih",
#        "IsoTrack_pt",
#        "IsoTrack_eta",
#        "IsoTrack_numberOfValidPixelHits",
#        "IsoTrack_fractionOfValidHits",
#        "IsoTrack_numberOfValidHits",
#        "IsoTrack_isHighPurityTrack",
#        "IsoTrack_normChi2",
#        "IsoTrack_dz",
#        "IsoTrack_dxy",
#        "IsoTrack_pfEnergyOverP",
#        "IsoTrack_ptErrOverPt2",
#        "IsoTrack_ptErrOverPt",
#    ]
#
#    branches = tree.arrays(branch_names, library="ak")
#
#    gen_pdgid = branches["GenPart_pdgId"]
#    gen_pt = branches["GenPart_pt"]
#    gen_eta = branches["GenPart_eta"]
#    gen_phi = branches["GenPart_phi"]
#    gen_mass = branches["GenPart_mass"]
#
#    PV_npvsGood = branches["PV_npvsGood"]
#    HSCP_n = branches["HSCP_n"]
#    nIsoTrack = branches["nIsoTrack"]
#    nMuon = branches["nMuon"]
#    HLT_FilterOR = branches["HLT_FilterOR"]
#
#    DeDx_Ih = branches["DeDx_Ih"]
#    IsoTrack_pt = branches["IsoTrack_pt"]
#    IsoTrack_eta = branches["IsoTrack_eta"]
#    IsoTrack_numberOfValidPixelHits = branches["IsoTrack_numberOfValidPixelHits"]
#    IsoTrack_fractionOfValidHits = branches["IsoTrack_fractionOfValidHits"]
#    IsoTrack_numberOfValidHits = branches["IsoTrack_numberOfValidHits"]
#    IsoTrack_isHighPurityTrack = branches["IsoTrack_isHighPurityTrack"]
#    IsoTrack_normChi2 = branches["IsoTrack_normChi2"]
#    IsoTrack_dz = branches["IsoTrack_dz"]
#    IsoTrack_dxy = branches["IsoTrack_dxy"]
#    IsoTrack_ptErrOverPt = branches["IsoTrack_ptErrOverPt"]
#    IsoTrack_ptErrOverPt2 = branches["IsoTrack_ptErrOverPt2"]
#    IsoTrack_pfEnergyOverP = branches["IsoTrack_pfEnergyOverP"]
#
#    rhadron_mask = jagged_isin(abs(gen_pdgid), rhadron_pdgids)
#
#    rhadrons = ak.zip(
#        {
#            "pdgId": gen_pdgid[rhadron_mask],
#            "pt": gen_pt[rhadron_mask],
#            "eta": gen_eta[rhadron_mask],
#            "phi": gen_phi[rhadron_mask],
#            "mass": gen_mass[rhadron_mask],
#        }
#    )
#
#    print(f"[DEBUG] Total events in input                 = {len(gen_pdgid)}")
#    print(f"[DEBUG] Events with >=1 GEN RHadron           = {int(ak.sum(ak.num(rhadrons) >= 1))}")
#    print(f"[DEBUG] Events with >=2 GEN RHadrons          = {int(ak.sum(ak.num(rhadrons) >= 2))}")
#
#    rhadrons = rhadrons[ak.argsort(rhadrons.pt, axis=1, ascending=False)]
#    rhadrons = ak.pad_none(rhadrons, 2)
#
#    leading_rhadron = rhadrons[:, 0]
#    subleading_rhadron = rhadrons[:, 1]
#
#    trigger_event_mask = HLT_FilterOR
#
#    reco_candidate_mask = (
#        (IsoTrack_pt > cuts["IsoTrack_pt"])
#        & (abs(IsoTrack_eta) < cuts["IsoTrack_eta"])
#        & (IsoTrack_fractionOfValidHits > cuts["IsoTrack_fractionOfValidHits"])
#        & (IsoTrack_numberOfValidPixelHits >= cuts["IsoTrack_numberOfValidPixelHits"])
#        & (IsoTrack_numberOfValidHits >= cuts["IsoTrack_numberOfValidHits"])
#        & (IsoTrack_isHighPurityTrack == cuts["IsoTrack_isHighPurityTrack"])
#        & (IsoTrack_normChi2 < cuts["IsoTrack_normChi2"])
#        & (abs(IsoTrack_dz) < cuts["IsoTrack_dz"])
#        & (abs(IsoTrack_dxy) < cuts["IsoTrack_dxy"])
#        & (IsoTrack_ptErrOverPt < cuts["IsoTrack_ptErrOverPt"])
#        & (IsoTrack_ptErrOverPt2 < cuts["IsoTrack_ptErrOverPt2"])
#        & (IsoTrack_pfEnergyOverP < cuts["IsoTrack_pfEnergyOverP"])
#        & (DeDx_Ih > cuts["C"])
#    )
#
#    reco_event_mask = ak.any(reco_candidate_mask, axis=1)
#
#    event_quality_mask = (
#        (PV_npvsGood >= cuts["PV_npvsGood"])
#        & (HSCP_n >= cuts["HSCP_n"])
#        & (nIsoTrack >= cuts["nIsoTrack"])
#        & (nMuon >= cuts["nMuon"])
#    )
#
#    gen_pair_mask = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron)
#    final_event_mask = ( reco_event_mask & trigger_event_mask & event_quality_mask & gen_pair_mask)
#
#    lead_final = leading_rhadron[final_event_mask]
#    sub_final = subleading_rhadron[final_event_mask]
#
#    n_final = int(ak.sum(final_event_mask))
#
#    print(f"[DEBUG] Events passing trigger                = {int(ak.sum(trigger_event_mask))}")
#    print(f"[DEBUG] Events passing reco cuts              = {int(ak.sum(reco_event_mask))}")
#    print(f"[DEBUG] Events passing event cuts             = {int(ak.sum(event_quality_mask))}")
#    print(f"[DEBUG] Events with GEN RHadron pair          = {int(ak.sum(gen_pair_mask))}")
#    print(f"[DEBUG] Events passing final selection        = {n_final}")
#
#    if n_final == 0:
#        print("[DEBUG] No selected events found")
#        return
#
#    print(f"[DEBUG] lead_final length                     = {len(lead_final)}")
#    print(f"[DEBUG] sub_final length                      = {len(sub_final)}")
#    print(f"[DEBUG] First selected leading pdgId          = {int(lead_final.pdgId[0])}")
#    print(f"[DEBUG] First selected subleading pdgId       = {int(sub_final.pdgId[0])}")
#
#    lead_tlv, sub_tlv, GEN_dirhadron_sum = build_tlorentz_vectors( lead_final, sub_final, max_print=cuts["max_events_to_print"])
#
#    out = {
#        # Full saved GEN info for selected events
#        "GenPart_pdgId": gen_pdgid[final_event_mask],
#        "GenPart_pt": gen_pt[final_event_mask],
#        "GenPart_eta": gen_eta[final_event_mask],
#        "GenPart_phi": gen_phi[final_event_mask],
#        "GenPart_mass": gen_mass[final_event_mask],
#
#        # Saved reco info for selected events
#        "IsoTrack_pt": IsoTrack_pt[final_event_mask],
#        "IsoTrack_eta": IsoTrack_eta[final_event_mask],
#        "IsoTrack_fractionOfValidHits": IsoTrack_fractionOfValidHits[final_event_mask],
#        "IsoTrack_numberOfValidPixelHits": IsoTrack_numberOfValidPixelHits[final_event_mask],
#        "IsoTrack_numberOfValidHits": IsoTrack_numberOfValidHits[final_event_mask],
#        "IsoTrack_isHighPurityTrack": IsoTrack_isHighPurityTrack[final_event_mask],
#        "IsoTrack_normChi2": IsoTrack_normChi2[final_event_mask],
#        "IsoTrack_dz": IsoTrack_dz[final_event_mask],
#        "IsoTrack_dxy": IsoTrack_dxy[final_event_mask],
#        "IsoTrack_ptErrOverPt": IsoTrack_ptErrOverPt[final_event_mask],
#        "IsoTrack_ptErrOverPt2": IsoTrack_ptErrOverPt2[final_event_mask],
#        "IsoTrack_pfEnergyOverP": IsoTrack_pfEnergyOverP[final_event_mask],
#        "DeDx_Ih": DeDx_Ih[final_event_mask],
#
#        # Event-level info
#        "PV_npvsGood": PV_npvsGood[final_event_mask],
#        "HSCP_n": HSCP_n[final_event_mask],
#        "nIsoTrack": nIsoTrack[final_event_mask],
#        "nMuon": nMuon[final_event_mask],
#        "HLT_FilterOR": HLT_FilterOR[final_event_mask],
#
#        # Which reco tracks passed the reco candidate mask
#        "reco_candidate_mask": reco_candidate_mask[final_event_mask],
#
#        # Leading GEN RHadron 4-vector
#        "GEN_LeadingRHadron_pdgId": np.array([int(x) for x in ak.to_list(lead_final.pdgId)], dtype=np.int32),
#        "GEN_LeadingRHadron_pt": np.array([v.Pt() for v in lead_tlv], dtype=np.float64),
#        "GEN_LeadingRHadron_eta": np.array([v.Eta() for v in lead_tlv], dtype=np.float64),
#        "GEN_LeadingRHadron_phi": np.array([v.Phi() for v in lead_tlv], dtype=np.float64),
#        "GEN_LeadingRHadron_mass": np.array([v.M() for v in lead_tlv], dtype=np.float64),
#
#        # Subleading GEN RHadron 4-vector
#        "GEN_SubleadingRHadron_pdgId": np.array([int(x) for x in ak.to_list(sub_final.pdgId)], dtype=np.int32),
#        "GEN_SubleadingRHadron_pt": np.array([v.Pt() for v in sub_tlv], dtype=np.float64),
#        "GEN_SubleadingRHadron_eta": np.array([v.Eta() for v in sub_tlv], dtype=np.float64),
#        "GEN_SubleadingRHadron_phi": np.array([v.Phi() for v in sub_tlv], dtype=np.float64),
#        "GEN_SubleadingRHadron_mass": np.array([v.M() for v in sub_tlv], dtype=np.float64),
#
#        # di_GEN RHadron 4-vector
#        "GEN_diRHadron_pt": np.array([v.Pt() for v in GEN_dirhadron_sum], dtype=np.float64),
#        "GEN_diRHadron_eta": np.array([v.Eta() for v in GEN_dirhadron_sum], dtype=np.float64),
#        "GEN_diRHadron_phi": np.array([v.Phi() for v in GEN_dirhadron_sum], dtype=np.float64),
#        "GEN_diRHadron_mass": np.array([v.M() for v in GEN_dirhadron_sum], dtype=np.float64),
#    }
#
#    with uproot.recreate(output_file) as fout:
#        fout["Events"] = out
#
#    print(f"\n[DEBUG] Wrote selected events: {output_file}")
#    print("[DEBUG] Saved leading/subleading/summed GEN 4-vectors as pt/eta/phi/mass branches")
#
#if __name__ == "__main__":
#    main()
#