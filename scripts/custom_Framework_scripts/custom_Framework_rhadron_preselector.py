#!/usr/bin/env python3
import os
import csv
import uproot
import awkward as ak
import numpy as np
import ROOT

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
    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,
    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
    1095314, 1095324, 1095334,

    1000612, 1000622, 1000632, 1000642, 1000652, 1006113, 1006211,
    1006213, 1006223, 1006311, 1006313, 1006321, 1006323, 1006333,
}

cuts = {
    "max_events_to_print": 1,

    # Event-level cuts
    "PV_npvsGood": 1,
    "HSCP_n": 1,
    "nIsoTrack": 1,
    "nMuon": 1,
    "PseudoMET_viaCaloJets": 170.0,

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


def make_tlv_arrays(lead, sub, max_print=0):
    lead_tlv = []
    sub_tlv = []
    di_tlv = []

    n_events = len(lead)
    print(f"\n[DEBUG] Building TLorentzVectors for {n_events} selected events")

    for i in range(n_events):
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

        lead_tlv.append(v1)
        sub_tlv.append(v2)
        di_tlv.append(v1 + v2)

    n_to_print = min(max_print, n_events)
    print(f"[DEBUG] Printing first {n_to_print} selected events")

    for i in range(n_to_print):
        print(f"\n[DEBUG] Selected event {i}")

        print("  Leading GEN RHadron:")
        print(f"    pdgId = {int(lead.pdgId[i])}")
        print(f"    pt    = {lead_tlv[i].Pt():.6f}")
        print(f"    eta   = {lead_tlv[i].Eta():.6f}")
        print(f"    phi   = {lead_tlv[i].Phi():.6f}")
        print(f"    mass  = {lead_tlv[i].M():.6f}")

        print("  Subleading GEN RHadron:")
        print(f"    pdgId = {int(sub.pdgId[i])}")
        print(f"    pt    = {sub_tlv[i].Pt():.6f}")
        print(f"    eta   = {sub_tlv[i].Eta():.6f}")
        print(f"    phi   = {sub_tlv[i].Phi():.6f}")
        print(f"    mass  = {sub_tlv[i].M():.6f}")

        print("  Sum of GEN RHadrons:")
        print(f"    pt    = {di_tlv[i].Pt():.6f}")
        print(f"    eta   = {di_tlv[i].Eta():.6f}")
        print(f"    phi   = {di_tlv[i].Phi():.6f}")
        print(f"    mass  = {di_tlv[i].M():.6f}")

    return lead_tlv, sub_tlv, di_tlv


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
    print(f"[INPUT] Sample       = {sample_name}")
    print(f"[INPUT] Input File   = {input_file}")
    print(f"[INPUT] TriggerMask  = {TriggerMask}")
    print(f"[OUTPUT] Output File = {output_file}")
    print("=" * 60)

    tree = uproot.open(input_file)[tree_path]
    data = tree.arrays(all_branch_names, library="ak")

    gen = {name: data[name] for name in gen_branches}
    evt = {name: data[name] for name in event_branches}
    trg = {name: data[name] for name in trigger_branches}
    reco = {name: data[name] for name in reco_branches}

    rhadron_mask = jagged_isin(abs(gen["GenPart_pdgId"]), rhadron_pdgids)

    rhadrons = ak.zip({
        "pdgId": gen["GenPart_pdgId"][rhadron_mask],
        "pt":    gen["GenPart_pt"][rhadron_mask],
        "eta":   gen["GenPart_eta"][rhadron_mask],
        "phi":   gen["GenPart_phi"][rhadron_mask],
        "mass":  gen["GenPart_mass"][rhadron_mask],
    })

    print(f"[DEBUG] Total events in input                 = {len(gen['GenPart_pdgId'])}")
    print(f"[DEBUG] Events with >=1 GEN RHadron           = {int(ak.sum(ak.num(rhadrons) >= 1))}")
    print(f"[DEBUG] Events with >=2 GEN RHadrons          = {int(ak.sum(ak.num(rhadrons) >= 2))}")

    rhadrons = rhadrons[ak.argsort(rhadrons.pt, axis=1, ascending=False)]
    rhadrons = ak.pad_none(rhadrons, 2)

    leading_rhadron = rhadrons[:, 0]
    subleading_rhadron = rhadrons[:, 1]
    gen_pair_mask = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron)

    # Trigger masks
    trigger_masks = {
        "HLT_FilterOR": trg["HLT_FilterOR"],

        "HLT_MET": (
            trg["HLT_PFMET120_PFMHT120_IDTight"]
            | trg["HLT_PFHT500_PFMET100_PFMHT100_IDTight"]
            | trg["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"]
            | trg["HLT_MET105_IsoTrk50"]
        ),

        "HLT_Mu": (
            trg["HLT_Mu50"]
            | trg["HLT_IsoMu24"]
            | trg["HLT_IsoMu27"]
            | trg["HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ"]
            | trg["HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL"]
        ),
    }

    if TriggerMask not in trigger_masks:
        raise ValueError(f"Unknown TriggerMask: {TriggerMask}")

    trigger_event_mask = trigger_masks[TriggerMask]
    print(f"[DEBUG] Using trigger definition            = {TriggerMask}")


    # Reco selection
    reco_candidate_mask = (
        (reco["IsoTrack_pt"] > cuts["IsoTrack_pt"])
        & (abs(reco["IsoTrack_eta"]) < cuts["IsoTrack_eta"])
        & (reco["IsoTrack_fractionOfValidHits"] > cuts["IsoTrack_fractionOfValidHits"])
        & (reco["IsoTrack_numberOfValidPixelHits"] >= cuts["IsoTrack_numberOfValidPixelHits"])
        & (reco["IsoTrack_numberOfValidHits"] >= cuts["IsoTrack_numberOfValidHits"])
        & (reco["IsoTrack_isHighPurityTrack"] == cuts["IsoTrack_isHighPurityTrack"])
        & (reco["IsoTrack_normChi2"] < cuts["IsoTrack_normChi2"])
        & (abs(reco["IsoTrack_dz"]) < cuts["IsoTrack_dz"])
        & (abs(reco["IsoTrack_dxy"]) < cuts["IsoTrack_dxy"])
        & (reco["IsoTrack_ptErrOverPt"] < cuts["IsoTrack_ptErrOverPt"])
        & (reco["IsoTrack_ptErrOverPt2"] < cuts["IsoTrack_ptErrOverPt2"])
        & (reco["IsoTrack_pfEnergyOverP"] < cuts["IsoTrack_pfEnergyOverP"])
        & (reco["DeDx_Ih"] > cuts["DeDx_Ih"])
    )

    reco_event_mask = ak.any(reco_candidate_mask, axis=1)
    # event selection
    event_quality_mask = (
        (evt["PV_npvsGood"] >= cuts["PV_npvsGood"])
        & (evt["HSCP_n"] >= cuts["HSCP_n"])
        & (evt["nIsoTrack"] >= cuts["nIsoTrack"])
        & (evt["nMuon"] >= cuts["nMuon"])
        & (evt["PseudoMET_viaCaloJets"] > cuts["PseudoMET_viaCaloJets"])
    )
    # final selection
    final_event_mask = (
        gen_pair_mask
        & event_quality_mask
        & reco_event_mask
        & trigger_event_mask
    )

    print(f"[DEBUG] Events passing trigger                = {int(ak.sum(trigger_event_mask))}")
    print(f"[DEBUG] Events passing reco cuts              = {int(ak.sum(reco_event_mask))}")
    print(f"[DEBUG] Events passing event cuts             = {int(ak.sum(event_quality_mask))}")
    print(f"[DEBUG] Events with GEN RHadron pair          = {int(ak.sum(gen_pair_mask))}")
    print(f"[DEBUG] Events passing final selection        = {int(ak.sum(final_event_mask))}")

    lead_final = leading_rhadron[final_event_mask]
    sub_final = subleading_rhadron[final_event_mask]
    n_final = len(lead_final)
   
    # Writes CSV for events that pass final selection for  GEN_diRHadron_pt < 150 GeV
    selected_indices = np.nonzero(ak.to_numpy(final_event_mask))[0]

    selected_di_pt = build_gen_dirhadron_pt(
        leading_rhadron[final_event_mask],
        subleading_rhadron[final_event_mask],
    )

    low_selected_mask = selected_di_pt < 150.0
    low_selected_indices = selected_indices[low_selected_mask]

    csv_name = f"{sample_name}_{TriggerMask}_low_diRHadron_pt_debug.csv"
    csv_path = os.path.join(output_dir, csv_name) if "output_dir" in locals() else csv_name

    rows = []

    for evt_idx in low_selected_indices:
        lead = leading_rhadron[evt_idx]
        sub  = subleading_rhadron[evt_idx]

        v1 = ROOT.TLorentzVector()
        v1.SetPtEtaPhiM(float(lead.pt), float(lead.eta), float(lead.phi), float(lead.mass))

        v2 = ROOT.TLorentzVector()
        v2.SetPtEtaPhiM(float(sub.pt), float(sub.eta), float(sub.phi), float(sub.mass))

        di = v1 + v2

        n_tracks = len(reco["IsoTrack_pt"][evt_idx])

        for itrk in range(n_tracks):
            pt_val                    = float(reco["IsoTrack_pt"][evt_idx][itrk])
            eta_val                   = float(reco["IsoTrack_eta"][evt_idx][itrk])
            frac_hits_val             = float(reco["IsoTrack_fractionOfValidHits"][evt_idx][itrk])
            n_pix_val                 = int(reco["IsoTrack_numberOfValidPixelHits"][evt_idx][itrk])
            n_valid_val               = int(reco["IsoTrack_numberOfValidHits"][evt_idx][itrk])
            high_purity_val           = bool(reco["IsoTrack_isHighPurityTrack"][evt_idx][itrk])
            normchi2_val              = float(reco["IsoTrack_normChi2"][evt_idx][itrk])
            dz_val                    = float(reco["IsoTrack_dz"][evt_idx][itrk])
            dxy_val                   = float(reco["IsoTrack_dxy"][evt_idx][itrk])
            pterr_val                 = float(reco["IsoTrack_ptErrOverPt"][evt_idx][itrk])
            pterr2_val                = float(reco["IsoTrack_ptErrOverPt2"][evt_idx][itrk])
            pfEoverP_val              = float(reco["IsoTrack_pfEnergyOverP"][evt_idx][itrk])
            dedx_val                  = float(reco["DeDx_Ih"][evt_idx][itrk])
            reco_pass_val             = bool(reco_candidate_mask[evt_idx][itrk])

            row = {
                "event_index": int(evt_idx),

                "gen_pair_mask": bool(gen_pair_mask[evt_idx]),
                "event_quality_mask": bool(event_quality_mask[evt_idx]),
                "reco_event_mask": bool(reco_event_mask[evt_idx]),
                "trigger_event_mask": bool(trigger_event_mask[evt_idx]),
                "final_event_mask": bool(final_event_mask[evt_idx]),

                "PV_npvsGood": int(evt["PV_npvsGood"][evt_idx]),
                "HSCP_n": int(evt["HSCP_n"][evt_idx]),
                "nIsoTrack": int(evt["nIsoTrack"][evt_idx]),
                "nMuon": int(evt["nMuon"][evt_idx]),
                "PseudoMET_viaCaloJets": float(evt["PseudoMET_viaCaloJets"][evt_idx]),

                "lead_pdgId": int(lead.pdgId),
                "lead_pt": float(v1.Pt()),
                "lead_eta": float(v1.Eta()),
                "lead_phi": float(v1.Phi()),
                "lead_mass": float(v1.M()),

                "sub_pdgId": int(sub.pdgId),
                "sub_pt": float(v2.Pt()),
                "sub_eta": float(v2.Eta()),
                "sub_phi": float(v2.Phi()),
                "sub_mass": float(v2.M()),

                "diRHadron_pt": float(di.Pt()),
                "diRHadron_eta": float(di.Eta()),
                "diRHadron_phi": float(di.Phi()),
                "diRHadron_mass": float(di.M()),

                "HLT_PFMET120_PFMHT120_IDTight": bool(trg["HLT_PFMET120_PFMHT120_IDTight"][evt_idx]),
                "HLT_PFHT500_PFMET100_PFMHT100_IDTight": bool(trg["HLT_PFHT500_PFMET100_PFMHT100_IDTight"][evt_idx]),
                "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": bool(trg["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"][evt_idx]),
                "HLT_MET105_IsoTrk50": bool(trg["HLT_MET105_IsoTrk50"][evt_idx]),
                "HLT_Mu50": bool(trg["HLT_Mu50"][evt_idx]),
                "HLT_IsoMu24": bool(trg["HLT_IsoMu24"][evt_idx]),
                "HLT_IsoMu27": bool(trg["HLT_IsoMu27"][evt_idx]),
                "HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ": bool(trg["HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ"][evt_idx]),
                "HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL": bool(trg["HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL"][evt_idx]),
                "HLT_FilterOR": bool(trg["HLT_FilterOR"][evt_idx]),

                "track_index": itrk,
                "track_passes_reco_candidate_mask": reco_pass_val,
                "IsoTrack_pt": pt_val,
                "IsoTrack_eta": eta_val,
                "IsoTrack_fractionOfValidHits": frac_hits_val,
                "IsoTrack_numberOfValidPixelHits": n_pix_val,
                "IsoTrack_numberOfValidHits": n_valid_val,
                "IsoTrack_isHighPurityTrack": high_purity_val,
                "IsoTrack_normChi2": normchi2_val,
                "IsoTrack_dz": dz_val,
                "IsoTrack_dxy": dxy_val,
                "IsoTrack_ptErrOverPt": pterr_val,
                "IsoTrack_ptErrOverPt2": pterr2_val,
                "IsoTrack_pfEnergyOverP": pfEoverP_val,
                "DeDx_Ih": dedx_val,

                "cut_pt": pt_val > cuts["IsoTrack_pt"],
                "cut_eta": abs(eta_val) < cuts["IsoTrack_eta"],
                "cut_fractionOfValidHits": frac_hits_val > cuts["IsoTrack_fractionOfValidHits"],
                "cut_numberOfValidPixelHits": n_pix_val >= cuts["IsoTrack_numberOfValidPixelHits"],
                "cut_numberOfValidHits": n_valid_val >= cuts["IsoTrack_numberOfValidHits"],
                "cut_isHighPurityTrack": high_purity_val == cuts["IsoTrack_isHighPurityTrack"],
                "cut_normChi2": normchi2_val < cuts["IsoTrack_normChi2"],
                "cut_dz": abs(dz_val) < cuts["IsoTrack_dz"],
                "cut_dxy": abs(dxy_val) < cuts["IsoTrack_dxy"],
                "cut_ptErrOverPt": pterr_val < cuts["IsoTrack_ptErrOverPt"],
                "cut_ptErrOverPt2": pterr2_val < cuts["IsoTrack_ptErrOverPt2"],
                "cut_pfEnergyOverP": pfEoverP_val < cuts["IsoTrack_pfEnergyOverP"],
                "cut_DeDx_Ih": dedx_val > cuts["DeDx_Ih"],
            }

            rows.append(row)

    if rows:
        with open(csv_path, "w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
            writer.writeheader()
            writer.writerows(rows)

        print(f"[DEBUG] Wrote low-diRHadron-pt debug CSV: {csv_path}")
        print(f"[DEBUG] Number of rows written: {len(rows)}")
        print(f"[DEBUG] Number of events written: {len(low_selected_indices)}")
    else:
        print("[DEBUG] No selected events with GEN_diRHadron_pt < 150 GeV were found")

    selected_indices = np.nonzero(ak.to_numpy(final_event_mask))[0]

    selected_gen_dirhadron_pt = build_gen_dirhadron_pt(
        leading_rhadron[final_event_mask],
        subleading_rhadron[final_event_mask],
    )

    low_pt_mask = selected_gen_dirhadron_pt < 150.0
    low_pt_indices = selected_indices[low_pt_mask]

    print("\n" + "=" * 100)
    print(" Searching for events that PASSED final selection but have GEN_diRHadron_pt < 150 GeV")
    print(f"Number of selected events with GEN_diRHadron_pt < 150 GeV = {len(low_pt_indices)}")

    for evt_idx in low_pt_indices:
        print("\n" + "-" * 100)
        print(f"[DEBUG] ORIGINAL EVENT INDEX = {evt_idx}")

        lead = leading_rhadron[evt_idx]
        sub = subleading_rhadron[evt_idx]

        v1 = ROOT.TLorentzVector()
        v1.SetPtEtaPhiM(float(lead.pt), float(lead.eta), float(lead.phi), float(lead.mass))

        v2 = ROOT.TLorentzVector()
        v2.SetPtEtaPhiM(float(sub.pt), float(sub.eta), float(sub.phi), float(sub.mass))

        di = v1 + v2

        print("[DEBUG] GEN RHadron info:")
        print(f"  lead pdgId = {int(lead.pdgId)}, pt = {v1.Pt():.6f}, eta = {v1.Eta():.6f}, phi = {v1.Phi():.6f}, mass = {v1.M():.6f}")
        print(f"  sub  pdgId = {int(sub.pdgId)}, pt = {v2.Pt():.6f}, eta = {v2.Eta():.6f}, phi = {v2.Phi():.6f}, mass = {v2.M():.6f}")
        print(f"  diRHadron pt = {di.Pt():.6f}, eta = {di.Eta():.6f}, phi = {di.Phi():.6f}, mass = {di.M():.6f}")

        # Event-level info
        print("[DEBUG] Event-level variables:")
        print(f"  PV_npvsGood            = {evt['PV_npvsGood'][evt_idx]}")
        print(f"  HSCP_n                 = {evt['HSCP_n'][evt_idx]}")
        print(f"  nIsoTrack              = {evt['nIsoTrack'][evt_idx]}")
        print(f"  nMuon                  = {evt['nMuon'][evt_idx]}")
        print(f"  PseudoMET_viaCaloJets  = {evt['PseudoMET_viaCaloJets'][evt_idx]}")

        print("[DEBUG] Event-level masks:")
        print(f"  gen_pair_mask        = {bool(gen_pair_mask[evt_idx])}")
        print(f"  event_quality_mask   = {bool(event_quality_mask[evt_idx])}")
        print(f"  reco_event_mask      = {bool(reco_event_mask[evt_idx])}")
        print(f"  trigger_event_mask   = {bool(trigger_event_mask[evt_idx])}")
        print(f"  final_event_mask     = {bool(final_event_mask[evt_idx])}")

        # Trigger
        print("[DEBUG] Trigger bits:")
        for trg_name in trigger_branches:
            print(f"  {trg_name:<45} = {bool(trg[trg_name][evt_idx])}")

        # Track-by-track  info
        print("[DEBUG] Reco tracks in this event:")
        n_tracks = len(reco["IsoTrack_pt"][evt_idx])

        for itrk in range(n_tracks):
            print(f"\n  [TRACK {itrk}]")
            print(f"    passes reco_candidate_mask = {bool(reco_candidate_mask[evt_idx][itrk])}")
            print(f"    IsoTrack_pt                       = {reco['IsoTrack_pt'][evt_idx][itrk]}")
            print(f"    IsoTrack_eta                      = {reco['IsoTrack_eta'][evt_idx][itrk]}")
            print(f"    IsoTrack_fractionOfValidHits      = {reco['IsoTrack_fractionOfValidHits'][evt_idx][itrk]}")
            print(f"    IsoTrack_numberOfValidPixelHits   = {reco['IsoTrack_numberOfValidPixelHits'][evt_idx][itrk]}")
            print(f"    IsoTrack_numberOfValidHits        = {reco['IsoTrack_numberOfValidHits'][evt_idx][itrk]}")
            print(f"    IsoTrack_isHighPurityTrack        = {reco['IsoTrack_isHighPurityTrack'][evt_idx][itrk]}")
            print(f"    IsoTrack_normChi2                 = {reco['IsoTrack_normChi2'][evt_idx][itrk]}")
            print(f"    IsoTrack_dz                       = {reco['IsoTrack_dz'][evt_idx][itrk]}")
            print(f"    IsoTrack_dxy                      = {reco['IsoTrack_dxy'][evt_idx][itrk]}")
            print(f"    IsoTrack_ptErrOverPt              = {reco['IsoTrack_ptErrOverPt'][evt_idx][itrk]}")
            print(f"    IsoTrack_ptErrOverPt2             = {reco['IsoTrack_ptErrOverPt2'][evt_idx][itrk]}")
            print(f"    IsoTrack_pfEnergyOverP            = {reco['IsoTrack_pfEnergyOverP'][evt_idx][itrk]}")
            print(f"    DeDx_Ih                           = {reco['DeDx_Ih'][evt_idx][itrk]}")

            print("    Individual cut decisions:")
            print(f"      pt > {cuts['IsoTrack_pt']}                               -> {reco['IsoTrack_pt'][evt_idx][itrk] > cuts['IsoTrack_pt']}")
            print(f"      |eta| < {cuts['IsoTrack_eta']}                            -> {abs(reco['IsoTrack_eta'][evt_idx][itrk]) < cuts['IsoTrack_eta']}")
            print(f"      fractionOfValidHits > {cuts['IsoTrack_fractionOfValidHits']}         -> {reco['IsoTrack_fractionOfValidHits'][evt_idx][itrk] > cuts['IsoTrack_fractionOfValidHits']}")
            print(f"      numberOfValidPixelHits >= {cuts['IsoTrack_numberOfValidPixelHits']}   -> {reco['IsoTrack_numberOfValidPixelHits'][evt_idx][itrk] >= cuts['IsoTrack_numberOfValidPixelHits']}")
            print(f"      numberOfValidHits >= {cuts['IsoTrack_numberOfValidHits']}             -> {reco['IsoTrack_numberOfValidHits'][evt_idx][itrk] >= cuts['IsoTrack_numberOfValidHits']}")
            print(f"      isHighPurityTrack == {cuts['IsoTrack_isHighPurityTrack']}             -> {reco['IsoTrack_isHighPurityTrack'][evt_idx][itrk] == cuts['IsoTrack_isHighPurityTrack']}")
            print(f"      normChi2 < {cuts['IsoTrack_normChi2']}                     -> {reco['IsoTrack_normChi2'][evt_idx][itrk] < cuts['IsoTrack_normChi2']}")
            print(f"      |dz| < {cuts['IsoTrack_dz']}                              -> {abs(reco['IsoTrack_dz'][evt_idx][itrk]) < cuts['IsoTrack_dz']}")
            print(f"      |dxy| < {cuts['IsoTrack_dxy']}                            -> {abs(reco['IsoTrack_dxy'][evt_idx][itrk]) < cuts['IsoTrack_dxy']}")
            print(f"      ptErrOverPt < {cuts['IsoTrack_ptErrOverPt']}              -> {reco['IsoTrack_ptErrOverPt'][evt_idx][itrk] < cuts['IsoTrack_ptErrOverPt']}")
            print(f"      ptErrOverPt2 < {cuts['IsoTrack_ptErrOverPt2']}            -> {reco['IsoTrack_ptErrOverPt2'][evt_idx][itrk] < cuts['IsoTrack_ptErrOverPt2']}")
            print(f"      pfEnergyOverP < {cuts['IsoTrack_pfEnergyOverP']}          -> {reco['IsoTrack_pfEnergyOverP'][evt_idx][itrk] < cuts['IsoTrack_pfEnergyOverP']}")
            print(f"      DeDx_Ih > {cuts['DeDx_Ih']}                               -> {reco['DeDx_Ih'][evt_idx][itrk] > cuts['DeDx_Ih']}")


    cutflow_steps = {
        "pt_gen_pair": gen_pair_mask,
        "pt_gen_pair_event": gen_pair_mask & event_quality_mask,
        "pt_gen_pair_event_reco": gen_pair_mask & event_quality_mask & reco_event_mask,
        "pt_gen_pair_event_reco_trigger": gen_pair_mask & event_quality_mask & reco_event_mask & trigger_event_mask,
    }

    cutflow_arrays = {
        name: build_gen_dirhadron_pt(leading_rhadron[mask], subleading_rhadron[mask])
        for name, mask in cutflow_steps.items()
    }

    empty = np.asarray([], dtype=np.float64)

    cutflow_arrays.update({
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
    })

    trigger_cutflow_map = {
        "HLT_FilterOR": {
            "pt_trg_HLT_FilterOR": trg["HLT_FilterOR"],
        },
        "HLT_MET": {
            "pt_trg_PFMET120_PFMHT120_IDTight": trg["HLT_PFMET120_PFMHT120_IDTight"],
            "pt_trg_PFHT500_PFMET100_PFMHT100_IDTight": trg["HLT_PFHT500_PFMET100_PFMHT100_IDTight"],
            "pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": trg["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"],
            "pt_trg_MET105_IsoTrk50": trg["HLT_MET105_IsoTrk50"],
        },
        "HLT_Mu": {
            "pt_trg_HLT_Mu50": trg["HLT_Mu50"],
            "pt_trg_IsoMu24": trg["HLT_IsoMu24"],
            "pt_trg_IsoMu27": trg["HLT_IsoMu27"],
            "pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ": trg["HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ"],
            "pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL": trg["HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL"],
        },
    }

    base_cut_mask = gen_pair_mask & event_quality_mask & reco_event_mask
    for out_name, trig_mask in trigger_cutflow_map[TriggerMask].items():
        mask = base_cut_mask & trig_mask
        cutflow_arrays[out_name] = build_gen_dirhadron_pt(
            leading_rhadron[mask],
            subleading_rhadron[mask],
        )

    print(f"[DEBUG] Cutflow pt_gen_pair entries                    = {len(cutflow_arrays['pt_gen_pair'])}")
    print(f"[DEBUG] Cutflow pt_gen_pair_event entries              = {len(cutflow_arrays['pt_gen_pair_event'])}")
    print(f"[DEBUG] Cutflow pt_gen_pair_event_reco entries         = {len(cutflow_arrays['pt_gen_pair_event_reco'])}")
    print(f"[DEBUG] Cutflow pt_gen_pair_event_reco_trigger entries = {len(cutflow_arrays['pt_gen_pair_event_reco_trigger'])}")

    if n_final == 0:
        print("[DEBUG] No selected events found")
        return

    print(f"[DEBUG] lead_final length                     = {len(lead_final)}")
    print(f"[DEBUG] sub_final length                      = {len(sub_final)}")
    print(f"[DEBUG] First selected leading pdgId          = {int(lead_final.pdgId[0])}")
    print(f"[DEBUG] First selected subleading pdgId       = {int(sub_final.pdgId[0])}")

    lead_tlv, sub_tlv, di_tlv = make_tlv_arrays(
        lead_final,
        sub_final,
        max_print=cuts["max_events_to_print"]
    )

    out = {}

    for name in gen_branches + event_branches + reco_branches + trigger_branches:
        out[name] = data[name][final_event_mask]

    out["reco_candidate_mask"] = reco_candidate_mask[final_event_mask]

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

    out["GEN_diRHadron_pt"] = np.array([v.Pt() for v in di_tlv], dtype=np.float64)
    out["GEN_diRHadron_eta"] = np.array([v.Eta() for v in di_tlv], dtype=np.float64)
    out["GEN_diRHadron_phi"] = np.array([v.Phi() for v in di_tlv], dtype=np.float64)
    out["GEN_diRHadron_mass"] = np.array([v.M() for v in di_tlv], dtype=np.float64)

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

#no-csv writing here. I am saving so I can reference it for now
#import uproot
#import awkward as ak
#import numpy as np
#import ROOT
#import os
#
#year = 2024
#GTAG = "150X_mcRun3_2024_realistic_v2"
#era = "D"
#tag = "MC"
#
#tree_path = "HSCPMiniAODAnalyzer/Events"
#output_dir = "/uscms/home/avendras/nobackup/HSCP/scripts/custom_Framework_scripts/preselected_rootfiles"
#
#samples = {
#    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150":
#        "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
#
#    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA":
#        "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_xqcutNA_MC.root",
#}
#
#trigger_options = [
#    "HLT_FilterOR",
#    "HLT_MET",
#    "HLT_Mu",
#]
#
#rhadron_pdgids = {
#    1000993, 1009213, 1009313, 1009323, 1009113, 1009223, 1009333,  # gluinos
#    1091114, 1092114, 1092214, 1092224, 1093114, 1093214, 1093224,
#    1093314, 1093324, 1093334, 1009413, 1009423, 1009433, 1009443,
#    1009513, 1009523, 1009533, 1009543, 1009553, 1094114, 1094214,
#    1094224, 1094314, 1094324, 1094334, 1095114, 1095214, 1095224,
#    1095314, 1095324, 1095334,
#
#    1000612, 1000622, 1000632, 1000642, 1000652, 1006113, 1006211,  # stops
#    1006213, 1006223, 1006311, 1006313, 1006321, 1006323, 1006333,
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
#    "PseudoMET_viaCaloJets": 170.0, #PseudoCaloMET
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
#    "DeDx_Ih": 1.0,
#}
#
#gen_branches = [
#    "GenPart_pdgId",
#    "GenPart_pt",
#    "GenPart_eta",
#    "GenPart_phi",
#    "GenPart_mass",
#]
#
#event_branches = [
#    "PV_npvsGood",
#    "HSCP_n",
#    "nIsoTrack",
#    "nMuon",
#    "PseudoMET_viaCaloJets",
#]
#
#trigger_branches = [
#    "HLT_PFMET120_PFMHT120_IDTight",
#    "HLT_PFHT500_PFMET100_PFMHT100_IDTight",
#    "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60",
#    "HLT_MET105_IsoTrk50",
#    "HLT_Mu50",
#    "HLT_IsoMu24",
#    "HLT_IsoMu27",
#    "HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ",
#    "HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL",
#    "HLT_FilterOR",
#]
#
#reco_branches = [
#    "DeDx_Ih",
#    "IsoTrack_pt",
#    "IsoTrack_eta",
#    "IsoTrack_numberOfValidPixelHits",
#    "IsoTrack_fractionOfValidHits",
#    "IsoTrack_numberOfValidHits",
#    "IsoTrack_isHighPurityTrack",
#    "IsoTrack_normChi2",
#    "IsoTrack_dz",
#    "IsoTrack_dxy",
#    "IsoTrack_pfEnergyOverP",
#    "IsoTrack_ptErrOverPt2",
#    "IsoTrack_ptErrOverPt",
#]
#
#all_branch_names = gen_branches + event_branches + trigger_branches + reco_branches
#
#
#def jagged_isin(jagged_array, valid_values):
#    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
#    return ak.unflatten(flat_mask, ak.num(jagged_array))
#
#
#def build_tlorentz_vectors(lead_final, sub_final, max_print=10):
#    lead_tlv = []
#    sub_tlv = []
#    GEN_dirhadron_sum = []
#
#    n_selected = len(lead_final)
#    print(f"\n[DEBUG] Building TLorentzVectors for {n_selected} selected events")
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
#        GEN_dirhadron_sum.append(v1 + v2)
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
#
#def build_gen_dirhadron_pt(lead, sub):
#    valid_mask = ~ak.is_none(lead) & ~ak.is_none(sub)
#    lead = lead[valid_mask]
#    sub = sub[valid_mask]
#
#    pts = []
#    for i in range(len(lead)):
#        v1 = ROOT.TLorentzVector()
#        v1.SetPtEtaPhiM(
#            float(lead.pt[i]),
#            float(lead.eta[i]),
#            float(lead.phi[i]),
#            float(lead.mass[i]),
#        )
#
#        v2 = ROOT.TLorentzVector()
#        v2.SetPtEtaPhiM(
#            float(sub.pt[i]),
#            float(sub.eta[i]),
#            float(sub.phi[i]),
#            float(sub.mass[i]),
#        )
#
#        pts.append((v1 + v2).Pt())
#
#    return np.asarray(pts, dtype=np.float64)
#
#
#def print_failed_events(
#    final_event_mask,
#    gen_pair_mask,
#    trigger_event_mask,
#    event_quality_mask,
#    reco_event_mask,
#    reco_candidate_mask,
#    PV_npvsGood,
#    HSCP_n,
#    nIsoTrack,
#    nMuon,
#    PseudoMET_viaCaloJets,
#    IsoTrack_pt,
#    IsoTrack_eta,
#    IsoTrack_numberOfValidPixelHits,
#    IsoTrack_fractionOfValidHits,
#    IsoTrack_numberOfValidHits,
#    IsoTrack_isHighPurityTrack,
#    IsoTrack_normChi2,
#    IsoTrack_dz,
#    IsoTrack_dxy,
#    IsoTrack_pfEnergyOverP,
#    IsoTrack_ptErrOverPt,
#    IsoTrack_ptErrOverPt2,
#    DeDx_Ih,
#    cuts,
#    max_failed_to_print=5,
#):
#    failed_indices = np.asarray(ak.to_numpy(ak.where(~final_event_mask)[0]))
#
#    print("\n" + "=" * 80)
#    print(f"[DEBUG] Found {len(failed_indices)} failed events")
#    print(f"[DEBUG] Printing up to {min(max_failed_to_print, len(failed_indices))} failed events")
#    print("=" * 80)
#
#    for ievt in failed_indices[:max_failed_to_print]:
#        print("\n" + "-" * 80)
#        print(f"[DEBUG] FAILED EVENT index = {int(ievt)}")
#        print("-" * 80)
#
#        # Overall masks
#        print("[DEBUG] Overall decision:")
#        print(f"  gen_pair_mask       = {bool(gen_pair_mask[ievt])}")
#        print(f"  trigger_event_mask  = {bool(trigger_event_mask[ievt])}")
#        print(f"  event_quality_mask  = {bool(event_quality_mask[ievt])}")
#        print(f"  reco_event_mask     = {bool(reco_event_mask[ievt])}")
#        print(f"  final_event_mask    = {bool(final_event_mask[ievt])}")
#
#        # Why it failed
#        print("[DEBUG] Failure reasons:")
#        if not bool(gen_pair_mask[ievt]):
#            print("  - Failed GEN pair requirement: event does not have 2 padded GEN RHadrons")
#        if not bool(trigger_event_mask[ievt]):
#            print("  - Failed trigger requirement")
#        if not bool(event_quality_mask[ievt]):
#            print("  - Failed event-level requirement(s)")
#        if not bool(reco_event_mask[ievt]):
#            print("  - Failed reco requirement: no IsoTrack passed all reco cuts")
#
#        # Event-level values
#        print("[DEBUG] Event-level values:")
#        print(f"  PV_npvsGood           = {PV_npvsGood[ievt]}")
#        print(f"  HSCP_n                = {HSCP_n[ievt]}")
#        print(f"  nIsoTrack             = {nIsoTrack[ievt]}")
#        print(f"  nMuon                 = {nMuon[ievt]}")
#        print(f"  PseudoMET_viaCaloJets = {PseudoMET_viaCaloJets[ievt]}")
#
#        print("[DEBUG] Event-level cut checks:")
#        print(f"  PV_npvsGood >= {cuts['PV_npvsGood']}                -> {bool(PV_npvsGood[ievt] >= cuts['PV_npvsGood'])}")
#        print(f"  HSCP_n >= {cuts['HSCP_n']}                          -> {bool(HSCP_n[ievt] >= cuts['HSCP_n'])}")
#        print(f"  nIsoTrack >= {cuts['nIsoTrack']}                    -> {bool(nIsoTrack[ievt] >= cuts['nIsoTrack'])}")
#        print(f"  nMuon >= {cuts['nMuon']}                            -> {bool(nMuon[ievt] >= cuts['nMuon'])}")
#        print(f"  PseudoMET_viaCaloJets > {cuts['PseudoMET_viaCaloJets']} -> {bool(PseudoMET_viaCaloJets[ievt] > cuts['PseudoMET_viaCaloJets'])}")
#
#        # Track-level info
#        pts = ak.to_list(IsoTrack_pt[ievt])
#        etas = ak.to_list(IsoTrack_eta[ievt])
#        pix = ak.to_list(IsoTrack_numberOfValidPixelHits[ievt])
#        frac = ak.to_list(IsoTrack_fractionOfValidHits[ievt])
#        nhits = ak.to_list(IsoTrack_numberOfValidHits[ievt])
#        hp = ak.to_list(IsoTrack_isHighPurityTrack[ievt])
#        chi2 = ak.to_list(IsoTrack_normChi2[ievt])
#        dz = ak.to_list(IsoTrack_dz[ievt])
#        dxy = ak.to_list(IsoTrack_dxy[ievt])
#        eop = ak.to_list(IsoTrack_pfEnergyOverP[ievt])
#        pterr = ak.to_list(IsoTrack_ptErrOverPt[ievt])
#        pterr2 = ak.to_list(IsoTrack_ptErrOverPt2[ievt])
#        dedx = ak.to_list(DeDx_Ih[ievt])
#        reco_mask_evt = ak.to_list(reco_candidate_mask[ievt])
#
#        print(f"[DEBUG] Number of stored IsoTracks in event = {len(pts)}")
#
#        if len(pts) == 0:
#            print("  No IsoTracks stored in this event")
#            continue
#
#        for itrk in range(len(pts)):
#            print(f"\n  [DEBUG] Track {itrk}")
#            print(f"    reco_candidate_mask = {reco_mask_evt[itrk]}")
#            print(f"    IsoTrack_pt                  = {pts[itrk]}")
#            print(f"    IsoTrack_eta                 = {etas[itrk]}")
#            print(f"    IsoTrack_numberOfValidPixelHits = {pix[itrk]}")
#            print(f"    IsoTrack_fractionOfValidHits = {frac[itrk]}")
#            print(f"    IsoTrack_numberOfValidHits   = {nhits[itrk]}")
#            print(f"    IsoTrack_isHighPurityTrack   = {hp[itrk]}")
#            print(f"    IsoTrack_normChi2            = {chi2[itrk]}")
#            print(f"    IsoTrack_dz                  = {dz[itrk]}")
#            print(f"    IsoTrack_dxy                 = {dxy[itrk]}")
#            print(f"    IsoTrack_pfEnergyOverP       = {eop[itrk]}")
#            print(f"    IsoTrack_ptErrOverPt         = {pterr[itrk]}")
#            print(f"    IsoTrack_ptErrOverPt2        = {pterr2[itrk]}")
#            print(f"    DeDx_Ih                      = {dedx[itrk]}")
#
#            print("    Cut checks:")
#            print(f"      pt > {cuts['IsoTrack_pt']}                              -> {pts[itrk] > cuts['IsoTrack_pt']}")
#            print(f"      |eta| < {cuts['IsoTrack_eta']}                          -> {abs(etas[itrk]) < cuts['IsoTrack_eta']}")
#            print(f"      fractionOfValidHits > {cuts['IsoTrack_fractionOfValidHits']} -> {frac[itrk] > cuts['IsoTrack_fractionOfValidHits']}")
#            print(f"      numberOfValidPixelHits >= {cuts['IsoTrack_numberOfValidPixelHits']} -> {pix[itrk] >= cuts['IsoTrack_numberOfValidPixelHits']}")
#            print(f"      numberOfValidHits >= {cuts['IsoTrack_numberOfValidHits']} -> {nhits[itrk] >= cuts['IsoTrack_numberOfValidHits']}")
#            print(f"      isHighPurityTrack == {cuts['IsoTrack_isHighPurityTrack']} -> {hp[itrk] == cuts['IsoTrack_isHighPurityTrack']}")
#            print(f"      normChi2 < {cuts['IsoTrack_normChi2']}                  -> {chi2[itrk] < cuts['IsoTrack_normChi2']}")
#            print(f"      |dz| < {cuts['IsoTrack_dz']}                            -> {abs(dz[itrk]) < cuts['IsoTrack_dz']}")
#            print(f"      |dxy| < {cuts['IsoTrack_dxy']}                          -> {abs(dxy[itrk]) < cuts['IsoTrack_dxy']}")
#            print(f"      ptErrOverPt < {cuts['IsoTrack_ptErrOverPt']}            -> {pterr[itrk] < cuts['IsoTrack_ptErrOverPt']}")
#            print(f"      ptErrOverPt2 < {cuts['IsoTrack_ptErrOverPt2']}          -> {pterr2[itrk] < cuts['IsoTrack_ptErrOverPt2']}")
#            print(f"      pfEnergyOverP < {cuts['IsoTrack_pfEnergyOverP']}        -> {eop[itrk] < cuts['IsoTrack_pfEnergyOverP']}")
#            print(f"      DeDx_Ih > {cuts['DeDx_Ih']}                             -> {dedx[itrk] > cuts['DeDx_Ih']}")
#def print_selected_low_pt_events(
#    final_event_mask,
#    leading_rhadron,
#    subleading_rhadron,
#    trigger_event_mask,
#    event_quality_mask,
#    reco_event_mask,
#    reco_candidate_mask,
#    PV_npvsGood,
#    HSCP_n,
#    nIsoTrack,
#    nMuon,
#    PseudoMET_viaCaloJets,
#    IsoTrack_pt,
#    IsoTrack_eta,
#    IsoTrack_numberOfValidPixelHits,
#    IsoTrack_fractionOfValidHits,
#    IsoTrack_numberOfValidHits,
#    IsoTrack_isHighPurityTrack,
#    IsoTrack_normChi2,
#    IsoTrack_dz,
#    IsoTrack_dxy,
#    IsoTrack_pfEnergyOverP,
#    IsoTrack_ptErrOverPt,
#    IsoTrack_ptErrOverPt2,
#    DeDx_Ih,
#    cuts,
#    max_to_print=None,
#):
#    selected_indices = np.asarray(ak.to_numpy(ak.where(final_event_mask)[0]))
#    printed = 0
#
#    print("\n" + "=" * 100)
#    print("[DEBUG] Searching for events that PASSED final selection but have GEN_diRHadron_pt < 150 GeV")
#    print("=" * 100)
#
#    for ievt in selected_indices:
#        lead = leading_rhadron[ievt]
#        sub = subleading_rhadron[ievt]
#
#        if lead is None or sub is None:
#            continue
#
#        try:
#            lead_pt   = float(lead.pt)
#            lead_eta  = float(lead.eta)
#            lead_phi  = float(lead.phi)
#            lead_mass = float(lead.mass)
#
#            sub_pt    = float(sub.pt)
#            sub_eta   = float(sub.eta)
#            sub_phi   = float(sub.phi)
#            sub_mass  = float(sub.mass)
#        except Exception:
#            print(f"[DEBUG] Skipping event {int(ievt)} because GEN RHadron record is malformed")
#            continue
#
#        v1 = ROOT.TLorentzVector()
#        v1.SetPtEtaPhiM(lead_pt, lead_eta, lead_phi, lead_mass)
#
#        v2 = ROOT.TLorentzVector()
#        v2.SetPtEtaPhiM(sub_pt, sub_eta, sub_phi, sub_mass)
#
#        di = v1 + v2
#        di_pt = di.Pt()
#
#        if di_pt >= 150.0:
#            continue
#
#        printed += 1
#
#        print("\n" + "-" * 100)
#        print(f"[DEBUG] LOW di-RHadron pT EVENT index = {int(ievt)}")
#        print("-" * 100)
#
#        print("[DEBUG] Final mask summary:")
#        print(f"  trigger_event_mask  = {bool(trigger_event_mask[ievt])}")
#        print(f"  event_quality_mask  = {bool(event_quality_mask[ievt])}")
#        print(f"  reco_event_mask     = {bool(reco_event_mask[ievt])}")
#        print(f"  final_event_mask    = {bool(final_event_mask[ievt])}")
#
#        print("[DEBUG] Event-level values:")
#        print(f"  PV_npvsGood           = {PV_npvsGood[ievt]}")
#        print(f"  HSCP_n                = {HSCP_n[ievt]}")
#        print(f"  nIsoTrack             = {nIsoTrack[ievt]}")
#        print(f"  nMuon                 = {nMuon[ievt]}")
#        print(f"  PseudoMET_viaCaloJets = {PseudoMET_viaCaloJets[ievt]}")
#
#        print("[DEBUG] Event-level cut checks:")
#        print(f"  PV_npvsGood >= {cuts['PV_npvsGood']}                    -> {bool(PV_npvsGood[ievt] >= cuts['PV_npvsGood'])}")
#        print(f"  HSCP_n >= {cuts['HSCP_n']}                              -> {bool(HSCP_n[ievt] >= cuts['HSCP_n'])}")
#        print(f"  nIsoTrack >= {cuts['nIsoTrack']}                        -> {bool(nIsoTrack[ievt] >= cuts['nIsoTrack'])}")
#        print(f"  nMuon >= {cuts['nMuon']}                                -> {bool(nMuon[ievt] >= cuts['nMuon'])}")
#        print(f"  PseudoMET_viaCaloJets > {cuts['PseudoMET_viaCaloJets']} -> {bool(PseudoMET_viaCaloJets[ievt] > cuts['PseudoMET_viaCaloJets'])}")
#
#        print("[DEBUG] Leading GEN RHadron:")
#        print(f"  pdgId = {int(lead.pdgId)}")
#        print(f"  pt    = {v1.Pt():.6f}")
#        print(f"  eta   = {v1.Eta():.6f}")
#        print(f"  phi   = {v1.Phi():.6f}")
#        print(f"  mass  = {v1.M():.6f}")
#
#        print("[DEBUG] Subleading GEN RHadron:")
#        print(f"  pdgId = {int(sub.pdgId)}")
#        print(f"  pt    = {v2.Pt():.6f}")
#        print(f"  eta   = {v2.Eta():.6f}")
#        print(f"  phi   = {v2.Phi():.6f}")
#        print(f"  mass  = {v2.M():.6f}")
#
#        print("[DEBUG] Combined GEN diRHadron:")
#        print(f"  pt    = {di.Pt():.6f}")
#        print(f"  eta   = {di.Eta():.6f}")
#        print(f"  phi   = {di.Phi():.6f}")
#        print(f"  mass  = {di.M():.6f}")
#
#        pts = ak.to_list(IsoTrack_pt[ievt])
#        etas = ak.to_list(IsoTrack_eta[ievt])
#        pix = ak.to_list(IsoTrack_numberOfValidPixelHits[ievt])
#        frac = ak.to_list(IsoTrack_fractionOfValidHits[ievt])
#        nhits = ak.to_list(IsoTrack_numberOfValidHits[ievt])
#        hp = ak.to_list(IsoTrack_isHighPurityTrack[ievt])
#        chi2 = ak.to_list(IsoTrack_normChi2[ievt])
#        dz = ak.to_list(IsoTrack_dz[ievt])
#        dxy = ak.to_list(IsoTrack_dxy[ievt])
#        eop = ak.to_list(IsoTrack_pfEnergyOverP[ievt])
#        pterr = ak.to_list(IsoTrack_ptErrOverPt[ievt])
#        pterr2 = ak.to_list(IsoTrack_ptErrOverPt2[ievt])
#        dedx = ak.to_list(DeDx_Ih[ievt])
#        reco_mask_evt = ak.to_list(reco_candidate_mask[ievt])
#
#        print(f"[DEBUG] Number of stored IsoTracks in event = {len(pts)}")
#
#        for itrk in range(len(pts)):
#            print(f"\n  [DEBUG] Track {itrk}")
#            print(f"    reco_candidate_mask              = {reco_mask_evt[itrk]}")
#            print(f"    IsoTrack_pt                      = {pts[itrk]}")
#            print(f"    IsoTrack_eta                     = {etas[itrk]}")
#            print(f"    IsoTrack_numberOfValidPixelHits  = {pix[itrk]}")
#            print(f"    IsoTrack_fractionOfValidHits     = {frac[itrk]}")
#            print(f"    IsoTrack_numberOfValidHits       = {nhits[itrk]}")
#            print(f"    IsoTrack_isHighPurityTrack       = {hp[itrk]}")
#            print(f"    IsoTrack_normChi2                = {chi2[itrk]}")
#            print(f"    IsoTrack_dz                      = {dz[itrk]}")
#            print(f"    IsoTrack_dxy                     = {dxy[itrk]}")
#            print(f"    IsoTrack_pfEnergyOverP           = {eop[itrk]}")
#            print(f"    IsoTrack_ptErrOverPt             = {pterr[itrk]}")
#            print(f"    IsoTrack_ptErrOverPt2            = {pterr2[itrk]}")
#            print(f"    DeDx_Ih                          = {dedx[itrk]}")
#
#        if max_to_print is not None and printed >= max_to_print:
#            break
#
#    if printed == 0:
#        print("[DEBUG] No events found with final selection AND GEN_diRHadron_pt < 150 GeV")
#    else:
#        print(f"\n[DEBUG] Printed {printed} low-diRHadron-pt selected event(s)")
#        
#def process_one(sample_name, input_file, TriggerMask):
#    output_file = (
#        f"{output_dir}/"
#        f"{sample_name}_{TriggerMask}_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
#    )
#
#    print("=" * 60)
#    print(f"[INPUT] Sample      = {sample_name}")
#    print(f"[INPUT] Input File  = {input_file}")
#    print(f"[INPUT] TriggerMask = {TriggerMask}")
#    print(f"[OUTPUT] Output File = {output_file}")
#    print("=" * 60)
#
#    tree = uproot.open(input_file)[tree_path]
#    branches = tree.arrays(all_branch_names, library="ak")
#
#    # Pull branches dynamically
#    data = {name: branches[name] for name in all_branch_names}
#
#    gen_pdgid = data["GenPart_pdgId"]
#    gen_pt = data["GenPart_pt"]
#    gen_eta = data["GenPart_eta"]
#    gen_phi = data["GenPart_phi"]
#    gen_mass = data["GenPart_mass"]
#
#    PV_npvsGood = data["PV_npvsGood"]
#    HSCP_n = data["HSCP_n"]
#    nIsoTrack = data["nIsoTrack"]
#    nMuon = data["nMuon"]
#
#    HLT_FilterOR = data["HLT_FilterOR"]
#    HLT_PFMET120_PFMHT120_IDTight = data["HLT_PFMET120_PFMHT120_IDTight"]
#    HLT_PFHT500_PFMET100_PFMHT100_IDTight = data["HLT_PFHT500_PFMET100_PFMHT100_IDTight"]
#    HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = data["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"]
#    HLT_MET105_IsoTrk50 = data["HLT_MET105_IsoTrk50"]
#    HLT_Mu50 = data["HLT_Mu50"]
#    HLT_IsoMu24 = data["HLT_IsoMu24"]
#    HLT_IsoMu27 = data["HLT_IsoMu27"]
#    HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ = data["HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ"]
#    HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL = data["HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL"]
#
#    DeDx_Ih = data["DeDx_Ih"]
#    IsoTrack_pt = data["IsoTrack_pt"]
#    IsoTrack_eta = data["IsoTrack_eta"]
#    IsoTrack_numberOfValidPixelHits = data["IsoTrack_numberOfValidPixelHits"]
#    IsoTrack_fractionOfValidHits = data["IsoTrack_fractionOfValidHits"]
#    IsoTrack_numberOfValidHits = data["IsoTrack_numberOfValidHits"]
#    IsoTrack_isHighPurityTrack = data["IsoTrack_isHighPurityTrack"]
#    IsoTrack_normChi2 = data["IsoTrack_normChi2"]
#    IsoTrack_dz = data["IsoTrack_dz"]
#    IsoTrack_dxy = data["IsoTrack_dxy"]
#    IsoTrack_pfEnergyOverP = data["IsoTrack_pfEnergyOverP"]
#    IsoTrack_ptErrOverPt = data["IsoTrack_ptErrOverPt"]
#    IsoTrack_ptErrOverPt2 = data["IsoTrack_ptErrOverPt2"]
#    PseudoMET_viaCaloJets = data["PseudoMET_viaCaloJets"]
#    rhadron_mask = jagged_isin(abs(gen_pdgid), rhadron_pdgids)
#    #print("\n[DEBUG] IsoTrack_pt type:")
#    #print(type(IsoTrack_pt))
#    #print("\n[DEBUG] IsoTrack_pt awkward type:")
#    #print(ak.type(IsoTrack_pt))
#    #print("\n[DEBUG] First 10 events of IsoTrack_pt:")
#    #print(IsoTrack_pt[:10])
#    #print("\n[DEBUG] Number of IsoTracks in first 10 events:")
#    #print(ak.num(IsoTrack_pt[:10]))
#    #print("\n[DEBUG] First event IsoTrack_pt:")
#    #print(IsoTrack_pt[0])
#    #print("\n[DEBUG] Second event IsoTrack_pt:")
#    #print(IsoTrack_pt[1])
#    #print("\n[DEBUG] First event converted to Python list:")
#    #print(ak.to_list(IsoTrack_pt[:5]))
#    #print("-------------------------------------------------------------------")
#    #print("\n[DEBUG] DeDx_Ih type:")
#    #print(type(DeDx_Ih))
#    #print("\n[DEBUG] DeDx_Ih awkward type:")
#    #print(ak.type(DeDx_Ih))
#    #print("\n[DEBUG] First 10 events of DeDx_Ih:")
#    #print(DeDx_Ih[:10])
#    #print("\n[DEBUG] Number of DeDx_Ih in first 10 events:")
#    #print(ak.num(DeDx_Ih[:10]))
#    #print("\n[DEBUG] First event DeDx_Ih:")
#    #print(DeDx_Ih[0])
#    #print("\n[DEBUG] Second event DeDx_Ih:")
#    #print(DeDx_Ih[1])
#    #print("\n[DEBUG] First event converted to Python list:")
#    #print(ak.to_list(DeDx_Ih[:5]))
#    #print("-------------------------------------------------------------------")
#    #print("\n[DEBUG] PseudoMET_viaCaloJets type:")
#    #print(type(PseudoMET_viaCaloJets)) 
#    #print("\n[DEBUG] PseudoMET_viaCaloJets awkward type:")
#    #print(ak.type(PseudoMET_viaCaloJets))
#    #print("\n[DEBUG] First 10 events of PseudoMET_viaCaloJets:")
#    #print(PseudoMET_viaCaloJets[:10])
#    #print("\n[DEBUG] First event PseudoMET_viaCaloJets:")
#    #print(PseudoMET_viaCaloJets[0])
#    #print("\n[DEBUG] First 5 events converted to Python list:")
#    #print(ak.to_list(PseudoMET_viaCaloJets[:5]))
#    rhadrons = ak.zip({
#        "pdgId": gen_pdgid[rhadron_mask],
#        "pt": gen_pt[rhadron_mask],
#        "eta": gen_eta[rhadron_mask],
#        "phi": gen_phi[rhadron_mask],
#        "mass": gen_mass[rhadron_mask],
#    })
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
#    # ADDED: define manual HLT_FilterOR once and use it consistently
#    manual_HLT_FilterOR = (
#        HLT_PFMET120_PFMHT120_IDTight
#        | HLT_PFHT500_PFMET100_PFMHT100_IDTight
#        | HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60
#        | HLT_MET105_IsoTrk50
#        | HLT_Mu50
#        | HLT_IsoMu24
#        | HLT_IsoMu27
#        | HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ
#        | HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL
#    )
#
#    trigger_masks = {
#        # "HLT_FilterOR": (HLT_PFMET120_PFMHT120_IDTight | HLT_PFHT500_PFMET100_PFMHT100_IDTight | HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 | HLT_MET105_IsoTrk50 | HLT_Mu50  | HLT_IsoMu24 | HLT_IsoMu27 | HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ | HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL),
#        "HLT_FilterOR": manual_HLT_FilterOR,
#        "HLT_MET": (HLT_PFMET120_PFMHT120_IDTight | HLT_PFHT500_PFMET100_PFMHT100_IDTight | HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 | HLT_MET105_IsoTrk50),
#        "HLT_Mu": (HLT_Mu50 | HLT_IsoMu24 | HLT_IsoMu27 | HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ | HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL),
#    }
#
#    if TriggerMask not in trigger_masks:
#        raise ValueError(f"Unknown TriggerMask: {TriggerMask}")
#
#    trigger_event_mask = trigger_masks[TriggerMask]
#    print(f"[DEBUG] Using trigger definition            = {TriggerMask}")
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
#        & (DeDx_Ih > cuts["DeDx_Ih"])
#    )
#
#    reco_event_mask = ak.any(reco_candidate_mask, axis=1)
#    event_quality_mask = (
#        (PV_npvsGood >= cuts["PV_npvsGood"])
#        & (HSCP_n >= cuts["HSCP_n"])
#        & (nIsoTrack >= cuts["nIsoTrack"])
#        & (nMuon >= cuts["nMuon"])
#        & (PseudoMET_viaCaloJets > cuts["PseudoMET_viaCaloJets"])
#    )
#
#    gen_pair_mask = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron)
#    final_event_mask = (reco_event_mask & trigger_event_mask & event_quality_mask & gen_pair_mask)
#
#    lead_final = leading_rhadron[final_event_mask]
#    sub_final = subleading_rhadron[final_event_mask]
#    print_selected_low_pt_events(
#        final_event_mask=final_event_mask,
#        leading_rhadron=leading_rhadron,
#        subleading_rhadron=subleading_rhadron,
#        trigger_event_mask=trigger_event_mask,
#        event_quality_mask=event_quality_mask,
#        reco_event_mask=reco_event_mask,
#        reco_candidate_mask=reco_candidate_mask,
#        PV_npvsGood=PV_npvsGood,
#        HSCP_n=HSCP_n,
#        nIsoTrack=nIsoTrack,
#        nMuon=nMuon,
#        PseudoMET_viaCaloJets=PseudoMET_viaCaloJets,
#        IsoTrack_pt=IsoTrack_pt,
#        IsoTrack_eta=IsoTrack_eta,
#        IsoTrack_numberOfValidPixelHits=IsoTrack_numberOfValidPixelHits,
#        IsoTrack_fractionOfValidHits=IsoTrack_fractionOfValidHits,
#        IsoTrack_numberOfValidHits=IsoTrack_numberOfValidHits,
#        IsoTrack_isHighPurityTrack=IsoTrack_isHighPurityTrack,
#        IsoTrack_normChi2=IsoTrack_normChi2,
#        IsoTrack_dz=IsoTrack_dz,
#        IsoTrack_dxy=IsoTrack_dxy,
#        IsoTrack_pfEnergyOverP=IsoTrack_pfEnergyOverP,
#        IsoTrack_ptErrOverPt=IsoTrack_ptErrOverPt,
#        IsoTrack_ptErrOverPt2=IsoTrack_ptErrOverPt2,
#        DeDx_Ih=DeDx_Ih,
#        cuts=cuts,
#        max_to_print=None,
#        )
#    n_final = int(ak.sum(final_event_mask))
#
#    print(f"[DEBUG] Events passing trigger                = {int(ak.sum(trigger_event_mask))}")
#    print(f"[DEBUG] Events passing reco cuts              = {int(ak.sum(reco_event_mask))}")
#    print(f"[DEBUG] Events passing event cuts             = {int(ak.sum(event_quality_mask))}")
#    print(f"[DEBUG] Events with GEN RHadron pair          = {int(ak.sum(gen_pair_mask))}")
#    print(f"[DEBUG] Events passing final selection        = {n_final}")
#
#    pt_gen_pair = build_gen_dirhadron_pt(
#        leading_rhadron[gen_pair_mask],
#        subleading_rhadron[gen_pair_mask],
#    )
#
#    pt_gen_pair_event = build_gen_dirhadron_pt(
#        leading_rhadron[gen_pair_mask & event_quality_mask],
#        subleading_rhadron[gen_pair_mask & event_quality_mask],
#    )
#
#    pt_gen_pair_event_reco = build_gen_dirhadron_pt(
#        leading_rhadron[gen_pair_mask & event_quality_mask & reco_event_mask],
#        subleading_rhadron[gen_pair_mask & event_quality_mask & reco_event_mask],
#    )
#
#    pt_gen_pair_event_reco_trigger = build_gen_dirhadron_pt(
#        leading_rhadron[gen_pair_mask & event_quality_mask & reco_event_mask & trigger_event_mask],
#        subleading_rhadron[gen_pair_mask & event_quality_mask & reco_event_mask & trigger_event_mask],
#    )
#
#    empty = np.asarray([], dtype=np.float64)
#
#    cutflow_arrays = {
#        "pt_gen_pair": pt_gen_pair,
#        "pt_gen_pair_event": pt_gen_pair_event,
#        "pt_gen_pair_event_reco": pt_gen_pair_event_reco,
#        "pt_gen_pair_event_reco_trigger": pt_gen_pair_event_reco_trigger,
#
#        "pt_trg_PFMET120_PFMHT120_IDTight": empty.copy(),
#        "pt_trg_PFHT500_PFMET100_PFMHT100_IDTight": empty.copy(),
#        "pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": empty.copy(),
#        "pt_trg_MET105_IsoTrk50": empty.copy(),
#
#        "pt_trg_HLT_Mu50": empty.copy(),
#        "pt_trg_IsoMu24": empty.copy(),
#        "pt_trg_IsoMu27": empty.copy(),
#        "pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ": empty.copy(),
#        "pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL": empty.copy(),
#        "pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL": empty.copy(),
#        # "pt_trg_HLT_FilterOR": empty.copy(),
#        "pt_trg_HLT_FilterOR_manual": empty.copy(),
#        "pt_trg_HLT_FilterOR_saved": empty.copy(),
#    }
#
#    trigger_cutflow_map = {
#        "HLT_FilterOR": {
#            # "pt_trg_HLT_FilterOR": HLT_FilterOR,
#            "pt_trg_HLT_FilterOR_manual": manual_HLT_FilterOR,
#            "pt_trg_HLT_FilterOR_saved": HLT_FilterOR,
#
#            "pt_trg_PFMET120_PFMHT120_IDTight": HLT_PFMET120_PFMHT120_IDTight,
#            "pt_trg_PFHT500_PFMET100_PFMHT100_IDTight": HLT_PFHT500_PFMET100_PFMHT100_IDTight,
#            "pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60,
#            "pt_trg_MET105_IsoTrk50": HLT_MET105_IsoTrk50,
#            "pt_trg_IsoMu24": HLT_IsoMu24,
#            "pt_trg_IsoMu27": HLT_IsoMu27,
#            "pt_trg_HLT_Mu50": HLT_Mu50,
#            "pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ": HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ,
#            "pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL": HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL,
#        },
#
#        "HLT_MET": {
#            "pt_trg_PFMET120_PFMHT120_IDTight": HLT_PFMET120_PFMHT120_IDTight,
#            "pt_trg_PFHT500_PFMET100_PFMHT100_IDTight": HLT_PFHT500_PFMET100_PFMHT100_IDTight,
#            "pt_trg_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60,
#            "pt_trg_MET105_IsoTrk50": HLT_MET105_IsoTrk50,
#        },
#
#        "HLT_Mu": {
#            "pt_trg_IsoMu24": HLT_IsoMu24,
#            "pt_trg_IsoMu27": HLT_IsoMu27,
#            "pt_trg_HLT_Mu50": HLT_Mu50,
#            "pt_trg_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ": HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ,
#            "pt_trg_HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL": HLT_Mu23_TrkIsoVVL_Ele12_CaloIdL_TrackIdL_IsoVL,
#        },
#    }
#
#    for out_name, trig_mask in trigger_cutflow_map[TriggerMask].items():
#        cut_mask = gen_pair_mask & event_quality_mask & reco_event_mask & trig_mask
#        cutflow_arrays[out_name] = build_gen_dirhadron_pt(
#            leading_rhadron[cut_mask],
#            subleading_rhadron[cut_mask],
#        )
#
#    print(f"[DEBUG] Cutflow pt_gen_pair entries                    = {len(pt_gen_pair)}")
#    print(f"[DEBUG] Cutflow pt_gen_pair_event entries              = {len(pt_gen_pair_event)}")
#    print(f"[DEBUG] Cutflow pt_gen_pair_event_reco entries         = {len(pt_gen_pair_event_reco)}")
#    print(f"[DEBUG] Cutflow pt_gen_pair_event_reco_trigger entries = {len(pt_gen_pair_event_reco_trigger)}")
#
#    if TriggerMask == "HLT_FilterOR":
#        print(f"[DEBUG] Cutflow pt_trg_HLT_FilterOR_manual entries     = {len(cutflow_arrays['pt_trg_HLT_FilterOR_manual'])}")
#        print(f"[DEBUG] Cutflow pt_trg_HLT_FilterOR_saved entries      = {len(cutflow_arrays['pt_trg_HLT_FilterOR_saved'])}")
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
#    lead_tlv, sub_tlv, GEN_dirhadron_sum = build_tlorentz_vectors(
#        lead_final,
#        sub_final,
#        max_print=cuts["max_events_to_print"]
#    )
#
#    out = {}
#
#    for name in gen_branches + event_branches + reco_branches + trigger_branches:
#        out[name] = data[name][final_event_mask]
#
#    out["reco_candidate_mask"] = reco_candidate_mask[final_event_mask]
#
#    # Saving derived GEN RHadron objects
#    out["GEN_LeadingRHadron_pdgId"] = np.array([int(x) for x in ak.to_list(lead_final.pdgId)], dtype=np.int32)
#    out["GEN_LeadingRHadron_pt"] = np.array([v.Pt() for v in lead_tlv], dtype=np.float64)
#    out["GEN_LeadingRHadron_eta"] = np.array([v.Eta() for v in lead_tlv], dtype=np.float64)
#    out["GEN_LeadingRHadron_phi"] = np.array([v.Phi() for v in lead_tlv], dtype=np.float64)
#    out["GEN_LeadingRHadron_mass"] = np.array([v.M() for v in lead_tlv], dtype=np.float64)
#
#    out["GEN_SubleadingRHadron_pdgId"] = np.array([int(x) for x in ak.to_list(sub_final.pdgId)], dtype=np.int32)
#    out["GEN_SubleadingRHadron_pt"] = np.array([v.Pt() for v in sub_tlv], dtype=np.float64)
#    out["GEN_SubleadingRHadron_eta"] = np.array([v.Eta() for v in sub_tlv], dtype=np.float64)
#    out["GEN_SubleadingRHadron_phi"] = np.array([v.Phi() for v in sub_tlv], dtype=np.float64)
#    out["GEN_SubleadingRHadron_mass"] = np.array([v.M() for v in sub_tlv], dtype=np.float64)
#
#    out["GEN_diRHadron_pt"] = np.array([v.Pt() for v in GEN_dirhadron_sum], dtype=np.float64)
#    out["GEN_diRHadron_eta"] = np.array([v.Eta() for v in GEN_dirhadron_sum], dtype=np.float64)
#    out["GEN_diRHadron_phi"] = np.array([v.Phi() for v in GEN_dirhadron_sum], dtype=np.float64)
#    out["GEN_diRHadron_mass"] = np.array([v.M() for v in GEN_dirhadron_sum], dtype=np.float64)
#
#    cutflow_out = {name: ak.Array([arr]) for name, arr in cutflow_arrays.items()}
#
#    os.makedirs(output_dir, exist_ok=True)
#    with uproot.recreate(output_file) as fout:
#        fout["Events"] = out
#        fout["Cutflow"] = cutflow_out
#
#    print(f"\n[DEBUG] Wrote selected events: {output_file}")
#    print("[DEBUG] Saved leading/subleading/summed GEN 4-vectors as pt/eta/phi/mass branches")
#    print("[DEBUG] Saved Cutflow tree with intermediate GEN diRHadron pT arrays\n")
#
#
#def main():
#    for sample_name, input_file in samples.items():
#        for TriggerMask in trigger_options:
#            process_one(sample_name, input_file, TriggerMask)
#
#
#if __name__ == "__main__":
#    main()
















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