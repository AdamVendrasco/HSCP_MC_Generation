#import uproot
#import awkward as ak
#import numpy as np
#
#
#input_file = (
#    "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2018/HSCP-Gluino_Par-M-1800_xqcut150/output.root"
#)
#
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
#    "max_events_to_print": 100,
#
#    # Gen cuts
#    "abs_eta_max": 2.4,
#    "pt_min": 55.0,
#
#    # dE/dx cuts
#    "DeDx_PixelNoL1NOM": 2.0,
#    "DeDx_NoL1NOM": 10.0,
#    "DeDx_FiPixelNoL1": 0.3,
#
#    # track cuts
#    "IsoTrack_pt": 55.0,
#    "IsoTrack_eta": 2.4,
#    "IsoTrack_fractionOfValidHits": 0.8,
#    "IsoTrack_isHighPurityTrack": True,
#    "IsoTrack_normChi2": 5.0,
#    "IsoTrack_dz": 0.1,
#    "IsoTrack_dxy": 0.02,
#    "IsoTrack_ptErrOverPt": 0.1,
#    "IsoTrack_ptErrOverPt2": 0.0008,
#    "IsoTrack_pfEnergyOverP": 0.3,
#    "IsoTrack_pfMiniRelIsoAll": 0.02,
#    "IsoTrack_IsoSumPt_dr03": 15.0,
#
#    # cuts left to add:
#    # Ih > C -> need to calculate C from track variables?
#}
#
#
#def jagged_isin(jagged_array, valid_values):
#    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
#    return ak.unflatten(flat_mask, ak.num(jagged_array))
#
#
#def main():
#    tree = uproot.open(input_file)[tree_path]
#    branches = tree.arrays(
#        [
#            "GenPart_pdgId",
#            "GenPart_pt",
#            "GenPart_eta",
#            "GenPart_phi",
#            "GenPart_mass",
#
#            "DeDx_PixelNoL1NOM",
#            "DeDx_NoL1NOM",
#            "DeDx_FiPixelNoL1",
#
#            "IsoTrack_pt",
#            "IsoTrack_eta",
#            "IsoTrack_fractionOfValidHits",
#            "IsoTrack_isHighPurityTrack",
#            "IsoTrack_normChi2",
#            "IsoTrack_dz",
#            "IsoTrack_dxy",
#            "IsoTrack_ptErrOverPt",
#            "IsoTrack_ptErrOverPt2",
#            "IsoTrack_pfEnergyOverP",
#            "IsoTrack_pfMiniRelIsoAll",
#            "IsoTrack_IsoSumPt_dr03",
#
#            "HLT_PFMET120_PFMHT120_IDTight",
#            "HLT_PFHT500_PFMET100_PFMHT100_IDTight",
#            "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60",
#            "HLT_MET105_IsoTrk50",
#
#        ],
#        library="ak",
#    )
#
#    gen_pdgid = branches["GenPart_pdgId"]
#    gen_pt = branches["GenPart_pt"]
#    gen_eta = branches["GenPart_eta"]
#    gen_phi = branches["GenPart_phi"]
#    gen_mass = branches["GenPart_mass"]
#
#    DeDx_PixelNoL1NOM = branches["DeDx_PixelNoL1NOM"]
#    DeDx_NoL1NOM = branches["DeDx_NoL1NOM"]
#    DeDx_FiPixelNoL1 = branches["DeDx_FiPixelNoL1"]
#
#    IsoTrack_pt = branches["IsoTrack_pt"]
#    IsoTrack_eta = branches["IsoTrack_eta"]
#    IsoTrack_fractionOfValidHits = branches["IsoTrack_fractionOfValidHits"]
#    IsoTrack_isHighPurityTrack = branches["IsoTrack_isHighPurityTrack"]
#    IsoTrack_normChi2 = branches["IsoTrack_normChi2"]
#    IsoTrack_dz = branches["IsoTrack_dz"]
#    IsoTrack_dxy = branches["IsoTrack_dxy"]
#    IsoTrack_ptErrOverPt = branches["IsoTrack_ptErrOverPt"]
#    IsoTrack_ptErrOverPt2 = branches["IsoTrack_ptErrOverPt2"]
#    IsoTrack_pfEnergyOverP = branches["IsoTrack_pfEnergyOverP"]
#    IsoTrack_IsoSumPt_dr03 = branches["IsoTrack_IsoSumPt_dr03"]
#    IsoTrack_pfMiniRelIsoAll = branches["IsoTrack_pfMiniRelIsoAll"]
#
#    HLT_PFMET120_PFMHT120_IDTight = branches["HLT_PFMET120_PFMHT120_IDTight"]
#    HLT_PFHT500_PFMET100_PFMHT100_IDTight = branches["HLT_PFHT500_PFMET100_PFMHT100_IDTight"]
#    HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = branches["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"]
#    HLT_MET105_IsoTrk50 = branches["HLT_MET105_IsoTrk50"]
#
#
#    # Gen Rhadron selection
#    particle_mask = (
#        jagged_isin(abs(gen_pdgid), rhadron_pdgids)
#        & (abs(gen_eta) < cuts["abs_eta_max"])
#        & (gen_pt > cuts["pt_min"])
#    )
#
#    selected = ak.zip(
#        {
#            "pdgId": gen_pdgid[particle_mask],
#            "pt": gen_pt[particle_mask],
#            "eta": gen_eta[particle_mask],
#            "phi": gen_phi[particle_mask],
#            "mass": gen_mass[particle_mask],
#        }
#    )
#
#    selected = selected[ak.argsort(selected.pt, axis=1, ascending=False)]
#    selected = ak.pad_none(selected, 2)
#
#    leading_rhadron = selected[:, 0]
#    subleading_rhadron = selected[:, 1]
#    has_valid_pair = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron) #keeps only pair lead/sublead rhadrons from GEN
#
#    # Trigger cuts
#    trigger_event_mask = (
#        HLT_PFMET120_PFMHT120_IDTight
#        | HLT_PFHT500_PFMET100_PFMHT100_IDTight
#        | HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60
#        | HLT_MET105_IsoTrk50
#    )
#
## reco mask: dedx + IsoTracks
#    reco_candidate_mask = (
#          (IsoTrack_pt > cuts["IsoTrack_pt"])
#        & (abs(IsoTrack_eta) < cuts["IsoTrack_eta"])
#        & (IsoTrack_fractionOfValidHits > cuts["IsoTrack_fractionOfValidHits"])
#        & (IsoTrack_isHighPurityTrack == cuts["IsoTrack_isHighPurityTrack"])
#        & (IsoTrack_normChi2 < cuts["IsoTrack_normChi2"])
#        & (abs(IsoTrack_dz) < cuts["IsoTrack_dz"])
#        & (abs(IsoTrack_dxy) < cuts["IsoTrack_dxy"])
#        & (IsoTrack_ptErrOverPt < cuts["IsoTrack_ptErrOverPt"])
#        & (IsoTrack_ptErrOverPt2 < cuts["IsoTrack_ptErrOverPt2"])
#        & (IsoTrack_pfEnergyOverP < cuts["IsoTrack_pfEnergyOverP"])
#        & (IsoTrack_pfMiniRelIsoAll < cuts["IsoTrack_pfMiniRelIsoAll"])
#        & (IsoTrack_IsoSumPt_dr03 < cuts["IsoTrack_IsoSumPt_dr03"])
#
#        & (DeDx_PixelNoL1NOM >= cuts["DeDx_PixelNoL1NOM"])
#        & (DeDx_NoL1NOM >= cuts["DeDx_NoL1NOM"])
#        & (DeDx_FiPixelNoL1 >= cuts["DeDx_FiPixelNoL1"])
#    )
#
#    reco_event_mask = ak.any(reco_candidate_mask, axis=1)
#
#    # Final event selection
#    final_event_mask = has_valid_pair & reco_event_mask & trigger_event_mask
#
#
#    # Summary
#    print(f"Total events                   = {len(gen_pdgid)}")
#    print(f"Events with RHadron pair       = {int(ak.sum(has_valid_pair))}")
#    print(f"Events passing trigger         = {int(ak.sum(trigger_event_mask))}")
#    print(f"Events passing reco cuts       = {int(ak.sum(reco_event_mask))}")
#    print(f"Events passing final selection = {int(ak.sum(final_event_mask))}")
#
#    print("\nFirst few selected events:")
#    shown = 0
#
#    for event_index in range(len(final_event_mask)):
#        if not bool(final_event_mask[event_index]):
#            continue
#
#        lead = leading_rhadron[event_index]
#        sub = subleading_rhadron[event_index]
#        candidate_passes = ak.to_list(reco_candidate_mask[event_index])
#
#        print(f"\nEvent {event_index}")
#        print(f"  reco_candidate_mask           = {candidate_passes}")
#        print(f"  DeDx_PixelNoL1NOM             = {ak.to_list(DeDx_PixelNoL1NOM[event_index])}")
#        print(f"  DeDx_NoL1NOM                  = {ak.to_list(DeDx_NoL1NOM[event_index])}")
#        print(f"  DeDx_FiPixelNoL1              = {ak.to_list(DeDx_FiPixelNoL1[event_index])}")
#        print(f"  IsoTrack_pt                   = {ak.to_list(IsoTrack_pt[event_index])}")
#        print(f"  IsoTrack_eta                  = {ak.to_list(IsoTrack_eta[event_index])}")
#        print(f"  IsoTrack_fractionOfValidHits  = {ak.to_list(IsoTrack_fractionOfValidHits[event_index])}")
#        print(f"  IsoTrack_isHighPurityTrack    = {ak.to_list(IsoTrack_isHighPurityTrack[event_index])}")
#        print(f"  IsoTrack_normChi2             = {ak.to_list(IsoTrack_normChi2[event_index])}")
#        print(f"  IsoTrack_dz                   = {ak.to_list(IsoTrack_dz[event_index])}")
#        print(f"  IsoTrack_dxy                  = {ak.to_list(IsoTrack_dxy[event_index])}")
#        print(f"  IsoTrack_ptErrOverPt          = {ak.to_list(IsoTrack_ptErrOverPt[event_index])}")
#        print(f"  IsoTrack_ptErrOverPt2         = {ak.to_list(IsoTrack_ptErrOverPt2[event_index])}")
#        print(f"  IsoTrack_pfEnergyOverP        = {ak.to_list(IsoTrack_pfEnergyOverP[event_index])}")
#        print(f"  IsoTrack_pfMiniRelIsoAll      = {ak.to_list(IsoTrack_pfMiniRelIsoAll[event_index])}")
#        print(f"  IsoTrack_IsoSumPt_dr03        = {ak.to_list(IsoTrack_IsoSumPt_dr03[event_index])}")
#
#        print(f"  HLT_PFMET120_PFMHT120_IDTight               = {bool(HLT_PFMET120_PFMHT120_IDTight[event_index])}")
#        print(f"  HLT_PFHT500_PFMET100_PFMHT100_IDTight       = {bool(HLT_PFHT500_PFMET100_PFMHT100_IDTight[event_index])}")
#        print(f"  HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = {bool(HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60[event_index])}")
#        print(f"  HLT_MET105_IsoTrk50                         = {bool(HLT_MET105_IsoTrk50[event_index])}")
#
#        print(
#            f"  Leading RHadron   : "
#            f"pdgId={int(lead.pdgId)}, "
#            f"pt={float(lead.pt):.3f}, "
#            f"eta={float(lead.eta):.3f}, "
#            f"phi={float(lead.phi):.3f}, "
#            f"mass={float(lead.mass):.3f}"
#        )
#        print(
#            f"  Subleading RHadron: "
#            f"pdgId={int(sub.pdgId)}, "
#            f"pt={float(sub.pt):.3f}, "
#            f"eta={float(sub.eta):.3f}, "
#            f"phi={float(sub.phi):.3f}, "
#            f"mass={float(sub.mass):.3f}"
#        )
#
#        shown += 1
#        if shown >= cuts["max_events_to_print"]:
#            break
#
#
#if __name__ == "__main__":
#    main()

