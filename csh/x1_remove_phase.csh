#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_PHASE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
endif
source $DVC_BIN/dvc_get_svn
source $DVC_BIN/dvc_get_version

if ($1 != "") then
    setenv DESIGN_PHASE $1
    if ($2 != "") then
        setenv DESIGN_PROJT $2
    endif
endif

setenv PHASE_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE
svn info $PHASE_URL >& /dev/null
if ($status == 0) then
    echo "INFO: Remove Project Design Phase : /$DESIGN_PROJT/$DESIGN_PHASE"
    svn remove --quiet $PHASE_URL -m "remove Phase : /$DESIGN_PROJT/$DESIGN_PHASE"
else
    echo "WARN: Design Phase Not Exist : /$DESIGN_PROJT/$DESIGN_PHASE"
endif
  

