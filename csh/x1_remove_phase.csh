#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_PHASE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/11_get_svn.csh
source $DOP_HOME/dvc/csh/12_get_version.csh

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
    svn remove --quiet $PHASE_URL -m "remove Phase : /$DESIGN_PROJT/$DESIGN_PHASE"
else
    echo "ERROR: Can not find Design Phase - /$DESIGN_PROJT/$DESIGN_PHASE"
endif
  

