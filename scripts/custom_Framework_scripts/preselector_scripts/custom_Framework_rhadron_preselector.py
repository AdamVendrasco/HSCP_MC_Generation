#!/usr/bin/env python3
import os
import uproot
import awkward as ak
import numpy as np
import ROOT

year = 2024
GTAG = "150X_mcRun3_2024_realistic_v2"
era = "D"
tag = "TestMC"

tree_path = "HSCPMiniAODAnalyzer/Events"
output_dir = "/uscms/home/avendras/nobackup/HSCP/scripts/custom_Framework_scripts/preselected_rootfiles"

samples = {
    # # Bugged mg5 ntuples here
    #"HSCP-Gluino_Par-M-1200_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1200_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-1300_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1300_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-1400_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1400_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-1100_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1100_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-1000_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1000_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-1500_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1500_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-1600_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1600_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_2024-D_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-2000_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-2000_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-2400_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-2400_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-2200_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-2200_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    #"HSCP-Gluino_Par-M-2600_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-2600_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150_MC.root",
    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut150": "/eos/uscms/store/user/avendras/HSCP/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_2024-D_xqcut150_MC.root",
    
    #Fixed Samples
    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut40_qcut60_PTJ20_NoDupCheck": "/uscms/home/avendras/nobackup/HSCP/CMSSW_Releases/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_madgraphMLM-pythia8_xqcut40_qcut60_PTJ20_MC_NoDupCheck.root",
    
    #pythia8 Samples
    "HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_MC.root": "/uscms/home/avendras/nobackup/HSCP/CMSSW_Releases/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_TuneCP5_13p6TeV_pythia8_MC.root"

}



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
    "DeDx_IhNoL1": 2.9784,
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
    "RecoPFMET",
    "HLTPFMET",
]

reco_branches = [
    "DeDx_IhNoL1",
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

all_branch_names = gen_branches + event_branches + reco_branches


def jagged_isin(jagged_array, valid_values):
    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
    return ak.unflatten(flat_mask, ak.num(jagged_array))


def build_tlv(pt, eta, phi, mass):
    v = ROOT.TLorentzVector()
    v.SetPtEtaPhiM(float(pt), float(eta), float(phi), float(mass))
    return v


def make_tlv_arrays(lead, sub, max_print=0):
    lead_tlv = []
    sub_tlv = []
    di_tlv = []

    n_events = len(lead)
    print(f"\n[DEBUG] Building TLorentzVectors for {n_events} selected events")

    for i in range(n_events):
        v1 = build_tlv(lead.pt[i], lead.eta[i], lead.phi[i], lead.mass[i])
        v2 = build_tlv(sub.pt[i], sub.eta[i], sub.phi[i], sub.mass[i])

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
        v1 = build_tlv(lead.pt[i], lead.eta[i], lead.phi[i], lead.mass[i])
        v2 = build_tlv(sub.pt[i], sub.eta[i], sub.phi[i], sub.mass[i])
        pts.append((v1 + v2).Pt())

    return np.asarray(pts, dtype=np.float64)


def process_file(sample_name, input_file):
    output_file = (
        f"{output_dir}/"
        f"{sample_name}_NoTrigger_{year}_{era}_{tag}_{GTAG}_preselected_events.root"
    )

    print("=" * 60)
    print(f"[INPUT] Sample       = {sample_name}")
    print(f"[INPUT] Input File   = {input_file}")
    print(f"[OUTPUT] Output File = {output_file}")
    print("=" * 60)

    tree = uproot.open(input_file)[tree_path]
    data = tree.arrays(all_branch_names, library="ak")

    gen = {name: data[name] for name in gen_branches}
    evt = {name: data[name] for name in event_branches}
    reco = {name: data[name] for name in reco_branches}

    # -------------------------
    # GEN RHadron selection
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

    # -------------------------
    # Reco-level selection
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
        & (reco["DeDx_IhNoL1"] > cuts["DeDx_IhNoL1"])
    )

    reco_event_mask = ak.any(reco_candidate_mask, axis=1)

    # -------------------------
    # Event-level selection
    event_quality_mask = (
        (evt["PV_npvsGood"] >= cuts["PV_npvsGood"])
        & (evt["HSCP_n"] >= cuts["HSCP_n"])
        & (evt["nIsoTrack"] >= cuts["nIsoTrack"])
        & (evt["nMuon"] >= cuts["nMuon"])
    )

    pmet_mask = evt["PseudoMET_viaCaloJets"] > cuts["PseudoMET_viaCaloJets"]

    # -------------------------
    # Final event selection
    final_event_mask = (
        gen_pair_mask
        & event_quality_mask
        & pmet_mask
        & reco_event_mask
    )

    print(f"[DEBUG] Events passing reco cuts              = {int(ak.sum(reco_event_mask))}")
    print(f"[DEBUG] Events passing event cuts             = {int(ak.sum(event_quality_mask))}")
    print(f"[DEBUG] Events passing PseudoMET cut          = {int(ak.sum(pmet_mask))}")
    print(f"[DEBUG] Events with GEN RHadron pair          = {int(ak.sum(gen_pair_mask))}")
    print(f"[DEBUG] Events passing final selection        = {int(ak.sum(final_event_mask))}")

    lead_final = leading_rhadron[final_event_mask]
    sub_final = subleading_rhadron[final_event_mask]
    n_final = len(lead_final)

    # -------------------------
    # Cutflow for new root file
    cutflow_steps = {
        "pt_gen_pair": gen_pair_mask,
        "pt_gen_pair_event": gen_pair_mask & event_quality_mask & pmet_mask,
        "pt_gen_pair_event_reco": gen_pair_mask & event_quality_mask & pmet_mask & reco_event_mask,
    }

    cutflow_arrays = {
        name: build_gen_dirhadron_pt(leading_rhadron[mask], subleading_rhadron[mask])
        for name, mask in cutflow_steps.items()
    }

    print(f"[DEBUG] Cutflow pt_gen_pair entries                    = {len(cutflow_arrays['pt_gen_pair'])}")
    print(f"[DEBUG] Cutflow pt_gen_pair_event entries              = {len(cutflow_arrays['pt_gen_pair_event'])}")
    print(f"[DEBUG] Cutflow pt_gen_pair_event_reco entries         = {len(cutflow_arrays['pt_gen_pair_event_reco'])}")

    if n_final == 0:
        print("[DEBUG] No selected events found — writing cutflow only")
        cutflow_out = {name: ak.Array([arr]) for name, arr in cutflow_arrays.items()}
        os.makedirs(output_dir, exist_ok=True)
        with uproot.recreate(output_file) as fout:
            fout["Cutflow"] = cutflow_out
        print(f"[DEBUG] Wrote cutflow-only file: {output_file}")
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

    # -------------------------
    # Output to new root file
    out = {}

    for name in gen_branches + event_branches + reco_branches:
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
        process_file(sample_name, input_file)


if __name__ == "__main__":
    main()
