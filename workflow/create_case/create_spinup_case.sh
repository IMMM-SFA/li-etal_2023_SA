#!/bin/bash
CASE=/glade/work/wangly/urban_runs/urban_I2000Clm50Sp_f09_g17_spinup
START_DATA=0001-01-01
ALIGN_YEAR=1990
DATM_START_YEAR=1990
DATM_END_YEAR=2010
STOP_OPTION=nyears
STOP_N=21
REST_OPTION=nyears
REST_N=21
RESUBMIT=3
NTASKS=-5
echo $CASE
rm -rf $CASE
rm -rf /glade/scratch/wangly/urban_I2000Clm50Sp_f09_g17_spinup
cd /glade/work/wangly/cesm/cime/scripts/

./create_newcase --case $CASE --res f09_g17 --compset I2000Clm50Sp --project UBUB0005 --run-unsupported
cd $CASE 

./xmlchange CLM_BLDNML_OPTS='-bgc sp'    
./xmlchange NTASKS=$NTASKS
./xmlchange RESUBMIT=$RESUBMIT
./xmlchange STOP_OPTION=$STOP_OPTION
./xmlchange STOP_N=$STOP_N
./xmlchange REST_OPTION=$REST_OPTION
./xmlchange REST_N=$REST_N
./xmlchange RUN_STARTDATE=$START_DATA
./xmlchange DATM_CLMNCEP_YR_ALIGN=$ALIGN_YEAR
./xmlchange DATM_CLMNCEP_YR_START=$DATM_START_YEAR
./xmlchange DATM_CLMNCEP_YR_END=$DATM_END_YEAR
./xmlchange DOUT_S_SAVE_INTERIM_RESTART_FILES=TRUE

./case.setup
cp ~/greenroof_version2.3.3/* ./SourceMods/src.clm/
cp ~/greenroof_version2.3.3/user_nl_clm_spinup user_nl_clm

./case.build 
./case.submit