#import uproot
#import awkward as ak
#import numpy as np
#
#
#input_file = (
#    "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2018/HSCP-Gluino_Par-M-1800_xqcut150/output.root"
#)
#
#output_file = "selected_events.root"
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
#    "max_events_to_print": 100,
#
#    # Gen cuts
#    "abs_eta_max": 2.4,
#    "pt_min": 55.0,
#
#    # dE/dx cuts
#    "DeDx_PixelNoL1NOM": 2.0,
#    "DeDx_NoL1NOM": 10.0,
#    "DeDx_FiPixelNoL1": 0.3,
#
#    # track cuts
#    "IsoTrack_pt": 55.0,
#    "IsoTrack_eta": 2.4,
#    "IsoTrack_fractionOfValidHits": 0.8,
#    "IsoTrack_isHighPurityTrack": True,
#    "IsoTrack_normChi2": 5.0,
#    "IsoTrack_dz": 0.1,
#    "IsoTrack_dxy": 0.02,
#    "IsoTrack_ptErrOverPt": 0.1,
#    "IsoTrack_ptErrOverPt2": 0.0008,
#    "IsoTrack_pfEnergyOverP": 0.3,
#    "IsoTrack_pfMiniRelIsoAll": 0.02,
#    "IsoTrack_IsoSumPt_dr03": 15.0,
#}
#
#
#def jagged_isin(jagged_array, valid_values):
#    flat_mask = np.isin(ak.to_numpy(ak.flatten(jagged_array)), list(valid_values))
#    return ak.unflatten(flat_mask, ak.num(jagged_array))
#
#
#def main():
#    tree = uproot.open(input_file)[tree_path]
#
#    branch_names = [
#        # gen branches used in selection
#        "GenPart_pdgId",
#        "GenPart_pt",
#        "GenPart_eta",
#        "GenPart_phi",
#        "GenPart_mass",
#
#        # reco branches used in cuts
#        "DeDx_PixelNoL1NOM",
#        "DeDx_NoL1NOM",
#        "DeDx_FiPixelNoL1",
#
#        "IsoTrack_pt",
#        "IsoTrack_eta",
#        "IsoTrack_fractionOfValidHits",
#        "IsoTrack_isHighPurityTrack",
#        "IsoTrack_normChi2",
#        "IsoTrack_dz",
#        "IsoTrack_dxy",
#        "IsoTrack_ptErrOverPt",
#        "IsoTrack_ptErrOverPt2",
#        "IsoTrack_pfEnergyOverP",
#        "IsoTrack_pfMiniRelIsoAll",
#        "IsoTrack_IsoSumPt_dr03",
#
#        # triggers used in cuts
#        "HLT_PFMET120_PFMHT120_IDTight",
#        "HLT_PFHT500_PFMET100_PFMHT100_IDTight",
#        "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60",
#        "HLT_MET105_IsoTrk50",
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
#    DeDx_PixelNoL1NOM = branches["DeDx_PixelNoL1NOM"]
#    DeDx_NoL1NOM = branches["DeDx_NoL1NOM"]
#    DeDx_FiPixelNoL1 = branches["DeDx_FiPixelNoL1"]
#
#    IsoTrack_pt = branches["IsoTrack_pt"]
#    IsoTrack_eta = branches["IsoTrack_eta"]
#    IsoTrack_fractionOfValidHits = branches["IsoTrack_fractionOfValidHits"]
#    IsoTrack_isHighPurityTrack = branches["IsoTrack_isHighPurityTrack"]
#    IsoTrack_normChi2 = branches["IsoTrack_normChi2"]
#    IsoTrack_dz = branches["IsoTrack_dz"]
#    IsoTrack_dxy = branches["IsoTrack_dxy"]
#    IsoTrack_ptErrOverPt = branches["IsoTrack_ptErrOverPt"]
#    IsoTrack_ptErrOverPt2 = branches["IsoTrack_ptErrOverPt2"]
#    IsoTrack_pfEnergyOverP = branches["IsoTrack_pfEnergyOverP"]
#    IsoTrack_pfMiniRelIsoAll = branches["IsoTrack_pfMiniRelIsoAll"]
#    IsoTrack_IsoSumPt_dr03 = branches["IsoTrack_IsoSumPt_dr03"]
#
#    HLT_PFMET120_PFMHT120_IDTight = branches["HLT_PFMET120_PFMHT120_IDTight"]
#    HLT_PFHT500_PFMET100_PFMHT100_IDTight = branches["HLT_PFHT500_PFMET100_PFMHT100_IDTight"]
#    HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60 = branches["HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60"]
#    HLT_MET105_IsoTrk50 = branches["HLT_MET105_IsoTrk50"]
#
#    particle_mask = (
#        jagged_isin(abs(gen_pdgid), rhadron_pdgids) & (abs(gen_eta) < cuts["abs_eta_max"]) & (gen_pt > cuts["pt_min"])
#    )
#
#    selected = ak.zip(
#        {
#            "pdgId": gen_pdgid[particle_mask],
#            "pt": gen_pt[particle_mask],
#            "eta": gen_eta[particle_mask],
#            "phi": gen_phi[particle_mask],
#            "mass": gen_mass[particle_mask],
#        }
#    )
#
#    selected = selected[ak.argsort(selected.pt, axis=1, ascending=False)]
#    selected = ak.pad_none(selected, 2)
#
#    leading_rhadron = selected[:, 0]
#    subleading_rhadron = selected[:, 1]
#    has_valid_pair = ~ak.is_none(leading_rhadron) & ~ak.is_none(subleading_rhadron)
#
#    # Trigger cuts
#    trigger_event_mask = (
#        HLT_PFMET120_PFMHT120_IDTight
#        | HLT_PFHT500_PFMET100_PFMHT100_IDTight
#        | HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60
#        | HLT_MET105_IsoTrk50
#    )
#
#    # reco cuts
#    reco_candidate_mask = (
#          (IsoTrack_pt > cuts["IsoTrack_pt"])
#        & (abs(IsoTrack_eta) < cuts["IsoTrack_eta"])
#        & (IsoTrack_fractionOfValidHits > cuts["IsoTrack_fractionOfValidHits"])
#        & (IsoTrack_isHighPurityTrack == cuts["IsoTrack_isHighPurityTrack"])
#        & (IsoTrack_normChi2 < cuts["IsoTrack_normChi2"])
#        & (abs(IsoTrack_dz) < cuts["IsoTrack_dz"])
#        & (abs(IsoTrack_dxy) < cuts["IsoTrack_dxy"])
#        & (IsoTrack_ptErrOverPt < cuts["IsoTrack_ptErrOverPt"])
#        & (IsoTrack_ptErrOverPt2 < cuts["IsoTrack_ptErrOverPt2"])
#        & (IsoTrack_pfEnergyOverP < cuts["IsoTrack_pfEnergyOverP"])
#        & (IsoTrack_pfMiniRelIsoAll < cuts["IsoTrack_pfMiniRelIsoAll"])
#        & (IsoTrack_IsoSumPt_dr03 < cuts["IsoTrack_IsoSumPt_dr03"])
#        & (DeDx_PixelNoL1NOM >= cuts["DeDx_PixelNoL1NOM"])
#        & (DeDx_NoL1NOM >= cuts["DeDx_NoL1NOM"])
#        & (DeDx_FiPixelNoL1 >= cuts["DeDx_FiPixelNoL1"])
#    )
#
#    reco_event_mask = ak.any(reco_candidate_mask, axis=1)
#
#
#    # Final event selection
#    final_event_mask = has_valid_pair & reco_event_mask & trigger_event_mask
#
#
#    # Build output dictionary
#    # Save all branches you cut on
#    # plus a few useful derived outputs
#
#    lead_final = leading_rhadron[final_event_mask]
#    sub_final = subleading_rhadron[final_event_mask]
#    out = {
#        "GenPart_pdgId": gen_pdgid[final_event_mask],
#        "GenPart_pt": gen_pt[final_event_mask],
#        "GenPart_eta": gen_eta[final_event_mask],
#        "GenPart_phi": gen_phi[final_event_mask],
#        "GenPart_mass": gen_mass[final_event_mask],
#        
#        "DeDx_PixelNoL1NOM": DeDx_PixelNoL1NOM[final_event_mask],
#        "DeDx_NoL1NOM": DeDx_NoL1NOM[final_event_mask],
#        "DeDx_FiPixelNoL1": DeDx_FiPixelNoL1[final_event_mask],
#        
#        "IsoTrack_pt": IsoTrack_pt[final_event_mask],
#        "IsoTrack_eta": IsoTrack_eta[final_event_mask],
#        "IsoTrack_fractionOfValidHits": IsoTrack_fractionOfValidHits[final_event_mask],
#        "IsoTrack_isHighPurityTrack": IsoTrack_isHighPurityTrack[final_event_mask],
#        "IsoTrack_normChi2": IsoTrack_normChi2[final_event_mask],
#        "IsoTrack_dz": IsoTrack_dz[final_event_mask],
#        "IsoTrack_dxy": IsoTrack_dxy[final_event_mask],
#        "IsoTrack_ptErrOverPt": IsoTrack_ptErrOverPt[final_event_mask],
#        "IsoTrack_ptErrOverPt2": IsoTrack_ptErrOverPt2[final_event_mask],
#        "IsoTrack_pfEnergyOverP": IsoTrack_pfEnergyOverP[final_event_mask],
#        "IsoTrack_pfMiniRelIsoAll": IsoTrack_pfMiniRelIsoAll[final_event_mask],
#        "IsoTrack_IsoSumPt_dr03": IsoTrack_IsoSumPt_dr03[final_event_mask],
#        
#        "HLT_PFMET120_PFMHT120_IDTight": HLT_PFMET120_PFMHT120_IDTight[final_event_mask],
#        "HLT_PFHT500_PFMET100_PFMHT100_IDTight": HLT_PFHT500_PFMET100_PFMHT100_IDTight[final_event_mask],
#        "HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60": HLT_PFMETNoMu120_PFMHTNoMu120_IDTight_PFHT60[final_event_mask],
#        "HLT_MET105_IsoTrk50": HLT_MET105_IsoTrk50[final_event_mask],
#        "reco_candidate_mask": reco_candidate_mask[final_event_mask],
#        
#        "LeadingRHadron_pdgId": ak.to_numpy(ak.fill_none(lead_final.pdgId, -999)),
#        "LeadingRHadron_pt": ak.to_numpy(ak.fill_none(lead_final.pt, -999.0)),
#        "LeadingRHadron_eta": ak.to_numpy(ak.fill_none(lead_final.eta, -999.0)),
#        "LeadingRHadron_phi": ak.to_numpy(ak.fill_none(lead_final.phi, -999.0)),
#        "LeadingRHadron_mass": ak.to_numpy(ak.fill_none(lead_final.mass, -999.0)),
#        "SubleadingRHadron_pdgId": ak.to_numpy(ak.fill_none(sub_final.pdgId, -999)),
#        "SubleadingRHadron_pt": ak.to_numpy(ak.fill_none(sub_final.pt, -999.0)),
#        "SubleadingRHadron_eta": ak.to_numpy(ak.fill_none(sub_final.eta, -999.0)),
#        "SubleadingRHadron_phi": ak.to_numpy(ak.fill_none(sub_final.phi, -999.0)),
#        "SubleadingRHadron_mass": ak.to_numpy(ak.fill_none(sub_final.mass, -999.0)),
#    }
#
#
#
#
#    with uproot.recreate(output_file) as fout:
#        fout["Events"] = out
#
#    print(f"Total events in input          = {len(gen_pdgid)}")
#    print(f"Events with RHadron pair       = {int(ak.sum(has_valid_pair))}")
#    print(f"Events passing trigger         = {int(ak.sum(trigger_event_mask))}")
#    print(f"Events passing reco cuts       = {int(ak.sum(reco_event_mask))}")
#    print(f"Events passing final selection = {int(ak.sum(final_event_mask))}")
#    print(f"Wrote selected events to       = {output_file}")
#
#
#if __name__ == "__main__":
#    main()

