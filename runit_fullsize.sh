#!/bin/sh

#  list the parameters

# put all the unique files in separate base directories
DATE=20180802
BASE_INPUT_DIR=data/$DATE
BASE_OUTPUT_DIR=results/$DATE

# list input and output files
HAWKEYE=/Applications/HawkEye.app/Contents/MacOS/HawkEye
HAWKEYE_PARAMS=params.HawkEye
HAWKEYE_PARAMS_MODEL=params_model.HawkEye
CFRADIAL_FILE=
ONE_SWEEP=$BASE_INPUT_DIR/sweep1
DATA_FILE=20180802/cfrad.20180802_222132.000_to_20180802_222830.000_DUG_DUG_SUR.nc 
# first sweep (lowest sweep)

# here are the steps

# 10 15 20 25
for training_sample_percent in 1 #10 # 10 # 15 20 25
do
 
# extract the data from a RadxPrint of the cfradial data file
#RadxPrint -f data/$DATA_FILE -sweep 1 -data -rays > /tmp/radxprint.out
#awk -f make_data_vectors.awk /tmp/radxprint.out > $ONE_SWEEP.dat 
# remember to add the dimension, '3' to the top of the all_points.dat file for SOM_PAK to read

# sample_points.py from sample_points_template.py
#python data/20170408/sample_points_$training_sample_percent.py > $BASE_INPUT_DIR/training_$training_sample_percent.dat

for xdim in  4 # 9 #  12 
do
   for ydim in 4
   do

                   rm editeddata.cod       
         
# SOM_PAK/som_pak-3.1/lininit -xdim 12 -ydim 3 -din data/20170408/training.dat -cout editeddata.cod -neigh bubble -topol rect

      # TODO: also try using randinit to initialize the grid to random values
      echo "initializing ..."
      # SOM_PAK/som_pak-3.1/randinit -xdim $xdim -ydim $ydim -din data/20170408/training_$training_sample_percent.dat -cout editeddata.cod -neigh bubble -topol rect
      # SOM_PAK/som_pak-3.1/randinit -xdim $xdim -ydim $ydim -din data/20170408/training_$training_sample_percent.dat -cout editeddata.cod -neigh gaussian -topol hexa
      SOM_PAK/som_pak-3.1/randinit -xdim $xdim -ydim $ydim -din $BASE_INPUT_DIR/training_$training_sample_percent.dat -cout editeddata.cod -neigh bubble -topol rect

      # SOM_PAK/som_pak-3.1/lininit -xdim $xdim -ydim $ydim -din data/20170408/training_$training_sample_percent.dat -cout editeddata.cod -neigh gaussian -topol rect
      #SOM_PAK/som_pak-3.1/lininit -xdim $xdim -ydim $ydim -din data/20170408/training_fixed.dat -cout editeddata.cod -neigh gaussian -topol rect

      for learning_rate in 1 #  1 2
      do
         for neighborhood_radius in  2 #  2 5 7 10
         do

            for ntraining_steps in 20 # 10 20 50 100 # 100 200 1000  # 50 100 200
            do 

                   rm editeddata_model.cod  
                   rm mapping_coords.vis    


               # train the SOM
               echo "training ..."
               SOM_PAK/som_pak-3.1/vsom -din $BASE_INPUT_DIR/training_$training_sample_percent.dat -cin editeddata.cod -cout editeddata_model.cod -rlen $ntraining_steps -alpha $learning_rate -radius $neighborhood_radius 
               # SOM_PAK/som_pak-3.1/vsom -din data/20170408/training.dat -cin editeddata.cod -cout editeddata_model.cod -rlen 100 -alpha 2 -radius 20 

               # map all the data
               echo "mapping input ..."
               SOM_PAK/som_pak-3.1/visual -din $BASE_INPUT_DIR/sweep1.dat -cin editeddata_model.cod -dout mapping_coords.vis

               # SOM_PAK/som_pak-3.1/visual -din data/20170408/just_a_few_points.dat -cin editeddata_model.cod -dout mapping_coords.vis
               # debug version
               # SOM_PAK/som_pak-3.1/visual -din data/20170408/just_a_few_points.dat -cin editeddata_model.cod -dout mapping_coords.vis -v
  
               for Nyquist in   12  # 2 3 5 7 10
               do
                  # merge the expected values from each grid with the folded data, then unfold as needed to meet expected values
                  # SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  -din data/20170408/just_a_few_points.dat -mapping mapping_coords.vis -dout merged.dat -Nyquist $Nyquist
                  echo "merging & unfolding ..."
                  SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  -din $BASE_INPUT_DIR/sweep1.dat -mapping mapping_coords.vis -dout merged.dat -Nyq $Nyquist -p 30

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

                   #OUTPUT_DIR=$BASE_OUTPUT_DIR/train/10/grid/$xdim/$ydim/lr/$learning_rate/nb/$neighborhood/steps/$steps/Nq/$Nyquist
                   OUTPUT_DIR=$BASE_OUTPUT_DIR/train-$training_sample_percent-grid-$xdim-$ydim-lr-$learning_rate-nb-$neighborhood_radius-steps-$ntraining_steps-Nq-$Nyquist
                   mkdir -p $OUTPUT_DIR
		   echo $OUTPUT_DIR
                   # format the unfolded data into a cfradial file for visualization
                   # radxops automatically writes the result to the file 'SOM_result'
                   echo "making Radx file ..."
                   SOM/radxops_DUG merged.dat
                   mv SOM_result SOM_result_SOM_PAK.nc
                   # RadxPrint -f SOM_result_SOM_PAK.nc -data -rays | less
      
                   # HawkEye should produce a .png image of the data
                   # $HAWKEYE -f $CFRADIAL_FILE -params $HAWKEYE_PARAMS
                   $HAWKEYE -f SOM_result_SOM_PAK.nc -params $HAWKEYE_PARAMS # -images_file_name_category "$xdim-$ydim"
                   mv /tmp/images/HawkEye/19700101/radar.SOM_dealias.VEL.png train-$training_sample_percent-grid-$xdim-$ydim-lr-$learning_rate-nb-$neighborhood_radius-steps-$ntraining_steps-Nq-$Nyquist.png
                   # --------------
                   # make an image of the model produced ...
                   #awk '(NR > 1)' editeddata_model.cod > modelready.txt
                   #SOM/radxmodel modelready.txt
                   #mv SOM_result SOM_result.nc
                   #$HAWKEYE -f SOM_result.nc -params $HAWKEYE_PARAMS_MODEL
                   #mv /tmp/images/HawkEye/19700101/radar.SOM_dealias.VEL.png train-$training_sample_percent-grid-$xdim-$ydim-lr-$learning_rate-nb-$neighborhood_radius-steps-$ntraining_steps-Nq-$Nyquist-model.png

                   # ---------

                   mv SOM_result_SOM_PAK.nc $OUTPUT_DIR
                   mv merged.dat            $OUTPUT_DIR

                   open train-$training_sample_percent-grid-$xdim-$ydim-lr-$learning_rate-nb-$neighborhood_radius-steps-$ntraining_steps-Nq-$Nyquist*.png

                done # for Nyquist
            done # for learning_rate
         done #  for neighborhood_radius
      done #  for ntraining_steps 
   done # ydim
done    # xdim

done # for training sample size

