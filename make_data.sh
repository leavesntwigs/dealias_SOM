#!/bin/sh                                                                                                                                                                                 

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
#for training_sample_percent in 1 #10 # 10 # 15 20 25                                                                                                                                      
#do

# extract the data from a RadxPrint of the cfradial data file                                                                                                                             
RadxPrint -f data/$DATA_FILE -sweep 1 -field VELH  -data -rays > /tmp/radxprint.out
awk -f data/make_data_vectors.awk /tmp/radxprint.out > $ONE_SWEEP.dat
# remember to add the dimension, '3' to the top of the all_points.dat file for SOM_PAK to read                                                                                            
awk '(NR > 1) {print $0}' $ONE_SWEEP.dat | sort -R | head -n 100 > $BASE_INPUT_DIR/training_1.dat
#  544  vi data/20180802/just_a_few_points.dat
#  545  ls
#  546  mv data/20180802/just_a_few_points.dat data/20180802/training_1.dat


# sample_points.py from sample_points_template.py                                                                                                                                         
# use awk to pull 1% random sample from data
# generate an array of random numbers from 1 to lines
# sort the array
# if current line number is in the array, then print it
#python data/20170408/sample_points_$training_sample_percent.py > $BASE_INPUT_DIR/training_$training_sample_percent.dat                                                                   

