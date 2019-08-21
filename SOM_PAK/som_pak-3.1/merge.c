/************************************************************************
 *                                                                      *
 *  Program package 'som_pak':                                          *
 *                                                                      *
 *  visual.c                                                            *
 *  -finds out the best matching unit in map and produces a file        *
 *   containing a line for each input sample, in each line the          *
 *   coordinates of the best match and the quantization error           *
 *   are given as well as the label if there is any                     *
 *                                                                      *
 *  Version 3.0                                                         *
 *  Date: 1 Mar 1995                                                    *
 *                                                                      *
 *  NOTE: This program package is copyrighted in the sense that it      *
 *  may be used for scientific purposes. The package as a whole, or     *
 *  parts thereof, cannot be included or used in any commercial         *
 *  application without written permission granted by its producents.   *
 *  No programs contained in this package may be copied for commercial  *
 *  distribution.                                                       *
 *                                                                      *
 *  All comments  concerning this program package may be sent to the    *
 *  e-mail address 'lvq@cochlea.hut.fi'.                                *
 *                                                                      *
 ************************************************************************/

#include <stdio.h>
#include <float.h>
#include <math.h>
#include "lvq_pak.h"
#include "som_rout.h"
#include "datafile.h"

static char *usage[] = {
  "merge - merge best matching unit for each data sample\n", 
  "Required parameters:\n",
  "  -grid filename         codebook file\n",
  "  -mapping filename      input data\n",
  "  -data filename         input data\n",
  "  -dout filename        output filename\n",
  NULL};


struct entries *compute_visual_data(struct teach_params *teach, 
				    char *out_file_name)
{
  int length_known;
  struct data_entry *datatmp;
  struct entries *data = teach->data;
  struct entries *codes = teach->codes;
  struct entries *fake_data;
  struct data_entry *fake_entry;
  struct file_info *fi;
  WINNER_FUNCTION *winner = teach->winner;
  struct winner_info win_info;
  int emptylab = LABEL_EMPTY;
  long index, nod, bpos;
  eptr p;

  emptylab = find_conv_to_ind("EMPTY_LINE");

  /* initialize fake entries table */
  fake_data = alloc_entries();
  if (fake_data == NULL)
    {
      fprintf(stderr, "Can't allocate memory for entries\n");
      return NULL;
    }

  fake_data->dimension = 3;
  fake_data->topol = codes->topol;
  fake_data->neigh = codes->neigh;
  fake_data->xdim = codes->xdim;
  fake_data->ydim = codes->ydim;

  fake_entry = alloc_entry(fake_data);
  if (fake_entry == NULL)
    {
      fprintf(stderr, "Can't allocate memory for fake entry\n");
      free_entries(fake_data);
      return NULL;
    }
  fake_data->entries = fake_entry;

  /* open output file */
  fi = open_file(out_file_name, "w");
  if (fi == NULL)
    {
      fprintf(stderr, "can't open file for output: '%s'\n", out_file_name);
      free_entries(fake_data);
      return NULL;
    }

  fake_data->fi = fi;
  /* write header of output file */
  write_header(fi, fake_data);

  /* Scan all input entries. */
  datatmp = rewind_entries(data, &p);

  if ((length_known = data->flags.totlen_known))
    nod = data->num_entries;
  else
    nod = 0;

  while (datatmp != NULL) {

    /* bpos = winner(codes, datatmp); */
    if (winner(codes, datatmp, &win_info, 1) == 0)
      {
	/* empty sample */
	/* Save the classification and coordinates */
	set_entry_label(fake_entry, emptylab); /* labels */
	fake_entry->points[0] = -1;
	fake_entry->points[1] = -1;
	/* And the quantization error */
	fake_entry->points[2] = -1.0;
      }
    else
      {
	bpos = win_info.index;
	index = get_entry_label(win_info.winner);
	
	/* Save the classification and coordinates */
	copy_entry_labels(fake_entry, win_info.winner); /* labels */
	fake_entry->points[0] = bpos % codes->xdim;
	fake_entry->points[1] = bpos / codes->xdim;
	/* And the quantization error */
	fake_entry->points[2] = sqrt(win_info.diff);
      }
    /* write new entry */
    write_entry(fi, fake_data, fake_entry);

    /* Take the next input entry */
    datatmp = next_entry(&p);

    if (length_known)
      ifverbose(1)
	mprint((long) nod--);
  }

  if (length_known)
    ifverbose(1)
      {
	mprint((long) 0);
	fprintf(stderr, "\n");
      }

  free_entries(fake_data);

  return(data);
}


