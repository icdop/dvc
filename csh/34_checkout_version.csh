#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if (($1 == "--data")) then
   set all_data = 1
   shift argv
else
   set all_data = 0
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/04_set_version.csh

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN
svn info $VERSN_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Version : $DESIGN_VERSN"
   exit -1
endif

mkdir -p .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN


if {(test -d .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dvc)} then
echo "INFO: Update Project Design Version : $DESIGN_STAGE/$DESIGN_VERSN"
svn update --quiet .project/.dvc
svn update --quiet .project/$DESIGN_PHASE/.dvc
svn update --quiet .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc
svn update --quiet .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dvc
else
echo "INFO: Checkout Project Design Version : $DESIGN_STAGE/$DESIGN_VERSN"
svn checkout --quiet $PROJT_URL/.dvc .project/.dvc
svn checkout --quiet $PHASE_URL/.dvc .project/$DESIGN_PHASE/.dvc
svn checkout --quiet $BLOCK_URL/.dvc .project/$DESIGN_PHASE/$DESIGN_BLOCK/.dvc
svn checkout --quiet $STAGE_URL/.dvc .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc
svn checkout --quiet $VERSN_URL/.dvc .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/.dvc
endif

rm -f .project/:
rm -f .project/$DESIGN_PHASE/:
rm -f .project/$DESIGN_PHASE/$DESIGN_BLOCK/:
rm -f .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/:
ln -s $DESIGN_PHASE .project/:
ln -s $DESIGN_BLOCK .project/$DESIGN_PHASE/:
ln -s $DESIGN_STAGE .project/$DESIGN_PHASE/$DESIGN_BLOCK/:
ln -s $DESIGN_VERSN .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/:

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
