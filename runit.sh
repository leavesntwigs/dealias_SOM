   98  more load_run.py 
   99  ls
  100  vi load_run.py
  101  more load_run.py 
  102  gcc -o libradxops.so -shared -fPIC radxops.cc
  103  ls
  104  rm radxops.so
  105  python load_run.py 
  106  vi load_run.py 
  107  python load_run.py 
  108  vi load_run.py 
  109  ls
  110  rm libradxops.so
  111  rm libRadx.so
  112  ls
  113  gcc -o radxops.so -shared -fPIC radxops.cc
  114  python load_run.py 
  115  gcc -o radxops radxops.cc
  116  ./radxops one two three
  117  ls
  118  vi load_run.py 
  119  python load_run.py 
  120  vi load_run.py 
  121  python load_run.py 
  122  vi radxops.cc
  123  gcc -o radxops radxops.cc
  124  vi radxops.cc
  125  gcc -o radxops -I/usr/local/inclradxops.cc
  126  gcc -o radxops radxops.cc
  127  ./radxops one two three
  128  vi radxops.cc
  129  gcc -o radxops -L/usr/local/lrose/lib -lRadx radxops.cc
  130  vi radxops.cc
  131  gcc -o radxops -L/usr/local/lrose/lib -lRadx radxops.cc
  132  vi radxops.cc
  133  gcc -o radxops -L/usr/local/lrose/lib -lRadx radxops.cc
  134  vi radxops.cc
  135  gcc -o radxops -L/usr/local/lrose/lib -lRadx radxops.cc
  136  vi radxops.cc
  137  gcc -o radxops -L/usr/local/lrose/lib -lRadx radxops.cc
  138  g++ -o radxops -L/usr/local/lrose/lib -lRadx radxops.cc
  139  ls /usr/local/lib
  140  g++ -o radxops  -lRadx radxops.cc
  141  ./radxops one two three
  142  more radxops.cc
  143  vi Makefile
  144  make all
  145  ./radxops one two three
  146  vi Makefile
  147  rm radxops
  148  make all
  149  ./radxops one two three
  150  vi Makefile
  151  rm radxops
  152  make all
  153  ./radxops one two three
  154  vi Makefile
  155  make all
  156  ./radxops one two three
  157  vi radxops.cc
  158  make all
  159  vi radxops.cc
  160  make all
  161  vi radxops.cc
  162  make all
  163  ./radxops one two
  164  vi radxops.cc
  165  make all
  166  ./radxops one two
  167  nm  /usr/local/Cellar/lrose-cyclone/cyclone-20190801/lib/libRadx.0.dylib | c++filt | grep nc__create
  168  nm  /usr/local/Cellar/lrose-cyclone/cyclone-20190801/lib/libNc*.0.dylib | c++filt | grep nc__create
  169  ls  /usr/local/Cellar/lrose-cyclone/cyclone-20190801/lib/libNc*.0.dylib 
  170  more Makefile
  171  ls  /usr/local/Cellar/lrose-cyclone/cyclone-20190801/lib/libNc*.dylib 
  172  ls  /usr/local/Cellar/lrose-cyclone/cyclone-20190801/lib/lib*.dylib 
  173  vi Makefile
  174  make all
  175  ./radxops one two
  176  ls
  177  ls -lrt
  178  RadxPrint -f SOM_result 
  179  RadxCheck -f SOM_result 
  180  RadxPrint -f SOM_result -rays -data
  181  vi radxops.cc
  182  make all
  183  ./radxops one two
  184  RadxPrint -f SOM_result -rays -data
  185  more results
  186  ls
  187  more result
  188  vi radxops.cc
  189  make all
  190  vi radxops.cc
  191  make all
  192  vi radxops.cc
  193  make all
  194  ./radxops one two
  195  vi radxops.cc
  196  make all
  197  vi radxops.cc
  198  make all
  199  vi radxops.cc
  200  make all
  201  vi radxops.cc
  202  make all
  203  vi radxops.cc
  204  make all
  205  man sscanf
  206  vi radxops.cc
  207  make all
  208  vi radxops.cc
  209  make all
  210  ./radxops one two
  211  vi radxops.cc
  212  make all
  213  ./radxops one two
  214  vi radxops.cc
  215  make all
  216  vi radxops.cc
  217  make all
  218  ./radxops one two
  219  vi radxops.cc
  220  make all
  221  vi radxops.cc
  222  make all
  223  vi radxops.cc
  224  make all
  225  vi radxops.cc
  226  make all
  227  ./radxops one two
  228  vi radxops.cc
  229  make all
  230  ./radxops one two
  231  vi radxops.cc
  232  make all
  233  ./radxops one two
  234  vi radxops.cc
  235  vi Makefile
  236  make all
  237  gdb radxops
  238  gdb
  239  lldb
  240  lldb radxops
  241  vi Makefile
  242  vi radxops.cc
  243  make all
  244  ./radxops one two
  245  vi radxops.cc
  246  make all
  247  ./radxops one two
  248  vi radxops.cc
  249  vi radxops.cc
  250  make all
  251  vi radxops.cc
  252  make all
  253  ./radxops one two
  254  RadxPrint -f SOM_result -rays -data
  255  ls
  256  cp SOM_result SOM_result.nc
  257  vi radxops.cc
  258  more result
  259  python 
  260  cp result sort_result.py
  261  vi sort_result.py 
  262  python sort_result.py 
  263  vi sort_result.py 
  264  python sort_result.py 
  265  vi sort_result.py 
  266  python sort_result.py 
  267  vi sort_result.py 
  268  python sort_result.py 
  269  ls
  270  more radxops.cc
  271  ls
  272  vi result_sorted.txt
  273  vi radxops.cc
  274  make all
  275  ./radxops result_sorted.txt 
  276  ls -lrt
  277  vi radxops.cc
  278  make all
  279  ./radxops result_sorted.txt 
  280  ls -lrt
  281  vi radxops.cc
  282  mv SOM_result SOM_result.nc
  283  RadxPrint -f SOM_result.nc -rays -data
  284  vi radxops.cc
  285  make all
  286  ./radxops result_sorted.txt 
  287  ls -lrt
  288  mv SOM_result SOM_result.nc
  289  RadxPrint -f SOM_result.nc -rays -data
  290  vi radxops.cc
  291  vi radxops.cc
  292  make all
  293  ./radxops result_sorted.txt 
  294  ls -lrt
  295  RadxPrint -f SOM_result -rays -data
  296  RadxPrint -f SOM_result -rays -data  | grep -A3 Data
  297  vi radxops.cc
  298  make all
  299  ./radxops result_sorted.txt 
  300  RadxPrint -f SOM_result -rays -data  | grep -A3 Data
  301  vi radxops.cc
  302  make all
  303  ./radxops result_sorted.txt 
  304  RadxPrint -f SOM_result -rays -data  | grep -A3 Data
  305  vi radxops.cc
  306  make all
  307  ./radxops result_sorted.txt 
  308  RadxPrint -f SOM_result -rays -data  | grep -A3 Data
  309  RadxPrint -f SOM_result -rays -data  | less
  310  RadxPrint -f SOM_result -rays -data  | grep -A3 -e Data -e az
  311  ls
  312  cp SOM_result SOM_result.nc
  313  cp SOM_result SOM_result.nc > /tmp/junk16
  314  vi /tmp/junk16
  315  RadxPrint -f SOM_result -rays -data  > /tmp/junk16
  316  vi /tmp/junk16
  317  ls
  318  cd ..
  319  ls
  320  cd git
  321  ls
  322  ls
  323  git clone https://github.com/leavesntwigs/dealias_SOM
  324  ls
  325  cd dealias_SOM/
  326  ls
  327  rsync
  328  ls
  329  pwd
  330  rsync ~/SOM .
  331  ls
  332  ls ~/SOM
  333  cp -R ~/SOM .
  334  ls
  335  ls SOM
  336  ls ~/data
  337  ls -R ~/data
  338  cp -R  ~/data .
  339  ls
  340  mkdir tensor_flow
  341  cd tensor_flow
  342  ls
  343  vi first_attempt.ipynb
  344  ls
  345  cd ..
  346  ls
  347  cd SOM
  348  ls
  349  rm radxops.so
  350  rm *.dylib
  351  ls
  352  rm hello.so
  353  cd ..
  354  git status
  355  ls data
  356  ls data/20170408/
  357  cd data
  358  ls
  359  cd 20170408/
  360  ls
  361  rm '!'
  362  ls
  363  cd ..
  364  cd ..
  365  git status
  366  git add SOM data tensor_flow/
  367  git status
  368  git commit -m "initial versions of data, scripts, and results"
  369  git config --global --edit
  370  git commit --amend --reset-author
  371  git status
  372  git push
  373  git status
  374  git config --global --edit
  375  git push
  376  git config --global --edit
  377  git config --global user.email "43278sklhf@users.noreply.github.com"
  378  git commit --amend --reset-author
  379  git push
  380  ls
  381  cd data
  382  ls
  383  more make_data_vectors.awk 
  384  ls
  385  cd 20170408/
  386  ls
  387  more sample_points.py
  388  tail  sample_points.py
  389  vi /tmp/junk1
  390  vi /tmp/junk2
  391  vim diff /tmp/junk1 /tmp/junk2
  392  vimdiff /tmp/junk1 /tmp/junk2
  393  diff /tmp/junk1 /tmp/junk2
  394  vi /tmp/junk16
  395  vi /tmp/junk17
  396  pwd
  397  cd ../..
  398  ls
  399  pwd
  400  ls
  401  cd SOM
  402  ls
  403  ls data
  404  cd ..
  405  ls
  406  ls data
  407  ls SOM
  408  mv ~/SOM/cleaner_attempt.py .
  409  pwd
  410  mv ~/SOM/result_fullsize .
  411  ls
  412  ls data
  413  cd data
  414  more make_data_vectors.awk 
  415  pwd
  416  cd ..
  417  ls
  418  cd SOM
  419  ls
  420  more Makefile
  421  more radxops.cc
  422  !
  423  ls
  424  pwd
  425  head result_fullsize 
  426  awk -f tf_result_2list.awk result_fullsize > result_radx_input
  427  awk -f tf_result_2list.awk result_fullsize > result_radx_input
  428  head result_radx_input 
  429  ls
  430  more Makefile
  431  make
  432  make
  433  make
  434  make
  435  make
  436  ls -lrt 
  437  mv SOM_result SOM_result_fullsize.nc
  438  mv SOM_result.nc SOM_result_clusters.nc
  439  RadxPrint -f SOM_result_fullsize.nc -data -rays | less
  440  RadxPrint -f SOM_result_fullsize.nc -data -rays | grep az
  441  ls
  442  vi result_fullsize 
  443  vi result_radx_input 
  444  vi result_fullsize 
  445  grep unfolded result_fullsize 
  446  grep unfolded result_fullsize  | less
  447  make
  448  grep unfolded result_fullsize  | less
  449  less result_radx_input
  450  less result_radx_input
  451  pwd
  452  ls
  453  cd ..
  454  ls
  455  cd SOM_PAK
  456  ls
  457  cd som_pak-3.1
  458  ls
  459  cd ..
  460  ls
  461  cd ..
  462  ls
  465  SOM_PAK/som_pak-3.1/lininit -xdim 12 -ydim 3 -din data/20170408/training.dat -cout editeddata.cod -neigh bubble -topol rect
  466  ls -lrt
  467  SOM_PAK/som_pak-3.1/vsom -din data/20170408/training.dat -cin editeddata.cod -cout editeddata_model.cod -rlen 100 -alpha 2 -radius 20 
  468  ls -lrt
  482  cd ..
  488  SOM_PAK/som_pak-3.1/visual -din data/20170408/just_a_few_points.dat -cin editeddata_model.cod -dout mapping_coords.vis
  489  cd SOM_PAK
  >>>>  SOM_PAK/som_pak-3.1/visual -din data/20170408/just_a_few_points.dat -cin editeddata_model.cod -dout mapping_coords.vis -v
  523  more mapping_coords.vis
  525  more editeddata_model.cod 
  534  cp visual.c merge.c
  535  vi merge.c
  549  SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  

SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  -din data/20170408/just_a_few_points.dat -mapping mapping_coords.vis -dout merged.dat 

  550  cd SOM_PAK/som_pak-3.1
  551  make merge
  552  cd ../..
  553  SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  
  554  cd SOM_PAK/som_pak-3.1; make merge
  555  SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  
  556  SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  
  557  cd SOM_PAK/som_pak-3.1
  558  cd ..
  559  cd ..
  570  SOM_PAK/som_pak-3.1/merge -grid editeddata_model.cod  
  571  pwd
  572  git status
  573  git add SOM_PAK/som_pak-3.1/merge.c
  574  git add SOM_PAK/som_pak-3.1/Makefile
  575  git commit -m "adding a merge utility"
  576  git push
  577  cd SOM_PAK/som_pak-3.1; make merge; cd ../..
  580  cd SOM_PAK/som_pak-3.1; make merge; cd ../..
  581  ls
  582  more mapping_coords.vis
  583  ls
  584  rm mapping_coords.dat

  628  SOM/radxops merged.dat
  629  ls -lrt
  630  mv SOM_result SOM_result_SOM_PAK.nc
  631  RadxPrint -f SOM_result_SOM_PAK.nc -data -rays | less
