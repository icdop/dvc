#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_PROJT>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/12_get_server.csh

setenv DESIGN_PROJT $1

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
echo "PARM: PROJ_URL = $PROJT_URL"
svn info $PROJT_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Delete Project Respository - $DESIGN_PROJT"
   rm -fr $SVN_ROOT/$DESIGN_PROJT
else
   echo "ERROR: Can not find Project Respository - $DESIGN_PROJT"
endif
