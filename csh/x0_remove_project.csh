#!/bin/csh -f
set prog=$0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
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

setenv DESIGN_PROJT $1

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
echo "PARM: PROJT_URL  = $PROJT_URL"
svn info $PROJT_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Delete Project Respository - $DESIGN_PROJT"
   rm -fr $SVN_ROOT/$DESIGN_PROJT
else
   echo "ERROR: Can not find Project Respository - $DESIGN_PROJT"
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
