# HSCP MC Generation
* 1) After cloning this repo run the follwoing command
   ```
   ./initial-setup.sh <CMSSW_VERSION> 
   ```

   This will automatically cmsrel `<CMSSW_VERSION>`, clone the genproductions repo 

* 2) To begin generating gridpacks there are two options. The first is using condor (recommended) and the other is local. Either are fine but condor is generally faster.

   ```
   python3 generate_gridpack.py   --in <INPUT CARD DIR>  --out <TARBALL OUTPUT LOCATION>   --tag <TAG>   --queue <HTcondor RUNTIME> -j <#CORES REQUESTED>
   ```
3) To run a gridpack edit the run_directories relevant python fragment file and type the following:
   ```
   ./run-gridpack.sh <RUN_NAME> <CMSSW_VERSION> [NEVENTS] [DEBUG_TAG]
   ```
