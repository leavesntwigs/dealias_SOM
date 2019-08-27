#include <stdio.h>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <Radx/RadxVol.hh>
#include <Radx/RadxRay.hh>
#include <Radx/RadxFile.hh>

#define MAX_GATES 15

RadxVol vol;
float data[MAX_GATES];

static float previousAz = -1.0;
static int nGates = 0;
static bool first = true;

// void accumulateData(az, 


void addRayToVolume2(float az, int nGates, float *velocityData) {

   int sweepNumber = 0;

   //float az = 315.0;
   float elevation = 0.3;

   RadxRay *ray = new RadxRay();
   ray->setSweepNumber(sweepNumber);
   ray->setAzimuthDeg(az);
   ray->setElevationDeg(elevation);
   double startKm = 2.125;
   double gateSpacingKm = 0.25;
   ray->setRangeGeom(startKm, gateSpacingKm);
   bool isLocal = true;
   float missingValue = Radx::missingFl32;
   ray->addField("VEL", "dbz", (size_t) nGates, missingValue, velocityData, isLocal);

   vol.addRay(ray);
}



void addRayToVolume(float az, float gate, float velocity) {

   int sweepNumber = 0;

   //float az = 315.0;
   float elevation = 0.3;

   RadxRay *ray = new RadxRay();
   ray->setSweepNumber(sweepNumber);
   ray->setAzimuthDeg(az);
   ray->setElevationDeg(elevation);
   double startKm = 2.125; // 0.0;
   double gateSpacingKm = 0.25; // gate; // 0.25;
   ray->setRangeGeom(startKm, gateSpacingKm);
   bool isLocal = true;
   float data[2];
   data[0] = velocity; 
   data[1] = velocity; 
   float missingValue = Radx::missingFl64;
   size_t nGates = 2;
   ray->addField("VEL", "dbz", nGates, missingValue, data, isLocal);

   vol.addRay(ray);
}

void storeRay(float az, float gate, float velocity) {

   if ((az != previousAz) && (!first)) {
      addRayToVolume2(previousAz, nGates, data);
      nGates = 0;
   } 

   previousAz = az;   
   if (first) {
      first = false;
   }

   // accumulate data ...
   data[nGates] = velocity;
   nGates += 1;
}


void writeVolume() {

  vol.setRadarBeamWidthDegH(2.0); // necessary if the azimuths are unevenly spaced
   vol.loadFieldsFromRays();
   //vol.remapRangeGeom(0.0, 0.25, false);
   //vol.loadFieldsFromRays();

   RadxFile radxFile;
   radxFile.writeToPath(vol, "SOM_result");
  
}

// to use:
// radxops filename 
int main(int argc, char *argv[]) {

   printf("Hello, Brenda\n");
   printf("argc = %d\n", argc);
   for (int i=0; i<argc; i++) {

      printf("%s\n", argv[i]);
   }

   string line;
   float azin, gate, velocity;
   ifstream results;
   // results.open("result");
   results.open(argv[1]);
   if (results.is_open()) {
      try {
         while (getline(results,line)) {
            //cout << line << endl;
            // sscanf(line.c_str(),"%f%f%f", &azin, &gate, &velocity);
            for (int i=0; i<line.size(); i++) {
               if ((line[i] == '[') || (line[i] == ']') || (line[i] == ',')) {
                  line[i] = ' ';
               }
            }
            string::size_type sz, sz2;
            azin = stod(line, &sz);
            gate = stod(line.substr(sz), &sz2);
            string the_rest = line.substr(sz);
            velocity = stod(the_rest.substr(sz2));
            // cout << "az " << azin << ", gate " << gate << ", velocity " << velocity << endl;
            storeRay(azin, gate, velocity);
            storeRay(azin, gate, velocity);
            storeRay(azin, gate, velocity);
            //addRayToVolume(azin, gate, velocity);
         }
      } catch (std::invalid_argument ex) {
         cout << "Unable to read a float" << endl;
      }
      // write the last ray
      storeRay(3000, 3, 45);
      results.close();
   } else {
     cout << "Unable to open file";
   }

   writeVolume();
   return 0;

   // junk from here down, but keep for reference ...   

   RadxVol vol;
   
   //  read list of points
   int sweepNumber = 0;

   float az = 315.0;
   float elevation = 0.3;

   RadxRay *ray = new RadxRay();
   ray->setSweepNumber(sweepNumber);
   ray->setAzimuthDeg(az);
   ray->setElevationDeg(elevation);
   double startKm = 0.5;
   double gateSpacingKm = 0.25;
   ray->setRangeGeom(startKm, gateSpacingKm);
   bool isLocal = true;
   float data[12] = {1,2,3,4,5,6,7,8,9,10,11,12};
   float missingValue = Radx::missingFl64;
   size_t nGates = 12;
   ray->addField("VEL", "dbz", nGates, missingValue, data, isLocal);


   vol.addRay(ray);

   vol.loadFieldsFromRays();

   RadxFile radxFile;
   radxFile.writeToPath(vol, "SOM_result.nc");
   
   

   return 0;
}
