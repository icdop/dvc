#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/11_get_svn.csh
source $DOP_HOME/dvc/csh/12_get_version.csh

if ($1 != "") then
    setenv CONTAINER $1
    echo "PARA: CONTAINER = $CONTAINER"
endif

setenv DVC_CONTAINER .design/$DESIGN_STAGE/$DESIGN_VERSN/$CONTAINER
if {(test -d $DVC_CONTAINER)} then
   echo "INFO: Remove Project Design Container - $DVC_CONTAINER ..."
   rm -fr $DVC_CONTAINER
else
   echo "ERROR: Can not find Desiign Container - $DVC_CONTAINER"
endif
