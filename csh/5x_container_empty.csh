#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/02_set_version.csh

setenv DVC_CONTAINER .design/$DESIGN_STAGE/$DESIGN_VERSN
if {(test -d $DVC_CONTAINER)} then
   svn remove --quiet --force `glob $DVC_CONTAINER/*`
   svn commit --quiet $DVC_CONTAINER -m "Empty all data in the version"
   svn update --quiet $DVC_CONTAINER
endif