int main(int argc, char **argv)
{
  char *in_data_file;
  char *in_mapping_file;
  char *out_data_file;
  char *grid_data_file;
  struct entries *data, *codes;
  struct teach_params params;
  int retcode, noskip;
  long buffer;

  data = codes = NULL;
  retcode = 0;

  global_options(argc, argv);
  if (extract_parameter(argc, argv, "-help", OPTION2))
    {
      printhelp();
      exit(0);
    }

  in_data_file = extract_parameter(argc, argv, IN_DATA_FILE, ALWAYS);
  in_mapping_file = extract_parameter(argc, argv, "-mapping", ALWAYS);
  out_data_file = extract_parameter(argc, argv, OUT_DATA_FILE, ALWAYS);
  // grid_data_file = extract_parameter(argc, argv, GRID_DATA_FILE, ALWAYS);
  grid_data_file = extract_parameter(argc, argv, "-grid", ALWAYS);

  label_not_needed(1);

  float grid[100][100];
/*
eolroots-air:dealias_SOM candyoh$ more editeddata_model.cod
3 rect 12 3 bubble
63.8696 3.31134 2.51771 
84.9417 3.3358 1.16621 
88.2957 3.55464 0.878878 
144.18 3.41084 -2.40987 
176.511 3.12196 -4.47179 
177.475 3.11245 -4.51216 
220.285 3.68934 -5.71956 
250.757 3.89585 -4.02394 
270.015 3.73376 -2.2509 
287.579 4.15141 -0.798296 
305.616 4.0853 1.14741 
305.629 4.08527 1.14758 
67.6027 3.2242 2.54621 
84.8012 3.35173 1.39531 
96.5475 3.42426 0.642534 
146.886 3.40725 -2.66885 
175.756 3.13637 -4.58363 
176.177 3.14765 -4.52443 
220.285 3.68934 -5.71956 
258.26 3.9973 -3.66246 
270.015 3.73376 -2.2509 
287.579 4.15141 -0.798296 
294.454 4.05576 -0.17124 
305.629 4.08527 1.14758 
69.6679 3.29436 2.4215 
86.9437 3.4317 1.24111 
113.222 3.55069 -0.2656 
161.056 3.16712 -3.81568 
169.628 3.2593 -4.41441 
184.116 3.16122 -5.10688 
222.982 3.68078 -5.79336 
245.954 3.7957 -4.38379 
280.733 3.99257 -1.63207 
280.733 3.99257 -1.63207 
289.171 4.10905 -0.775451 
305.629 4.08527 1.14758 
*/

  // 
  // read the grid; create a 2D matrix of expected velocity values
  // 
  FILE *grid_data = fopen(grid_data_file, "r");
  if (grid_data != NULL) {
    float az, range, velocity;
    char rect[255], bubble[255];
    int dim, xdim, ydim;

    fscanf(grid_data, "%d %s %d %d %s", &dim, rect, &xdim, &ydim, bubble);
    printf("first line: %d %s %d %d %s\n", dim, rect, xdim, ydim, bubble);
    // read and fill the grid
    for (int m = 0; m < ydim; m++) {
      for (int n = 0; n < xdim; n++) {
         fscanf(grid_data, "%f %f %f", &az, &range, &velocity);
         printf("%f %f %f\n", az, range, velocity);
         grid[n][m] = velocity;
      }
    }
  }
  printf("grid[0][0] = %f\n", grid[0][0]);
  printf("grid[0][0] = %f\n", grid[0][0]);
  printf("grid[3][2] = %f\n", grid[3][2]);


  // read mapping file, and data file in tandem;
  // for each mapping
     // read data (az, range, v_a)
     // look up value in 2D grid
     // unfold v_a
     // write az, range, v_unfolded 
  data = open_entries(in_data_file);
  if (data == NULL)
    {
      fprintf(stderr, "Can't open data file '%s'\n", in_data_file);
      retcode = 1;
      goto end;
    }
  
  mapping = open_entries(in_mapping_file);
  if (mapping == NULL)
    {
      fprintf(stderr, "Can't open data file '%s'\n", in_mapping_file);
      retcode = 1;
      goto end;
    }
  
  ifverbose(2)
    fprintf(stderr, "Codebook entries are read from file %s\n", in_mapping_file);
  codes = open_entries(in_mapping_file);
  if (codes == NULL)
    {
      fprintf(stderr, "can't open code file '%s'\n", in_mapping_file);
      retcode = 1;
      goto end;
    }

  if (codes->topol < TOPOL_HEXA) {
    fprintf(stderr, "File %s is not a map file\n", in_mapping_file);
    retcode = 1;
    goto end;
  }

  if (data->dimension != codes->dimension) {
    fprintf(stderr, "Data and codebook vectors have different dimensions");
    retcode = 1;
    goto end;
  }

  set_teach_params(&params, codes, data, buffer);
  set_som_params(&params);
  /* does not skip empty samples if wanted */
  if (noskip)
    data->flags.skip_empty = 0;
  data = compute_visual_data(&params, out_data_file);

 end:
  if (data)
    close_entries(data);
  if (codes)
    close_entries(codes);
  return(retcode);
}
