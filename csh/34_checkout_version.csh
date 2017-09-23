#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh

if ($1 != "") then
   if (($1 != ":") && ($1 != ".")) then
      setenv DESIGN_VERSN $1
      $CSH_DIR/00_set_env.csh DESIGN_VERSN $DESIGN_VERSN
   endif 
   shift argv
endif


setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN

svn info $VERSN_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Cannot find Project Design Version : $DESIGN_VERSN"
   exit 1
endif

echo "INFO: Checkout Project Design Version : $DESIGN_VERSN"
setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
setenv CURR_PTR $CURR_VERSN

source $CSH_DIR/39_checkout_dvc_path.csh

$CSH_DIR/05_set_container.csh .

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
