#!/bin/csh -f
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <CONTAINER>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/13_get_container.csh

if (($1 != "") && ($1 != ".")) then
   setenv CONTAINER $1
   echo "PARA: CONTAINER = $CONTAINER"
   setenv DVC_CONTAINER .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$CONTAINER
endif

if {(test -d $DVC_CONTAINER)} then
   echo "URL: $DVC_CONTAINER"
   echo "------------------------------------------------------------"
   svn list $DVC_CONTAINER -v
else
   echo "ERROR: Can not find Container : $DVC_CONTAINER"
endif
 