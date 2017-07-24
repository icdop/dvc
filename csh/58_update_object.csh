#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_CNTNR>"
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
   svn update --quiet $DVC_CONTAINER
else
   echo "ERROR: Cannot find Container : $DVC_CONTAINER"
endif
