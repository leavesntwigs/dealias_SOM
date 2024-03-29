#include <stdio.h>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <math.h>
#include <Radx/RadxVol.hh>
#include <Radx/RadxRay.hh>
#include <Radx/RadxFile.hh>

#define MAX_GATES 2000

// TODO: need to read the number of gates as a parameter?!

RadxVol vol;
float data[MAX_GATES];

static float previousAz = -1.0;
static int nGates = 0;
static bool first = true;

// TODO: These are specific to a data file
double startKm = 0.0625;
double gateSpacingKm = 0.125;
int magic_nGates = 1930;

// void accumulateData(az, 


void addRayToVolume2(float az, int nGates, float *velocityData) {

   int sweepNumber = 0;

   //float az = 315.0;
   float elevation = 0.9;

   RadxRay *ray = new RadxRay();
   ray->setSweepNumber(sweepNumber);
   ray->setAzimuthDeg(az);
   ray->setElevationDeg(elevation);
   ray->setRangeGeom(startKm, gateSpacingKm);
   bool isLocal = true;
   float missingValue = Radx::missingFl32;
   ray->addField("VELV", "dbz", (size_t) nGates, missingValue, velocityData, isLocal);

   vol.addRay(ray);
}


void storeRay(float az, float gate, float velocity) {

   if ((az != previousAz) && (!first)) {
     addRayToVolume2(previousAz, magic_nGates, data); // TODO: Magic number!
     nGates = 0;
     for (int i=0; i<MAX_GATES; i++) 
       data[i] = Radx::missingFl32;  // TODO: magic number!
   } 

   previousAz = az;   
   if (first) {
      first = false;
   }

   // accumulate data ...
   //data[nGates] = velocity;
   float whichGatef =  (gate - startKm)/gateSpacingKm;
   int whichGate = (int) roundf(whichGatef);

   if ((az < 185) && (az >= 184)) {
     printf("az: %f, gate=%f,  whichGate = %d\n", az, gate, whichGate);
   }
   
   if ((whichGate < 0) || (whichGate >= MAX_GATES)) {
     printf("FATAL ERROR gate index out of bounds %d\n", whichGate);
     exit(-1);
   }
   if ((whichGate < 0) || (whichGate >= MAX_GATES)) {
     printf("FATAL ERROR gate index out of bounds %d\n", whichGate);
     exit(-1);
   }
     
   data[whichGate] = velocity;
   nGates += 1;
}

void addRayToVolume(float az, float gate, float velocity) {

   int sweepNumber = 0;

   //float az = 315.0;
   float elevation = 0.9;

   RadxRay *ray = new RadxRay();
   ray->setSweepNumber(sweepNumber);
   ray->setAzimuthDeg(az);
   ray->setElevationDeg(elevation);
   double startKm = 0.0;
   double gateSpacingKm = gate; // 0.25;
   ray->setRangeGeom(startKm, gateSpacingKm);
   bool isLocal = false;
   float data[1];
   data[0] = velocity; 
   float missingValue = Radx::missingFl64;
   size_t nGates = 1;
   ray->addField("VELV", "dbz", nGates, missingValue, data, isLocal);

   vol.addRay(ray);
}

void writeVolume() {

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

   for (int i=0; i<magic_nGates; i++)
     data[i] = Radx::missingFl32;  // TODO: magic number!

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
            // addRayToVolume(azin, gate, velocity);
         }
      } catch (std::invalid_argument ex) {
         cout << "Unable to read a float" << endl;
      }
      results.close();
   } else {
     cout << "Unable to open file";
   }

   writeVolume();
   return 0;
/*
 
[[59.413208 ,  3.5604413,  4.886854 ],
 [38.083633,  3.265606,  4.509778],
 [18.094137 ,  2.9830067,  4.9272447],
 [80.25891  ,  3.1349723,  4.5599174],
 [65.89754  ,  3.0341396,  2.5781374],
 [50.090397 ,  3.3666725,  3.3316522],

*/

   

   RadxVol vol;
   
   //  read list of points
   int sweepNumber = 0;

   float az = 315.0;
   float elevation = 0.9;

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
   ray->addField("VELV", "dbz", nGates, missingValue, data, isLocal);


   vol.addRay(ray);

   vol.loadFieldsFromRays();

   RadxFile radxFile;
   radxFile.writeToPath(vol, "SOM_result.nc");
   
   

   return 0;
}
