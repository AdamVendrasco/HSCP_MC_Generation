// File: GeneratorInterface/Pythia8Interface/plugins/DumpPythia8ParticleData.cc

#include "GeneratorInterface/Pythia8Interface/interface/CustomHook.h"
#include "Pythia8/UserHooks.h"
#include "Pythia8/ParticleData.h"

#include <fstream>
#include <string>
#include <iomanip>   
#include <memory>   

using namespace Pythia8;

class DumpPythia8ParticleData : public UserHooks {
public:
  explicit DumpPythia8ParticleData(const edm::ParameterSet& pset) { }
  ~DumpPythia8ParticleData() override { }

  bool initAfterBeams() override {
    std::ofstream outAll("Pythia8_ParticleDataTable.dat");
    if (outAll) {
      outAll << "Block MASS   #\n";
      outAll << "  #  PDG code     mass                 particle\n";
      for (auto it = particleDataPtr->begin(); it != particleDataPtr->end(); ++it) {
        std::shared_ptr<ParticleDataEntry> entry = it->second;
        if (!entry) continue;
        int pdgId       = entry->id();
        double mass_GeV = entry->m0();
        const std::string& name = entry->name();
        outAll << std::setw(9) << pdgId
               << std::fixed << std::setprecision(3)
               << std::setw(12) << mass_GeV
               << "    # " << name << "\n";
      }
      outAll.close();
    }

   //searches for Rhadrons with "R" need to add ~g search too.
    std::ofstream outR("Pythia8_RhadronParticleDataTable.dat");
    if (outR) {
      outR << "Block MASS   #\n";
      outR << "  #  PDG code     mass                 particle\n";
      for (auto it = particleDataPtr->begin(); it != particleDataPtr->end(); ++it) {
        std::shared_ptr<ParticleDataEntry> entry = it->second;
        if (!entry) continue;
        const std::string& name = entry->name();
        if (!name.empty() && (name[0] == 'R' || name.find("~g") != std::string::npos)){
          int pdgId       = entry->id();
          double mass_GeV = entry->m0();
          outR << std::setw(9) << pdgId
               << std::fixed << std::setprecision(3)
               << std::setw(12) << mass_GeV
               << "    # " << name << "\n";
        }
      }
      outR.close();
    }

    return true;
  }
};

REGISTER_USERHOOK(DumpPythia8ParticleData);
