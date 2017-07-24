#!/bin/csh -f
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_OBJECT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/13_get_container.csh

if {(test -d $DVC_CONTAINER)} then
   svn commit --quiet $DVC_CONTAINER -m "Commit Design Container" 
else
   echo "ERROR: Cannot find Container : $DVC_CONTAINER"
endif


