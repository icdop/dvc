#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DVC_PATH>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_folder.csh

if ($?recursive_mode) then
  tree -I $PTR_CURR $PROJT_PATH
else if ($?info_mode) then
  tree -d $PROJT_PATH
else
  tree -L 5 -I $PTR_CURR -d $PROJT_PATH
endif

exit 0
