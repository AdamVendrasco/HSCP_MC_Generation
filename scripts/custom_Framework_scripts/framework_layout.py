#import uproot
#
#fname = "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2018/HSCP-Gluino_Par-M-1800_xqcut150/output.root"
#outtxt = "framework_contents.txt"
#
#file = uproot.open(fname)
#tree = file["HSCPMiniAODAnalyzer/Events"]
#
#with open(outtxt, "w") as f:
#    f.write("Tree: HSCPMiniAODAnalyzer/Events\n\n")
#    f.write(f"Number of entries: {tree.num_entries}\n\n")
#    f.write("Branches:\n")
#
#    for branch in tree.keys():
#        f.write(branch + "\n")
#
#print(f"Saved branch list to {outtxt}")
import uproot
import awkward as ak

fname = "/uscms/home/avendras/nobackup/HSCP/hscp_tutorial/CMSSW_15_0_16/src/ntuples/2018/HSCP-Gluino_Par-M-1800_xqcut150/output.root"
tree = uproot.open(fname)["HSCPMiniAODAnalyzer/Events"]

event_array = tree["event"].array()
DeDx_PixelNoL1NOM_array = tree["DeDx_PixelNoL1NOM"].array()
IsoTrack_fractionOfValidHits_array = tree["IsoTrack_fractionOfValidHits"].array()
IsoTrack_isHighPurityTrack_array = tree["IsoTrack_isHighPurityTrack"].array()
IsoTrack_normChi2_array = tree["IsoTrack_normChi2"].array()
DeDx_NoL1NOM_array = tree["DeDx_NoL1NOM"].array()
IsoTrack_dz_array = tree["IsoTrack_dz"].array()
IsoTrack_dxy_array = tree["IsoTrack_dxy"].array()
DeDx_FiPixelNoL1_array = tree["DeDx_FiPixelNoL1"].array()
IsoTrack_ptErrOverPt_array = tree["IsoTrack_ptErrOverPt"].array()
IsoTrack_ptErrOverPt2_array = tree["IsoTrack_ptErrOverPt2"].array()
IsoTrack_pfEnergyOverP_array = tree["IsoTrack_pfEnergyOverP"].array()
IsoTrack_pfMiniRelIsoAll_array = tree["IsoTrack_pfMiniRelIsoAll"].array()



print("Number of events =", len(event_array))
print("DeDx_PixelNoL1NOM =", DeDx_PixelNoL1NOM_array)                        # pixel hits w/o L1
print("IsoTrack_fractionOfValidHits =", IsoTrack_fractionOfValidHits_array)  # frac of valid hits
print("DeDx_NoL1NOM =", DeDx_NoL1NOM_array)                                  # dE/dx hits w/o L1 (strip+pixel?)
print("IsoTrack_isHighPurityTrack =", IsoTrack_isHighPurityTrack_array)      # high purity tracks
print("IsoTrack_normChi2 =", IsoTrack_normChi2_array)                                  # normalized chi2 of iso tracks
print("IsoTrack_dz =", IsoTrack_dz_array)                                    # dz of iso tracks
print("IsoTrack_dxy =", IsoTrack_dxy_array)                                  # dxy of iso tracks
print("sigma_pt/pt =", IsoTrack_ptErrOverPt_array)
print("sigma_pt/pt2 =", IsoTrack_ptErrOverPt2_array)
print("IsoTrack_pfEnergyOverP =", IsoTrack_pfEnergyOverP_array)
print("[CHECK] I rel PF here? IsoTrack_pfMiniRelIsoAll = ", IsoTrack_pfMiniRelIsoAll_array)
print("[CHECK] I trk here?")     
print("DeDx_FiPixelNoL1 =", DeDx_FiPixelNoL1_array)                         # Fpix dE/dx w/o L1
print("[CHECK]Ih > C here? Probably need to calculate C")
