#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
endif
source $DVC_BIN/dvc_set_version
source $DVC_BIN/dvc_get_version
source $DVC_BIN/dvc_get_svn


setenv BLOCK_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK
setenv DVC_CONTAINER .design/$DESIGN_STAGE/$DESIGN_VERSN

mkdir $DVC_CONTAINER -p
svn checkout --quiet $BLOCK_URL/$DESIGN_STAGE/$DESIGN_VERSN $DVC_CONTAINER
svn update --quiet $DVC_CONTAINER


	