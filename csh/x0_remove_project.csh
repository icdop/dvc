#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_PROJT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/11_get_svn.csh

if ($1 != "") then
    setenv DESIGN_PROJT $1
    echo "INFO: Delete Project Design Respository : $DESIGN_PROJT"
    rm -fr $SVN_ROOT/$DESIGN_PROJT
endif

