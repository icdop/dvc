#!/bin/csh -f
set prog=$0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK> <DESIGN_PHASE>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
source $DVC_HOME/csh/12_get_server.csh
source $DVC_HOME/csh/13_get_project.csh
source $DVC_HOME/csh/14_get_version.csh

if ($1 != "") then
    setenv DESIGN_BLOCK $1
    if ($2 != "") then
        setenv DESIGN_PHASE $2
        if ($3 != "") then
            setenv DESIGN_PROJT $3
        endif
    endif
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
svn info $BLOCK_URL >& /dev/null
if ($status == 0) then
    echo "INFO: Remove Project Design Block - /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK"
    svn remove $BLOCK_URL -m "Remove Design Block : $DESIGN_BLOCK"
else
    echo "ERROR: Can not find Design Block - /$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK"
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
