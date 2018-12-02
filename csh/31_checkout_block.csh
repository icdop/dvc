#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK>"
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
source $CSH_DIR/14_get_folder.csh

if ($1 != "") then
   if (($1 != "_") && ($1 != ".")) then
      setenv DESIGN_BLOCK $1
      $CSH_DIR/00_set_env.csh DESIGN_BLOCK $DESIGN_BLOCK
   endif
   shift argv
endif

setenv BLOCK_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_BLOCK
svn info $BLOCK_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Cannot find Project Design Block : $DESIGN_BLOCK"
   exit 1
endif

echo "INFO: Checkout Project Design Block : $DESIGN_BLOCK"
setenv DVC_PATH $DESIGN_BLOCK
setenv DESIGN_PTR $PTR_BLOCK

source $CSH_DIR/39_checkout_dvc_path.csh

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
