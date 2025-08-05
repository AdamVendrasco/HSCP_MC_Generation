# mg-Rhadron
1) After cloning this repo run the follwoing command
   ```
   ./initial-setup.sh <CMSSW_VERSION> <MIN_MASS> <MAX_MASS> <INCREMENT>
   ```
   This will create all run directories needed based on the mass spectrum you are intreseted in running.
   For example:
   ```
   ./initial-setup.sh CMSSW_13_2_9 1000 2000 100
   ```
   This will automatically cmsrel CMSSW_13_2_9, clone genproductions repo and then create the different run directories that varies based the mass range you wish to analyze.
3) To generate a gridpack run the following command:
   ```
   python3 generate_gridpack.py   --in <INPUT CARD DIR>  --out <TARBALL OUTPUT LOCATION>   --tag <TAG>   --queue <HTcondor RUNTIME> -j <#CORES REQUESTED>
   ```
3) To run a gridpack edit the run_directories relevant python fragment file and type the following:
   ```
   ./run-gridpack.sh <RUN_NAME> <CMSSW_VERSION> [NEVENTS] [DEBUG_TAG]
   ```
