#!/bin/bash
# Modify the surfdata in user_nl_clm and tag to create different experiments
tag=regular_roof
#tag=regular_roof_urbuniform
#tag=regular_roof_urbuniform2
#tag=regular_roof_urbuniform3
#tag=regular_roof_urbuniform4
#tag=regular_roof_urbuniform5
#tag=regular_roof_urbuniform6
CASE=/glade/work/wangly/urban_runs/urban_I2000Clm50Sp_f09_g17_$tag
START_DATA=1990-01-01
ALIGN_YEAR=1990
DATM_START_YEAR=1990
DATM_END_YEAR=2010
STOP_OPTION=nyears
STOP_N=21
REST_OPTION=nyears
REST_N=21
echo $CASE
rm -rf $CASE
rm -rf /glade/scratch/wangly/urban_I2000Clm50Sp_f09_g17_$tag
cd /glade/work/wangly/cesm/cime/scripts/
./create_newcase --case $CASE --res f09_g17 --compset I2000Clm50Sp --project UBUB0005 --run-unsupported
cd $CASE 

./xmlchange CLM_BLDNML_OPTS='-bgc sp'		
./xmlchange STOP_OPTION=$STOP_OPTION
./xmlchange STOP_N=$STOP_N
./xmlchange REST_OPTION=$REST_OPTION
./xmlchange REST_N=$REST_N
./xmlchange RUN_STARTDATE=$START_DATA

./xmlchange DATM_CLMNCEP_YR_ALIGN=$ALIGN_YEAR
./xmlchange DATM_CLMNCEP_YR_START=$DATM_START_YEAR
./xmlchange DATM_CLMNCEP_YR_END=$DATM_END_YEAR

./xmlchange DOUT_S_SAVE_INTERIM_RESTART_FILES=TRUE
./xmlchange RUN_TYPE=hybrid,RUN_REFCASE=urban_I2000Clm50Sp_f09_g17_spinup,RUN_REFDATE=0085-01-01

./case.setup
cp ~/greenroof_version2.3.3/* ./SourceMods/src.clm/
cp ~/greenroof_version2.3.3/user_nl_clm ./ 
cp /glade/work/wangly/archive/urban_I2000Clm50Sp_f09_g17_spinup/rest/0085-01-01-00000/* /glade/scratch/wangly/urban_I2000Clm50Sp_f09_g17_$tag/run/

./case.build 
./case.submit
