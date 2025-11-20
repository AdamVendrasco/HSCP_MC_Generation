# HSCP MC Generation
1) After cloning this repo, run the following command

   ```
   ./initial-setup.sh <CMSSW_VERSION>  (needs to be udpated only needed for "running over" gridpacks already generated)
   ```
   This will automatically run `cmsrel <CMSSW_VERSION>` and clone the `genproductions` repo.

2) Before generating gridpacks we must generate MadGraph5 cards to use as input. Under `run_directories/Run-3/` there are template cards to be used for stop and gluino production. Run the `Run-3_gluino_generate_cards.sh` or `Run-3_stop_generate_cards.sh` scripts. This will create many directories and corresponding MadGraph5 cards for that mass/matching-scale point (xqcut). Edit the mass point and matching scale in the generation script to your desired value or range. Note this script only edits:
   * Mass point (`param_card.dat`)
   * Matching scale: xqcut / minimum pT for the jets and b (`run_card.dat`)
   * MadGraph5 `run_tag` (`run_card.dat`)
   * Output name (`proc_card.dat`)

   So if you want more custom MadGraph5 configurations, you'll need to edit the .sh files accordiningly. To run either script:
   ```
   ./Run-3_gluino_generate_cards.sh
   ```
   ```
   ./Run-3_stop_generate_cards.sh
   ```

3) Now that we have our cards with our desired configurations we can begin generating gridpacks. There are two options: 
* **HTCondor (recommended)**  
   * Locate the `condor` directory. The script `condor/autoCreate_subFIles_forDagman.sh` will automatically create Condor submit files which we can then mass-submit using DAGMAN. In the `autoCreate_subFIles_forDagman.sh` file 
      * Edit the mass point and `XQCUTS` parameters to match the desired cards you wish to generate gridpacks for.  
      * Edit the `IN_DIR` parameter to point to where all your card directories are. This will tell Condor what `.dat` MadGraph5 cards to copy when the job is submitted. 
      * Run `autoCreate_subFIles_forDagman.sh` with
        ```
        ./autoCreate_subFIles_forDagman.sh
        ```
        This will create new directories called `batchexec_` & `batchlogs_` for each mass point/xqcut value. The `batchexec_` directory contains the actual `.sh` files to be executed on the Condor node. If you want to change the `.sh` contents you must edit the `condor_generate_gridpacks.py` file to your desired configuration, since this is the script that actually creates the `.sh` and executes the Condor submission.
         * If you wish to edit Condor memory usage or the `ApptainerImage`, this can be done by editing the `condor_generate_gridpacks.py` script.
         * If you wish to edit input cards, Condor run tags, xqcut values, number of CPUs (jobs), output directory, or the Condor job queue, this must be edited in the `autoCreate_subFIles_forDagman.sh` script.
   * Now that we have all of our submit scripts generated, we can mass-submit jobs to Condor via the DAGMAN job scheduler. This enables us to keep our job submission priority high, since many individual submissions to Condor will lower our priority. To mass-submit with DAGMAN, locate the `condor/condor_submit_files/DAGMAN_jobSubmitFile.dag` file. Each job is numbered as `JOB#` with the location of the individual submit file. Edit this file to point to your newly generated submit files. To submit all these jobs to DAGMAN:
     ```
     condor_submit_dag condor_submit_files/DAGMAN_jobSubmitFile.dag
     ```
     This will generate many DAGMAN-specific files. The ones of importance for debugging (usually pathing issues to the `.sh` file to be generated, so check your `condor/autoCreate_subFIles_forDagman.sh` is correct) are the `.rescue`, `.log`, and `.out` files. Typing 
     ```
     condor_q $USER
     ```
     should now display all the jobs running with either an I or R in the status. If it has an H status, type 
     
     ```
     condor_q -name <ClusterID> <JobID> -af HoldReason HoldReasonCode HoldReasonSubCode
     ```
     Most likley it is a pathing issue. Edit the necessary scripts to fix the pathing issue.

* **Locally (needs to be updated)**
  ```bash
  python3 generate_gridpack.py   --in <INPUT CARD DIR>  --out <TARBALL OUTPUT LOCATION>   --tag <TAG>   --queue <HTCondor runtime> -j <#CORES REQUESTED>
  ```

4) To run a gridpack, edit the relevant Python fragment file under `run_directories/` and type the following:
```bash
./run-gridpack.sh <RUN_NAME> <CMSSW_VERSION> [NEVENTS] [DEBUG_TAG]
