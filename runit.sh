#!/bin/sh

#  list the parameters

# put all the unique files in separate base directories
BASE_INPUT_DIR=
BASE_OUTPUT_DIR=

# list input and output files
HAWKEYE=/Applications/HawkEye.app/Contents/MacOS/HawkEye
HAWKEYE_PARAMS=params.HawkEye
CFRADIAL_FILE=
 
# here are the steps

# 10 15 20 25
# for training_sample_percent in 10 15 20 25
 
# extract the data from a RadxPrint of the cfradial data file
# RadxPrint -f data/20170408/cfrad.20170408_001452.962_to_20170408_001604.560_KARX_Surveillance_SUR_edited0730.nc -data -rays > /tmp/radxprint.out
# awk -f make_data_vectors.awk /tmp/radxprint.out > all_points.dat 
# remember to add the dimension, '3' to the top of the all_points.dat file for SOM_PAK to read

# sample_points.py from sample_points_template.py
# python sample_points.py $training_sample_percent > training.dat

for xdim in 12 
do
   for ydim in 3
   do

         
# SOM_PAK/som_pak-3.1/lininit -xdim 12 -ydim 3 -din data/20170408/training.dat -cout editeddata.cod -neigh bubble -topol rect

      # TODO: also try using randinit to initialize the grid to random values
      SOM_PAK/som_pak-3.1/lininit -xdim $xdim -ydim $ydim -din data/20170408/training.dat -cout editeddata.cod -neigh bubble -topol rect

      for learning_rate in 2
      do
         for neighborhood_radius in 20
         do

            for ntraining_steps in 100
            do 

               # train the SOM
               SOM_PAK/som_pak-3.1/vsom -din data/20170408/training.dat -cin editeddata.cod -cout editeddata_model.cod -rlen $ntraining_steps -alpha $learning_rate -radius $neighborhood_radius 
               # SOM_PAK/som_pak-3.1/vsom -din data/20170408/training.dat -cin editeddata.cod -cout editeddata_model.cod -rlen 100 -alpha 2 -radius 20 

               # map all the data
               SOM_PAK/som_pak-3.1/visual -din data/20170408/just_a_few_points.dat -cin editeddata_model.cod -dout mapping_coords.vis

               # SOM_PAK/som_pak-3.1/visual -din data/20170408/just_a_few_points.dat -cin editeddata_model.cod -dout mapping_coords.vis
               # debug version
               # SOM_PAK/som_pak-3.1/visual -din data/20170408/just_a_few_points.dat -cin editeddata_model.cod -dout mapping_coords.vis -v
  
               for Nyquist in 2  #  3 5 7 10
               do
                  # merge the expected values from each grid with the folded data, then unfold as needed to meet expected values
                  # SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  -din data/20170408/just_a_few_points.dat -mapping mapping_coords.vis -dout merged.dat -Nyquist $Nyquist

                  SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  -din data/20170408/just_a_few_points.dat -mapping mapping_coords.vis -dout merged.dat -Nyquist $Nyquist

#  426  awk -f tf_result_2list.awk result_fullsize > result_radx_input
#  427  awk -f tf_result_2list.awk result_fullsize > result_radx_input
#  428  head result_radx_input 
#  437  mv SOM_result SOM_result_fullsize.nc
#  438  mv SOM_result.nc SOM_result_clusters.nc
#  439  RadxPrint -f SOM_result_fullsize.nc -data -rays | less
#  440  RadxPrint -f SOM_result_fullsize.nc -data -rays | grep az
#  449  less result_radx_input
#  450  less result_radx_input

#  577  cd SOM_PAK/som_pak-3.1; make merge; cd ../..

                   # format the unfolded data into a cfradial file for visualization
                   # radxops automatically writes the result to the file 'SOM_result'
                   SOM/radxops merged.dat
                   mv SOM_result SOM_result_SOM_PAK.nc
                   # RadxPrint -f SOM_result_SOM_PAK.nc -data -rays | less
      
                   # HawkEye should produce a .png image of the data
                   # $HAWKEYE -f $CFRADIAL_FILE -params $HAWKEYE_PARAMS
                   $HAWKEYE -f SOM_result_SOM_PAK.nc -params $HAWKEYE_PARAMS

                done # for Nyquist
            done # for learning_rate
         done #  for neighborhood_radius
      done #  for ntraining_steps 
   done # ydim
done    # xdim

