#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK> <DESIGN_PHASE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if (($1 == "--data")) then
   set all_data = 1
   shift argv
else
   set all_data = 0

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh
endif

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DESIGN_BLOCK $1
   echo "INFO: DESIGN_BLOCK = $DESIGN_BLOCK"
   mkdir -p .dvc/env
   echo $DESIGN_BLOCK > .dvc/env/DESIGN_BLOCK
endif

if (($2 != "") && ($2 != ":") && ($2 != ".")) then
    setenv DESIGN_PHASE $1
    echo $DESIGN_PHASE > .dvc/env/DESIGN_PHASE
    echo "INFO: DESIGN_PHASE = $DESIGN_PHASE"
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
svn checkout --quiet $PROJT_URL/.dvc .project/.dvc
svn checkout --quiet $PHASE_URL/.dvc .project/$DESIGN_PHASE/.dvc
if ($all_data == 1) then
   svn checkout --quiet $BLOCK_URL .project/$DESIGN_PHASE/$DESIGN_BLOCK
else
   svn checkout --quiet $BLOCK_URL/.dvc .project/$DESIGN_PHASE/$DESIGN_BLOCK/.dvc
endif
rm -f .project/$DESIGN_PHASE/:
ln -s $DESIGN_BLOCK .project/$DESIGN_PHASE/:

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
