#!/bin/csh -f
# set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv CSH_DIR $DOP_HOME/dvc/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh
source $CSH_DIR/15_get_container.csh

if {(test -d $DVC_CONTAINER)} then
   echo "DVC_PATH: $DVC_CONTAINER"
   echo "SVN_PATH: $SVN_CONTAINER"
   echo "------------------------------------------------------------"
   svn list $SVN_URL/$DESIGN_PROJT/$SVN_CONTAINER -v
#   svn list $DVC_CONTAINER -v
else
   echo "ERROR: Can not find Container : $DVC_CONTAINER"
endif
 