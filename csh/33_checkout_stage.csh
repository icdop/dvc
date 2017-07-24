#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_STAGE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh

if ($1 != ".") then
   setenv DESIGN_STAGE $1
   echo "INFO: DESIGN_STAGE = $DESIGN_STAGE"
   mkdir -p .dvc/env
   echo $DESIGN_STAGE > .dvc/env/DESIGN_STAGE
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
svn info $STAGE_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Stage : $DESIGN_STAGE"
   exit 1
endif

echo "INFO: Checkout Project Design Stage : $DESIGN_STAGE"
mkdir -p .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE
svn checkout --quiet $PROJT_URL/.dvc .project/$DESIGN_PROJT/.dvc
svn checkout --quiet $PHASE_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/.dvc
svn checkout --quiet $BLOCK_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/.dvc
svn checkout --quiet $STAGE_URL/.dvc .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc
svn checkout --quiet $STAGE_URL/ .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/
rm -f .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/.current_version
ln -s $DESIGN_STAGE .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/.current_version

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