#!/usr/bin/env python3
import uproot
import awkward as ak
import numpy as np

input_file = (
    "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2024/HSCP-Gluino_Par-M-1800_xqcut150_MC.root"
)

output_file = "selected_events_matching_michael_with_gen_and_reco.root"
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
    "PV_npvsGood_min": 1,
    "HSCP_n_min": 1,
    "nIsoTrack_min": 1,
    "nMuon_min": 1,

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
    "IsoTrack_ptErrOverPt2": 0.0008,

    # GEN RHadron cuts
    "Gen_abs_eta_max": 2.4,
    "Gen_pt_min": 55.0,
}


def jagged_isin(jagged_array, valid_values):
    flat = ak.flatten(jagged_array)
    flat_mask = np.isin(ak.to_numpy(flat), list(valid_values))
    return ak.unflatten(flat_mask, ak.num(jagged_array))


def main():
    tree = uproot.open(input_file)[tree_path]

    branch_names = [
        # Event-level branches
        "PV_npvsGood",
        "HLT_FilterOR",
        "HSCP_n",
        "nIsoTrack",
        "nMuon",

        # Reco track branches
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

        # GEN branches
        "GenPart_pdgId",
        "GenPart_pt",
        "GenPart_eta",
        "GenPart_phi",
        "GenPart_mass",
    ]

    branches = tree.arrays(branch_names, library="ak")
    PV_npvsGood = branches["PV_npvsGood"]
    HLT_FilterOR = branches["HLT_FilterOR"]
    HSCP_n = branches["HSCP_n"]
    nIsoTrack = branches["nIsoTrack"]
    nMuon = branches["nMuon"]

    IsoTrack_pt = branches["IsoTrack_pt"]
    IsoTrack_eta = branches["IsoTrack_eta"]
    IsoTrack_numberOfValidPixelHits = branches["IsoTrack_numberOfValidPixelHits"]
    IsoTrack_fractionOfValidHits = branches["IsoTrack_fractionOfValidHits"]
    IsoTrack_numberOfValidHits = branches["IsoTrack_numberOfValidHits"]
    IsoTrack_isHighPurityTrack = branches["IsoTrack_isHighPurityTrack"]
    IsoTrack_normChi2 = branches["IsoTrack_normChi2"]
    IsoTrack_dz = branches["IsoTrack_dz"]
    IsoTrack_dxy = branches["IsoTrack_dxy"]
    IsoTrack_pfEnergyOverP = branches["IsoTrack_pfEnergyOverP"]
    IsoTrack_ptErrOverPt2 = branches["IsoTrack_ptErrOverPt2"]

    GenPart_pdgId = branches["GenPart_pdgId"]
    GenPart_pt = branches["GenPart_pt"]
    GenPart_eta = branches["GenPart_eta"]
    GenPart_phi = branches["GenPart_phi"]
    GenPart_mass = branches["GenPart_mass"]

    n_events = len(PV_npvsGood)


    # Event-level masks: Matches emerys cutflow script
    all_events_mask = ak.ones_like(PV_npvsGood, dtype=bool)
    vtx_mask = PV_npvsGood >= cuts["PV_npvsGood_min"]
    trigger_mask = HLT_FilterOR == 1
    hscp_mask = HSCP_n >= cuts["HSCP_n_min"]
    track_count_mask = nIsoTrack >= cuts["nIsoTrack_min"]
    muon_mask = nMuon >= cuts["nMuon_min"]

    event_cutflow_masks = {
        "AllEvents": all_events_mask,
        ">=1Vtx": all_events_mask & vtx_mask,
        "PassedHLT": all_events_mask & vtx_mask & trigger_mask,
        ">=1HSCP": all_events_mask & vtx_mask & trigger_mask & hscp_mask,
        ">=1track": all_events_mask & vtx_mask & trigger_mask & hscp_mask & track_count_mask,
        ">=1muon": all_events_mask & vtx_mask & trigger_mask & hscp_mask & track_count_mask & muon_mask,
    }


    # cumulative track-level masks: Matches emerys cutflow script
    event_trigger_broadcast = ak.broadcast_arrays(trigger_mask, IsoTrack_pt)[0]
    event_hscp_broadcast = ak.broadcast_arrays(HSCP_n > 0, IsoTrack_pt)[0]

    track_cutflow_masks = {}

    track_cutflow_masks["All"]                  = ak.ones_like(IsoTrack_pt, dtype=bool)
    track_cutflow_masks["Technical"]            = track_cutflow_masks["All"]
    track_cutflow_masks["Trigger"]              = (track_cutflow_masks["Technical"]& event_trigger_broadcast)
    track_cutflow_masks["p_T"]                  = (track_cutflow_masks["Trigger"]& (IsoTrack_pt > cuts["IsoTrack_pt"]))
    track_cutflow_masks["eta"]                  = (track_cutflow_masks["p_T"]& (abs(IsoTrack_eta) < cuts["IsoTrack_eta"]))
    track_cutflow_masks["N_pixel_hits"]         = (track_cutflow_masks["eta"]& (IsoTrack_numberOfValidPixelHits >= cuts["IsoTrack_numberOfValidPixelHits"]))
    track_cutflow_masks["f_valid_hits"]         = (track_cutflow_masks["N_pixel_hits"]& (IsoTrack_fractionOfValidHits > cuts["IsoTrack_fractionOfValidHits"]))
    track_cutflow_masks["N_dEdx_hits"]          = (track_cutflow_masks["f_valid_hits"]& (IsoTrack_numberOfValidHits >= cuts["IsoTrack_numberOfValidHits"]))
    track_cutflow_masks["HighPurity"]           = (track_cutflow_masks["N_dEdx_hits"]& (IsoTrack_isHighPurityTrack == cuts["IsoTrack_isHighPurityTrack"]))
    track_cutflow_masks["Chi2_Ndof"]            = (track_cutflow_masks["HighPurity"]& (IsoTrack_normChi2 < cuts["IsoTrack_normChi2"]))
    track_cutflow_masks["dz"]                   = (track_cutflow_masks["Chi2_Ndof"]& (abs(IsoTrack_dz) < cuts["IsoTrack_dz"]))
    track_cutflow_masks["dxy"]                  = (track_cutflow_masks["dz"]& (abs(IsoTrack_dxy) < cuts["IsoTrack_dxy"]))
    track_cutflow_masks["E_over_p"]             = (track_cutflow_masks["dxy"]& (IsoTrack_pfEnergyOverP < cuts["IsoTrack_pfEnergyOverP"]))
    track_cutflow_masks["sigma_pT_over_p2"]     = (track_cutflow_masks["E_over_p"]& (IsoTrack_ptErrOverPt2 < cuts["IsoTrack_ptErrOverPt2"]))
    track_cutflow_masks["n_reco_tracks_total"]  = (track_cutflow_masks["sigma_pT_over_p2"]& event_hscp_broadcast)
   
    reco_event_mask = ak.any(track_cutflow_masks["n_reco_tracks_total"], axis=1)

    # Final event mask
    final_event_mask = (
        vtx_mask
        & trigger_mask
        & hscp_mask
        & track_count_mask
        & muon_mask
        & reco_event_mask
    )

    # GEN RHadron mask
    gen_rhadron_mask = (
        jagged_isin(abs(GenPart_pdgId), rhadron_pdgids)
        & (abs(GenPart_eta) < cuts["Gen_abs_eta_max"])
        & (GenPart_pt > cuts["Gen_pt_min"])
    )


    selected_event_track_mask = track_cutflow_masks["n_reco_tracks_total"][final_event_mask]
    selected_event_gen_mask = gen_rhadron_mask[final_event_mask]

    out = {
        # Event-level branches (one value per saved event)
        "PV_npvsGood": PV_npvsGood[final_event_mask],
        "HLT_FilterOR": HLT_FilterOR[final_event_mask],
        "HSCP_n": HSCP_n[final_event_mask],
        "nIsoTrack": nIsoTrack[final_event_mask],
        "nMuon": nMuon[final_event_mask],

        # Reco tracks SAVED ONLY IF THEY PASS FINAL TRACK CUTS
        "RecoHSCPTrack_pt": IsoTrack_pt[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_eta": IsoTrack_eta[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_numberOfValidPixelHits": IsoTrack_numberOfValidPixelHits[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_fractionOfValidHits": IsoTrack_fractionOfValidHits[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_numberOfValidHits": IsoTrack_numberOfValidHits[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_isHighPurityTrack": IsoTrack_isHighPurityTrack[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_normChi2": IsoTrack_normChi2[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_dz": IsoTrack_dz[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_dxy": IsoTrack_dxy[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_pfEnergyOverP": IsoTrack_pfEnergyOverP[final_event_mask][selected_event_track_mask],
        "RecoHSCPTrack_ptErrOverPt2": IsoTrack_ptErrOverPt2[final_event_mask][selected_event_track_mask],

        # GEN RHadrons SAVED ONLY IF THEY PASS GEN RHADRON CUTS
        "GenRHadron_pdgId": GenPart_pdgId[final_event_mask][selected_event_gen_mask],
        "GenRHadron_pt": GenPart_pt[final_event_mask][selected_event_gen_mask],
        "GenRHadron_eta": GenPart_eta[final_event_mask][selected_event_gen_mask],
        "GenRHadron_phi": GenPart_phi[final_event_mask][selected_event_gen_mask],
        "GenRHadron_mass": GenPart_mass[final_event_mask][selected_event_gen_mask],
    }

    with uproot.recreate(output_file) as fout:
        fout["Events"] = out

    print(f"Total events in input = {n_events}")
    print("\nEvent-level cutflow (event counts):")
    
    for name, mask in event_cutflow_masks.items():
        print(f"  {name:20s}: {int(ak.sum(mask))}")

    print("\nTrack-level cutflow (track counts):")
    
    for name, mask in track_cutflow_masks.items():
        print(f"  {name:20s}: {int(ak.sum(ak.num(IsoTrack_pt[mask], axis=1)))}")

    n_events_with_final_track   = int(ak.sum(reco_event_mask))
    n_events_written            = int(ak.sum(final_event_mask))
    n_gen_rhadrons_total        = int(ak.sum(ak.num(GenPart_pt[gen_rhadron_mask], axis=1)))
    n_gen_rhadrons_written      = int(ak.sum(ak.num(out["GenRHadron_pt"], axis=1)))
    n_reco_tracks_total         = int(ak.sum(ak.num(IsoTrack_pt[track_cutflow_masks["n_reco_tracks_total"]], axis=1)))
    n_reco_tracks_written       = int(ak.sum(ak.num(out["RecoHSCPTrack_pt"], axis=1)))

    print("\nWhat the output file contains:")
    print(f"  Events written (n_events_written)                       = {n_events_written}")
    print(f"  Reco tracks passing Michael (n_reco_tracks_written)   = {n_reco_tracks_written}")
    print(f"  GEN RHadrons passing GEN cuts (n_gen_rhadrons_written)         = {n_gen_rhadrons_written}")

    print("\nReference totals before final event write-out:")
    print(f"  Events with >=1 final reco track (n_events_with_final_track)       = {n_events_with_final_track}")
    print(f"  All reco tracks passing n_reco_tracks_total (n_reco_tracks_total)       = {n_reco_tracks_total}")
    print(f"  All GEN RHadrons passing GEN cuts (n_gen_rhadrons_total)    = {n_gen_rhadrons_total}")

    print("\nExactly what is being cut:")
    print("  Event-level cuts:")
    print("    - PV_npvsGood >= 1")
    print("    - HLT_FilterOR == 1")
    print("    - HSCP_n >= 1")
    print("    - nIsoTrack >= 1")
    print("    - nMuon >= 1")
    print("    - event must contain >=1 reco track passing n_reco_tracks_total")

    print("  Reco track cuts (Michael):")
    print("    - IsoTrack_pt > 55")
    print("    - |IsoTrack_eta| < 2.4")
    print("    - IsoTrack_numberOfValidPixelHits >= 2")
    print("    - IsoTrack_fractionOfValidHits > 0.8")
    print("    - IsoTrack_numberOfValidHits >= 10")
    print("    - IsoTrack_isHighPurityTrack == True")
    print("    - IsoTrack_normChi2 < 5")
    print("    - |IsoTrack_dz| < 0.1")
    print("    - |IsoTrack_dxy| < 0.02")
    print("    - IsoTrack_pfEnergyOverP < 0.3")
    print("    - IsoTrack_ptErrOverPt2 < 0.0008")
    print("    - HSCP_n > 0")

    print("  GEN RHadron cuts:")
    print("    - |GenPart_pdgId| in RHadron PDG ID list")
    print("    - |GenPart_eta| < 2.4")
    print("    - GenPart_pt > 55")

    print(f"\nOutput written to: {output_file}")


    print("\nFirst few saved events:")
    saved_indices = np.nonzero(ak.to_numpy(final_event_mask))[0]

    for i_evt, evt_idx in enumerate(saved_indices[:cuts["max_events_to_print"]], start=1):
        reco_pts = out["RecoHSCPTrack_pt"][i_evt - 1]
        gen_pts = out["GenRHadron_pt"][i_evt - 1]

        print("-" * 80)
        print(f"Saved event #{i_evt} (original event index = {evt_idx})")
        print(f"  PV_npvsGood = {out['PV_npvsGood'][i_evt - 1]}")
        print(f"  HLT_FilterOR = {out['HLT_FilterOR'][i_evt - 1]}")
        print(f"  HSCP_n = {out['HSCP_n'][i_evt - 1]}")
        print(f"  nIsoTrack = {out['nIsoTrack'][i_evt - 1]}")
        print(f"  nMuon = {out['nMuon'][i_evt - 1]}")
        print(f"  Number of saved reco tracks   = {len(reco_pts)}")
        print(f"  Number of saved GEN RHadrons  = {len(gen_pts)}")

        if len(reco_pts) > 0:
            print("  Saved reco tracks:")
            for j in range(len(reco_pts)):
                print(
                    f"    reco[{j}] : "
                    f"pt={float(out['RecoHSCPTrack_pt'][i_evt - 1][j]):.3f}, "
                    f"eta={float(out['RecoHSCPTrack_eta'][i_evt - 1][j]):.3f}, "
                    f"nPix={int(out['RecoHSCPTrack_numberOfValidPixelHits'][i_evt - 1][j])}, "
                    f"fValid={float(out['RecoHSCPTrack_fractionOfValidHits'][i_evt - 1][j]):.3f}, "
                    f"nHits={int(out['RecoHSCPTrack_numberOfValidHits'][i_evt - 1][j])}, "
                    f"highPurity={bool(out['RecoHSCPTrack_isHighPurityTrack'][i_evt - 1][j])}, "
                    f"chi2={float(out['RecoHSCPTrack_normChi2'][i_evt - 1][j]):.3f}, "
                    f"dz={float(out['RecoHSCPTrack_dz'][i_evt - 1][j]):.5f}, "
                    f"dxy={float(out['RecoHSCPTrack_dxy'][i_evt - 1][j]):.5f}, "
                    f"E/p={float(out['RecoHSCPTrack_pfEnergyOverP'][i_evt - 1][j]):.3f}, "
                    f"ptErrOverPt2={float(out['RecoHSCPTrack_ptErrOverPt2'][i_evt - 1][j]):.6f}"
                )

        if len(gen_pts) > 0:
            print("  Saved GEN RHadrons:")
            for j in range(len(gen_pts)):
                print(
                    f"    gen[{j}] : "
                    f"pdgId={int(out['GenRHadron_pdgId'][i_evt - 1][j])}, "
                    f"pt={float(out['GenRHadron_pt'][i_evt - 1][j]):.3f}, "
                    f"eta={float(out['GenRHadron_eta'][i_evt - 1][j]):.3f}, "
                    f"phi={float(out['GenRHadron_phi'][i_evt - 1][j]):.3f}, "
                    f"mass={float(out['GenRHadron_mass'][i_evt - 1][j]):.3f}"
                )


if __name__ == "__main__":
    main()