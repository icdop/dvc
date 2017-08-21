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
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/14_get_version.csh
source $DVC_CSH/15_get_container.csh

if {(test -d $DVC_CONTAINER)} then
   echo "DVC_PATH: $DVC_CONTAINER"
   echo "SVN_PATH: $SVN_CONTAINER"
   echo "------------------------------------------------------------"
   svn list $SVN_URL/$DESIGN_PROJT/$SVN_CONTAINER -v
#   svn list $DVC_CONTAINER -v
else
   echo "ERROR: Can not find Container : $DVC_CONTAINER"
endif
 