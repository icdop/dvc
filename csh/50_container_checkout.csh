#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/02_set_version.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/11_get_svn.csh


setenv BLOCK_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK
setenv DVC_CONTAINER .design/$DESIGN_STAGE/$DESIGN_VERSN

mkdir -p .project/$DESIGN_PHASE/$DESIGN_BLOCK
rm -f .design
ln -fs .project/$DESIGN_PHASE/$DESIGN_BLOCK .design
mkdir -p $DVC_CONTAINER
svn checkout --quiet $BLOCK_URL/$DESIGN_STAGE/$DESIGN_VERSN $DVC_CONTAINER
svn update --quiet $DVC_CONTAINER


	