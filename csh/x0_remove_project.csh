#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_PROJT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
endif
source $DVC_BIN/dvc_get_svn

if ($1 != "") then
    setenv DESIGN_PROJT $1
    echo "INFO: Delete Project Design Respository : $DESIGN_PROJT"
    rm -fr $SVN_ROOT/$DESIGN_PROJT
endif

