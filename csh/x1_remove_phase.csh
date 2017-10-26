#!/bin/csh -f
set prog=$0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PHASE>"
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
source $CSH_DIR/14_get_design.csh

if ($1 != "") then
    setenv DESIGN_PHASE $1
    if ($2 != "") then
        setenv DESIGN_PROJT $2
    endif
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
svn info $PHASE_URL >& /dev/null
if ($status == 0) then
    echo "INFO: Remove Project Design Phase - /$DESIGN_PROJT/$DESIGN_PHASE"
    svn remove $PHASE_URL -m "remove Phase : /$DESIGN_PROJT/$DESIGN_PHASE"
else
    echo "ERROR: Can not find Design Phase - /$DESIGN_PROJT/$DESIGN_PHASE"
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
