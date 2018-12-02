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
source $CSH_DIR/14_get_folder.csh

if ($1 != "") then
   if (($1 != "_") && ($1 != ".")) then
   setenv DESIGN_VERSN $1
   endif 
   shift argv
endif

echo "INFO: Checkin Project Design Version : $DESIGN_VERSN"
setenv DVC_PATH $DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN

source $CSH_DIR/69_checkin_dvc_path.csh

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
