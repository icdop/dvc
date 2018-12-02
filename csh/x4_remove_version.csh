#!/bin/csh -f
set prog=$0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_folder.csh

if ($1 != "") then
   if (($1 != "_") && ($1 != ".")) then
   setenv DESIGN_VERSN $1
   endif 
   shift argv
endif

setenv DVC_PATH $DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv VERSN_URL $PROJT_URL/$DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN

svn info $VERSN_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Remove Project Design Version - $DESIGN_PROJT/$DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN"
   svn remove $VERSN_URL -m "Remove Design Version $DESIGN_VERSN"
else
   echo "ERROR: Can not find Design Version - $DESIGN_PROJT/$DESIGN_BLOCK/$DESIGN_PHASE/$DESIGN_STAGE/$DESIGN_VERSN"
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
