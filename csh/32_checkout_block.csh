#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DESIGN_BLOCK $1
   $CSH_DIR/00_set_env.csh DESIGN_BLOCK $DESIGN_BLOCK
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
svn info $BLOCK_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Block : $DESIGN_BLOCK"
   exit 1
endif

echo "INFO: Checkout Project Design Block : $DESIGN_PHASE/$DESIGN_BLOCK"
mkdir -p .project/$DESIGN_PHASE/$DESIGN_BLOCK

if ($?depth_mode) then
   svn checkout --quiet --force $BLOCK_URL .project/$DESIGN_PHASE/$DESIGN_BLOCK --depth $depth_mode
   svn update --quiet --force .project/$DESIGN_PHASE/$DESIGN_BLOCK
endif

if {(test -e .project/$DESIGN_PHASE/$DESIGN_BLOCK/.dvc)} then
   svn update --quiet --force .project/$DESIGN_PHASE/$DESIGN_BLOCK/.dvc
else
   svn checkout --force $BLOCK_URL/.dvc .project/$DESIGN_PHASE/$DESIGN_BLOCK/.dvc
endif

rm -f .project/$DESIGN_PHASE/:
ln -s $DESIGN_BLOCK .project/$DESIGN_PHASE/:

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
