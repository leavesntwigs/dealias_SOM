#!/bin/sh

SOM/radxmodel /tmp/model
mv SOM_result SOM_result.nc

HAWKEYE=/Applications/HawkEye.app/Contents/MacOS/HawkEye
HAWKEYE_PARAMS=params.HawkEye
$HAWKEYE -f SOM_result.nc -params $HAWKEYE_PARAMS
open /tmp/images/HawkEye/19700101/radar.SOM_dealias.VEL.png
