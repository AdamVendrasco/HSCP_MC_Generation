# HSCP MC Generation
1) After cloning this repo run the follwoing command
   ```
   ./initial-setup.sh <CMSSW_VERSION>  (script needs to be udpated)
   ```
   This will automatically cmsrel `<CMSSW_VERSION>`, clone the genproductions repo 

2) Before generating gridpacks we must generate MadGraph5 cards to use as input. Under `run_directories/Run-3/` there are template cards to be used for stop and gluino production. Run the `Run-3_gluino_generate_cards.sh` or `Run-3_stop_generate_cards.sh` script. This will create many directories and correspodinging MadGraph5 cards for that mass/matching scale point (xqcut). Edit the generation script mass point and matching scale your desired value or range. Note this script only edits:
   * Mass point (param_card.dat)
   * Matching scale: xqcut/minimum pt for the jets and b (run_card.dat)
   * MadGraph5 run_tag (run_card.dat)
   * output name (proc_card.dat)


3) Now that we have our cards with our desired configurations we can begin generating gridpacks. There are two options: 
   * HTCondor (recommended) 
      * Locate the `condor` directory. The script `condor/autoCreate_subFIles_forDagman.sh` will automatically create condo submit files which we then can mass submitt using DAGMAN. 
         * Edit the mass point and XQCUTS parameters to match the desired cards you wish to generate gridpacks for.  
         * Edit the IN_DIR parameter that will point to where all your card directories are. This will tell condor what .dat files to copy when the job is submitted. 
         * Run `autoCreate_subFIles_forDagman.sh` with
         ```
         ./autoCreate_subFIles_forDagman.sh
         ```
         This will create new directories called batchexec_ & bathclogs_ for each mass point/xqcut value. The batchexec_ directory contains the actual .sh files to be executed on the condor node. If you want to change the .sh you must edit the `condor_generate_gridpacks.py` file to your desired configuration since this this is the script that actually creates the .sh and exectues the condor submission.
            * If you wish to edit: Condor memory usage, ApptainerImage. This can be done via editing the `condor_generate_gridpacks.py` script:
            * If you wish to edit: Input cards, condor run tags, xqcut values, number of cpus (jobs), condor job queue: This must be edited in the `autoCreate_subFIles_forDagman.sh` script.
      * Now that we have all of our our submit scritps generated, we can mass submit jobs to condor via DAGMAN job scheduler. This enables us to keep our job submission priotey high since if we have many indiviual submitts to condor we will lower our proitoy. To submit to mass submit with DAGMAN, locate the `condor/condor_submit_files/DAGMAN_jobSubmitFile.dag` file. Each job is number as Jjob# with the loaction of the indivdual submit file. Edit this file to point to your newly generated submit file. To submit all these jobs to DAGMAN
      ```
      condor_submit_dag condor_submit_files/DAGMAN_jobSubmitFile.dag
      ```
      This will generate many DAGMAN speficic files. Ones of importance for debugging (usually pathing issues to the .sh file to be generated so check your `condor/autoCreate_subFIles_forDagman.sh` is correct) is the the `.rescue`, .`log`, `.out` files.
            
   * Locally


   ```
   python3 generate_gridpack.py   --in <INPUT CARD DIR>  --out <TARBALL OUTPUT LOCATION>   --tag <TAG>   --queue <HTcondor RUNTIME> -j <#CORES REQUESTED>
   ```
3) To run a gridpack edit the run_directories relevant python fragment file and type the following:
   ```
   ./run-gridpack.sh <RUN_NAME> <CMSSW_VERSION> [NEVENTS] [DEBUG_TAG]
   ```
