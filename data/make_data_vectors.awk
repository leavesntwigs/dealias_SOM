# maybe encode the data as a python dictionary?
# otherwise, I'll need to make an array of [t][z]
# where t is time step, and z is sweep/elevation
# if I'm ignoring MISSing values, then I need to encode
# the range; i.e. store as a sparse array
#
# I need at least 3 time steps; i.e. 3 data files at consecutive times
#
# initial encoding for data_vector generation:
# (time_step, az, range, sweep#) ==> (observed_velocity)
# because I need to lookup (time - 1) and (sweep# - 1), i.e. t-1 & z-1
#
# final encoding for the SOM
# (az, range, possible_velocity)
#
#

BEGIN {print 3}
/az:/ {az = $2}
/elev:/ {elev = $2}
/gateSpacingKm:/ {gateSpacing = $2}
/startRangeKm:/  {startRange = $2}

/Data/ {start = 1; gate = 0; }
# /(MISS)|(:digit:)|(\*)/ { if (start) {
$0 ~ /[:digit:]*/ { if (start) {
                        for (i=1; i<=NF; i++) {
                           # print $i
                           npieces = split($i, pieces, "*")
# TODO: get rid of "MISS"
                           if (npieces > 1) {
			       if ( pieces[2] !~ /MISS/) {
                                  # print "nrepeats = ", pieces[1]
				   for (n = 1; n <= pieces[1]; n++) {
                                      velocity = pieces[2]
                                      range = startRange + gateSpacing * gate
                                      print az, range, velocity
                                      gate += 1
                                   }
                               } else { # assume MISS
                                   gate += pieces[1] 
                               } # end MISS
			   } #else { # end if npieces > 1
                              # else no repeater
			     #  print az, range, $i
                             #  gate += 1
			   #} # end else no repeater               
                        }
                      }
                    }


/=========================/ { 
                 if (start) {
                    start = 0;
                 }
               }
