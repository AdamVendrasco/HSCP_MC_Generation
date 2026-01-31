#This script comes from https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuidePATFWLiteMiniaodExercise 
#!/usr/bin/env python3
import ROOT
ROOT.gROOT.SetBatch(True)  # (on lxplus, the X-connection is opened anyways) 
 
# load FWLite C++ libraries
ROOT.gSystem.Load("libFWCoreFWLite.so");
ROOT.gSystem.Load("libDataFormatsFWLite.so");
ROOT.AutoLibraryLoader.enable()
 
# load FWlite python libraries
from DataFormats.FWLite import Handle, Events
 
# superimportant shortcuts!!
DeltaR = ROOT.Math.VectorUtil.DeltaR
DeltaPhi = ROOT.Math.VectorUtil.DeltaPhi
DeltaR2 = lambda a, b: DeltaR(a.p4(), b.p4())  # for reco::Candidates
DeltaPhi2 = lambda a, b: DeltaPhi(a.p4(), b.p4())  # for reco::Candidates

# work-around for a bug in root: currently "+" does not work on a LorenzVector type
def addLVs(a, b):
    """add two Lorenz-vectors. a and b should be of the same type"""
    LV = type(a)
    return LV(a.x()+b.x(), a.y()+b.y(), a.z()+b.z(), a.t() + b.t())
