# HSCP MC Generation
1) After cloning this repo run the follwoing command
   ```
   ./initial-setup.sh <CMSSW_VERSION>  (script needs to be udpated)
   ```
   This will automatically cmsrel `<CMSSW_VERSION>`, clone the genproductions repo 

2) Before generating gridpacks we must generate MadGraph5 cards to use as input. Under `run_directories/Run-3/` there are template cards to be used for stop and gluino production. Run the `Run-3_gluino_generate_cards.sh` or `Run-3_stop_generate_cards.sh` script. This will create many directories and correspodinging MadGraph5 cards for that mass/matching scale point (xqcut). Note this script only edits:
   * Mass point (param_card.dat)
   * Matching scale: xqcut/minimum pt for the jets and b (run_card.dat)
   * MadGraph5 run_tag (run_card.dat)
   * output name (proc_card.dat)



3) Now that we have our cards with our desired configurations we can begin generating gridpacks. There are two options: 
   * HTCondor (recommended) 
   * Locally


   ```
   python3 generate_gridpack.py   --in <INPUT CARD DIR>  --out <TARBALL OUTPUT LOCATION>   --tag <TAG>   --queue <HTcondor RUNTIME> -j <#CORES REQUESTED>
   ```
3) To run a gridpack edit the run_directories relevant python fragment file and type the following:
   ```
   ./run-gridpack.sh <RUN_NAME> <CMSSW_VERSION> [NEVENTS] [DEBUG_TAG]
   ```
